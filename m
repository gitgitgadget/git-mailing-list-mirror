Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E6CC433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 23:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B5361037
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 23:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhJVXCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 19:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhJVXCp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 19:02:45 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742ECC061764
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 16:00:27 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g10so7021577edj.1
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 16:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=5orOQWGxRKoAE7szDcr5I+Zc4CQQv4tV+NwCln0viW4=;
        b=EAXKqhT3BYozvlcJzh0f9D4vzxW4x2FKP1RKsTwEvP1yS5fq5PP7qM4C9rzHFiwy1q
         Kzi/bBXf6HYwloBFpe6yR8h4EpYbp2CEx/ZK+iYpa/sPOLsMRGKoAYe3CIG/WIrhCXZA
         8t57Y5kGynKNQB8sucgADTNhcZq6BOO3yFe3hvqSZRmhoGqAoU/T4yk0Cju7en2NNef3
         G2l1NxuocEwCU6FcbYkxUE44f5D0VYo12SYT5z7Cbl6DwQadtnGhDj2qtmhzXWzrECzF
         FtR4h+jRq83GtkSYv+6Oi3oXgRdBO/LgLxQBEfb8CQnmmRBJhQCbCxMqVdKYN14H9ofH
         OReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=5orOQWGxRKoAE7szDcr5I+Zc4CQQv4tV+NwCln0viW4=;
        b=x+m7oECdflFGPEyoiWGP2VD/TxDVh69V904BgB3G6LEhAlLjFJt5g4MBynZMADB6PV
         G/G1B0SgbTffLFyqkPBZ9b2ockeay/nh2bWteXjTMzdVGXbJ8mATUnhHAhV5RGgVJ1tc
         f/Ym9oymGqDtYm1jogRyNsA8EtwuqlLkzoZTceXck58aSq16WQ8JZ14hLDWpIxZK0AJw
         O72u0a8RZ2OE7/qkzh8WQi1NmL9cDdaxaxaPlLJ6A6VIgteWol1FhHn5rO6KHjqyYPvG
         ZUk29L07CLgXWEvbJaihah0P229MG0Tpk3jWN62kDZ15z/v1SKR52bFdBbCmWyLglrq8
         mNrw==
X-Gm-Message-State: AOAM532TvCy8BSBZo//4Fxnp2lj+x+9inu7MSALUJbnXlKOjd2CHY+ap
        0zVZ4iywBlS36hFkFRZ/KKx1fQrmICKU2A==
X-Google-Smtp-Source: ABdhPJwLi4+O/ImLqPNNrufeTEM2pWsgS0EMM5MqNEKUN3GCPqxkpMSESWnauxGh/xXx8eghqgdviw==
X-Received: by 2002:a05:6402:3488:: with SMTP id v8mr3908827edc.106.1634943626029;
        Fri, 22 Oct 2021 16:00:26 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cx10sm1145206edb.93.2021.10.22.16.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 16:00:25 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1me3WT-001Ogy-1O;
        Sat, 23 Oct 2021 01:00:25 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Krzysztof =?utf-8?Q?=C5=BBelechows?= =?utf-8?Q?ki?= 
        <giecrilj@stegny.2a.pl>, git@vger.kernel.org,
        Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: *Really* noisy encoding warnings post-v2.33.0
Date:   Sat, 23 Oct 2021 00:58:34 +0200
References: <9896630.2IqcCWsCYL@localhost.localdomain>
 <YSWVi8uLHZCTtG0l@coredump.intra.peff.net> <xmqqeeahjxj4.fsf@gitster.g>
 <YSkvNyR4uT52de13@coredump.intra.peff.net>
 <87ily7m1mv.fsf@evledraar.gmail.com>
 <YWEAEjIN0HVHbIpg@coredump.intra.peff.net>
 <YWEBmJk0aENR5Yeo@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <YWEBmJk0aENR5Yeo@coredump.intra.peff.net>
Message-ID: <211023.86sfwsis1i.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 08 2021, Jeff King wrote:

> On Fri, Oct 08, 2021 at 10:36:02PM -0400, Jeff King wrote:
>
>> If that were coupled with, say, an advise() call to explain that output
>> and matching might be inaccurate (and show that _once_), that might
>> might it more clear what's going on.
>> 
>> Now I am sympathetic to flooding the user with too many messages, and
>> maybe reducing this to a single instance of "some commit messages could
>> not be re-encoded; output and matching might be inaccurate" is the right
>> thing. But in a sense, it's also working as designed: what you asked for
>> is producing wrong output over and over, and Git is saying so.
>
> The single-output version would perhaps be something like this:
>
> diff --git a/pretty.c b/pretty.c
> index 708b618cfe..c86f41bae7 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -606,6 +606,21 @@ static char *replace_encoding_header(char *buf, const char *encoding)
>  	return strbuf_detach(&tmp, NULL);
>  }
>  
> +static void show_encoding_warning(const char *output_encoding)
> +{
> +	static int seen_warning;
> +
> +	if (seen_warning)
> +		return;
> +
> +	seen_warning = 1;
> +	warning("one or more commits could not be re-encoded to '%s'",
> +		output_encoding);
> +	advise("When re-encoding fails, some output may be in an unexpected\n"
> +	       "encoding, and pattern matches against commit data may be\n"
> +	       "inaccurate.");
> +}
> +
>  const char *repo_logmsg_reencode(struct repository *r,
>  				 const struct commit *commit,
>  				 char **commit_encoding,
> @@ -673,7 +688,7 @@ const char *repo_logmsg_reencode(struct repository *r,
>  	 * case we just return the commit message verbatim.
>  	 */
>  	if (!out) {
> -		warning("unable to reencode commit to '%s'", output_encoding);
> +		show_encoding_warning(output_encoding);
>  		return msg;
>  	}
>  	return out;

*Poke* about this. We're getting pretty close to release. I think the
WIP hunk I posted in
https://lore.kernel.org/git/871r4umfnm.fsf@evledraar.gmail.com/ presents
a good way forward with this.

I.e. aside from how wise it is to warn about this in general, I think
there's a pretty bad bug in your implementation where what should
effectively be a parse_options() or git_config()-time one-off warning is
being fired off for every single commit in "git log" in some cases.
