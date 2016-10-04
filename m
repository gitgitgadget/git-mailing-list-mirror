Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B60020986
	for <e@80x24.org>; Tue,  4 Oct 2016 19:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754078AbcJDTv3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 15:51:29 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33988 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752594AbcJDTv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 15:51:28 -0400
Received: by mail-qk0-f177.google.com with SMTP id j129so193308191qkd.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 12:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GQeP5tLBnpHT5v5Go6djBYTTrcZTKLvuIitOW9k2zSo=;
        b=RAALabbqXgaUWE2cDgRzy1E+SglymClmK1i6MBw3Q7DYZ4f3Drlq1Jviy1g+3VJyJy
         mQE7jZPAe8W3CwpOFF3FMe/F9lEaMrestT8C5jfxn0QjkTtB3S7jN5yZM+GqtmnbHxxf
         deHSlAG1PmKdfvTWkepFtuaxDaeGr5r50KdIxP6Tjwyt5Bbz6kNC02RGOUCUqOr3ZMo1
         PyBC4PmWNuiPlmR4JCt70YIftMYrpqkerxUL78VFMqqfhGO+OmqFmDeGIJO5kjC+JkEx
         ibfcMA2ercrvU/T+k4RmskbsJmpS1I8o/OOG+LDDaY6HGm2YHImbJtbsvz551agloOOv
         zVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GQeP5tLBnpHT5v5Go6djBYTTrcZTKLvuIitOW9k2zSo=;
        b=Jj1ubJ8/Gf1s42YGihE0Tk2tM42qCQXplHvsr8nKvHMfrMafdhnOG5XmU1+/Zkzs5V
         5zw0WTQIFAf8sH7FSr9s4rR4Uo5CtOwtNjzSCnqW/69oAoVN6AowcvWxhN6FnxmLs3rf
         rtMoae1FxcRPMHsiK1TlWyQNm8W40R/fqfZSQvXLp8T10Ioq6u/o+W79OzRsut3LrylY
         WfDw6mHznAdClH6b/Vx9PKZYJ5vKm/8Ob/mGgnolVFFIEXKgO8v+6U8b85hphZ2OLsIV
         NOia/wuDE9Zv4dbR1rv6TTsx5N6+9pF5XAw1Ak4BxJ1YGCovRouURDIRFIOeYH4uUIfG
         P1bA==
X-Gm-Message-State: AA6/9RmLazf3vxc1f7VkOkICX0JOf6tXCpCmg6OLwTY7ZgqsyocKP3AwmGK6vmEf2o4xUSWJLzmVyfyIsb5C69fr
X-Received: by 10.55.36.131 with SMTP id k3mr5227913qkk.86.1475610687411; Tue,
 04 Oct 2016 12:51:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 4 Oct 2016 12:51:26 -0700 (PDT)
In-Reply-To: <20161004193926.32w7yivkakqoadm2@sigill.intra.peff.net>
References: <20161004182801.j3fdpewybatmibpo@sigill.intra.peff.net>
 <20161004192910.30649-1-sbeller@google.com> <20161004193926.32w7yivkakqoadm2@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Oct 2016 12:51:26 -0700
Message-ID: <CAGZ79kbt+SZoogKTV_-rVfOOFzf6xrhWytrBo2H3r6NQw34WTw@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] push: change submodule default to check when
 submodules exist
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 4, 2016 at 12:39 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 04, 2016 at 12:29:09PM -0700, Stefan Beller wrote:
>
>> Jeff wrote:
>> > Consulting .git/config is fine, I think. It's not like we don't read it
>> > (sometimes multiple times!) during the normal course of the program
>> > anyway. It's just a question of whether it makes more sense for the
>> > heuristic to kick in after "init", or only after "update". I don't know
>> > enough to have an opinion.
>>
>> I think there is no difference in practice, however the "after update"
>> is way easier to implement and hence more maintainable (one lstat instead of
>> fiddeling with the config; that can go wrong easily).
>
> Hmm, I would have thought it is the opposite; can't submodules exist in
> the working tree in their own ".git" directory? I know that's the "old"
> way of doing it, but I didn't know if it was totally deprecated.

Oo, right. :(

The proposed patch would not change the current behavior for a layout of
.git directories inside the submodule working trees, actually.
It would however also not have the desired effect of enabling the check for
push.

However these not-yet-deprecated layouts are likely in use by people
who know what they are doing, so maybe we can punt on that.

>
> Anyway, the config version is probably just:
>
>   int config_check_submodule(const char *var, const char *value, void *data)
>   {
>         if (starts_with(var, "submodule.") && ends_with(var, ".path"))

s/.path/.url/ but I get the point. I do dislike this solution for
another reasons though:

In the future when worktree supports submodules we either
have the url per worktree,so we'd need to process all working tree
configs as well
or we do it the proper way, which is replacing the submodule.$name.url variable
with 2 options, one is purely used to configure the URL and the other is purely
used to indicate the existence of a submodule.  Piling on the mixed use case of
urls today feels sad.


>                 *(int *)data = 1;
>         return 0;
>   }
>
>   ...
>   int have_submodule = 0;
>   git_config(config_check_submodule, &have_submodule);
>
> But I don't care too much either way. that's just for reference.
>
>> @@ -31,6 +32,19 @@ static const char **refspec;
>>  static int refspec_nr;
>>  static int refspec_alloc;
>>
>> +static void preset_submodule_default(void)
>> +{
>> +     struct strbuf sb = STRBUF_INIT;
>> +     strbuf_addf(&sb, "%s/modules", get_git_dir());
>> +
>> +     if (file_exists(sb.buf))
>
> Maybe just:
>
>   if (file_exists(git_path("modules"))

Sounds good.

So I'll see if I can get the version running you propose here, otherwise
I'll resend with these changes.


>
> ?
>
> -Peff
