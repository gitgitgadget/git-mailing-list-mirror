Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77DDC433DB
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 16:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7872920936
	for <git@archiver.kernel.org>; Sun,  3 Jan 2021 16:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbhACQzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Jan 2021 11:55:43 -0500
Received: from ciao.gmane.io ([116.202.254.214]:55056 "EHLO ciao.gmane.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbhACQzn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jan 2021 11:55:43 -0500
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <gcvg-git-3@m.gmane-mx.org>)
        id 1kw6ej-0003qm-Se
        for git@vger.kernel.org; Sun, 03 Jan 2021 17:55:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Stefan Monnier <monnier@iro.umontreal.ca>
Subject: Re: [BUG] Destructive access to an "objects/info/alternates" repository
Date:   Sun, 03 Jan 2021 11:50:35 -0500
Message-ID: <jwv1rf26k9n.fsf-monnier+gmane.comp.version-control.git@gnu.org>
References: <jwvpn2tdb0r.fsf-monnier+gmane.comp.version-control.git@gnu.org>
        <20201228190036.vnkgeu6puxmvgt5s@chatter.i7.local>
        <jwv8s9hd9cg.fsf-monnier+Inbox@gnu.org>
        <jwvlfdhbsbs.fsf-monnier+gmane.comp.version-control.git@gnu.org>
        <20201229154403.xutnk2aoawdrjfwx@chatter.i7.local>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Cancel-Lock: sha1:3S7IPS6GWOLNwl7wRkEO9d7eofc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> FWIW, I just tried it with
>> 
>>     git clone --shared ~otheruser/nongnu
>> 
>> and got the same result.
>> I also tried with another repository, still with the same result (tho
>> different pack.idx names, of course).
>
> I've tried several times to reproduce this, but I am unable to do so. You may
> need to provide the tarball with ~otheruser/nongnu contents for someone to be
> able to properly debug this.

OK, you can try with the following tarball:

    https://www.iro.umontreal.ca/~monnier/nongnu.tar.gz

untar it (as "otheruser") into ~otheruser (which will create
~otheruser/nongnu) and then do (as your normal user):

    git clone --shared ~otheruser/nongnu
    cd nongnu
    git gc

It "worked" (i.e. gave me the unlink failure warnings) for me, so
hopefully it will "work" for others as well.

The `git clone` will likely give you some message about HEAD not being
found, which is normal.


        Stefan

