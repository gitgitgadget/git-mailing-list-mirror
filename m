Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B62F1F461
	for <e@80x24.org>; Wed, 15 May 2019 11:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731746AbfEOLnO (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 07:43:14 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:41825 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730677AbfEOLnO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 07:43:14 -0400
Received: by mail-ed1-f46.google.com with SMTP id m4so3655030edd.8
        for <git@vger.kernel.org>; Wed, 15 May 2019 04:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=gzRhABsBlDv4TDVcie9RcAHoDUOlczcwhAI5VsvoKdY=;
        b=hKfMdhsAPDIanP5nPk4CJY403phe2XYl/YzGGibyR8tywDakBFwRxwY3MHGM0ZOuuR
         4jQ7867Ppo5TI8xasK6YFgZBe2sPSUgfRBh4Eg9BA+TN+DeKWqu+/WyIttSjwjnqwPzj
         MPG3p6dL9OCA5BB0I8GGnFVrt+QQHV5AlVAFC1UDm8mvNaUU+oJvGOXE6kuDpvTd/p6s
         SaavqeB1XMacfymXZtMT8+NwXsTnKQL4E3mZjVr25bwew4cvS7THJxCThZD9vG7BnIwv
         Oj7vS9a/Uxl+mssQ9w9QGCgsCN4Do3NEMTg8EjYFoAfgPOtM1udUI2yFrN1gw5PMfULL
         ydSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=gzRhABsBlDv4TDVcie9RcAHoDUOlczcwhAI5VsvoKdY=;
        b=pN08crl2XftBoCU9UDBpeTCHXym8sIESZIFrfANo7InDIfwxldvWTRxRAF1MuiiKv5
         PHbqguCqWh9BpZqv9sWHWPdCd36bR7rdJFheGxwVi7RkRPqCharPn1458vomRFoaJLoL
         VvwF7ZRHsJLjsMKTZO2tbPxmktIpKSkoIV1Fd2DY/ACr7/hDUFXNTmghhDZQTPJ/vs8q
         b5PM+oGrZj4NZDUbwmCQlIE8f/sORm3tkxG34JfKYvK2NtdMkT/leC7K3ezJ99K0at5w
         qtkY3O+c3oaKlONTcOxAz5zzchj2VAWouboOjIWZzkxE8/QHVQCE2NsaFYu7gs3Xz1N8
         s+4Q==
X-Gm-Message-State: APjAAAVmwNZka4gp+iZwKFrqXlSaHmhH8lCmSsffqrw+aWCga/Ztnh5o
        3H+kXUABs30tQXqxQ+g1VaiIyimR
X-Google-Smtp-Source: APXvYqwAeBhYANZlxiQpLDXELziidtq6nA0iP09/SdsDb0YDkn4EnkC/BBV+kX92kDSB1qOdUsz2Ag==
X-Received: by 2002:a50:bf0a:: with SMTP id f10mr43391450edk.51.1557920591775;
        Wed, 15 May 2019 04:43:11 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id y46sm721060edd.29.2019.05.15.04.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 04:43:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
Subject: Re: Closing fds twice when using remote helpers
References: <20190515105609.sucfjvuumeyyrmjb@glandium.org>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190515105609.sucfjvuumeyyrmjb@glandium.org>
Date:   Wed, 15 May 2019 13:43:10 +0200
Message-ID: <87bm04vt81.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 15 2019, Mike Hommey wrote:

> Hi,
>
> I started getting a weird error message during some test case involving
> git-cinnabar, which is a remote-helper to access mercurial
> repositories.
>
> The error says:
> fatal: mmap failed: Bad file descriptor
>
> ... which was not making much sense. Some debugging later, and it turns
> out this is what happens:
>
> - start_command is called for fast-import
> - start_command is called again for git-remote-hg, passing the
>   fast_import->out as cmd->in.
> - in start_command, we end up on the line of code that does
>   close(cmd->in), so fast_import->out/cmd->in is now closed
> - much later, in disconnect_helper, we call close(data->helper->out),
>   where data->helper is the cmd for fast-import, and that fd was already
> closed above.
> - Except, well, fds being what they are, we in fact just closed a fd
>   from a packed_git->pack_fd. So, when use_pack is later called, and
>   tries to mmap data from that pack, it fails because the file
>   descriptor was closed.
>
> I'm not entirely sure how to address this... Any ideas?
>
> Relatedly, use_pack calls xmmap, which does its own error handling and
> die()s in case of error, but then goes on to do its own check with a
> different error message (which, in fact, could be more useful in other
> cases). It seems like it should call xmmap_gently instead.

The "obvious" hacky fix is to pass in some "I own it, don't close it"
new flag in the child_process struct.

In fact we used to have such a thing in the code, see e72ae28895
("start_command(), .in/.out/.err = -1: Callers must close the file
descriptor", 2008-02-16).

So we could bring it back, but I wonder if a better long-term solution
is to refactor the API to have explicit start_command() ->
free_command() steps, even if the free() is something that happens
implicitly unless some "gutsy" function is called.
