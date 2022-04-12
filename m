Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3365FC433F5
	for <git@archiver.kernel.org>; Tue, 12 Apr 2022 10:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347324AbiDLKAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 06:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359866AbiDLItN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 04:49:13 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3794062A32
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 01:12:03 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id p15so35710331ejc.7
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 01:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=3Vq44remPcaiWwD9CW8PLvCFm795bGsA4gVxLpau0f0=;
        b=ni8PjAmtJr/hyve5IFI1oY3JGefeeL7unZv7BDLmt2G/uAtmVJj17BRFcz6mRlOKKa
         Vb2v2LWwG4cX/t4ucmZ7GttIKHMhXAVZCF7XoohodrdgW6cN9+MJoieS+kql4ol2+JTm
         4G6Vs97m9oe4VJbAM5U8Hc0SYcB7w1aKW2Yb02VEVXKnOHC/XM8/Wde+jACShzyhD1Ph
         Jv/1NZTL7nRdPYwOOKGbyZTuzhKG6gwuASqGOaaPXchwOR6/k0ZUOLre6wTrD6RAXhOw
         sdXhiqMxFoUN833X274/EvLFGOSlrBJccpeHf47Mf1znsKeUtl76+b5ebJQf77mSDJlR
         YwwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=3Vq44remPcaiWwD9CW8PLvCFm795bGsA4gVxLpau0f0=;
        b=hvmASrKCxhJGUFQzNVmfiANR0YJZI7Djgnip8R5HjIe8nZSpRicb/4spqjqRyvrMfF
         c/jLVK7hIwswd4+/ragwX57Eb5+DjpBo6cN7vHBkdqjyYkVUxXGTsnPBn2bZgVEcq07h
         c8621ksl+fte4gkmcyi1/fhJFPewG3g4kYZFyJ1agUAAB/zgR4JalPHlO9oUAdF8cBzl
         HyWaUFVszH3aFkP2FLSdCfKw6/loZ9kM1QqHoyEfcoOjiBsLkENvf+a/ld/B4DX6dpJ8
         BgT2MBCs4D1f4xOwa2gmXlpT9hmKfgj+t/Ak5HYE9kJ/1r3LIWyK6/eFPPG3yFEONqk/
         +aVg==
X-Gm-Message-State: AOAM533ZetTJKAQF/RlNPz39tl3hB+GNPqjnRaLhqxavL0x/txc7NfN+
        4ABWg2mjiacItIDW+fmTVu8=
X-Google-Smtp-Source: ABdhPJx3H2htLgV4lcovYeTUw3em0yaOUP6ISBUO/hAEB4grm5TkQD81so1ymEl8HWe83OB/hKKSEg==
X-Received: by 2002:a17:906:dc89:b0:6db:a789:7563 with SMTP id cs9-20020a170906dc8900b006dba7897563mr32839788ejc.471.1649751121429;
        Tue, 12 Apr 2022 01:12:01 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id kw5-20020a170907770500b006db075e5358sm12608151ejc.66.2022.04.12.01.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 01:12:00 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1neBd2-004VvU-Dd;
        Tue, 12 Apr 2022 10:12:00 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Julien Palard <julien@palard.fr>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?Q?S=C3=A9bastien?= Helleu <flashcode@flashtux.org>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] Make a colon translatable
Date:   Tue, 12 Apr 2022 10:03:48 +0200
References: <-9xEw4skKJRhRp5v7WmxeS2n5xv-xmM0HWqmoiameagKhpiDOP9y3Yxj7WFy6M-jztxqug8DKopXIr_op09VlGPkUC7iG5V6xXjKh_SxHEg=@palard.fr>
 <xmqq5ynfh101.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq5ynfh101.fsf@gitster.g>
Message-ID: <220412.86tuayhga7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 11 2022, Junio C Hamano wrote:

> Julien Palard <julien@palard.fr> writes:
>
>> In french we use a no-break space before colon, so with formatting
>> like:
>>
>>     printf("... %s: ...", _("some string"))
>>
>> We can't cleanly add our no-break space, so I think:
>>
>>     printf("... %s ...", _("some string:"))
>
> Sorry, but I do not quite buy this.  The above is a representative
> example of what we call "sentence lego", which is what we absolutely
> want to avoid, isn't it?
>
> We'd rather want to see
>
> 	printf_like_function(_("Use 'git %s' ...", "string"));
>
> when "string" is something that should not be translated to begin
> with (e.g. "add" to form "git add"), and different languages can use
> different conventions for quoting the command name (a translation
> may want to use something other than single-quotes, for example).
>
> And in a less optimal case,
>
> 	printf_like_function(_("%s: ...", _("string")));
>
> would be needed, when "string" is something that is to be translated
> (e.g. a phrase used as a label, like "Untracked files" in the code
> this patch touches).  I think the case you have is the latter one.

You're right, but wt-status.c is sentence lego galore, and that's been a
TODO since the i18n effort was started.

It's particularly hard to peel it apart, and doing so would require
e.g. having translators translate a string with embedded color formats,
or even git-for-each-ref embedded %(if...) formats.

But in lieu of that I don't see a reson for not taking this much more
narrow change, since it solves a practical issue for a major language...

>> diff --git a/wt-status.c b/wt-status.c
>> index d33f9272b7..ef0c276c3d 100644
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -248,7 +248,7 @@ static void wt_longstatus_print_other_header(struct wt_status *s,
>>  					     const char *how)
>>  {
>>  	const char *c = color(WT_STATUS_HEADER, s);
>> -	status_printf_ln(s, c, "%s:", what);
>> +	status_printf_ln(s, c, "%s", what);
>
> I.e. this one is better handled by
>
> 	status_printf_ln(s, c, _("%s:"), what);
>
> as _(...) in C-locale is original-language centric, where we want
> the label to be <phrase> immediately followed by a colon.  And that
> allows French translation to have nbsp before the colon.

In this case I think the change as suggested is better, translators get
zero context from "%s:", whereas "Untracked files:" being status output
is immediately obvious.

>>  	if (s->show_untracked_files) {
>> -		wt_longstatus_print_other(s, &s->untracked, _("Untracked files"), "add");
>> +		wt_longstatus_print_other(s, &s->untracked, _("Untracked files:"), "add");
>
> Then this <phrase>, to be used in the label above, can be without colon.
>
>>  		if (s->show_ignored_mode)
>> -			wt_longstatus_print_other(s, &s->ignored, _("Ignored files"), "add -f");
>> +			wt_longstatus_print_other(s, &s->ignored, _("Ignored files:"), "add -f");

It's a good rule of thumb to give translators the "whole thing", in this
case that's a heading, so despite other issues with lego'd "status"
output this particular string is following best-practices after this
change by Julien.

His commit message also doesn't mention it, but for existing "headings"
we already do this, e.g.:

    status_printf_ln(s, c, _("Changes to be committed:"));
    status_printf_ln(s, c, _("Changes not staged for commit:"));

etc., grep for status_printf_ln.*" in that file, so this is making
things consistent with that other code.
