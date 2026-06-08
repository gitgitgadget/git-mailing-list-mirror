Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A6E19EED3
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 10:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780916198; cv=none; b=Mg8Yl310I2IIucMMMFLtGmy9wY5KyVuUg7VHmrfIIbpFCRqYPTQnRZU1Pt1Bi4a3McmQ4gyRDeY63+P1bZUlGSEG8aFo8z5bZdaBel7Fzx8XWmEU2FuEQOkjRpqNLKGtiQHupTS6BOz0Q1I3u8wCrLsCcc/bLtSSjv4hJf+1xK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780916198; c=relaxed/simple;
	bh=snthnn8/U/8zqGsQOxFKAhiMF6KDgn5hAtLQgNeztYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fRHWnZIfcGCF5q7EULvGN7EAjmPacZs+fypuw6TCGguaxgxn0sFPuPYjptsq/KzLVO6qbYYEjZNQzvSKUJ2ieHExBMdjj1FAB8Z3iQE5XCHKcQus06n1ZspPVyFp2WPp3o9UpObqOoJ0LU1MDKDnh7nph3X4mqUT9RbnksJtOaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bo9nZ4/y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H/mIWQNg; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bo9nZ4/y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H/mIWQNg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 50A02EC0218;
	Mon,  8 Jun 2026 06:56:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 08 Jun 2026 06:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780916195; x=1781002595; bh=G+8KAY+rWo
	2dZvad6HqVcijuRFFJAKBlPiBItFH5eVc=; b=bo9nZ4/yqcO927e2pNt8OBmFar
	udiZTIiAQrD8TaqYY11HPsW4Q+TnBNkmw6nYiOcbUK0SGlVhTdOhD/ee/QUOUM3l
	zvl7XR9p/EgiCOVDGTKGzbvD2PVzCycKM2jjigEYukU5xmTMIJlCGBxRP8FTFWBm
	j3oy+j1hZflsQpMISKenqB3yFnp50qPzlqZ4SywVe1nHcSIcdBxmtIfDhnJtKvmi
	Sf88cOCfR7Hz7vdlY7YB6y/AMjtUNG6npsxicqKsvLjd+CIfxdW3G5a0nqKkg5Jp
	Nwrt7tOERr8AS5CL9/rwOKrYKKVZcxypBYzRY5oFemQcmGpa/hc9FZB+DjWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780916195; x=1781002595; bh=G+8KAY+rWo2dZvad6HqVcijuRFFJAKBlPiB
	ItFH5eVc=; b=H/mIWQNg5ud43I3ndXUj5rVnySrw8GEoCglvp51gKP+fUuuiBg3
	9ZnjErOBlE6S7PfvnBbdmdCyHHfcnGVr22iDHHyc+y3fGq6OgbqmJs0c9CCwFJ32
	yquyMHBFb/xMp9p+sMg5rDIqdE0LeVC6QSw6r+C4d/p8s22SV4JcGLbp86aVtgvh
	RSCsaN+9LLD0ClDeCwD1+mDozo4oloMsFoWpztJ8HzTvWiHw20Qt9SZU78z7imxH
	fuL2fyDuUzeWEUiRMqDOVgZ9sZpWw/P8/43t7hWn7JX/uifsmgEMyJwGDFvh14rM
	dHW0fVmJ5sR4nw7mKCk3FHPfgkpuLXTPFUg==
X-ME-Sender: <xms:458maoUSrrGWtQa2pK5KFOnmeW6otT7bSzCPSw3Tnu_QlrbHN2412A>
    <xme:458majkhjNfQrfTEyTk9tg3dpdHa9JKe2i4HILNH6QLet3qIrHecPdETcjbvJYLdo
    PgjmwZzNNHWdvssqW_dD_6kXTEqLlDdsGlay5S2Qz6tcg1Pn8aE>
