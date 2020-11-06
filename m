Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DCEC2D0A3
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 18:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8933020B80
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 18:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="eLs/RP6L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgKFSei (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Nov 2020 13:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgKFSei (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Nov 2020 13:34:38 -0500
Received: from forward103j.mail.yandex.net (forward103j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EB1C0613CF
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 10:34:38 -0800 (PST)
Received: from forward102q.mail.yandex.net (forward102q.mail.yandex.net [IPv6:2a02:6b8:c0e:1ba:0:640:516:4e7d])
        by forward103j.mail.yandex.net (Yandex) with ESMTP id C361267405C4
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 21:34:34 +0300 (MSK)
Received: from mxback4q.mail.yandex.net (mxback4q.mail.yandex.net [IPv6:2a02:6b8:c0e:6d:0:640:ed15:d2bd])
        by forward102q.mail.yandex.net (Yandex) with ESMTP id BF08A7F20002
        for <git@vger.kernel.org>; Fri,  6 Nov 2020 21:34:34 +0300 (MSK)
Received: from vla4-a16f3368381d.qloud-c.yandex.net (vla4-a16f3368381d.qloud-c.yandex.net [2a02:6b8:c17:d85:0:640:a16f:3368])
        by mxback4q.mail.yandex.net (mxback/Yandex) with ESMTP id e0fO1s5sfw-YYoSbO4w;
        Fri, 06 Nov 2020 21:34:34 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1604687674;
        bh=1HN7/8fBWFcOp4Ih0//9TEwKd17iZxM0It3b+6SKl00=;
        h=In-Reply-To:Subject:To:From:References:Date:Message-ID;
        b=eLs/RP6LwVI88CJGVBo4SeXMcCtpvQiwU9mAEHTdMlHdqahxFPYHJ69KHcjHyL/JM
         ZmBP2HW2qze14NUr7B1c7heJIohcBwqRpdYy8hEFQG75ZlyPrc3YRsFt+4CrlZiEox
         42tbn7+zhCCR6hY3bZhTMkbAFj2ElskInvnC2V1k=
Authentication-Results: mxback4q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla4-a16f3368381d.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id ZPjUlFSl1C-YXJa197V;
        Fri, 06 Nov 2020 21:34:34 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Fri, 6 Nov 2020 20:34:33 +0200
From:   Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <992859192.20201106203433@yandex.ru>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git rebase/git rebase --abort cause inconsistent state
In-Reply-To: <1526558917.20201106203213@yandex.ru>
References: <1526558917.20201106203213@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Eugen,

Friday, November 6, 2020, 8:32:13 PM, you wrote:

> Hi

> I try to rebase, get conflicts. So I decide to --abort

> After --abort I expect state before rebasing, but I get conflicts.

> I  supposet  this  is  because `git rebase` switches to not branch and
> --abort can not return to branch I was on before rebasing

> Is this a bug?




> kes@work ~/t/lib/MaitreD $ git rebase dev local/dev
> Created autostash: 566876c8
> warning: Cannot merge binary files: share/ChangeAgreement.docx
> (HEAD vs. f2442d9a... Update Docs.pm)
> Auto-merging share/ChangeAgreement.docx
> CONFLICT (content): Merge conflict in share/ChangeAgreement.docx
> error: could not apply f2442d9a... Update Docs.pm
> Resolve all conflicts manually, mark them as resolved with
> "git add/rm <conflicted_files>", then run "git rebase --continue".
> You can instead skip this commit: run "git rebase --skip".
> To abort and get back to the state before "git rebase", run "git rebase --abort".
> Could not apply f2442d9a... Update Docs.pm
> kes@work ~/t/lib/MaitreD $ git rebase --abort 
> Applying autostash resulted in conflicts.
> Your changes are safe in the stash.
> You can run "git stash pop" or "git stash drop" at any time.

> Here is a tree before rebasing:
>> a9597aaa (HEAD -> dev) Use DateTime with correct timezone
>> 822ff801 Add link to Podio into mail
>> 65575afe Update Docs.pm
> | < e0003861 (local/dev) Update podio.t - test person contacts
> | < 28ab8630 Create docdate if agreement is new and update test for that
> | < 208ead68 Specified checking of person
> | < f2442d9a Update Docs.pm
> |/  
> o 6d9c2159 (xtucha/test, xtucha/dev) Leave only one example in month

> Here is conflicts:
> HEAD detached from 142c1b15
> Changes to be committed:
>   (use "git restore --staged <file>..." to unstage)
> 1       modified:   ../../Makefile
> 2       modified:   ../../etc/maitre_d.development.conf
> 3       modified:   Command/bank_statement.pm
> 4       modified:   Command/invoicing.pm
> 5       modified:   Command/reminding.pm
> 6       modified:   Controller/Cart.pm
> 7       modified:   Controller/Saldo.pm

> Unmerged paths:
>   (use "git restore --staged <file>..." to unstage)
>   (use "git add <file>..." to mark resolution)
> 8       both modified:   Controller/Podio.pm

> $ git --version
> git version 2.28.0


history after --abort:
* e0003861 (HEAD, local/dev) Update podio.t - test person contacts
* 28ab8630 Create docdate if agreement is new and update test for that
* 208ead68 Specified checking of person
* f2442d9a Update Docs.pm
* 6d9c2159 (xtucha/test, xtucha/dev) Leave only one example in month


history before rebase:
a9597aaa (HEAD -> dev) Use DateTime with correct timezone



-- 
Best regards,
Eugen Konkov

