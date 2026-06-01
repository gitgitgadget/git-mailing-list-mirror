Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975DE846F
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 01:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780276576; cv=none; b=NzrlHIqd/8/N1etRB1yKFCG1F2W8LMMFOfIK4te86MNsdnU7huZhPLK0fyWJs7rAu367bjzzKmy10xqDYy80V3XeDuUtvzM1wVBk8UgeTUFatIdkumMU7roeuukFS/xgTodWbHyWYJTng/QXhx1ngBgvGFyNTfvZTprrmscGtxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780276576; c=relaxed/simple;
	bh=YrDynY4kEJObGJpOnITN11tY2R508fNEdYXk/OVyrU0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ctH7QQOlGKQ2jrZiUzr/Eu4HEUZaeY0R+s8n+y7cn0RpkVeXRUi5UcPRnUQ1wTJ4f1o3/orvyJwjJyNrTsui+l+wMil9/QMCTf3wYFz+ztXRMaj7gp5d98MfPw/Q10nr8AMXEpNwfcBAych8ZsRczIHTThfnqkDavne60W9jGQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RMnBK2m5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ovDF7ipm; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RMnBK2m5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ovDF7ipm"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id A62A11D00188;
	Sun, 31 May 2026 21:16:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 31 May 2026 21:16:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1780276573; x=1780362973; bh=9sYHotS7DU
	5fCh9D69+evX9MoveG1uX0PPQJh/4hYl0=; b=RMnBK2m5KhlHC7JUnnJNfUKMmP
	IJGpry+YfDHfzp6JtpPQiEDKorZlr3/WEg102Zl4IXOJQ5rrkC5hkAZYyYPtEmf8
	GI62ivAKRhFRNhlLRmkJbe09cLoTB59EAOcsb5vyZW7A8WrZkD1mB4IDsruVk0rf
	NWvDKHDjQdUXidh27scK5Zf1OcpDd9h4Vbo65Ao5nidVg5SIlEjHViTNGymBfevL
	0xxgh02ORONw+67g1wakgGtTySPPIqRaxOW/D0byTcDwc+Cmu8buOkEXs2/k91ae
	68XMJA1REGAjg9nbdP7zU23641crPCN8VItQvmDqHhcfMISd9Lo6GIQhoRtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1780276573; x=1780362973; bh=9sYHotS7DU5fCh9D69+evX9MoveG1uX0PPQ
	Jh/4hYl0=; b=ovDF7ipmxqdhBhf7bwu2iAeMe71GThXIlg2u1yVHvW97VlYkhDf
	ppP5pIfKta7ctDxjjllrCBPrjv06LeIAzGZ+fjzpksp8o6MYvY6fXALSiOhwy0wO
	MV4TA/huP8TrkCmZloCT5zXUsn3F3BBxUpJGwfOzuEAOcJ3015xTszq1QvyXm/9X
	krIc+2X4hJwXnMsTwAgBciqWNWx5DJh5vH04LD/vRiWBwJwgT+39fLKLm3jMi0Qk
	whFK9vD/djgyktxbz9ExvnxdII2erZMMuuNOTLaFRoBUZliGhB7g4irr9btar4kF
	gARj+ianT4qZgAbkB6asv/yRIv8DUv3/glQ==
X-ME-Sender: <xms:Xd0caoNjFRoET2p_UO0WlGSL5DZ_CjFo7coDFbby0WPlq7a96O22FA>
    <xme:Xd0camYIGVs6BB56610WQBIGVm3BtZeaDQI_jzhyztx7XwxXEMjmwfHlz2wN8eHI8
    xR49kJM3cO9cGM2qU0K74GdYqgRRewJv_cmQL4tCd2ECQSWYWYo>
X-ME-Received: <xmr:Xd0caso_uq1kMqkDTX37AaTjQ_DBlkiDn3Y-stGg4pxuivILbSOKK7LNPEYB_VlqR2GTS0G9bMlULjobN3LMwbUw4_yd0N-UFkcN>
X-ME-Proxy-Cause: dmFkZTFH44GGxyfAsaySNlSJxTXWRhoieNl18z+TTAR+btkug2eehvodBGpzx6n5TSlWCU
    vqdgBjvsxjIsGctbzhdi9CgB5oZgjNkp2qUDjOk3ZfVoKQqKxKtDqYf/SXVfzycvSV4ODB
    +MuX0elhVc1Jof9bKwcHSHfa0a+h1wjMeh8UvF8hu1BTILDDNwqT7MPNR0Vxkm3Mr8CkYG
    h7C6v0M9hAC7yAfOCeIq7kkWVznU4mr5FY07LqjyklXWVrmOxkK1UlqHW+8A+QPt2hmZXY
    fCWjRQ8s8qRzTfcn5/wsqT5vUR/HBwUNw9PWA8gXulpYiSQQqopJZbHGv9mj0JN5k1vibl
    BCDQyxe76KpLhRY/ZnsRyS3Q7GBORh2ZpCJFK4a9LL+7oWUnc+p5gfi3GqgCmdzC+UrB4j
    MwK3ZLXMnrHem8n/5AvveVpv1TcMGipOLyBQNXxLd4ijwbXyV65Ek7F0UP/ogP5Me1tuXp
    uzX0enEN4blGoQfWS2tnlKMTD1DzIsDQ3q7rBZBVW/i0bZMhUzOEMmPhpdd2lZOg5VQjMc
    ZcjdkPDXAhwll+O6Vn6w6+tPZ4T5cwfpuS1c90feNJHifuzRHDv8567VFyFXnfVvnYn9O7
    4aag7oZZxdxjxDKHOEibC3WoQzh2xaGl39zlm70ZkqEuGgn9Gg6c2BIaI4ag
