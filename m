Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE6538A73C
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 14:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792074993; cv=none; b=hSs58IeTTqfDakqDLI3eS0zyS3nU2l3UltUBec/fxWV2p+vwy1RxG0uytzHFIIApZCJXhO9gPGo+w+mTZd9Dq9l/AprGdlegtHYaVLzJbD6hCGrHyxo3OJQgD7jfgsJmEHlnEZgx3u/9HJAfJhAZBGjxgi3eTwAroDGnfFRqxxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792074993; c=relaxed/simple;
	bh=VUtz/lrx8M8YbSZVbNa3lrLSXbKrQ2a5156KdEBQ5WA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uNwaBh/yaHgkmKt+U1OOaV5PG4TGvH2y3heuKPQX6j9YiSy5peZ3NY51arG2AcXMicasXw1UEWbT0A4DykPA6V9TKs8QCe9XHFRexWDX4cHXwr3HjEHps/DUWp2b/FjIIdMsgD8TLEvFuKZfKXVWm0mvK4aE99HxHlURHdiMwOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=b6D0pgFL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XqQPA3ZB; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="b6D0pgFL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XqQPA3ZB"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A9BD87A01AA
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 10:36:31 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 15 Oct 2026 10:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792074989;
	 x=1792161389; bh=jNabF9eQZjhgN4jB2yejJUNTvnWskJsVadc/8H3pI4E=; b=
	b6D0pgFLnSvt6BFM1fADgHIZAbK0FVWUR6BBGrZ0H0Mh3pEFZTNektEqqv0dwnLV
	m7/mVe4hnXnQIHYTm59Vx/gNaHqdNkMGgRFk7Jagbmjedx92jZWQfb+NAe5H6QiB
	RHzty/SHDtBEK0ZYgKLdISAMJTqS0+W9Yr4YOon4E3erK0ND3FYJjggz85jRPM3/
	PIrcYPJYl9b4LKPMrVDuH2h6HndM9PGjZKzynz/KdAM/LMl2pY2Lv0YG6dKDYH2d
	oHYuoc++7PSilEd8BW8qbYJB1pEv+CiLRk6jq+n7oNQcKTAApp/1jLQ6vhJ9KUe7
	iEZzxK7xgTYffsh1AizpLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792074989; x=
	1792161389; bh=jNabF9eQZjhgN4jB2yejJUNTvnWskJsVadc/8H3pI4E=; b=X
	qQPA3ZBaWW9C3HaeyGuOoPKwOeNiQ2FGI27SW5aMSgyOtFzuF2gcwjuAoovB/kLY
	Y6GL8AZS/6NFgCM694zHNPuYA/wvJpsx2W4DfkzAfki2MxTgXCrcVs1DvWgFolxd
	YyS1VC9hGEvjeisOV/p522/4oC9hexRuriiBusKyNI0MiocWvVLVjYegPG+uhLdl
	H8ZQaXFMPb/0cKKgj/dlYdto455zEbnkdldhQ7DeGSNOQwShpoSLn/6Ba4d0gNc6
	U9opgN3YVNhHnbTOvgfjJGvas6hYd1wG+uGpNlHcJ5JE6wd/8wAn6oNsQpjhjII6
	+wxCkXh3o7WmFUw1p250w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792074989; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:GgAmfPpInAdTwZySbpsjro68mdLR0in7KKwNheKxmhGWsFo
	nyv82wxitaI7j6hqUJiASzykiw4suaN2cTyCk+wvpRTAGz0pbZPrDMzqt7ROrXGN
	QkFXYKT+gfeKz7Qo+cYSO4XDLx6o9OOXQ+1tnbNP+wGFs8C5hxc16lFd+MKrNYzf
	sTM122bZgzfiU4xTwamKzaEtWCiu2IlhY8RhmfMA2aHRc2nPc9S92n0fpGbxwTM+
	Z3ZRLoHMjvj7COma6T+f9Zov8FyIqphE/WYi5Cgy7roQFdPOOINFBm0uE1pJssmU
	8GsCHAOoOfsAdFT/nTkuqJqFKri5yQXMmz2mqkA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:44/zzPkWNiCkvZT56D9ewkUCvzP3rIL2dYB1zRKf0Vo=:VUtz/lrx8M8YbSZVbNa3lrLSXbKrQ2a5156KdEBQ5WA=;
