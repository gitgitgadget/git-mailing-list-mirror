Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8133C433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 21:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB55B60FC4
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 21:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhKBVtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 17:49:01 -0400
Received: from mout.web.de ([212.227.15.14]:45277 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230382AbhKBVtA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 17:49:00 -0400
X-Greylist: delayed 3934 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Nov 2021 17:48:59 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1635889576;
        bh=plUbFLyv4wMEKfQTcdvpEaYxLAM9tEwphn0B8cgB03c=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=YmEc93Yw1KuuKqanwxQ0+JrRnrx0FWzS3XpWW2/QAsMBExD4OSs8AJr3BGtWc5/W/
         tRmjG2uozk40xOMlU1IAZsd+OjVtvrnIdUUoKaH6AYwg942uy2GYoHyFH/QJy2uvI/
         VIZsxFH0a4hCylRddp20tBeNjGiu44o7y4rAzucg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M8QeQ-1mVI9S0orq-00w0R8; Tue, 02
 Nov 2021 22:46:16 +0100
Date:   Tue, 2 Nov 2021 22:46:15 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 0/8] Allow clean/smudge filters to handle huge files
 in the LLP64 data model
Message-ID: <20211102214615.sflg5xgztdzrb27l@tb-raspi4>
References: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
 <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:HBUImWLVYUKptf2225DNlvKS0GbRwaFYaZKhMdV8R3XMuPkysTp
 HUJvRh2kUXnX31FWpkaNL83V1WO2d3hHhW7QD0lplFzZWc9wJ7j76sxGWevHjnwGWxwmv9o
 K7gMOvdCA8kJaWJh9NVIinjdgXhZ5JW/Wk9zWRPqOSw7ZB6cwBHfMgkRAbuFTiVfqWb8z9c
 eUTKgR/QEdtk1PJsJSAMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/rW9v8Jclzg=:1OMh2wakUBBNGYfYr7SokJ
 05IeH62qbU1HpWUsgX5/6350SqVtVpXoaW2QihDFukdxz5SFku/rjULuwGJ5tKzSvRqmZDcfT
 2KVZJVOdTNRUsKdvvgYhdZQlUM2YPmbT5auV+4rLyGFwWfXG0Toh+xYlZTq3U6JNm5PFOzZfu
 IKnZ0UlzuqGiuWif08hkgGCZZvTYuTS3W4AMahn6/aMQ9XuitVVcyAtMsHalaHnZKeZ+/cTEn
 eKA2LtAvRGp5uSTgUOgHpbGvZheaxCk5nptHEyblzdHua9YcH7xLVO9mLC3dzIFMVfDcJvYiX
 9AjiAN0lEfApGyQqo6l8CEOM2vQ63/gkN9CZWQ3PEvsn0ls37GHza/ELkskD/cTPApgwRtCVX
 cSWLrofNec17eskenOPhrVMt0Chg2FbTPddJG3/XTIPuY4Kn5LSHSI441FrDt82y9MaND0Mqu
 hQ04FdEeYXPmUHZVAry5V7KC5w+4w/460etAET6mxRsYN7eSxw8BSigeA1T3dGJxRWH59riBn
 ZhudSmX5/8whrq5DO23CrjD0qoN572KVdrTV4iQlse5XWjdlnmCDOIQ74so8SWPtpQOOf31a/
 VlAXBQHWBIlbbMfE/BOSUbbZ8Bo1KCmozeLryk9FpX7trvZZ7FWgC1L6xvnlhEYhKhyf4Yj4y
 aycx9ry+wgnTdwr/PWoA5BpPagN+slARv28kPueR/U3UKyAbDZ+oBERSekF9nrs1GHh+QhbwD
 rvVaBUuGVNR/kgdULlE+sBG1xNb5ZSRORP8ggM5OQWlPDyRBkOc5pvIYHYy+SMulXpCLJML4G
 /jKlAaqVJimixQF8H2E5Pa/tU/0Q+QFSfXdbxuodVY0vMKI3CwDJkemCiBvtn+qUculGKOHGs
 3xuRsSO0Trlfmd8iXobdtQYjfJtlImqKb/AmN636uCfEDMoTVRYvq/erGBKRvqfvsGcxk3y4j
 K8exnHfIzP9TO9gxEf5t+e2ZsYumWyQRAjPOltSJx3FRKAqfZug9r2NB63kpefpRD2bGn0ekj
 RDTUFEAXgZ/HVrIJX3swDm6yAB74Ds/OFRmcaUDHsQktO8DqC5L8zaslSILxNY4zeec3LTlaC
 zNmqraoxVPHhjo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 02, 2021 at 03:46:03PM +0000, Johannes Schindelin via GitGitGadget wrote:

I could not convince my raspi to apply patch 7/8:

  git am </tmp/7
  Applying: odb: guard against data loss checking out a huge file
  error: patch failed: object-file.c:1344
  error: object-file.c: patch does not apply
  Patch failed at 0001 odb: guard against data loss checking out a huge file
  hint: Use 'git am --show-current-patch=diff' to see the failed patch
  When you have resolved this problem, run "git am --continue".
  If you prefer to skip this patch, run "git am --skip" instead.
  To restore the original branch and stop patching, run "git am --abort".

I am not sure, what went wrong. I can retry the next days - or is this
branch/series somewhere available ?

But beside this, up to patch 6/8 it compiled without warnings.
And the series looks good so far.
Some minor nits had been found and reported for 2 of the patches/commit messages.

[snip]
