Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E77B5476D0
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083947; cv=none; b=HBpfKNobGCChKBMssXds+aWdnUdDTINw76EiXZXRgePL1NVF+vnGA+6QDWShfN4bw2dunF7nr/TiKkd2/kchgvwJ3NbQWi0qr1R7wVd4s+4fzszqS9ElTrBB2oNiNd8JuVS87YyOmvGKbBt8ZEalLKeA2C5x0UCKJ8K/weql+uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083947; c=relaxed/simple;
	bh=7XLi3IlqKSDWGvNn4SCzO7Eb+Qp9VsC1rUeBrJNnV+8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C6lOPomEG4qJkMe5DJlX/J86uXTZb17CpgDx/CUW5l5nzRO/ZBLUA7RT+IP+yIFb96zZaGTCQ1B4r2c+/FNJBfOjdfrMuGuYWTGLOgc5ciBa8LCf/c9khZYI91ddgbrLbXxoYUnQI9Iv8lSDbzyNwJY6zxCucjcB7IbRzotGYUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gVVuQGlb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZopSD82S; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gVVuQGlb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZopSD82S"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 17C627A00CA
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 13:05:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 15 Oct 2026 13:05:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792083935; x=1792170335; bh=Li5kgOxy6k
	ApGHcy/NSiYEFHZp7efl2BtBwNftuRk6E=; b=gVVuQGlbMQX/8e8Qiy8+Ki3QTv
	ON+8iLre6TZqXVR/eNdqoMKfP+E8lOEo0DRX7MTOXcQ3ePyPxI9I58x99AC1o82m
	o1TN8iTYfeE8s9xl3IO9WJoSA3dRt9jN59q6mmMh6+q37DsEQV/0lWmRjt0hNe1e
	G694osyT/wdGjJgiIhCkyV9bUJxq1MzlgXU0iewcSnhJFUQGbxjmUYNx5sBpwWj6
	sJaePs533qShlNs3QBHozTnyiBy89uh7m4ZFMauVCCPYiHi2PCISfrePy1G7H5P0
	C/msP2y8zTPaUiFTjShRKE8Hh40ZFMSl8BSsYORJOAB65BWF/+pjhYjlPBpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792083935; x=1792170335; bh=Li5kgOxy6kApGHcy/NSiYEFHZp7efl2BtBw
	NftuRk6E=; b=ZopSD82SCHWP0J3UdqAJ5QMSvItO2ihPpnxXqNVQGX7hGT0V+0+
	HonSOZZT1e5LQq1wyeaHlL0yC0awfnLokh3+HK2IUsDReKzLqsLzFPCRWaB9iu7e
	LjcxLobIZBU+X6OCb0M60NthhtyMIbPhDPPMDyRxyA9H0/EenjNV4qrusbuCW2ou
	HTKqqABa1bvsRVsjyvHfAQyPgTbkmpEYm02DslM7vs9BPgFjrGdgupNg/wAaIF/w
	8W3ikudbp8lemoCzEs55dn5jNWzEqnVSAnn8RXEYl0sSICv9iM7KiBMUSG45HDAg
	rE4s4RbVWkePOlMaqrXl+fhGHwOajgqu99Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792083935; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:NrtiUPgV99F+7bsBQDY9PVU1OEZ7usuXjd8pGM5O0zfqiNX
	lpIVhdyG7Xec3PfVsQS7xxUgEOLb/5MpinPHeVkYGwo24UzpaTtOP278tN7wi9oY
	w3Zk/PRGJR6ilXszsxlDywynQ1crQC5HOnN2vlxPOXFyOUfSsDhxfSDqgojmwZm+
	+9VrBaylX3rFtYf8sd/vAEVDTmSOAyYqynci+C4lXyWXc/CN3+akqxCvwZ6tKrrc
	UHksh5QNYtg18x5+NyDXlaT+1ZqG/phJTTuO+Bb7hXBMwma3JuvhMgnrXpaMormH
	8i2gxCPAI7Et0hPNuBMiglFSkc7/wJnMgGJNTbw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:umlaZUfQgs9SXSBmjKlCCdprk7TLskdUEooLSJzw0VQ=:7XLi3IlqKSDWGvNn4SCzO7Eb+Qp9VsC1rUeBrJNnV+8=;
