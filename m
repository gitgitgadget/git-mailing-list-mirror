Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3813F53E31B
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 19:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791919336; cv=none; b=ZLs40t/npfX62+JFHzAglUDzTIgcRewBBJbmTjqF1Vy1Hts2ajyhzApuHETm9BSbOLx93ggahAISq+sn+xzihw4TWXEhVSAH09d/uzLmp0IGEB0kPzm/O2vtu402LNmUo85R5zYfmgso6umh0qgzjx13v+BpMiTpxpgKSRDXAWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791919336; c=relaxed/simple;
	bh=MmAoI/d8oQbxzPBn2/EoIT4Hqj15iHRsTX4azTnOD0k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fWq+2XxR3ucLdq0grirDtVVKPCjHlTRR8es3Gan+IS5L2QGlixHOMpesVUmnw2Sr1ud1F2wGpLqkW/SWyH+lTDJHrtvaRG/1b/ZK9EqRmMFqh3Z67UcuWOsTMRIgeZTbMdnJR+DdBMBHTPcgDrxqI3feXuhy8v2GPFOLxnnB9E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=e1ypcoAN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=olBzEcuu; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="e1ypcoAN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="olBzEcuu"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 8BBEF1D00058
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 15:22:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 13 Oct 2026 15:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791919333; x=1792005733; bh=1zRAulpHrY
	XQKyUiIWmTq8D3oeKvpR+1oG0KoLJV9ao=; b=e1ypcoANp52F9Du+XB64+9DPpy
	6KNZ7n22pxKowy4OmKZsaO2SMW5CA5M77wrxI74YKt/4/A1cLWXs4f4XvBi71Hyo
	ng97kMTaPTBx0ZNFvZ9Wh988x0OAUv1EPH1/TXMFJUHF74YyFWpQAlyf1TAB27kA
	sGGD7ODbU9jseWu2uCgIBqijgOk/BJKG48o8cj/tf4XENiUynCFywMU5RsE/ake/
	5bOGb7F4g1k6v6z5VCZprEO115Tzw2GUvATO4QiEAcDDI4XqVWVfdVDUmbudbEKm
	/rElUtSvW31stp7nENiVfGAjWLHJEV+/ZwOs6VsZUGCa/GSKgXmmG9+QOXYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791919333; x=1792005733; bh=1zRAulpHrYXQKyUiIWmTq8D3oeKvpR+1oG0
	KoLJV9ao=; b=olBzEcuuo0hqGJt1IwMlTKzwReGrT+XeX28e5LByS94NrpLmbsc
	OD10y5HdgJem+PATlJc0/WOExift6U2s9cBaslzjZM5ew6EUc8owtIZi/rcmWLKB
	2aLGXV8QqduEw1HYWUJk+fB58bgn+yUaQlaeYk45CUbGxPWBtD8FJKI1n5PpceTg
	IQQaFnBKaxuZzJb6n10Md0o46h7hRE32eHbwmNvcv3bUQmOIzQzgs5mGfVY+c1gN
	Pjgcd7CHxvosdbOWSYSFWgzRP9xy68i+bmJv6ME0XJlHvHg57qMMbyF8NP/Dhc4I
	yKW49oapRnrK1hD6HHSGz5zOuHQCmk+DqgA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791919333; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:WylZrrXVje0BCt27nB8WkN3EmP2kjsWp7Qn02IkrZPECDkQ
	py8MN1Z8g0suzBVsxZUsXnD5TyrX5DBCbG5gK154AT7W2cStpXAiaf4n3AchOcaC
	J0iJHlRtgaNSxSI5OlCkguii8G9PMUoPo5DENXWWk2Ru+WO5kk/J5ua2FLxoecCo
	DOjt2jSZa0Sz0Ej/u+XsEz3n46bi+DniiWeXIfINWB7z7aqoE6NG61UUcUk2sWpz
	C+1ZnG5mhE5tld+xFok06cNvvdUPaEPlxo7OnR3Fz3beiPAR+hRb++vxfnYI3XtC
	WiS4Dq8cN90oYDA+fe5+rPpCU2YT5gebs6xXjgQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:e/p5IH8xRj4MJ1JCcsxALCxRiGFpe91MHqPMnzIPKH0=:MmAoI/d8oQbxzPBn2/EoIT4Hqj15iHRsTX4azTnOD0k=;
