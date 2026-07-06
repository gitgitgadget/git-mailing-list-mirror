Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393B13876BE
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 20:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783370011; cv=none; b=b111EAdYaCPrUaJuO/5BIT61UVyXrSwqg0IStXeWRgdo9qG9I/K5Zc84GC/Z4lDlXq9C1Pvaf/M92FPOIV1Sl8Aq6OUQ2gP9kRtOpXG7X8f22EfA6l0ZKH1mhYJta7zM3QQaCDvN4i2fZCW+QDZ9Zok8JPRktmCTa0wtLur0Mpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783370011; c=relaxed/simple;
	bh=J4tqe/HxtY/ImZN2tGwHVePZwa4nwruhb/1JM/29PtA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZvtPrDikz7nGK0WHFUELrADG0Xm/IHZYGQwtZPJS+z0QchDZulSiozRKLrB+hOuBMDgOqjgat8at5SuxtwWdFoIIgByfD39+DgNCZpZS3n2MbFjyZPjTJpbG4qo8SnK3K0t2FAQGWAou/Qnl+LiW3Jvf9XtW5wfHIca+YaRkoyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=R5uzzK1o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ys2NrNvF; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="R5uzzK1o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ys2NrNvF"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DA1951400085;
	Mon,  6 Jul 2026 16:33:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 06 Jul 2026 16:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1783370007;
	 x=1783456407; bh=bhfaaVHyX5p3a9eJB+1Lq+pI5rBatUF9jGhsoFWTHX0=; b=
	R5uzzK1osvHM6R2QPBXk4AlwivR+84PavbFnuM5JDcTWombgNiE1BtEzjbmxgV/+
	wMafTbXmLsO334KEtnaC980K5gV5XM8tmHtB4Ab6E8IuoZPTnVDj1invC9zUaHBe
	utEzXPNfbaGjxrOCfQeuI+TJgh+1QgyLbULc+Tyisf2W8tG1smoXbnG/x3ekTIP9
	GOCFjew4CDdE8ys44JRn15taj2ZPdGZGutYLz380iqglykTDanX8kiciUQVd5lWy
	fBPkv7OTyaZwKp9cHYB0WF3woYLIej8msDCKEWV0VtYF04+l5sRVFtpjUZXHK9Cr
	0NsQzMjCtQggh0wGGOUDZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783370007; x=
	1783456407; bh=bhfaaVHyX5p3a9eJB+1Lq+pI5rBatUF9jGhsoFWTHX0=; b=Y
	s2NrNvFDuRiE5ia6r//8i8RcJlEXETGDjYwMcF2JNHH2kammFqFlqRdjbxxdYJM5
	yazzatOnhTjaxILkgx34BF9xnkETUlQCDwRvSbIRAhNxEw59S2SHzRwW9i1Af+bT
	x/WjzXvXnRzGT5mTcL7CMmEG1SN4N7DAm+Q3bKdcDJ9XpaAA04Ohn+u8ngpqTwCx
	TI2U8iInAnAfUdby3E+SH2jJv5Vr476EWy9iFJiJRCqMNxr/QXGcNpptKqA1YGCb
	1tXji56BUbzDAv2N7baDeYECinlNUx3mJ7JMSPkhH9tkxuhixdDRlVaXNPaf85f6
	wO5uzJAq5yh+s9+OAKpPQ==
X-ME-Sender: <xms:FxFMaiSaDzbA8kmzDAPHMbnwl_2UAAT7VkriKA9Y9Ap9ua-E_bvYzQ>
    <xme:FxFMauy5f72QvlXNWFzyC_GKVkx195tVz_Wd6jw2dc0tRuMOzVl5XXp52AU8jhOJ9
    PTC6BmD9_wZfQnmZe07gxfVCVLVLx1wJ5yaRbuaxX2i1iy0H_ZpnQ>