X-ME-Sender: <xms:3wfRamlj0NkFzqgiNCN3QGKkPaIOMR3v8ssGNcqzjG-7ChnJX494CQ>
    <xme:3wfRak1qBQ1DKAgk6jsnUVVYUJxzuHHUxYjtpYnPEjG1Rh2UtbPAdh8KkLnsPXEBj
    pPveqrZGS4JvFuyYekazjf9vV62PW3GNpaVjrMo-Jc4gNHujLs4P6k>
X-ME-Received: <xmr:3wfRapp-tZtG1SF13KApS3z_pBzhVzsalPsFyhUsTZDR_pdcLaQOtclLdvfzj7eDNmKjL22faZltQ59c7OzYELV5F-NyjQFgXDNE>
X-ME-Proxy-Cause: dmFkZTEpVb7O+G2Q/LccZdfQfsLC6+gbCPjrhGhRZWrCWKqxQsWU/cbUwsjvg+i0AVgNzb
    CTOzwv7rAsEH2hwNGggh+te1hkZKbRkrFEih+/12JK+At5gVJDnBezwARJRhujHqQthUUX
    RPIEFY5zWGt/St1uzmMGiGCmuntWCVKT1vuZAPJOt/+jn9LIhH/Om3lsUD2h2/MnTFc0lb
    fBA5R7peUETFDEygC1QIezkjPjidbtkZ2xzaaPsCiZ87h6foPIz58mpcEA7Oy8RGCcZ+lp
    mOQAL5LMHVPy8l5Td3RLgHZaWjIiBAEoa8ANxkxTexjYlmzV6mLc9eZ5TTkWMKSy+iHzBI
    zTJIbmM8ccQrzSCB7zgQbBID3PUNJtMPfESoddAIeFJWDrioCWif2VxrRzMB0zckgLBpAm
    7OcBmX/aFka6T6lQnTI9957/BHzfhvYbaduym7JIAZDX7oQqgRd4u7aJls88qGJMJGfZ2F
    LnR3EkVmiGYc4u4CFEnUif9S17MU15b9onHnRy+SvEz7jBkjy90s2gVUKuYFRFH+mkiDnf
    0pc+iofd/YoXo2U43z5XIN1MxecQ+zhx25xdL9dg1gruE8jHYIWHBkt037Hz3vfqEzDvcV
    mxQuwCMVa/C15+7AASSXBOiKXa34pKrSX/Y8rIdq9DkijzZLrd+tTQb+iMVA
X-ME-Proxy: <xmx:3wfRapdRHXfQLgIbrkF2RCLCGwg6jUNEobyRjy2QzFVWNO9Jdp7yNQ>
    <xmx:3wfRagqdPuWxvASrMmNV8B-krCqf5pap_o_zr063Ww6fDIv6LDBoSw>
    <xmx:3wfRaiEnjpwFWXhNrNseWes9zBDps46NtUb_WuwO0PkuMsC7S00RWA>
    <xmx:3wfRaotiBZjDrCxY2Onx07YtSt-T20PVbVGjdIyl_hH0YM92sElUoQ>
    <xmx:3wfRalIp1Q0Lv4G344hq8AMdRE7d1FAsvq47gO-F5I69WVxJq43gqCBo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 13:05:35 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: jyotish kumar <jyotishkumar725015@gmail.com>,  git@vger.kernel.org
Subject: Re: [RFC] pull: custom fetch refspecs and fork-point lookup
In-Reply-To: <CAHwyqnVX+FBbihdXA2jxDoweKv6wnqr_rtb110uqLrzNVRAZfw@mail.gmail.com>
	(Harald Nordgren's message of "Thu, 15 Oct 2026 09:17:10 +0200")
References: <CAGjZMyTQt2XEF69pJWHA=diRjoidixGs48E1vA0ytGUgZYOZNQ@mail.gmail.com>
	<xmqq5wz4rthd.fsf@gitster.g>
	<CAHwyqnVX+FBbihdXA2jxDoweKv6wnqr_rtb110uqLrzNVRAZfw@mail.gmail.com>
Date: Thu, 15 Oct 2026 10:05:33 -0700
Message-ID: <xmqq4iemq4gy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

> Yes, seems like a hardcoding bug.
>
> Is this for an in-flight topic that Jyotish is working on, or
> something already in master?

The former.  You can see the thread in all its glory at

https://lore.kernel.org/git/CAGjZMyTQt2XEF69pJWHA=diRjoidixGs48E1vA0ytGUgZYOZNQ@mail.gmail.com/

which is (still) quite short.

