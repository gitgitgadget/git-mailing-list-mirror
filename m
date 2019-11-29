Return-Path: <SRS0=rBju=ZV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8482FC432C0
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D196206B5
	for <git@archiver.kernel.org>; Fri, 29 Nov 2019 21:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="txv3EStS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfK2V3G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:29:06 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:44558 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfK2V3G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Nov 2019 16:29:06 -0500
Received: by mail-pl1-f178.google.com with SMTP id az9so13380364plb.11
        for <git@vger.kernel.org>; Fri, 29 Nov 2019 13:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=whyfsiQOlPY4RhKc8O02w2NiKni1ryDRt7S1fupGnho=;
        b=txv3EStSpnlEwLIKEyT8poYLVhzCn7Sns33JGV139EITYkbfHqk5kkjTAzb2oyKa7D
         1DHK59bUZXKfF5EuqSphOr5wMrb8CBe0Ka8wfBCmOiGzgpsBs0GdEW24dBJ7DLqPNGN7
         SG08gzos26VvllvXMnYdbj5NXY5NcEsJ+nJBODGSyH+xP0m2WLCGtxaJvMRR6+0Tr8ZE
         Hc16afmGu7iKjZWwL8Vq2uTtfx4DcGYFXz34nsv/PBWpLbUA8VZPLBUC4TRpyfDWDO2n
         cniLxuQi2RJGDhavM6ySDgkBfpSCnd2LRp90GcZNoVAzbbBxDoiQwIifmlMXFWqj+EFw
         1urA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=whyfsiQOlPY4RhKc8O02w2NiKni1ryDRt7S1fupGnho=;
        b=oj9x62kFhbF7AGLOLXupEFugti9KuL9pGWXPwW6khpWUmauVMsR12KwsnWR7nMRtLx
         rgYV1JZlOQKE0VcrBZdfKjSUK4yECJdrRVMR4TkAsPBArg2KAq7k/ERWCpliC2Bk0bbP
         Heu7gpi7CtUzEjpbAsGye4izoiehSQElUqyb8TEjpK7D7dxNZ8fSDLdaEaMsCCVcO8hv
         Vd7xlxttHXGh4agyDluDNLBMeQE8EBVM8VsM7KaqB+MAnm+dmlXVSjg4PIXgau8UE0rn
         SRxseW+b3sULD+HlLF1RsTyBYQcx1ZouPaUpmYPlRHcVZidq8gPeBuRpMqItuQWW24O3
         ClPA==
X-Gm-Message-State: APjAAAWCmPeHivSjwxfIk6s0gG7WzDXbKhSVa0lVrhGpKU6KdI8ikZ6P
        HDohHAJpWaaVMBI66utDNQ1aOPpID/euajGrFm8=
X-Google-Smtp-Source: APXvYqzqrRMaKIph3qx9nl42qH57xLTWeziOkEjMQGoWCwwnY1lilGhOFfU2ZZEtmgdofe5nck1q4DA7II2fFw4VURk=
X-Received: by 2002:a17:90a:4d4c:: with SMTP id l12mr20195603pjh.127.1575062944091;
 Fri, 29 Nov 2019 13:29:04 -0800 (PST)
MIME-Version: 1.0
References: <CAN_72e2h2avv-U9BVBYqXVKiC+5kHy-pjejyMSD3X22uRXE39g@mail.gmail.com>
 <eadb7c7e-5c8c-7e0b-2be0-ddc31d6ff7d4@iee.email>
In-Reply-To: <eadb7c7e-5c8c-7e0b-2be0-ddc31d6ff7d4@iee.email>
From:   Pavel Roskin <plroskin@gmail.com>
Date:   Fri, 29 Nov 2019 13:28:52 -0800
Message-ID: <CAN_72e3PLSyc_qXVztrSwKn+3tFA_x1TDkmA5Pi21KZvbb0ENQ@mail.gmail.com>
Subject: Re: git-rebase produces incorrect output
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Philip,

I just found out that the true diff on Github should use two dots, not three:
https://github.com/proski/git-rebase-demo/compare/merge-good..rebase-bad

The first difference is on line 187 in
getPullRequests_throws_on_not_found(). The correct change should have
"nullValue" (see the diff between "master" and "branch1"), but
"rebase-bad" has "SocketException" there instead.

[Sorry for the private email that I sent by mistake]

Pavel
