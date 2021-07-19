Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7C6C07E9B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E556B61164
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 17:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350460AbhGSRI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 13:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376938AbhGSRGV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 13:06:21 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25809C08EC8A
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 10:27:55 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id dp20so28165269ejc.7
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 10:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=sfA9qZvhLNQrxyT+rvafGiYsoZ2t+JeJRAenggMeUlQ=;
        b=XJ0+FDLlRrrNIyV1xQhkdVN02NboEUtq/XnkCzVbspUs/grqwNx1p/1H6FimXPT+jX
         kGgSemlIzlFIcyeYgVCYsH+TkWWmRkMIQKivfcpwb6UYp6QUa5eiGoli17MYrZl94VSd
         Za9QujXvL/UKBhIC84Ig4yFy6a6b0uJpoUsxvvFojmtlHTUG/+Tei9cqgL4m+6+lvBLP
         OmvIP02l6XdZYkI1hG3tDqwmOTtVBha6r97l0zvGH4Wo5GDCSSTwUa9dCrSBVCcUYHA1
         yqZ7F3fug3DJCPevCP5tBhoz6YhYQpS8jtY3ZMrbk7VCVcPj3/Bks3e4R9CxGbOBj3Sb
         06NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=sfA9qZvhLNQrxyT+rvafGiYsoZ2t+JeJRAenggMeUlQ=;
        b=QYkk1SwPa5IXPK6a9XYeV6PjHEHE2pwBHts9qC+y2Rz3cIDJPxn2CrB7UIY0riqMgd
         SGHZLrJjapkMz8Eb8IpsODwsQrHvytSRVrx2FkC9TxWQvlyWZUOkBjPaNzXQgD3dyDpK
         tHzL3h2sp0a9Uq/k3XVYqKjVrr8Vih/YvpxsB4u14xhUvKx4w0T0ThxV7IuGHBJXfjBI
         O3mNm57t5BNu0m8NfsoeJOcxfeeuaFlR/IahTcbsKmm72ldrb21xiguyFdsgAzLNgqkn
         ulq8sJmAfu9zF1fwnwXNs2eb4Iv3VY03nmI1RF+qCIXldkTZj7mLfhvN0TbimsyxjvE9
         NINA==
X-Gm-Message-State: AOAM532RiikTUMaoG/yNRIsUyxvIPadICE05SM/OlBieMz2VHqWJuV8O
        3fNww4I5ZmdFxk5zjk/tAXTOQHWHu3r2CiapRSEbgnSQ
X-Google-Smtp-Source: ABdhPJwfVqYNvBJymFIRSzPZkhKMKMAh1mnuKaAXhQtAAmaNHbXe2UVjnhWDmaSshecfBM+QdcYUMQQw6Ysh2Qyr+yo=
X-Received: by 2002:a17:906:6047:: with SMTP id p7mr27904762ejj.206.1626716711832;
 Mon, 19 Jul 2021 10:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAJcwCMPU9EhRkqeei_LnYyTJRZUQgHCvomrBbW0Qn+Jp1yhQfQ@mail.gmail.com>
In-Reply-To: <CAJcwCMPU9EhRkqeei_LnYyTJRZUQgHCvomrBbW0Qn+Jp1yhQfQ@mail.gmail.com>
From:   Andy Zhang <zhgdrx@gmail.com>
Date:   Tue, 20 Jul 2021 01:45:01 +0800
Message-ID: <CAJcwCMPHFNHi5i=xRg=GAJL5HiUfKu_KUPwYwELofLLtOAK1bg@mail.gmail.com>
Subject: why "git rebase" searching the duplicate patches in <upstream branch>
 rather than in <new base branch>?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

why "git rebase" searching the duplicate patches in <upstream branch>
rather than in <new base branch>?

hi, all:

 I am reading the help of "git rebase", it says:
    "If the upstream branch already contains a change you have made
(e.g., because you mailed a patch which was applied upstream), then
that commit will be skipped. "

 But, because we are applying commits to <new base branch> rather than
to <upstream branch>, I really don't understand why we are searching
the duplicate patches in <upstream branch> rather than in <new base
branch>?

 In the following example, the git command is as:
   git rebase --onto master next topic

 I think it should be reasonable to search the duplicate patches in
<new base branch>(i.e, master) instead of <next branch>.

 If possible, an improvement may be an option for enabling searching
in <new base branch> as well?

  Thank you in advance for any enlightenment you can provide!


Jintao Zhu

//----
example:

Old tree is:

o---o---o---o---o  master
    \
     o---o---o---o---o  next
                      \
                       o---o---o  topic


We want our tree to look like this:
o---o---o---o---o  master
   |            \
   |             o'--o'--o'  topic
    \
     o---o---o---o---o  next

We can get this using the following command:

  git rebase --onto master next topic

//----