X-ME-Received: <xmr:FxFMak0_5usLN2X9hyGtU0uQuzFrGKdTky-iZKP8P3-e0iWlmbG49nFAic26YN_oe6sRmOYxhW4UBLOhiTVKtp4u7lKotEtYjoSscAA>
X-ME-Proxy-Cause: dmFkZTEjhUETIhgW6+iczxd/G6t31ab0qU5u4QP1GV8HCxIWd/foQTlzEFwNKeyoyLOip0
    B9hrZ8Mti81AHOlaDSL18H3NJOTNpb9rxevvVWzLg/WZ/KEcTmaF2ngR+DDCCsJxb0wy+N
    TgQbpSrfXV8IyNdhvNv0LhZMz+djNyYTtiPhsOMrvxBo3DCgmhOSAYP3Mp6/u+ILbSyY7g
    XOfHOITyDV1VQt2q9YNQgNRmIz4gmjckAgztUbA4kR8JS4/HkGHuUziGcLj8IuSVL0oYDV
    0VC/ic05aG2U1WUbv1MjcZDaQQGLzFOznK+diEsVUcMosCJbOFH4cLhwpKC1HB8SaDBwEt
    xMbC1oo5pG/3ADweycnzPqwuQTo3yJ1noxqZ5pNkrtuHJGt0aepxuHg+TfT1+looMjEhOn
    lJXLHzFuTuDvGPrRAV42mKXPqKiKvcHVbjvUiknPrm9AMoKMPKVul7xWEwplH4At7aZAtE
    +eMyF3+iTcucBbsuY1E2FKIfIN4mfOTvDVt2U35ZVSo7MAXh2yUk4JrVwKkM0QVTMVsM8s
    tKwvHfglrjC2SA1yV5LXArI71me+nF2ArhpxdW2WvKR0S+7u6wOFduOhWGnbZCiFJpzpOg
    Kyz1yCOFKruuSrPziQlMy6YxuK1AjN4shyo3HAMiTk7axtrphfYyjCqpxWsw
X-ME-Proxy: <xmx:FxFMas4vBEgwB4V8u6NvPzHaQsFJqT6Pb6z5toBlp-MTQtkNyKgAEg>
    <xmx:FxFManWk5M-YIJTz4aPxbIh2KQVIUcVsb24fHwVy8aj1zv1HpxN4aw>
    <xmx:FxFMarBxjVAnTFfCWz6J-ZPgTRKAcFbdDYZj0TugPpqnAqsTVtGwrA>
    <xmx:FxFMam6biFZNU-Tuxvv1dK-QYwZ1Oyu5I_YM2kvQxkSKiNDb33XNPA>
    <xmx:FxFMaiEiEGDXXyFDN_eoc04pq3YMhhzgYCb_DJwENkjcradrNDLsGl_->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 16:33:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Laszlo Ersek <laszlo.ersek@posteo.net>,  git@vger.kernel.org
Subject: Re: [PATCH] blame: reserve mark column only if necessary
In-Reply-To: <92991b5e-0667-4315-89d5-1514a5499297@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Mon, 6 Jul 2026 10:38:25 +0200")
References: <b500479b-14c1-4fbb-a672-1d2cd4852601@posteo.net>
	<92991b5e-0667-4315-89d5-1514a5499297@web.de>
Date: Mon, 06 Jul 2026 13:33:26 -0700
Message-ID: <xmqqzf0397u1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

>  `--abbrev=<n>`::
> +	Instead of using the default _7_ hexadecimal digits as the
> +	abbreviated object name, use at least _<n>_ digits, but ensure
> +	the commit object names are unique.
> +	If commits marked with caret (boundary), question mark (ignored)
> +	or asterisk (unblamable) are shown, extend unmarked object names
> +	to align them.

OK.

> +static inline int maybe_putc(int c, FILE *out)
> +{
> +	return out ? putc(c, out) : 0;
> +}
> +
> +static size_t print_marks(FILE *out, const struct blame_entry *ent, int opt)
> +{
> +	size_t len = 0;
> +
> +	if ((ent->suspect->commit->object.flags & UNINTERESTING) &&
> +	    !blank_boundary && !(opt & OUTPUT_ANNOTATE_COMPAT)) {
> +		maybe_putc('^', out);
> +		len++;
> +	}
> +	if (mark_unblamable_lines && ent->unblamable) {
> +		maybe_putc('*', out);
> +		len++;
> +	}
> +	if (mark_ignored_lines && ent->ignored) {
> +		maybe_putc('?', out);
> +		len++;
> +	}
> +	return len;
> +}

Quite straight-forward.

> +static size_t count_marks(const struct blame_entry *ent, int opt)
> +{
> +	return print_marks(NULL, ent, opt);
> +}

OK.

