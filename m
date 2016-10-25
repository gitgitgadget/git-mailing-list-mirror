Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BE202022A
	for <e@80x24.org>; Tue, 25 Oct 2016 11:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941642AbcJYLHT (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 07:07:19 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:34075 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752957AbcJYLHT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 07:07:19 -0400
Received: by mail-yw0-f169.google.com with SMTP id w3so4149057ywg.1
        for <git@vger.kernel.org>; Tue, 25 Oct 2016 04:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KahGf64DFWgwVo4ZfWb7qJ/HmyvzUeJnLYG+NRuD9OE=;
        b=IJhSuHu4r5wKuPn41vvCSVOqsvD+DYZgwtDTcafJYhDzmCXiX71S8SLF+UfdIsudkg
         tXxcBj7yMOXUJ8e9Zncm0KOZVGp2Ot7ocCMg+cXDoXhr5bDAj8SzSGOmmJhUWv+GRyuC
         KABjTUzdV6JNhFhz0gGNisHi9pKS5Uf0MzSmuZnN2k0Gq09FYZZH6uqr4XmvAT+N459o
         gXprCs4mm14oN65BRh/HYE/GfWuChVm2e5EBOKGtbaE3zCKhvt6gqldbesin7HsxSyCE
         /saaylM/H8vtteVH7x3qYz/Jjug9reV9S1oIVtOpr7FHosnXKJvXyXvJTmaPT9TuMVWE
         GqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KahGf64DFWgwVo4ZfWb7qJ/HmyvzUeJnLYG+NRuD9OE=;
        b=c965C2WYNep+mAwuOvP7ozp0tZxbtEYzcRiBxrmMPijyqjJBgRKaJhA4mhnplMj2X2
         dPl3QaHmpn+x5RCi/m1AilGq8YPfVUR5fU7Alf8Mp4sx5hzRnTPs0otZsrECWi2isly8
         LUKhoYFSMPOGjk2JW4CA8QdPP3k28l9sly5WrwSP9/tEniOprxBlf1ZyUHUTgtB3O+RO
         sTmZVc1DE2lGnOTDuX654GHPpDxYcbObJE2o4bh8aW0Z3LS9IxO7txU/yEHIAEJnQFIP
         9UZ1zW/8V4hE/Gz9DPzOn11xi1uZa8ZZBhQ997Wi7i7MqlkP9LYe5Xp0r7OPsFmHzEnO
         RTdg==
X-Gm-Message-State: ABUngvfDm+VMzQEaLMABYVw5gk3yJEuYUIis/iLXlElZzmr3YqsO2Gblg/2qilEhtQD+6ShQ2Ka7cyMZiVEQgw==
X-Received: by 10.36.118.82 with SMTP id z79mr1210474itb.74.1477393638140;
 Tue, 25 Oct 2016 04:07:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Tue, 25 Oct 2016 04:06:47 -0700 (PDT)
In-Reply-To: <xmqqa8dttkbw.fsf@gitster.mtv.corp.google.com>
References: <xmqqa8dttkbw.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Oct 2016 18:06:47 +0700
Message-ID: <CACsJy8B-GcMNv7pYYLpaUXc2kKnvyYEYm6w=fiaHy7rt4aug1Q@mail.gmail.com>
Subject: Re: [PATCH] reset: --unmerge
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 25, 2016 at 6:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> The procedure to resolve a merge conflict typically goes like this:
>
>  - first open the file in the editor, and with the help of conflict
>    markers come up with a resolution.
>
>  - save the file.
>
>  - look at the output from "git diff" to see the combined diff to
>    double check if the resolution makes sense.
>
>  - perform other tests, like trying to build the result with "make".
>
>  - finally "git add file" to mark that you are done.
>
> and repeating the above until you are done with all the conflicted
> paths.  If you, for whatever reason, accidentally "git add file" by
> mistake until you are convinced that you resolved it correctly (e.g.
> doing "git add file" immediately after saving, without a chance to
> peruse the output from "git diff"), there is no good way to recover.

I made this exact mistake on a giant, half-resolved merge conflict the
other day and panicked. While I prepared myself to script update-index
to restore stages 2 and 3, I found "update-index --unresolve". It
sounds like this "reset --unmerge" is the same functionality, right?
I'm not objecting this patch though, update-index is not something a
casual user should use.

> There is "git checkout -m file" but that overwrites the working tree
> file to reproduce the conflicted state, which is not exactly what
> you want.  You only want to reproduce the conflicted state in the
> index, so that you can inspect the (proposed) merge resolution you
> already have in your working tree.
-- 
Duy