X-ME-Sender: <xms:5YTOatrL2b0x4jTBN9DVuKeSz6TwcEt0mNR9flEvM6B1YN4alyU0DA>
    <xme:5YTOampoCN9P3zPpDglrZ6S88AknNAjhHQywtyA1o8B1CxTkB13GD8hGx16jBgDKT
    zXAnnJ1f87JTVxAxIbppxlPGTJ8RrSmZ2s6PZg03zgfi4NX0TQ2_A>
X-ME-Received: <xmr:5YTOavO-BSCuLPXYyaXarZCY6-ckjnbwq3oe6iHvRAVeYLDii5jdehUkb7zTDCnglGl0IEg5qClxkGq0y1xV35y9RZ3S9ok1cN9l>
X-ME-Proxy-Cause: dmFkZTECr8wxlwzXd83ByB1002RKJ4G+zxukuwR5Xi27oAmjAzTVZ6XtmbbWbPvWk9BPIX
    Gt3dzQ63nNEOKy1aUuUQAT03/VyVkfM4WXQgRkmmKEwCf8tSXeW6oTlWjAHDBCmuZDi9h3
    SfIK/2e/qojlV1IcmxlYogHipxs+cbYkRYwVcN2tRppcDmVS5+fT6T6rmNoo0fRUVO9yyq
    ED/1GpQ5PykRWZnQemeeu4X+fuBj5mZy6sc+FckiyyWnnFkgp2pt1d8LVX06wdoOLFyNS2
    HgOF65K+7IPXJhHMVLoS6ieYGMme+d7dRO23P9TQpIh0pGmmH275/T4bRtaPjMPSB5kAHZ
    jx5uK8AIbvRnTx9+mJ3XWy8UyC6StK7tnB0KMYfvLILGPPDT3jDiMlWVaTNDYr06je3QKb
    ewQci42Ll0B9K+5plMz9TODyhCd1pZLOlaxDcXNH8jhtgC3vI0x1hi29+4QGfd2smWv0N9
    V51jtVhQGHo4Q7TDTP7stYWED6mU24HOD2PwJlXjHGgKleD+42yqQFzrC6juJN9PrKLWyF
    zaI+jA6IeYwzP/xTGSR44/09ilHuVGO9LQqeAbcYSmnGF/AgelYKwrsjx0/Ke2UD/dMuqI
    Qyu2DIt3N65zS1r3UDnfOnvTQFtjsxeiRU1op+O1BmOGubV+FzYoQ9gubLMQ
X-ME-Proxy: <xmx:5YTOanytJGfu-hWfJkj5xfFuHQagx7ADPUZVPAN2zvzfpaeY-BGLvw>
    <xmx:5YTOaot7DAL0abcga3Ft8KWYXHtHDECofh5sVdwLRB2J9ix55aZ6CA>
    <xmx:5YTOag7KCdOmSHJLcHRkDOyKjBuhFeMoNAm4eMh17fhVGl3LqFyOFw>
    <xmx:5YTOanSvhpc5NVtbLCJvO272juJUNQEvbkPb0qeHosmkKWEmi4PpwQ>
    <xmx:5YTOat2opLi5W-LXBbl921aXgYcIWnK1sjGVIgaU5kRm9L6DbHQjz34g>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 15:22:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Souma <git@5ouma.me>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v5 0/2] history: sign rewritten commits
In-Reply-To: <20261003134058.23494-1-git@5ouma.me> (Souma's message of "Sat, 3
	Oct 2026 22:40:56 +0900")
References: <20260703145037.69832-1-git@5ouma.me>
	<20261003134058.23494-1-git@5ouma.me>
Date: Tue, 13 Oct 2026 12:22:11 -0700
Message-ID: <xmqqecdtwgm4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Souma <git@5ouma.me> writes:

> Changes since v4:
>
>  - Add Git completion coverage for `--gpg-sign` and `--no-gpg-sign` to the
>    history subcommand option tests

At v3 the topic we already had a "looks good enough", but sorry, but
I somehow missed this topic.  Thanks for writing and reviewing.
Marked as ready for 'next'.
