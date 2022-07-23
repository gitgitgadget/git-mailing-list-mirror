Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0680C433EF
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 05:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiGWFjy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jul 2022 01:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiGWFjx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jul 2022 01:39:53 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A67B5565
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 22:39:51 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ez10so11709168ejc.13
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 22:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=4vRhz0iYk456e0KPZbMX+YwpcsQakGxH44YXUDTljv4=;
        b=TUSDl4NuJKoaHrJFFbRlxCsXdISB8UeGUEicgqGVvpZWKb9PNubKVReuE1Y/pVslhT
         Jhx7Il12XGxM6VdppplvkVqJhMf9Y2O5Ks4B/UxqbEH6dBBrJcsPUPuDXagNxYgrnTtg
         43cD3w5kaVyVVSs5HISe/PP4CZNFZ5CiGj1vhNuZMAUHMZYOeSukzy/NvO25o8ArfHHH
         vphu1qWz/k8BTSuDwtqVHBCUwylQaVhsoby3WGq0BWynkf0iBd83iR40s1FzOzR/wmHP
         kEsCatkd/6bJu1x1pJn1iEnZSUV9B03im38Q6EmQyVFGuoHrLbxkKt3a2CN2OHz8ICPA
         ldfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=4vRhz0iYk456e0KPZbMX+YwpcsQakGxH44YXUDTljv4=;
        b=bxhP70w3vQ36+sVP2r/HFZTQ6XAPKUvLYXCMrt7zGClqSbyN5z2wnwJziAGWHOWAk2
         VhBrw/Bbcptt2+YrYks/pkh7bPn9DxfkKO3iDZlTjbhYLtT8eRTJKnqOOAoxLFPy3lsw
         fWzZ7e57ElJ8pLZCUNXO/vW9P2YVCDFBiRK0x1oAX8rQWWOr/rzzs6Mad51W2qRrJgFa
         yHboWhDlSF2vuDZn2+jsQgMZuehuqJMH/oM0e1PlufwfYoIMqs5bLJq0WyqUGKotCyny
         gLCIz9joQ24qMvQnUPDCKlp/0Zw+7r7ZD0a6eak3aL87f9gk+Cs27tXo8hsqb2XvSEuP
         2rvw==
X-Gm-Message-State: AJIora8ShiPxy1QwmuLfxisiFc0j7u2MK8BNPdZ6qy/s+oho+Pu34ykK
        WuWeoQuh5clNuKVHEPW/bL4=
X-Google-Smtp-Source: AGRyM1tiBTyLpJ7PlCvvNHp83V2KEZ7GQ2dLw5aKtNEjuOQPwnxoBwyPMqnjkw5Om3KnNq9nunCUrQ==
X-Received: by 2002:a17:907:2710:b0:72b:7f52:75da with SMTP id w16-20020a170907271000b0072b7f5275damr2550042ejk.26.1658554789663;
        Fri, 22 Jul 2022 22:39:49 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id c14-20020aa7d60e000000b0043b240ce57bsm3524372edr.82.2022.07.22.22.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 22:39:49 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oF7rg-005QKg-IN;
        Sat, 23 Jul 2022 07:39:48 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/2] builtin/cat-file.c: support NUL-delimited input
 with `-z`
Date:   Sat, 23 Jul 2022 07:17:48 +0200
References: <cover.1658532524.git.me@ttaylorr.com>
 <ed1583223f63cfde99829069f14af62e4f0f2a82.1658532524.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <ed1583223f63cfde99829069f14af62e4f0f2a82.1658532524.git.me@ttaylorr.com>
Message-ID: <220723.86leskqtej.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jul 22 2022, Taylor Blau wrote:

