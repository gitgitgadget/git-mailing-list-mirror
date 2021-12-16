Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47059C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 21:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241635AbhLPVdC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 16:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241571AbhLPVdB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 16:33:01 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0A5C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 13:33:00 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id x15so562383edv.1
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 13:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=/lshgoHpC20M5j8sHkBjml1r2ZFi9WOF/86b8+x4mYw=;
        b=oASVEbLlGLuUAiaUhvMC/zTT6B4mMpsIa31nA0lsU/PaxP/FawPwY2LJppXRA3xp5/
         9dxgqfPqDTEpW2GNuh2xbY5K/2zc56vFViRZIRDGQOCzFeAA0KYs+44AawfIPdsG7DXj
         h9VT+Kog0SwOJXTpXlVOkueY9pCohHyNR2r0nC5woAsIbu0v97wZ/kyJN19OBCCl/cNl
         jPEfnDNJpayIL7kGNmGPU2V42ixFCqrIKEHftQJc9UNvXzW4O5Yl5kLRpR3u3QUdIfDE
         kEaEb2nFCz8p3Nn6xu8Bb73mWoOk+J4vz4+U7m0xL2+Gr4O0lHM2XUym7bQykqS8GgPZ
         ivHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=/lshgoHpC20M5j8sHkBjml1r2ZFi9WOF/86b8+x4mYw=;
        b=Ag2lkusf7vGN/NVV99K2g+eDSdXMeCCkTx07H1X9xW1xBje+R6gzX3zze1Zs4kWIh5
         UZnUE+c+9Z1JGXJi/PCQ71lXRCR3AZ64JztWRBwJHp5+ujyzoFqbCj8x+e+XJKAKs0Rp
         OGJR54GNwEcpxQgNrwAkjzAwxmr8mrXhhYHK4/xxHUNd0qQdspaEoKeHlY0IZ3ZL/heK
         d+mmzW9rAB0WiUm3ETco80VtvjCiX6lpqBlBiuLTydv0OJDQ0c0AklXUkvJcYAnxpFoG
         Tr0uRpO2JgJSCd70MZ184pB9tXlkbSHgCue01nKchrYf8jt15nqoOwfua3LvFZ+jkMXk
         YCbQ==
X-Gm-Message-State: AOAM533ukONrLNCbRrvAOGhRjd7FMi8mYHW9pXentHBwiKg2jwdtAZR2
        8DcJP8RwXpIlZNXMC0wYSAU=
X-Google-Smtp-Source: ABdhPJyuDNHUKD/YH0JJS47N7JTzPu4p7jCOsPnwlHz2e1WdxB7JXJOkOvqX38Okl6GuIxMyeBhcmQ==
X-Received: by 2002:a17:907:c0c:: with SMTP id ga12mr17417738ejc.417.1639690379109;
        Thu, 16 Dec 2021 13:32:59 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x16sm1591598ejs.92.2021.12.16.13.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 13:32:58 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mxyN0-000bc3-57;
        Thu, 16 Dec 2021 22:32:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Teng Long <dyroneteng@gmail.com>, congdanhqx@gmail.com,
        git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v5 1/1] ls-tree.c: support `--object-only` option for
 "git-ls-tree"
Date:   Thu, 16 Dec 2021 22:29:45 +0100
References: <xmqqk0g5656r.fsf@gitster.g>
 <20211216121630.14553-1-dyroneteng@gmail.com> <xmqq7dc49r7j.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqq7dc49r7j.fsf@gitster.g>
Message-ID: <211216.86mtl09qwl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 16 2021, Junio C Hamano wrote:

