Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 996C820A29
	for <e@80x24.org>; Tue, 19 Sep 2017 08:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbdISIlh (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 04:41:37 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:50678 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbdISIlg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 04:41:36 -0400
Received: by mail-io0-f181.google.com with SMTP id w94so8249385ioi.7
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 01:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zdNr+81zDv7BuvDMK0rGkms+TN6dsv+W+OZh6gSuXzs=;
        b=WVL5qGsNIEZjlNfc31D0hFGZFzEBCkn6E3ZfT5epX4j9g9KOzsUPyLJ2iYAjm5AZ7I
         /5LGtis5MiT7xT8RExdH78dRyB1fkUaWWfVntdsVR9QEJRU9NoqfAzqoxLoni3jknT7d
         Kj0Bpz/dl4A8S+Ed/L/qtuVbavZBOY7Anc5QS2MEnfZQUCtMA875/vFn3/l1DQ+hs6Zv
         LQn4tYyw/G6TDj7WIBjSWhE3hxbzab4L1eSTM9rSjtzl8n/MVX8cvTM2DSGqKIEmiuXZ
         YGbXlPkLezgS8wZR8ulgooHmtHzrGeDOeqJC2BF3zToosLWDtNmWET+dPz9bSj3/oxET
         w0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zdNr+81zDv7BuvDMK0rGkms+TN6dsv+W+OZh6gSuXzs=;
        b=ZIDCeUiKPYJ5LkbqzRpfls4UKBSLAdL28QFpi5JpyLceziMiVpMzDOE8UvBTIyE8qg
         GGMimoSMJCDkolxePzAzBFLbcl0uKN/gKuWHULWMQZWXLNWcxn4kHBQA4F3pxuT+VE4P
         1kanLR2xS1f+U+LjLGMPygVrqlqM5SXrmyHck/7F1G51ekx6lGKKkE6ILy5+1JipBHgC
         Fwx0Z8908WXTo5T9lJv4ttX3UbBN7lKslaCxDjarnzfGiOSOPB0f/NwNURx5POnyDM5b
         JR1SDGFBQNZmbNXJP4z+1u3qERsCMDhExrZMbAFmt5w6F+gQX/y5/A4UnJJxsSxSflgj
         p7Hg==
X-Gm-Message-State: AHPjjUho9cTRzQickQrpHWIT4jU44thGUwL7z1/KttL+ZH9ocVeY9hlJ
        MuLfJqGutSQ0c3Rls2wR45E=
X-Google-Smtp-Source: AOwi7QCUXhHAAIWUyeGMizimIknhd2YGCzMMPT4dzkL1VrtGx8Zro2RZtjcelNeKBBtC2TEi7Cj9hQ==
X-Received: by 10.107.192.132 with SMTP id q126mr764943iof.181.1505810495492;
        Tue, 19 Sep 2017 01:41:35 -0700 (PDT)
Received: from [10.4.2.238] ([14.102.72.146])
        by smtp.gmail.com with ESMTPSA id 78sm704448itz.12.2017.09.19.01.41.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Sep 2017 01:41:34 -0700 (PDT)
Subject: [RFC SAMPLE] builtin/branch: give more useful error messages when
 renaming
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
References: <xmqqd18pcysa.fsf@gitster.mtv.corp.google.com>
 <20170919071525.9404-1-kaarticsivaraam91196@gmail.com>
 <20170919071525.9404-6-kaarticsivaraam91196@gmail.com>
Message-ID: <da5038e1-4d45-881b-3791-746987112aa7@gmail.com>
Date:   Tue, 19 Sep 2017 14:11:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170919071525.9404-6-kaarticsivaraam91196@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The patch series results in a change in output as specified below. Only 
few cases
have been shown here to keep it short. The output for other cases are 
similar.

$ git branch
* master
   foo
   bar

Before patch,

$ # Trying to rename non-existent branch
$ git branch -m hypothet no_such_branch
error: refname refs/heads/hypothet not found
fatal: Branch rename failed


$ # Trying to rename non-existent branch into existing one
$ git branch -m hypothet master
error: refname refs/heads/hypothet not found
fatal: Branch rename failed


$ # Trying to force update current branch
$ git branch -M foo master
fatal: Cannot force update the current branch.

$ # Trying to force rename an in-existent branch with an invalid name
$ git branch -M hypothet ?123
fatal: '?123' is not a valid branch name.


After patch,

$ # Trying to rename non-existent branch
$ git branch -m hypothet no_such_branch
fatal: branch 'hypothet' doesn't exist

$ # Trying to rename non-existent branch into existing one
$ git branch -m hypothet master
fatal: branch 'hypothet' doesn't exist, and branch 'master' already exists


$ # Trying to force update current branch
$ git branch -M foo master
fatal: cannot force update the current branch

$ # Trying to force rename an in-existent branch with an invalid name
$ git branch -M hypothet ?123
fatal: branch 'hypothet' doesn't exist, and branch name '?123' is invalid