X-ME-Sender: <xms:7eTQathxM_irVbx08s9a7-uzFr74CT6b0snKGHE84yoTaGY0zRJ8unw>
    <xme:7eTQas1c3gRenYYObdw5P9N94fAHpJ4mWobEDmCEgBBnx34oWxQ7ReICNpD3AZq2H
    _IsfLqFDiR-FMLlZtFZrrjCCafMcaLD7m8xsK5_LW3D1LJSyhiKzto>
X-ME-Proxy-Cause: dmFkZTGVV/qSK33626taDvT1SXraqosaFvSc60nST4W/VhJBm+TPY5wmHcYNj8SkA9dZhd
    x9LIJRHFFZ5/dnFcxtEY9vTjFOfzoQXOyW2KXazZiWIAjFqqqszJ+qv0AMXKLyK1w6F+LV
    zrHb+6uT/+2bGlz0kEGetLm3/A4JawC6Ht9KAvwIBFK4cM3VmaeoHj05rzfYlC4E6mbseT
    NfdyGeM/Ol8GicFSLjdGhvnbp5cm8ynAq/0stoeobQcSX4lxJUJjaXZeAZeKWi9rN8aCXe
    2lDCNgkiA+mSM5c+UxfJiX4+ysej99qZPWwRMiKIB/rdNlPxGk3/1GJk9PbZXTvUkKx1RT
    JgnGcEECw+ZBsNZlVDmrG1ysyHO+E7J5ZIUGMFM7bM2PN+Fw+zCZ/QkoWWzWu1kBcinxOa
    ffEqe6v10fY2QuGwf1OM+Jm2OdezNsyc2JLfhZrfy1eyhXORDESjWrWcL/t8R4mAmPdQb/
    moC2nX438wDPyoVvxVMBbAPk/FUGOlVmGBZsu8YdHghGcWCmXCZSO/kvSEiNSGEjXyEZWL
    VfGu5gm0Dviarg2PvihYZ5nu4RY/QH5sbsoj7dybZC3NmIDmgsZ2oGSMt3pluUbB/hz/UL
    GK5uLpZvY+E3hVxjLoZHqASOV3GQE1UPlpulPUk6qjtrzqSw3ynvScnfg7eA
X-ME-Proxy: <xmx:7eTQam8G2YyEnHA_BVr13Z2B9QXT3OCPp0FPNM6vXkGtfEE8dasmVw>
    <xmx:7eTQauf6TQ1ToOfjRoNvoZrzEzcgL-3FkOa9HR4X-3_jsOBcOUD-Hg>
    <xmx:7eTQavHZ9MJxSbMtbHCmaxQRS2byvGqAu6IwI4aPwvAMA2jLov_rrw>
    <xmx:7eTQasfSzPD3CRQgCE7fZpqMKTspgImQFXc_NFKBypMGDdhNc8hMvg>
    <xmx:7eTQakd7buZErmsEfr5CgZ7aLziwdSh2WYPIAGtFWLE0OgJY2q7DXlMS>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 2E73122C00A1; Thu, 15 Oct 2026 10:36:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AgdWeLtCs7o3
Date: Thu, 15 Oct 2026 16:36:07 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: git@vger.kernel.org, GGG <gitgitgadget@gmail.com>
Cc: "Harald Nordgren" <haraldnordgren@gmail.com>
Message-Id: <fbbbabee-c586-4305-bdfe-3f7cb46b7191@app.fastmail.com>
In-Reply-To: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
Subject: Re: [PATCH 0/3] reflog: add --operations and --historical-branch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 15, 2026, at 15:13, Harald Nordgren via GitGitGadget wrote:
> Create a better reflog. Follows the discussion in
> https://lore.kernel.org/git/akZfm-igZKeHaDST@pks.im/.
>
> "git reflog" lists every step of a rebase and every branch switch, which
> makes it hard to see what was done and on which branch. This adds two
> options to "git reflog" and "git log -g":
>
>  * --operations shows one entry per command, folding a rebase into the entry
>    that finished or aborted it, and leaves out entries that change no
>    branch.
>  * --historical-branch decorates each entry with the branch HEAD was on when
>    it was recorded.

This sounds very useful. That you rebase many commits and then the reset
points (where each one started and ended) get obscured in the reflog is
classic for me. And I think many have had the same issue. This is why I
sometimes use `ORIG_HEAD` instead, or maybe make a backup ref.