> Teng Long <dyroneteng@gmail.com> writes:
>
>>> A better name, anybody?
>>> 
>>> This bit is to keep track of the fact that we made _some_ output
>>> already so any further output needs an inter-field space before
>>> writing what it wants to write out.
>>
>> I found a word "interspace", it looks like a little better than the old
>> one. I will rename to it in next patch, and If there's a better idea,
>> will apply further.
>
> Yeah, it really is needs_inter_field_space but that is way too long.
>
>>> We need to stop using write_name_quoted_relative() in SHOW_FILE_NAME
>>> part, because the helper insists that the name written by it must be
>>> at the end of the entry, if we go that route, but it may be a good
>>> change in the longer term.
>>
>> Let me try to represent to make sure I understand your suggestion
>> sufficiently.
>>
>> "write_name_quoted_relative" is used to compute the relative file name
>> by "prefix" and output the name and a line termination to the given FD.
>>
>> We do not want use "write_name_quoted_relative" in here because the
>> function alway output a line termination after "name", this may bring
>> some inconvenience because the "name" may not be the last field in the
>> future.
>>
>> So, instead:
>>
>> We need to calculate the file name (relative path and quotes if need)
>> without "write_name_quoted_relative"  and then output the line
>> termination before return.
>
> I think we are on the same page.  We can work backwards, I think.
>
> We have a repetitive
>
>         if (mode should be shown) {
>                 show mode;
>                 record that we have already shown something;
>         }
>         if (type should be shown) {
>                 give inter-field-space if we have shown something;
>                 show type;
>                 record that we have already shown something;
>         }
>         ...
>
> that ends with
>
>         if (name should be shown) {
>                 give inter-field-space if we have shown something;
>                 show name PLUS line termination;
> 	}
>
> But if we can make the last step to
>
>         if (name should be shown) {
>                 give inter-field-space if we have shown something;
>                 show name;
> 	}
>
> 	give line termination;
>
> it gets easier to support a combination that does not show name, and
> we can have inter-record separator.
>
> But write_name_quoted_relative() does not give the caller a choice
> to have no terminator, so we need to do something like this:
>
> 	if (shown_bits & SHOW_FILE_NAME) {
> 		const char *name;
>                 struct strbuf name_buf = STRBUF_INIT;
>
> 		if (follow)
> 			printf("\t");
> 		baselen = base->len;
> 		strbuf_addstr(base, pathname);
>                 
> 		name = relative_path(base->buf, 
> 				     chomp_prefix ? ls_tree_prefix : NULL,
>                                      &name_buf);
> 		if (line_termination)
> 			quote_c_style(name, NULL, stdout, 0);
> 		else
> 			fputs(name, stdout);
> 		strbuf_release(&name_buf);
> 		strbuf_setlen(base, baselen);
> 	}
>
> I initially thought that extending write_name_quoted() and
> write_name_quoted_relative() to accept a special value or two for
> terminator to tell it not to add terminator would be sufficient (see
> below).  I however think it is way too ugly to have the "add no
> terminator and do not quote" option at write_name_quoted() level,
> simply because the caller that chooses as-is can simply do fputs()
> itself without bothering to use write_name_quoted().  So I am not
> convinced that it will a good idea.
>
> If we were to go that "ugly helper" route, the above can become even
> simpler and closer to what you originally wrote, e.g.
>
> 	if (shown_bits & SHOW_FILE_NAME) {
> 		if (follow)
> 			printf("\t");
> 		baselen = base->len;
> 		strbuf_addstr(base, pathname);
> 		write_name_quoted_relative(base->buf,
> 					   chomp_prefix ? ls_tree_prefix : NULL,
> 					   stdout,
>                                            line_termination 
>                                            ? CQ_NO_TERMINATOR_C_QUOTED
>                                            : CQ_NO_TERMINATOR_AS_IS);
> 		strbuf_setlen(base, baselen);
> 	}
>
>
>  quote.c |  5 +++--
>  quote.h | 19 +++++++++++++++++++
>  2 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git c/quote.c w/quote.c
> index 26719d21d1..cbbcd8563f 100644
> --- c/quote.c
> +++ w/quote.c
> @@ -340,12 +340,13 @@ void quote_two_c_style(struct strbuf *sb, const char *prefix, const char *path,
>  
>  void write_name_quoted(const char *name, FILE *fp, int terminator)
>  {
> -	if (terminator) {
> +	if (0 < terminator || terminator == CQ_NO_TERMINATOR_C_QUOTED) {
>  		quote_c_style(name, NULL, fp, 0);
>  	} else {
>  		fputs(name, fp);
>  	}
> -	fputc(terminator, fp);
> +	if (0 <= terminator)
> +		fputc(terminator, fp);
>  }
>  
>  void write_name_quoted_relative(const char *name, const char *prefix,
> diff --git c/quote.h w/quote.h
> index 87ff458b06..5c8c7cf952 100644
> --- c/quote.h
> +++ w/quote.h
> @@ -85,7 +85,26 @@ int unquote_c_style(struct strbuf *, const char *quoted, const char **endp);
>  size_t quote_c_style(const char *name, struct strbuf *, FILE *, unsigned);
>  void quote_two_c_style(struct strbuf *, const char *, const char *, unsigned);
>  
> +/*
> + * Write a name, typically a filename, followed by a terminator that
> + * separates it from what comes next.
> + * When terminator is NUL, the name is given as-is.  Otherwise, the
> + * name is c-quoted, suitable for text output.  HT and LF are typical
> + * values used for the terminator, but other positive values are possible.
> + *
> + * In addition to non-negative values two special values in terminator
> + * are possible.
> + * -1: show the name c-quoted, without adding any terminator.
> + * -2: show the name as-is, without adding any terminator.
> + */
> +#define CQ_NO_TERMINATOR_C_QUOTED	(-1)
> +#define CQ_NO_TERMINATOR_AS_IS		(-2)
>  void write_name_quoted(const char *name, FILE *, int terminator);
> +
> +/*
> + * Similar to the above, but the name is first made relative to the prefix
> + * before being shown.
> + */ 
>  void write_name_quoted_relative(const char *name, const char *prefix,
>  				FILE *fp, int terminator);
>  

In my "just make ls-tree support --format" this whole thing is just:
    
    +               if (prefix)
    +                       name = relative_path(name, prefix, &scratch);
    +               quote_c_style(name, sb, NULL, 0);
    +               strbuf_addch(sb, line_termination);

But of course that's an implementation that's moved away from the "write
stuff to a FH for me" API in quote.c.

So I haven't looked carefully here, but you need this API just because
of some constraint in the write_name_quoted()?

Perhaps just running with that approach is better? Whether it's stealing
that approach, or doing away with --object-only for a --format...
