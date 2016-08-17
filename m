Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2103E2018E
	for <e@80x24.org>; Wed, 17 Aug 2016 12:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbcHQMsk (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 08:48:40 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33014 "EHLO
	mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181AbcHQMsj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 08:48:39 -0400
Received: by mail-it0-f68.google.com with SMTP id d65so8968391ith.0
        for <git@vger.kernel.org>; Wed, 17 Aug 2016 05:48:38 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=DoTgA6ekVAa4vuL6sm/NgyCOGhufN4sISre4EKp6Gvc=;
        b=AaWD8faWqnmeMKfbn2LGXgn0/s6tCUpybHlGs81aGlnaOc9wmk07pwGmj3WMkZxFsV
         qTVXP89Otg0hTStDuIHW5SBK02++1/IHzllnpkyz1LcWVbxXtrMh0LivHyiMbHFiZSF0
         MMnEAL4L0dJABoRRbh1oHTfCLIgVewj8pyiRL59tsWHW7pu19SFgYeIVc9DrWrEERAah
         vACqP4i2QQBdLbkGTy5vM1a04tyu48e2VkgUm+WaedLTyGhDC3n56a+HT19islIB/kBC
         ECRehd07pX6NiOlriHH8Hm+OjDJTm+q+UVdoGhOfVIEN2cThvT+JgckG0DygEGlFJt0o
         MX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=DoTgA6ekVAa4vuL6sm/NgyCOGhufN4sISre4EKp6Gvc=;
        b=jz0GyvR7cWNWu+vGLoenWcWRI/30jxp0TjxYfy4qht+5EdUujIA88synLXHOucIm+S
         dlfpga7LBBPOwHE45Dw0aF0xA0wgYI/bvSIHVWn83Fk95AlZA/VbUuVsQevBa/CeEPKM
         It3ptVvVNVe/cSxlQSbySxKsCS/QK5IvzdBUPHBWK9YVhL1WgPSnGboi2w9g+Rl9nFLM
         kThEEgBhNuKm4nRNQ8Q/PF/4UN7yyME2XwnMcGiAn4d6VItc2hfipVM04AGax0cq9KWu
         Rw1JmiHv0nfJCSKzCSOG5Cwm/WJLWhrbmUgcHU6JmHRuxVr5QCsSzn2wnG7yAG8qIYxi
         Ob8A==
X-Gm-Message-State: AEkoouvW5AfL/NqXX/q+6PanhuUKH5muKIkG+QYQ53eJiiYlvalrilA4S4eoERjsmQDUStI5J7q1a4K0tlaYBA==
X-Received: by 10.36.210.68 with SMTP id z65mr10057267itf.32.1471438118270;
 Wed, 17 Aug 2016 05:48:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.130.1 with HTTP; Wed, 17 Aug 2016 05:48:37 -0700 (PDT)
In-Reply-To: <77e7c4e4de6c45a1b24bb4d08ca20a1385f43444.1471437637.git.johannes.schindelin@gmx.de>
References: <cover.1471437637.git.johannes.schindelin@gmx.de> <77e7c4e4de6c45a1b24bb4d08ca20a1385f43444.1471437637.git.johannes.schindelin@gmx.de>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Wed, 17 Aug 2016 08:48:37 -0400
X-Google-Sender-Auth: StiY8KAM5Y9ijbITccXbuk69FMM
Message-ID: <CAPig+cR4=kEUb5PsZfoz3=W+R61wER=vHos5uX02kEVM8YETgA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mingw: ensure temporary file handles are not
 inherited by child processes
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	Git List <git@vger.kernel.org>, Ben Wijen <ben@wijen.net>,
	Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 17, 2016 at 8:41 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> When the index is locked and child processes inherit the handle to
> said lock and the parent process wants to remove the lock before the
> child process exits, on Windows there is a problem: it won't work
> because files cannot be deleted if a process holds a handle on them.
> The symptom:
>
>     Rename from 'xxx/.git/index.lock' to 'xxx/.git/index' failed.
>     Should I try again? (y/n)
>
> Spawning child processes with bInheritHandles==FALSE would not work
> because no file handles would be inherited, not even the hStdXxx
> handles in STARTUPINFO (stdin/stdout/stderr).
>
> Opening every file with O_NOINHERIT does not work, either, as e.g.
> git-upload-pack expects inherited file handles.
>
> This leaves us with the only way out: creating temp files with the
> O_NOINHERIT flag. This flag is Windows-specific, however. For our
> purposes, it is equivalent our purposes) to O_CLOEXEC (which does not

s/our purposes)//

> exist on Windows), so let's just open temporary files with the
> O_CLOEXEC flag and map that flag to O_NOINHERIT on Windows.
>
> This fixes the test that we just introduced to demonstrate the problem.
>
> Signed-off-by: Ben Wijen <ben@wijen.net>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
