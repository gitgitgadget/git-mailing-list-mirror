Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 975B11FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 14:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752396AbdBIOSJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 09:18:09 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:36653 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752200AbdBIOSH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 09:18:07 -0500
Received: by mail-it0-f43.google.com with SMTP id c7so125882621itd.1
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 06:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8WNwtV2PnRzdG2hJ/t5ZpKMgIQQBQUOcKZFOmLtpO3o=;
        b=RX1kbK/2dnKteKSOz1iLo+0iHnKhAO3UAA5SZhCeYjCELTdb+4aNGtYAybrh08lPDj
         6N4tqMDpjWvQvLtOQ7/ppgDkgH8t52oEYZqcAHjBTckIuDeosMf7hOq2qGEtLM8Xupnk
         GDU3IsnJQM3VjxzZY9yygbuST+ZtI7lQkAEf186WLiPH7FyIkVQHljzKIjNohO1bDGHk
         pQ7tO/cZOBm/Gh7BDnujD6a75lRoyxnLi439HfPVysNBwqrZ3J5EC9ldVzYITup82cIc
         bTymnbpHWZ/Xlcwthujwn/A88fBl4s+JaXLVnV9flAX674bKT1m6nbtBUSZhV4L2RNyp
         F+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8WNwtV2PnRzdG2hJ/t5ZpKMgIQQBQUOcKZFOmLtpO3o=;
        b=tNCXvxjL1xRZTwcSj++xidWPuFyEeVAMBCdWOaEbYKuEV6Y34MA3wzDGJbbHHehOdq
         X1x1XAkfCSUtN89mLz7fJMUMWZgvqVY01Z+/ID2SX65x/udFCby+ZYGs9SIfH5kC2K9b
         U3qHbceov4R5nB25yyCmXiLUgoNfsV3uokB0zlA068I77ST+pH9dw7c8I2XibGeYg1iB
         07kmweJJyYth+4m7oVMkWlXDNom2RQ65qLkuNQeQ7q36w/helHvSGirzwDTEGPa9oPLu
         m/VZKchRFLUP13FZ+Jk36M+FplYXFhl2Za/HwOonmFU4ExPT3MA3Mk4BZgcUKhA+Qx7h
         PKlw==
X-Gm-Message-State: AIkVDXKpRYoaTctuoz8BB2F5H7t4yjY3np7gCGLg4cNYhEMrxiAw2ijdb5LIx6U7MPjZ+nvkdEXvFd0MdSoRTQ==
X-Received: by 10.36.110.205 with SMTP id w196mr21920980itc.20.1486648002968;
 Thu, 09 Feb 2017 05:46:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.164.36 with HTTP; Thu, 9 Feb 2017 05:46:22 -0800 (PST)
In-Reply-To: <CACsJy8CigsWjAq5cmJ=cbBmj=DdJtHdMKxmoifftuz9+9kqJiQ@mail.gmail.com>
References: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de>
 <CACsJy8CigsWjAq5cmJ=cbBmj=DdJtHdMKxmoifftuz9+9kqJiQ@mail.gmail.com>
From:   Mike Rappazzo <rappazzo@gmail.com>
Date:   Thu, 9 Feb 2017 08:46:22 -0500
Message-ID: <CANoM8SWv+KD92T263gS0Uxxi2ekNQdo0aNGx3AmweVasXk3GbA@mail.gmail.com>
Subject: Re: [PATCH] rev-parse --git-path: fix output when running in a subdirectory
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 9, 2017 at 4:48 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Wed, Feb 8, 2017 at 7:17 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>> In addition to making git_path() aware of certain file names that need
>> to be handled differently e.g. when running in worktrees, the commit
>> 557bd833bb (git_path(): be aware of file relocation in $GIT_DIR,
>> 2014-11-30) also snuck in a new option for `git rev-parse`:
>> `--git-path`.
>>
>> On the face of it, there is no obvious bug in that commit's diff: it
>> faithfully calls git_path() on the argument and prints it out, i.e. `git
>> rev-parse --git-path <filename>` has the same precise behavior as
>> calling `git_path("<filename>")` in C.
>>
>> The problem lies deeper, much deeper. In hindsight (which is always
>> unfair), implementing the .git/ directory discovery in
>> `setup_git_directory()` by changing the working directory may have
>> allowed us to avoid passing around a struct that contains information
>> about the current repository, but it bought us many, many problems.
>
> Relevant thread in the past [1] which fixes both --git-path and
> --git-common-dir. I think the author dropped it somehow (or forgot
> about it, I know I did). Sorry can't comment on that thread, or this
> patch, yet.

I didn't exactly forget it (I have it sitting in a branch), I wasn't
sure what else was needed (from a v5 I guess), so it has stagnated.

There was also another patch [1] at the time done by SZEDER G=C3=A1bor
trying to speed up the completion scripts by adding `git rev-parse
--absolute-git-dir` option to deal with this case as well.

>
> [1] http://public-inbox.org/git/1464261556-89722-1-git-send-email-rappazz=
o@gmail.com/
> --
> Duy

[1] http://public-inbox.org/git/20170203024829.8071-16-szeder.dev@gmail.com=
/