X-ME-Received: <xmr:458mahZp-SiLjf3XMkk4mHyFCsm1_4x-gPrmo3vasn7k9iqjmNDHD073xJIvUAMKcMLM1jFRDywUWxagMAYuqOxLEwTYjVpafLqe>
X-ME-Proxy-Cause: dmFkZTEgLY0ebErR3KPS77iJ6f03u361gsFGlJo7jiq8pUgkz5dC8wPTFstB+/jJl1G/KB
    i972wiXREtyJXEsh8X50IsYXuCOSe2Wr3Z/iOn84JNeS7KbMmgH/fwzCtZ6bZgOTs9YWr1
    bpVa0waWl9ljkcVGJfxUL037C+MLWKZ1uJEsiwxWr3XG6VM+xmNLogaGrcDXQczyMQ+ed1
    QAOA2ZjEhJibUqZ1loAOl5UDNnATPbvui7mlKlxeFtSK3cl8hCWJsspMuumJg3iEtkyQZA
    jWLUOMBTwfo6W57BBGZbFx45/t8b3lqeq6DLQ/2aGLTRkIkrqD7xjPCA9g8vTCZlj/tLTr
    FgrgF1cbbAaEjCyytn/Cs1Zg07MFBp4V7rUcVb8dQsBo6MZEFCz2RmyYEBmg4M77oGdoqS
    wmJ3V1Q6shdyT4cheJerpia0fro2ZRApEFSY+p/brReNgj3nmshupcgkSHWFlPUh+DB5Tr
    xJHHKyOGkEd8xMJYwyRSUGKmyO/F2fRWyG63vnDLjIQWD+Sv6nFBdMD4wtv1c13HOG7Oxh
    itAfiRH7aAiVWU1AEMYcS27uNECp5j0sMuHuPecRS08JNZUR3XH4OoFxblAQkyz6QiE4Xx
    xL9yLql8baX3PdN1Oqr4l8pscM3RU+Xm+7LccEE5DA0EzBHXcFWU0qCIeh3A
X-ME-Proxy: <xmx:458mamOQA1SoyCCGcroekbxI-UyYyrUol8QmosR1V0TsqNDnfnSlEQ>
    <xmx:458mauahwptp9HghSGOebbHCJN3xEy717ZRw2UAWOMpjuG-mHzigFg>
    <xmx:458mas3g8TFCt0grcpMhKmNeZjKc56FGY2BPiqMKs-ajwq_xxacc8Q>
    <xmx:458masf42x61AnEDfGa6s7x1VSE1JUwiUX0O5Kf_jQW8ecn0pt3n7A>
    <xmx:458mauxwjBinCTpdw79O2GdvI6Ah8s5B-Zj5Eg5yZJWY7HhZa9r5kVAl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 06:56:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Andrew Kreimer <algonell@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3] doc: fix typos via codespell
In-Reply-To: <3398ef40-1547-4324-2cfc-97b9e2b24854@gmx.de> (Johannes
	Schindelin's message of "Sat, 6 Jun 2026 22:23:29 +0200 (CEST)")
References: <20260506101631.18127-1-algonell@gmail.com>
	<20260602111552.6084-1-algonell@gmail.com>
	<xmqqzf1dujtf.fsf@gitster.g>
	<3398ef40-1547-4324-2cfc-97b9e2b24854@gmx.de>
Date: Mon, 08 Jun 2026 03:56:33 -0700
Message-ID: <xmqq8q8p1ese.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I'll squash the fix-up I already had into [v2] that I have queued,
>> which should be sufficient to get to the state this [v3] should have
>> been, I think.
>
> The mechanical nature of these fixes explains another issue: One typo fix
> touched two test fixtures which might seem harmless at first, but those
> fixtures are littered with checksums that relied on the original
> (misspelled) form.
>
> Please adopt this follow-up into ak/typofixes:

Thanks.  You often keep your eyes peeled to spot these forgotten
bits, which is very very much appreciated.

I briefly wondered if this was to be done by me or it was an request
to Andrew, but since I've promised to squash the update into what I
have myself, I'll do another squashing into the result, instead of
asking Andrew to update the v2+v3 with these fixes.

Luckily, b8b38eee85 is *not* yet in 'next', so we can just squash
the [v3] from Andrew and this fixup from you into it to keep the
test passing with or without the "typo fix", to maintain
bisectability.

Somebody has to come up with a bit of tweak to the log message to
explain what has been done in all these three pieces when it
happens.  I may ask some agent to prepare a draft, review it myself,
and perhaps redo it myself from the originals without taking
anything from agent output, as I am still skeptical about all these
AI hype ;-).