X-ME-Proxy: <xmx:Xd0caqYonzBJ2m9DBh77Xsxo8M8oT3otZ4yDE9sSLbDVA1E4xYq-EA>
    <xmx:Xd0cakTusomIJB1nMobE4-uORq_xySN-L6KqfCjXC9G8UZH7_VLqUw>
    <xmx:Xd0cah4MggwU9scwtfLoBSbXJic7GCmZU-4Vs3MuMTeZ0juOsBm1cg>
    <xmx:Xd0capwmvccaPGBzf81Gcdn2CZIO2Md7TXrOBIdg8-x124gLo63zqg>
    <xmx:Xd0caibumE9S7COWsAJj977ig1WTNUm7rKjpidRk5sVp9BwKtXV_F1Z5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 May 2026 21:16:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Andrew Kreimer <algonell@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] doc: fix typos via codespell
In-Reply-To: <20260531184428.55905-1-algonell@gmail.com> (Andrew Kreimer's
	message of "Sun, 31 May 2026 21:43:58 +0300")
References: <20260506101631.18127-1-algonell@gmail.com>
	<20260531184428.55905-1-algonell@gmail.com>
Date: Mon, 01 Jun 2026 10:16:11 +0900
Message-ID: <xmqqo6hv9i1w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Kreimer <algonell@gmail.com> writes:

> diff --git a/midx-write.c b/midx-write.c
> index 561e9eedc0..19e1cd10b7 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1461,7 +1461,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
>  
>  		/*
>  		 * Attempt opening the pack index to populate num_objects.
> -		 * Ignore failiures as they can be expected and are not
> +		 * Ignore failures as they can be expected and are not
>  		 * fatal during this selection time.
>  		 */
>  		open_pack_index(oldest);

You seem to have lost the following hunk from the previous round

diff --git a/midx-write.c b/midx-write.c
index a25cab75ab..6d6d29c6cd 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1152,7 +1152,7 @@ static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_c
 
 	/*
 	 * Ensure that we have a valid checksum before consulting the
-	 * exisiting MIDX in order to determine if we can avoid an
+	 * existing MIDX in order to determine if we can avoid an
 	 * update.
 	 *
 	 * This is necessary because the given MIDX is loaded directly

but it is OK as the same fix appears in 'master' thanks to 22235136
(midx-write: handle noop writes when converting incremental chains,
2026-05-19).

Other than that, I made sure that there is no other changes since
the initial patch other than that the changes to po/ and git-gui/ no
longer exist in the topic, which matches what the proposed commit
log says.

However, there are things that BREAK tests.

> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index ac4a5b2734..869fb4a14e 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -502,7 +502,7 @@ test_expect_success 'do not refresh null base index' '
>  		git checkout main &&
>  		git update-index --split-index &&
>  		test_commit more &&
> -		# must not write a new shareindex, or we wont catch the problem
> +		# must not write a new shareindex, or we won't catch the problem
>  		git -c splitIndex.maxPercentChange=100 merge --no-edit side-branch 2>err &&
>  		# i.e. do not expect warnings like
>  		# could not freshen shared index .../shareindex.00000...

The edit above is made to a STRING that is enclosed inside a pair of
single quote.  If we want to use "won't", we would need to write "We
won'\''t", but while it may be syntactically correct as a part of
shell script, it is a pointless change, as the target audience wants
to see this line as if it is just a plain text.

"We will not" would be acceptable,

> diff --git a/t/t3909-stash-pathspec-file.sh b/t/t3909-stash-pathspec-file.sh
> index 73f2dbdeb0..3afa6bff3d 100755
> --- a/t/t3909-stash-pathspec-file.sh
> +++ b/t/t3909-stash-pathspec-file.sh
> @@ -29,7 +29,7 @@ verify_expect () {
>  test_expect_success 'simplest' '
>  	restore_checkpoint &&
>  
> -	# More files are written to make sure that git didnt ignore
> +	# More files are written to make sure that git didn't ignore

Ditto.  "did not ignore".

>  	# --pathspec-from-file, stashing everything
>  	echo A >fileA.t &&
>  	echo B >fileB.t &&
> @@ -47,7 +47,7 @@ test_expect_success 'simplest' '
>  test_expect_success '--pathspec-file-nul' '
>  	restore_checkpoint &&
>  
> -	# More files are written to make sure that git didnt ignore
> +	# More files are written to make sure that git didn't ignore

Ditto.

>  	# --pathspec-from-file, stashing everything
>  	echo A >fileA.t &&
>  	echo B >fileB.t &&
> @@ -66,7 +66,7 @@ test_expect_success '--pathspec-file-nul' '
>  test_expect_success 'only touches what was listed' '
>  	restore_checkpoint &&
>  
> -	# More files are written to make sure that git didnt ignore
> +	# More files are written to make sure that git didn't ignore

Ditto.

It is a bit disappointing that the changes were guided by a tool
called Codespell, yet apparently the tool does not seem to
understand the syntax rules of the language the files it is
modifying is written in X-<.

Thanks.
