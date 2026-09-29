Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABCC44F563
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710175; cv=none; b=SmwvIpkjUgv6DTTuBW0Ki8Cft2i3rC91tCXn6DKUgqzT7EDJqQat1x+ndZmC5qsVAcJYM7eoJAcfbexELDC9l5B/yLd78cHApBtRoCEtnBISqkPzGrGQBqVB2vov33sHuCbNwqS61ItXeTEWUaE7OjYYAAwOjPbR7PAe5IVMPio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710175; c=relaxed/simple;
	bh=+6liAz90zYE87HG0e4cAp98osQLwUAx3dgLIghuh7Lc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qvS0mVjJmSdS4y2oeUwkI+Dq2fwRpqwN+nwtssKE7J+vHvRBccfuVpAKUjjCW4PnMO4G3IdUk9LEg2TFBzGhz99aSYfSSUalfil4fP+ltFKwohgMfud6FGgcFTpMn/3ifCML8TEvrbiuNNQ66YvK9/4QX0+msM2A7RnF9ljG4YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h5u0Z/6A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C/xDGl2U; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h5u0Z/6A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C/xDGl2U"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id EE51F1D000CF;
	Tue, 29 Sep 2026 15:29:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 29 Sep 2026 15:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790710172; x=1790796572; bh=3NbYHGlar4
	3JpFym6JXXykKJIrxIZP57z3pofKTEkFM=; b=h5u0Z/6A95v7mz7WZELdDAsRAj
	IPRtdqBV2sxbemlg6YWRvkDjQsiPgM2QsYTIOa6Ohi0VXF6UDQuVt92B1j0dTRkK
	RBQMuN/9EgwluWu0StxMaRrYvwDLrkmUrMuhgKaDMpQL1PGpL7Z5Wc4FJBpnYfSy
	KCarG7T3k8UfbxzeJrcN83bNM/wl40973lQqthuezuHXHrH+ic79znceNMp/5Cpz
	oPDsVimzgwye0qFA0wYnHKD5zn2YpbhanTcLTGNf94emZF0GUn1Bdx3SIWLUju1+
	jenOtnMxkxqo10RhaTWK2yOVWBBKDywyE03gf/2oD+mCl9GUGC/J7zMIkZBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790710172; x=1790796572; bh=3NbYHGlar43JpFym6JXXykKJIrxIZP57z3p
	ofKTEkFM=; b=C/xDGl2Ut+qfW1ZgFRZwHu6BJoV/DhxhN1fQIU62OIpiabJZYYC
	S7ht/tpRpzJWMqS4NTuIgTGsVbyY79EFdtu1V2m3MHdeNjdwaZ/BLbfsOxoYFysc
	3F0QWdbF1o7CvpAt7FcbiaEOy7f4ai568j2LEpV3Xo4TnkFA9FNAglbn/5CfbknG
	UsTTfHZ6QnN3ysBh55ckgYANV5H9bJE1BVdhXyiHNslb2cyMuNUrPQ4burqD9x8K
	nKgKvwTckuyCUQb8iN7tQ/W+p5LTvsQ4hqrfkDy+lg3Z5fEv2hBuD1o3x0mazeMC
	TxjVXtqPGBtH4RkqR6kpjAJ2tXIAk3Kpatw==
X-ME-Sender: <xms:nBG8aisRWsUV9zlqfu5T3tJnh-J3T_racLHS9vwva2jWMOXdgMkMXw>
    <xme:nBG8auexmHOyTsReCFKNOHnB5jIICkmEeoaNse-Dz95QuRG0JTr8JXYWmqtHpmert
    QFyTquK7AZGGTmkk2NJ5n1OyQU7WGu4qnum50SgbYLUBI7giE1AUH_S>