> @@ -499,23 +529,10 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent,
>  		if (color)
>  			fputs(color, stdout);
>  
> -		if (suspect->commit->object.flags & UNINTERESTING) {
> -			if (blank_boundary) {
> -				memset(hex, ' ', strlen(hex));
> -			} else if (!(opt & OUTPUT_ANNOTATE_COMPAT)) {
> -				length--;
> -				putchar('^');
> -			}
> -		}
> -
> -		if (mark_unblamable_lines && ent->unblamable) {
> -			length--;
> -			putchar('*');
> -		}
> -		if (mark_ignored_lines && ent->ignored) {
> -			length--;
> -			putchar('?');
> -		}
> +		if ((suspect->commit->object.flags & UNINTERESTING) &&
> +		    blank_boundary)
> +			memset(hex, ' ', strlen(hex));
> +		length -= print_marks(stdout, ent, opt);
>  
>  		printf("%.*s", (int)(length < GIT_MAX_HEXSZ ? length : GIT_MAX_HEXSZ), hex);
>  		if (opt & OUTPUT_ANNOTATE_COMPAT) {
> @@ -647,11 +664,15 @@ static void find_alignment(struct blame_scoreboard *sb, int *option)
>  	struct blame_entry *e;
>  	int compute_auto_abbrev = (abbrev < 0);
>  	int auto_abbrev = DEFAULT_ABBREV;
> +	size_t max_marks_count = 0;
>  
>  	for (e = sb->ent; e; e = e->next) {
>  		struct blame_origin *suspect = e->suspect;
>  		int num;
> +		size_t marks_count = count_marks(e, *option);
>  
> +		if (max_marks_count < marks_count)
> +			max_marks_count = marks_count;
>  		if (compute_auto_abbrev)
>  			auto_abbrev = update_auto_abbrev(auto_abbrev, suspect);
>  		if (strcmp(suspect->path, sb->path))
> @@ -685,8 +706,12 @@ static void find_alignment(struct blame_scoreboard *sb, int *option)
>  	max_score_digits = decimal_width(largest_score);
>  
>  	if (compute_auto_abbrev)
> -		/* one more abbrev length is needed for the boundary commit */
> -		abbrev = auto_abbrev + 1;
> +		abbrev = auto_abbrev;
> +	if (abbrev < (int)the_hash_algo->hexsz) {
> +		abbrev += max_marks_count;
> +		if (abbrev > (int)the_hash_algo->hexsz)
> +			abbrev = the_hash_algo->hexsz;
> +	}
>  }
>  
>  static void sanity_check_on_fail(struct blame_scoreboard *sb, int baa)
> @@ -1047,10 +1072,7 @@ int cmd_blame(int argc,
>  	} else if (show_progress < 0)
>  		show_progress = isatty(2);
>  
> -	if (0 < abbrev && abbrev < (int)the_hash_algo->hexsz)
> -		/* one more abbrev length is needed for the boundary commit */
> -		abbrev++;
> -	else if (!abbrev)
> +	if (!abbrev)
>  		abbrev = the_hash_algo->hexsz;

OK.


> diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
> index 7822947f028..bf04b8273ef 100755
> --- a/t/t8002-blame.sh
> +++ b/t/t8002-blame.sh
> @@ -113,8 +113,7 @@ test_expect_success 'set up abbrev tests' '
>  '
>  
>  test_expect_success 'blame --abbrev=<n> works' '
> -	# non-boundary commits get +1 for alignment
> -	check_abbrev 31 --abbrev=30 HEAD &&
> +	check_abbrev 30 --abbrev=30 HEAD &&
>  	check_abbrev 30 --abbrev=30 ^HEAD
>  '
>  
> @@ -141,10 +140,8 @@ test_expect_success 'blame --abbrev gets truncated with boundary commit' '
>  '
>  
>  test_expect_success 'blame --abbrev -b truncates the blank boundary' '
> -	# Note that `--abbrev=` always gets incremented by 1, which is why we
> -	# expect 11 leading spaces and not 10.
>  	cat >expect <<-EOF &&
> -	$(printf "%11s" "") (<author@example.com> 2005-04-07 15:45:13 -0700 1) abbrev
> +	$(printf "%10s" "") (<author@example.com> 2005-04-07 15:45:13 -0700 1) abbrev
>  	EOF

OK.

>  	git blame -b --abbrev=10 ^HEAD -- abbrev.t >actual &&
>  	test_cmp expect actual
