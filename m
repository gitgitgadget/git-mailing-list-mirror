Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 175B51F89C
	for <e@80x24.org>; Sat, 21 Jan 2017 12:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751100AbdAUMzi (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 07:55:38 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33957 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbdAUMzh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2017 07:55:37 -0500
Received: by mail-ot0-f194.google.com with SMTP id 73so10321886otj.1
        for <git@vger.kernel.org>; Sat, 21 Jan 2017 04:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KJAmeag5n7z7CAaNtx+4BFCOqNC1zdTs5J0FoU8IKMk=;
        b=kHoCSZVG5q7lcEbWD+xEjfTz92UzymGjGUebx3Kp/WeW9iE017cxc7qE2hTfFItMCF
         jO1qJrsx4gBvaZp7OpwA4S/PgSGoRI12/nv/HkCp2o0yGPMgqWfbPoqd+DnN34e4wmbJ
         tYlI/65g0Ups9oW5jt8l1PQeh+ReGrpGlBbST/p3QIoSQBdT2QiTxUfvr1Q9U1uGgfpP
         YkuVvJMybp9CpV6MCr3Ut/lkWF5mworasxw6FkAd3wnHBrBlwODK9iSFX/4VK596uqeY
         vNr82cTPddo6FSSzsijJQsWntMv+iod1CerufmEbLluaknN8IjBZyxGFTWwmnN4CvI3l
         pMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KJAmeag5n7z7CAaNtx+4BFCOqNC1zdTs5J0FoU8IKMk=;
        b=Dv8f71L3PbOTEqgw7ON4+T9j8+VunTivf0daT7QJIzbAjqhzTAnx/gpw97VifYiXwC
         /Cu8EWoMT1QfTNXnLVoJm1z+cRiQN6hTpH7AOobjBFJ7IY2tekanixtNOXvy3Un3fdui
         dTvS4JyRCGLMeAjpFkwTR6mEH1A0OANP7Rm2eP6qR/dmND+I+lx4empKu8/KJv7Of1RD
         ONtfhFaKOACx2aUy/OKaFFdf/NulLY5LedT9/uWVdYIKmS+Hsz5sobFnP9jZGfs2321W
         Vy9X4fQ9VY9UezOeTSpiPDQ8em71YhFc54v8hjXi/O7XBUqms8DQHqHltORrpNeCtVGT
         nmgQ==
X-Gm-Message-State: AIkVDXIh5OLojr+0SEx3Wvuy6ES16Y7zPCbkOUaBNV90HHK6Diby7dFAca7o20acnj4TGcRd1hK+DGtMIO4esw==
X-Received: by 10.157.18.246 with SMTP id g109mr10403178otg.10.1485003336514;
 Sat, 21 Jan 2017 04:55:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Sat, 21 Jan 2017 04:55:05 -0800 (PST)
In-Reply-To: <20170120191728.l3ne5tt5pwbmafjh@sigill.intra.peff.net>
References: <20170119193023.26837-1-sbeller@google.com> <20170120191728.l3ne5tt5pwbmafjh@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 21 Jan 2017 19:55:05 +0700
Message-ID: <CACsJy8DJpueeRqLSbGuY6gsMKeYd+Q0dUzFB4p_Sq-795MhG1A@mail.gmail.com>
Subject: Re: [RFC/PATCH] Disallow commands from within unpopulated submodules.
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 21, 2017 at 2:17 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Jan 19, 2017 at 11:30:23AM -0800, Stefan Beller wrote:
>
>> Now let's ask the same question for "git -C sub status ." (which is a
>> command that is only reading and not writing to the repository)
>>
>> 1) If the submodule is populated, the user clearly intended to know
>>    more about the submodules status
>> 2) It is unclear if the user wanted to learn about the submodules state
>>    (So ideally: "The submodule 'sub' is not initialized. To init ...")
>>    or the status check should be applied to the superproject instead.
>>
>> Avoid the confusion in 2) as well and just error out for now. Later on
>> we may want to add another flag to git.c to allow commands to be run
>> inside unpopulated submodules and each command reacts appropriately.
>
> I like the general idea of catching commands in unpopulated submodules,
> but I'm somewhat uncomfortable with putting an unconditional check into
> git.c, for two reasons:
>
>   1. Reading the index can be expensive. You would not want "git
>      rev-parse" to incur this cost.
>
>   2. How does this interact with commands which do interact with the
>      index? Don't they expect to find the_index unpopulated?
>
>      (I notice that it's effectively tied to RUN_SETUP, which is good.
>       But that also means that many commands, like "diff", won't get the
>       benefit. Not to mention non-builtins).
>
> I'd rather see it in the commands themselves. Especially given the
> "ideal" in your status example, which requires command-specific
> knowledge.

I agree. It's already bad enough for pathspec code to peek into the
index, adding a hidden dependency between parse_pathspec() and
read_cache(). And I still think parse_pathspec() is not the right
place to check submodule paths. Worktree should be checked as well, in
the case that the submodule is not yet registered in the index. The
right place to do that is per-command, with their consent so to speak,
because they may need to set things up (index, .git/config and stuff)
properly before explicitly doing this check.
-- 
Duy