> -- snipsnap --
> From 54aa4f7f7adf0c0e02b5463b5f7f64547e80cbce Mon Sep 17 00:00:00 2001
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Sat, 6 Jun 2026 22:09:04 +0200
> Subject: [PATCH] svn-test-dumps: restore checksums after the `hapenning` typo
>  fix
>
> b8b38eee85 (doc: fix typos via codespell, 2026-05-31) ran codespell
> against the entire tree and rewrote `hapenning` to `happening`
> inside the body of `t/t9150/svk-merge.dump` and
> `t/t9151/svn-mergeinfo.dump`. Both files are Subversion dump
> files: each `Node-path:` block embeds `Text-content-md5` /
> `Text-content-sha1` for the new content and, on copy operations,
> `Text-copy-source-md5` / `Text-copy-source-sha1` for the source
> content as observed at the cited revision. None of those
> checksums were updated, so loading the dumps with svnadmin 1.14.5
> (present in `ubuntu:rolling`'s CI image) fails immediately with
> `E200014: Checksum mismatch for '/trunk/Makefile'` and the two
> tests stop before any of the assertions they actually exercise can
> run. The CI failure has been visible on every `seen`-based
> linux-sha256 / linux-reftable build since 2026-06-02 (the first
> run that picked up b8b38eee85).
>
> Because `happening` and `hapenning` have the same length, no
> header byte counts need updating; only the embedded checksums do.
> Recompute the MD5 and SHA1 of every text body in the two dumps,
> and for every `Node-copyfrom-path` consult the path's most
> recently defined content to refresh the corresponding
> `Text-copy-source-md5` / `Text-copy-source-sha1`. After this,
> `svnadmin load -q` accepts both dumps cleanly and t9150 and t9151
> get past their setup steps.
>
> This commit only touches the two dump files; the typo correction
> in their surrounding human-readable comment is preserved.
>
> Assisted-by: Opus 4.7
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t9150/svk-merge.dump     | 10 ++++----
>  t/t9151/svn-mergeinfo.dump | 48 +++++++++++++++++++-------------------
>  2 files changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/t/t9150/svk-merge.dump b/t/t9150/svk-merge.dump
> index 6a8ac81b11e6..3c46afc18a65 100644
> --- a/t/t9150/svk-merge.dump
> +++ b/t/t9150/svk-merge.dump
> @@ -71,7 +71,7 @@ Node-kind: file
>  Node-action: add
>  Prop-content-length: 10
>  Text-content-length: 2401
> -Text-content-md5: bfd8ff778d1492dc6758567373176a89
> +Text-content-md5: d6a3917748b0c09ad85c2783f1d4dac1
>  Content-length: 2411
>  
>  PROPS-END
> @@ -201,7 +201,7 @@ Node-path: branches/left/Makefile
>  Node-kind: file
>  Node-action: change
>  Text-content-length: 2465
> -Text-content-md5: 16e38d9753b061731650561ce01b1195
> +Text-content-md5: 3f413450a7a26596d9e512ee385a9b19
>  Content-length: 2465
>  
>  # -DCOLLISION_CHECK if you believe that SHA1's
> @@ -305,7 +305,7 @@ Node-path: trunk/Makefile
>  Node-kind: file
>  Node-action: change
>  Text-content-length: 2521
> -Text-content-md5: 0668418a621333f4aa8b6632cd63e2a0
> +Text-content-md5: 89788781014278d76ff23648b8b08b2d
>  Content-length: 2521
>  
>  # -DCOLLISION_CHECK if you believe that SHA1's
> @@ -412,7 +412,7 @@ Node-path: branches/left/Makefile
>  Node-kind: file
>  Node-action: change
>  Text-content-length: 2593
> -Text-content-md5: 5ccff689fb290e00b85fe18ee50c54ba
> +Text-content-md5: 706d73919e6f319a0e624aa50c8b8b38
>  Content-length: 2593
>  
>  # -DCOLLISION_CHECK if you believe that SHA1's
> @@ -529,7 +529,7 @@ Node-path: trunk/Makefile
>  Node-kind: file
>  Node-action: change
>  Text-content-length: 2713
> -Text-content-md5: 0afbe34f244cd662b1f97d708c687f90
> +Text-content-md5: 1c05266da99e8f01a5ccf816be47a484
>  Content-length: 2713
>  
>  # -DCOLLISION_CHECK if you believe that SHA1's
> diff --git a/t/t9151/svn-mergeinfo.dump b/t/t9151/svn-mergeinfo.dump
> index d5e169563745..ad741400104e 100644
> --- a/t/t9151/svn-mergeinfo.dump
> +++ b/t/t9151/svn-mergeinfo.dump
> @@ -80,8 +80,8 @@ Node-kind: file
>  Node-action: add
>  Prop-content-length: 10
>  Text-content-length: 2401
> -Text-content-md5: bfd8ff778d1492dc6758567373176a89
> -Text-content-sha1: 103205ce331f7d64086dba497574734f78439590
> +Text-content-md5: d6a3917748b0c09ad85c2783f1d4dac1
> +Text-content-sha1: 9ffe895eb95d4a7c2ee2712dcf7a13637edee6a9
>  Content-length: 2411
>  
>  PROPS-END
> @@ -194,8 +194,8 @@ Node-kind: file
>  Node-action: add
>  Node-copyfrom-rev: 2
>  Node-copyfrom-path: trunk/Makefile
> -Text-copy-source-md5: bfd8ff778d1492dc6758567373176a89
> -Text-copy-source-sha1: 103205ce331f7d64086dba497574734f78439590
> +Text-copy-source-md5: d6a3917748b0c09ad85c2783f1d4dac1
> +Text-copy-source-sha1: 9ffe895eb95d4a7c2ee2712dcf7a13637edee6a9
>  
>  
>  Revision-number: 4
> @@ -228,8 +228,8 @@ Node-kind: file
>  Node-action: add
>  Node-copyfrom-rev: 2
>  Node-copyfrom-path: trunk/Makefile
> -Text-copy-source-md5: bfd8ff778d1492dc6758567373176a89
> -Text-copy-source-sha1: 103205ce331f7d64086dba497574734f78439590
> +Text-copy-source-md5: d6a3917748b0c09ad85c2783f1d4dac1
> +Text-copy-source-sha1: 9ffe895eb95d4a7c2ee2712dcf7a13637edee6a9
>  
>  
>  Revision-number: 5
> @@ -254,8 +254,8 @@ Node-path: branches/left/Makefile
>  Node-kind: file
>  Node-action: change
>  Text-content-length: 2465
> -Text-content-md5: 16e38d9753b061731650561ce01b1195
> -Text-content-sha1: 36da4b84ea9b64218ab48171dfc5c48ae025f38b
> +Text-content-md5: 3f413450a7a26596d9e512ee385a9b19
> +Text-content-sha1: b3cd389d63c5e3af4fe22b7464cf97968662ad1a
>  Content-length: 2465
>  
>  # -DCOLLISION_CHECK if you believe that SHA1's
> @@ -359,8 +359,8 @@ Node-path: branches/right/Makefile
>  Node-kind: file
>  Node-action: change
>  Text-content-length: 2521
> -Text-content-md5: 0668418a621333f4aa8b6632cd63e2a0
> -Text-content-sha1: 4f29afd038e52f45acb5ef8c41acfc70062a741a
> +Text-content-md5: 89788781014278d76ff23648b8b08b2d
> +Text-content-sha1: f52afb2d6230e5a418416b77c3c9ad610edfd202
>  Content-length: 2521
>  
>  # -DCOLLISION_CHECK if you believe that SHA1's
> @@ -467,8 +467,8 @@ Node-path: branches/left/Makefile
>  Node-kind: file
>  Node-action: change
>  Text-content-length: 2529
> -Text-content-md5: f6b197cc3f2e89a83e545d4bb003de73
> -Text-content-sha1: 2f656677cfec0bceec85e53036ffb63e25126f8e
> +Text-content-md5: abcac8d04eb061b0a3053e359e44a2a0
> +Text-content-sha1: 866caf95e04809a5ed897aea41075b24833612ea
>  Content-length: 2529
>  
>  # -DCOLLISION_CHECK if you believe that SHA1's
> @@ -572,8 +572,8 @@ Node-path: branches/left/Makefile
>  Node-kind: file
>  Node-action: change
>  Text-content-length: 2593
> -Text-content-md5: 5ccff689fb290e00b85fe18ee50c54ba
> -Text-content-sha1: a13de8e23f1483efca3e57b2b64b0ae6f740ce10
> +Text-content-md5: 706d73919e6f319a0e624aa50c8b8b38
> +Text-content-sha1: 9992d5a9aea960c7856ef6a9364aedd5b710ef53
>  Content-length: 2593
>  
>  # -DCOLLISION_CHECK if you believe that SHA1's
> @@ -689,8 +689,8 @@ Node-kind: file
>  Node-action: add
>  Node-copyfrom-rev: 8
>  Node-copyfrom-path: branches/left/Makefile
> -Text-copy-source-md5: 5ccff689fb290e00b85fe18ee50c54ba
> -Text-copy-source-sha1: a13de8e23f1483efca3e57b2b64b0ae6f740ce10
> +Text-copy-source-md5: 706d73919e6f319a0e624aa50c8b8b38
> +Text-copy-source-sha1: 9992d5a9aea960c7856ef6a9364aedd5b710ef53
>  
>  
>  
> @@ -761,8 +761,8 @@ Node-path: trunk/Makefile
>  Node-kind: file
>  Node-action: change
>  Text-content-length: 2593
> -Text-content-md5: 5ccff689fb290e00b85fe18ee50c54ba
> -Text-content-sha1: a13de8e23f1483efca3e57b2b64b0ae6f740ce10
> +Text-content-md5: 706d73919e6f319a0e624aa50c8b8b38
> +Text-content-sha1: 9992d5a9aea960c7856ef6a9364aedd5b710ef53
>  Content-length: 2593
>  
>  # -DCOLLISION_CHECK if you believe that SHA1's
> @@ -942,8 +942,8 @@ Node-path: trunk/Makefile
>  Node-kind: file
>  Node-action: change
>  Text-content-length: 2713
> -Text-content-md5: 0afbe34f244cd662b1f97d708c687f90
> -Text-content-sha1: 46d9377d783e67a9b581da110352e799517c8a14
> +Text-content-md5: 1c05266da99e8f01a5ccf816be47a484
> +Text-content-sha1: 0cba212974e2b288389d73317f3220be11158e00
>  Content-length: 2713
>  
>  # -DCOLLISION_CHECK if you believe that SHA1's
> @@ -1166,8 +1166,8 @@ Node-path: branches/left-sub/Makefile
>  Node-kind: file
>  Node-action: change
>  Text-content-length: 2713
> -Text-content-md5: 0afbe34f244cd662b1f97d708c687f90
> -Text-content-sha1: 46d9377d783e67a9b581da110352e799517c8a14
> +Text-content-md5: 1c05266da99e8f01a5ccf816be47a484
> +Text-content-sha1: 0cba212974e2b288389d73317f3220be11158e00
>  Content-length: 2713
>  
>  # -DCOLLISION_CHECK if you believe that SHA1's
> @@ -1408,8 +1408,8 @@ Node-path: branches/left/Makefile
>  Node-kind: file
>  Node-action: change
>  Text-content-length: 2713
> -Text-content-md5: 0afbe34f244cd662b1f97d708c687f90
> -Text-content-sha1: 46d9377d783e67a9b581da110352e799517c8a14
> +Text-content-md5: 1c05266da99e8f01a5ccf816be47a484
> +Text-content-sha1: 0cba212974e2b288389d73317f3220be11158e00
>  Content-length: 2713
>  
>  # -DCOLLISION_CHECK if you believe that SHA1's