[I think John Cai would appreciate being CC'd on this]

> It's tempting to think that we could use `strbuf_getwholeline()` and
> specify either `\n` or `\0` as the terminating character. But for input
> on platforms that include a CR character preceeding the LF, this
> wouldn't quite be the same, since `strbuf_getline(...)` will trim any
> trailing CR, while `strbuf_getwholeline(&buf, stdin, '\n')` will not.

I commend the effort to maintain bug-for-bug compatibility, but do we
care about this distinction, or is it just an accident that we support
\r\n here in the first place?

This doesn't apply to the rest of cat-file directly, but the origin of
the recent --batch-command mode cdoe was to lift the same-ish code from
builtin/update-ref.c, whose \n or \0 mode does exactly that:

	while (!strbuf_getwholeline(&input, stdin, line_termination)) {

I.e. it doesn't support \r\n, just \n or \0.

Isn't that fine? I may be missing something, but why isn't it OK even on
platforms that use \r\n for their normal *.txt endings to only use \n or
\0 for this bit of protocol?

For the command mode at least this passes our tests:
	
	diff --git a/builtin/cat-file.c b/builtin/cat-file.c
	index f42782e955f..8646059472d 100644
	--- a/builtin/cat-file.c
	+++ b/builtin/cat-file.c
	@@ -614,12 +614,16 @@ static void batch_objects_command(struct batch_options *opt,
	 	struct queued_cmd *queued_cmd = NULL;
	 	size_t alloc = 0, nr = 0;
	 
	-	while (!strbuf_getline(&input, stdin)) {
	+	while (!strbuf_getwholeline(&input, stdin, '\n')) {
	 		int i;
	 		const struct parse_cmd *cmd = NULL;
	 		const char *p = NULL, *cmd_end;
	 		struct queued_cmd call = {0};
	 
	+		if (input.len > 0 && input.buf[input.len - 1] == '\n')
	+			--input.len;
	+		input.buf[input.len] = '\0';
	+
	 		if (!input.len)
	 			die(_("empty command in input"));
	 		if (isspace(*input.buf))

So maybe we should just do something like that instead? I.e. declare
that a mistake.

As for the rest of cat-file 05d5667fec9 (git-cat-file: Add --batch-check
option, 2008-04-23) documents that it's LF, not CR LF, ditto
git-cat-file.txt.

So isn't this just an accident in of us having used the strbuf_getline()
function to mean "\n", but actually it also does "\r\n".

Which is a really unfortunately named function b.t.w., since it sneaks
this bit of Windows portability into places that may not want it in the
first place.

>  strlen () {
>      echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
>  }
> @@ -398,6 +403,12 @@ test_expect_success '--batch with multiple sha1s gives correct format' '
>  	test "$(maybe_remove_timestamp "$batch_output" 1)" = "$(maybe_remove_timestamp "$(echo_without_newline "$batch_input" | git cat-file --batch)" 1)"
>  '
>  
> +test_expect_success '--batch, -z with multiple sha1s gives correct format' '
> +	echo_without_newline_nul "$batch_input" >in &&
> +	test "$(maybe_remove_timestamp "$batch_output" 1)" = \
> +	"$(maybe_remove_timestamp "$(git cat-file --batch -z <in)" 1)"

This...

> +'
> +
>  batch_check_input="$hello_sha1
>  $tree_sha1
>  $commit_sha1
> @@ -418,6 +429,24 @@ test_expect_success "--batch-check with multiple sha1s gives correct format" '
>      "$(echo_without_newline "$batch_check_input" | git cat-file --batch-check)"
>  '
>  
> +test_expect_success "--batch-check, -z with multiple sha1s gives correct format" '
> +    echo_without_newline_nul "$batch_check_input" >in &&
> +    test "$batch_check_output" = "$(git cat-file --batch-check -z <in)"

This....

> +'
> +
> +test_expect_success FUNNYNAMES '--batch-check, -z with newline in input' '
> +	touch -- "newline${LF}embedded" &&
> +	git add -- "newline${LF}embedded" &&
> +	git commit -m "file with newline embedded" &&
> +	test_tick &&
> +
> +	printf "HEAD:newline${LF}embedded" >in &&
> +	git cat-file --batch-check -z <in >actual &&
> +
> +	echo "$(git rev-parse "HEAD:newline${LF}embedded") blob 0" >expect &&

..and this hides git's exit code, better to pipe to a file, use test_cmp
etc. etc.
