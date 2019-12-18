Return-Path: <SRS0=Z/Vr=2I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA69DC43603
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 03:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BABB8206EE
	for <git@archiver.kernel.org>; Wed, 18 Dec 2019 03:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sO/Mu+c/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfLRD2k (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 22:28:40 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46721 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfLRD2k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 22:28:40 -0500
Received: by mail-qt1-f196.google.com with SMTP id 38so794927qtb.13
        for <git@vger.kernel.org>; Tue, 17 Dec 2019 19:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xtXEOT6RIn5QpXskPkR+8uB9puNwY4qRDX1jn8XigNk=;
        b=sO/Mu+c/uQzA3f54A8jmOaHm9xca9NjbF5qhr7rLfc/CKUmXZXk/SUR8x3eS10ywbd
         qYOaUCUEnllfto1ZUgrj8M1ZqiqbsL57nHU3A24Ryv6fWBaH1rbVLWQV8PYaQVe+mXjp
         BhL9gtJD6n6KFUAIVWedry9pLwtEisRY8gpBO6eFJ4un5rJZ3t6jlvli49gtxPhqdsIK
         H6nUHukUmME/Ytzx8p8FH4ZdOS0A3Dna0VJkCX96DqQXqckkmvkspx9aipyAa20j2xGh
         LTcO9zkhtwkrP87gWyF7FtfAOZq/EKHkTCr1LWVuJl0u6qTQWngAvwNmpMt3rAmWLKf+
         HMzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=xtXEOT6RIn5QpXskPkR+8uB9puNwY4qRDX1jn8XigNk=;
        b=YWQTtl0y7ZLknt4pNsQ7ugY0lhbYYz+zybrCugG03U2ShMyY5kpb4nwpc2R8ZsJMIa
         NOT4SFjGKXl0fedv1Ap/S6NlHXLN4/6oSUEn9gm+sC/nnOQv4ql4qiiK0hl5wRW0SETV
         qK1zGyBmocU1BfW0m+CMyr9mtibBvXkNgP5fNrkIutdWotL45xiqi74+P66ubflDLAbB
         qyVUx0koVhG1ut2G6bWrxt2aYxC1vyc13jxqRoJ+zBJ2oGEYSUbCc/ZbkB7a3gVDzhOM
         TR+p/BLEo37tsiOuSjF7y/OWEFlZW4Y2US2/KEKmOj9yfWhCkXDuJIVrHyY1IHme9DkM
         PTYg==
X-Gm-Message-State: APjAAAWXiw0MmW67SPGPnnZakQg89mstX3zUdK5Exmj5klW7KUYrttED
        67MQgfnYWA+BhrTZAusGD6w=
X-Google-Smtp-Source: APXvYqxhTIs3zqSCZKvxVVEqkoZbwtdlD3aCDMmdZSANiGk/dImBkhNX8gN06TT/jnjR8wVvjOIxCA==
X-Received: by 2002:ac8:1835:: with SMTP id q50mr420723qtj.210.1576639719563;
        Tue, 17 Dec 2019 19:28:39 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id x11sm243415qkf.50.2019.12.17.19.28.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Dec 2019 19:28:39 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/2] Documentation/git-log: mention that line-log regex must match in starting revision
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqq5zieizrb.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 17 Dec 2019 22:28:37 -0500
Cc:     Derrick Stolee <stolee@gmail.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>
Content-Transfer-Encoding: quoted-printable
Message-Id: <147443E8-EA04-45D2-B3BC-D879A5FFECDC@gmail.com>
References: <pull.494.git.1576559263.gitgitgadget@gmail.com> <4ea4eeae0c1e23221012855168bf6640be93fd4f.1576559263.git.gitgitgadget@gmail.com> <1d033204-80fd-25f8-3a80-0cb641953139@gmail.com> <xmqq5zieizrb.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 17 d=C3=A9c. 2019 =C3=A0 13:16, Junio C Hamano <gitster@pobox.com> =
a =C3=A9crit :
> Even when you specify <start> or <end> as a line number, they must
> exist in the starting revision or it would be a fatal error.  If we
> are clarifying with this patch for completeness, I think we should
> also mention it together. =20
Thanks for the feedback. I did some tests :=20
    git log -L 73,2000000085:Documentation/git-log.txt
does not error and shows the history from line 73 to the end of the =
file.
    git log -L 300,2000000085:Documentation/git-log.txt=20
errors out:
    fatal: file Documentation/git-log.txt has only 239 lines
But=20
    git log -L 300,-2000000085:Documentation/git-log.txt
does not error out and shows the history for the whole file. Also,
    git log -L 1,-2000000085:Documentation/git-log.txt
does not error out and gives the history for the first line.

So I think that it=E2=80=99s really only regex that must match...=
