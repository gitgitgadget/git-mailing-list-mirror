Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68758C05027
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 00:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjBRAJM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 19:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBRAJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 19:09:09 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C78466CCC
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 16:09:07 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
        t=1676678945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9vnTznWzcPsRp7cIzA2nfoli/rT3lvTly0lQnwd8uiU=;
        b=h79+fLyM16YjxCKLwlxVVcjWtAs9UAKtODSsgml511A1WVyeAKW4tOPw3C4TyR4LuqUni0
        oMfktYEZNbuKffdMIK/mqsnepRv9TTBATLcy17Hzrfs/01yMZaN32l1T2sizdoCNJ3uVAh
        rjBz8FNRWo1LnWWh8ibF/Yhr8mPBdWo=
Date:   Sat, 18 Feb 2023 00:09:05 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   ronan@rjp.ie
Message-ID: <49c07b5dc2afbd422d492d59380ad2c2@rjp.ie>
Subject: Git pull without fetch
To:     git@vger.kernel.org
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear maintainers,=0A=0AI use the git-maintenance prefetch task with a cer=
tain repo to periodically=0Afetch updates from the remote. I'm trying to =
figure out a way to have git=0A"complete" a prefetch on command, via an o=
ption, alias, or other extension that=0Amimics the behavior of git pull, =
but does not fetch from the remote. By=0Acomparison, `git pull` or `git f=
etch && git rebase` would fetch the remote and=0Afast-forward my local co=
py to match, but I don't want to fetch the remote.=0AInstead I want to fa=
st-forward my current branch (and the remote tracking=0Abranch) to the pr=
efetched tip as if git pull had been run at the time of the=0Alast prefet=
ch.=0A=0AFor example, suppose my local copy has a branch master that trac=
ks the remote=0Abranch master from origin. Suppose that the local copy (a=
nd the remote tracking=0Abranch) have commits A--B, the remote has commit=
s A--B--C--D, and commit C has=0Abeen prefetched and is pointed to by ref=
s/prefetch/remotes/origin/master. The=0Adesired effect could be accomplis=
hed, I think, by:=0A=0Agit update-ref refs/remotes/origin/master refs/pre=
fetch/remotes/origin/master refs/heads/master &&=0Agit rebase origin/mast=
er master=0A=0AMy question is, how can I calculate the correct remote tra=
cking branch to=0Aaccomplish this operation in the general case, just as =
git pull without argument=0Awould have done? Or is there a simpler way to=
 achieve my goal?=0A=0ACheers,=0ARonan
