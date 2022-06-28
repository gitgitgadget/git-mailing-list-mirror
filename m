Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B245C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 13:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345656AbiF1N6Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 09:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347178AbiF1N5z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 09:57:55 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7427735260
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 06:57:53 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id v6so9637657qkh.2
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 06:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=N7GzA/48+q8APUXPG5Jo9feXKVxki8QO8+Xti1vPLok=;
        b=NpzTXcEJJpnE83ghQaZr8bkIDfM1s3QxVfyDtDDgUych59d486K3AiD4dlwEGTbqXV
         VqujKCN5iw1g9tHU7Dyx0dCE+yg9OTVTzAeNpCnhy9Zz9cjA+7lqz/SSa6B6XVCdBWoS
         O6dNqCc7iK2JfTWCaTE1fDdVoZr8IyMqVWQ2PEAgPgOnJAPR+TW2fsXCHss+QX2jI7VB
         k802xPONjLQcgb6Om+rNcig5J92Q2UOz/6xqs7MSryDvavgRJjU27YRnNSvRGSZbtvkO
         uWWmKGKnEXgPIS8URY3E2+kqM+7b0RfR0TWkkew5aPqkc5dZBgKMd1MGoOes5TT+fHKi
         FNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=N7GzA/48+q8APUXPG5Jo9feXKVxki8QO8+Xti1vPLok=;
        b=FbcGPO/pr3yC5YXPxb6aOkGp+Xp6MqVprDVgTfSsZH0k+v+vav3CJ26AU+JwT6s8/0
         ptO6MYWq6ZuiIDbNn/8qbWE03Djnm5deo1c/wtYRa1bhQOaOuJIk198W4icYJNsxr9SF
         h7FvkkHWJsTtqs/dmYI3nSvJdTPREH8Jq4LQQ+AxohVhxwkwfkie/bVCI0L2QZqHB259
         1vScckio8RXO5036r1hsvHHwBFEu8nN1Q1jvOFUwAMoV8/827rwoeAOD8velZNWhM3pD
         4glnxfSL5aqlx15boH8Y/LYDc2Ksw17Hg50fEyhASLeinfBwKUwu+xJdaxmOTq/rOuqi
         Wd1w==
X-Gm-Message-State: AJIora9K1EcnLSb8acEtire3s8SgsfxItCAAUaUZ0TrjtutOs5ehzL0o
        /ZUtcieaPTqmEauwr5olePm5op6XJAB1Ig==
X-Google-Smtp-Source: AGRyM1uXkma4bWLunBDf9Brc7XhxfdB7uMewjXwh1/fH4Z1lfM+uBEoy8Bj4X9ghq4lNnXLDDQcjvQ==
X-Received: by 2002:a05:620a:288c:b0:6a7:9d8c:a8a1 with SMTP id j12-20020a05620a288c00b006a79d8ca8a1mr11590754qkp.199.1656424672625;
        Tue, 28 Jun 2022 06:57:52 -0700 (PDT)
Received: from smtpclient.apple ([2601:89:c600:f150:945:395e:48be:27e7])
        by smtp.gmail.com with ESMTPSA id he18-20020a05622a601200b00317c38c8606sm3579809qtb.20.2022.06.28.06.57.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2022 06:57:52 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: Oddities in gitignore matching
From:   John Thorvald Wodder II <jwodder@gmail.com>
In-Reply-To: <0871A57F-4AF4-4F45-AC56-10C1817761BB@gmail.com>
Date:   Tue, 28 Jun 2022 09:57:51 -0400
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <288621B7-8418-471B-8C64-3F8AE5AA4DC2@gmail.com>
References: <DC3C4CED-3781-4380-95E6-97F5CBE1B13C@gmail.com>
 <72a1a225-5d84-56c3-2652-ec7c17c18cbd@gmail.com>
 <0871A57F-4AF4-4F45-AC56-10C1817761BB@gmail.com>
To:     John Thorvald Wodder II <jwodder@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022 Jun 28, at 09:48, John Thorvald Wodder II <jwodder@gmail.com> =
wrote:
> Through further experimentation, I've discovered a fourth oddity with =
gitignore: If "foo//" (with two or more trailing slashes) is added to =
.gitignore and `mkdir -p foo/bar` is run, then `git status =
--ignored=3Dmatching --porcelain` won't show "foo/" or "foo/bar/" at =
all, which is something I'd previously only encountered for completely =
empty top-level directories.  This holds true no matter how deep or wide =
you make the directory tree at "foo/", as long as it's all-directories; =
once a file gets added somewhere under "foo/", the "git status" command =
shows "foo/" as ignored.

Correction: When a file is added under "foo/", then "git status" shows =
it as *untracked*, not ignored.  I also see now that a pure-directory =
tree being absent from "git status" happens even without a .gitignore, =
so presumably this is intended behavior.  It's just a little odd that, =
if "foo/" is an empty top-level directory, it only shows up in "git =
status --ignored=3Dmatching" if it's ignored.

-- John Wodder=