X-ME-Received: <xmr:nBG8aixXtyhwf2w-R-WHbSGXK72FlOv8nrlwy3N6CE-C6Ms9f2ZOu9KGMQzWKEBxAGpiI39qyYOa3ce_E4WezOgMhP-WB8XxoFA6>
X-ME-Proxy-Cause: dmFkZTE7/tHlUSdoM4+8Q0gftIu/5lH82n+RgM3AOLrfUWfGqmVWgetZWTdnvYIb8Af2Ub
    DxBWOjR6JRoJCLB552Isf6HInLhOkOusZMtlf2GiRli457fs8DoZwSrtAuHC09oCLx+Olu
    vPUqRuTDTksNkioSSKay9gA9Oubp0qFM+HKcgNI0ziBYKDIyxGb/urPDeMOT6DvIgti4be
    K2y55P4/tqOc1xZZ/Lu6EbUxkPjOHBfq6ArmFikxCFMR6mBRTK56qf9+5MDX6pa7oRgaHn
    M/U8smIU4Wgrlh0M5K0jPxJKYl3aXLSUlN2Z9HyS6CkkT1thnr+Htv8exvxLPrW041erI4
    JgPQ5jY9T40oZudhzDYpcClrO1nx7rgqMX9UP9ID6uB4DEB95fRCuhPwOwDf0RiM5aCaC9
    Le+UXgEiSjH+uF0n5WkHCe9PQRFxBVniOhgfCA0bi07bYlsUAKq4X2wDRGOhgtm5ln9U5G
    S2gsoe6AN1PfBkPeSvxSg8nbefJOomYhSR0NnsGEwp4CIWVhxC9S1+2trIKma3bi3v74Yh
    b1kiJr6JUudeD2LNluuYUWUmRzbFgj4y6ucMMAtKF/pVgN0SqQahpqJDJUs4n+a7bVWcsu
    RHtZTzcrkERJ0Xasj0usg6iWzHu97EeyiXyuCTwamdJBMca4MLO7Bb33dZiQ
X-ME-Proxy: <xmx:nBG8asGzEWzVAJV0xufcFBvT7ygXLbuP8WpScj0cUHBaiAPiF4AvNA>
    <xmx:nBG8auwkNqwnWHeJJmdw2F0AmkZNKbxuwP3MtWXZgN-J_wv18A5asw>
    <xmx:nBG8alsOYPiztDVbLB-d4R3Pzfmv85DnAMmkGsphJhHxHjYs00pqug>
    <xmx:nBG8aj3ymrtHE9memhQoZgJIHXpHyc9eJS_oTfHxFnfqJzrOI2rRRg>
    <xmx:nBG8as2d-zp4ISltd09tega3Ph1eMh0Lmk5VZtD7CvzIf4JtbIc7bpUr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Sep 2026 15:29:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Brigham Campbell <me@brighamcampbell.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v5 1/2] git-contacts: allow inputting patch via stdin
In-Reply-To: <20260928-git-contacts-stdin-v5-1-e9becaebc47e@brighamcampbell.com>
	(Brigham Campbell's message of "Mon, 28 Sep 2026 23:47:12 -0600")
References: <20260928-git-contacts-stdin-v5-0-e9becaebc47e@brighamcampbell.com>
	<20260928-git-contacts-stdin-v5-1-e9becaebc47e@brighamcampbell.com>
Date: Tue, 29 Sep 2026 12:29:31 -0700
Message-ID: <xmqqv77ng8kk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brigham Campbell <me@brighamcampbell.com> writes:

> Make git-contacts accept patch contents via stdin for better
> interoperability with other utilities. Read from stdin when the user
> passes `-` at least once:
>
> $ git contacts - <patch
>
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
>  contrib/contacts/git-contacts | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-contacts
> index 85ad732fc0..df7b920d9e 100755
> --- a/contrib/contacts/git-contacts
> +++ b/contrib/contacts/git-contacts
> @@ -162,9 +162,11 @@ if (!@ARGV) {
>  	die "No input revisions or patch files\n";
>  }
>  
> -my (@files, @rev_args);
> +my ($read_from_stdin, @files, @rev_args);
>  for (@ARGV) {
> -	if (-e) {
> +	if ($_ eq '-') {
> +		$read_from_stdin = 1;
> +	} elsif (-e) {
>  		push @files, $_;
>  	} else {
>  		push @rev_args, $_;
> @@ -172,6 +174,9 @@ for (@ARGV) {
>  }
>  
>  my %sources;
> +if ($read_from_stdin) {
> +	scan_patches(\%sources, undef, \*STDIN);
> +}
>  for (@files) {
>  	scan_patch_file(\%sources, $_);
>  }

Doesn't the Usage comment at the beginning also want to be updated?

Thanks.


diff --git i/contrib/contacts/git-contacts w/contrib/contacts/git-contacts
index 85ad732fc0..1eb91c4ab1 100755
--- i/contrib/contacts/git-contacts
+++ w/contrib/contacts/git-contacts
@@ -3,7 +3,7 @@
 # List people who might be interested in a patch.  Useful as the argument to
 # git-send-email --cc-cmd option, and in other situations.
 #
-# Usage: git contacts <file | rev-list option> ...
+# Usage: git contacts <file | '-' | rev-list option> ...
 
 use strict;
 use warnings;
