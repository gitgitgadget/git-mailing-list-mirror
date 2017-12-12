Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DCBB1F404
	for <e@80x24.org>; Tue, 12 Dec 2017 00:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751622AbdLLAk6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 19:40:58 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:37403 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdLLAk5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 19:40:57 -0500
Received: by mail-qt0-f196.google.com with SMTP id f2so43385934qtj.4
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 16:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=BeS/vaiTXMX2YjBwIHLvcRNYr4812rLWOLMDkMQZPvM=;
        b=HXm6ZBpYyzgJw6GMR6lYUhtg5U8cXW+8nKxWPhNUryIpri3bqSfhNasHEu7B0WqrKi
         6bRkLZfxG4SvlNlD0+FdEOQOQ7w3AIgF1Uk3Lqp0Pg6uEoI+ED13u2iBeGH19CG+2jfD
         gWoQG6vwzijg4mDhAXS9teD8JvCoWhws1v7c2iHwSh0hd7Ciy7NHEzt/IIpehaXqldz6
         MrF3xEbYQwAF7wBDql3tsmEadgHW544+L16E+ycexR46FQA2CWuNwF9bmWDHZWEQ3I+1
         QY9vHM/C5cwmWEeyxyUTIzp15I8OwZXpyiCpPpsSEUYyWdVb3JCu22RjhogJ2+m6yJuB
         YSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=BeS/vaiTXMX2YjBwIHLvcRNYr4812rLWOLMDkMQZPvM=;
        b=pG71OuYs+OnyDw/LOstsk/ddQ+HcZYvH+Mcxx07JKLdPBy3Unl9ep202/1E+fYStBo
         SoN2a/QUCwOOvh83nIsJ8Mh52iR2ydGLxsWdnvK0oE4lTscug6Z2r605toUzLMa7R6o2
         FDck294Q7Kb7F6SHJuIJsYnsvRUjw2uf2WH6j0Ux3ongeCMljLEKtOLtobj/K/4eODKF
         c+nBs5qnzmDgpmOmhHLwzNAAc8Uwf5Ln7jS6i/Y2ZDWKOwffFClsbuh5NXKdUjuB8L5M
         VQZX3Mho/1cNPwlSadm/EisTZcdmw5b+1pR1F13lwlMVZPgUYBXfDx4YtUO0b35jKui8
         WRzQ==
X-Gm-Message-State: AKGB3mKyNTyluGJ206s077rjABtguJOWJIzCaBAQ2KJv5HhZNAIT5pcb
        efEo9qtOc48+mjiQSYynp7sWh40PSJUetCvRMCw=
X-Google-Smtp-Source: ACJfBosVua8wMf+zFl8IHIP45SPU2zzKB//uVuTx+Vguke6wSHc94XHB4Ie4lgDE/caDOfhyJfOtlnRI4rV7mYHPheo=
X-Received: by 10.237.37.47 with SMTP id v44mr3449834qtc.55.1513039256560;
 Mon, 11 Dec 2017 16:40:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Mon, 11 Dec 2017 16:40:56 -0800 (PST)
In-Reply-To: <20171212001802.GC177995@google.com>
References: <20171211231612.29275-1-sunshine@sunshineco.com> <20171212001802.GC177995@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 11 Dec 2017 19:40:56 -0500
X-Google-Sender-Auth: c0ua0tORmC6FaZ7_ycgSNlQXxFw
Message-ID: <CAPig+cSTsuHdAqdBMvO80ybTSzfxncX8yQODSKd1bmaoNRQOjw@mail.gmail.com>
Subject: Re: [PATCH] clone: support 'clone --shared' from a worktree
To:     Brandon Williams <bmwill@google.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 11, 2017 at 7:18 PM, Brandon Williams <bmwill@google.com> wrote:
> On 12/11, Eric Sunshine wrote:
>>               struct strbuf alt = STRBUF_INIT;
>> -             strbuf_addf(&alt, "%s/objects", src_repo);
>> +             get_common_dir(&alt, src_repo);
>> +             strbuf_addstr(&alt, "/objects");
>
> If you wanted to do this in one function call you could either use
> 'strbuf_git_common_path()' or either 'strbuf_git_path()' or
> 'strbuf_repo_git_path()' which will do the proper path adjustments when
> working on a path which should be shared between worktrees (i.e. part of
> the common git dir).

Thanks for the pointers, however, the above fix mirrors the fix made
by 744e469755 (clone: allow --local from a linked checkout,
2015-09-28) to code immediately below it in the 'else' arm:

    get_common_dir(&src, src_repo);
    get_common_dir(&dest, dest_repo);
    strbuf_addstr(&src, "/objects");
    strbuf_addstr(&dest, "/objects");

It would be poor form and confusing to use one of the mechanisms you
suggest while leaving the 'else' arm untouched.

Re-working both arms of the 'if' to use one of the suggested functions
would make a fine follow-on or preparatory patch, however, I'd rather
not hold up this fix merely to re-roll for such a minor cleanup. (I
also considered a follow-on patch to reduce the duplication between
the two cases but decided against it, for the present, since such a
patch would almost be noise without much gain.)

By the way, is there any documentation explaining the differences
between all these similar functions and when one should be used over
the others?
