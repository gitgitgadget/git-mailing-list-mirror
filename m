Return-Path: <SRS0=w3fS=3B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24194C33CA2
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 16:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E809C206ED
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 16:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjfN2nmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733100AbgALQMj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jan 2020 11:12:39 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:41678 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733030AbgALQMj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jan 2020 11:12:39 -0500
Received: by mail-wr1-f44.google.com with SMTP id c9so6200110wrw.8
        for <git@vger.kernel.org>; Sun, 12 Jan 2020 08:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=j+FYP6nx/2Uk1agvzZF2kN9ZvtKZ3YK04U9Kl76rMmE=;
        b=NjfN2nmFNBy3AXIbqOcd1wG/VE3xfpgYwdUUjqroLNQynijH8H3F8v0PfpJOhaj8nA
         bffwP1YqWXbP1888xuO4BjsEE0tvrBJjyU4K7Znhu4VKXSBhAF9fEoM7g64Jaq203bck
         HXD71pnOoPWsnaF5HoK6pKod/n+zbsXbU5LBft0oepKRci3HIiMt/p314NjQLlHTvuZM
         OKABP9wZBKj50zxfaM2WfITguwJfgf9z45/w+9zWBBaRrHkWVqRXqKTxQivT0yrutHCL
         ei/V6iczjrZ5UjocRihFFMgEvTBRb2xQLwtIOEzIWZNeTXdFKHZ6ewxZt17XWdGZq7iD
         2TBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:from:subject:to:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=j+FYP6nx/2Uk1agvzZF2kN9ZvtKZ3YK04U9Kl76rMmE=;
        b=nSr0Vibx+TNNGvrYYaykdgtWctdK+sGOf1ze1sLjsC5EHvtwNXWeyAlCIj0A7oFVmk
         TqoL1JDGIhqTrv4dSURofLlDhK2OuJViKAserq1fqNDGKEGIFP5gzTELUrpeEeqPGgST
         MH4W5/gfqSoSFqu+spQVX4mWIAmYS9iaR2JRx5f/IdjE1DvexJPRxlPyirXVzM8kH3Bu
         ry3SgZMNxyQNTnt2hk9NLvig2yPi87sPgiR5JDpdn6ZkBJyKM5QOnF3moxNN6z83PTfh
         vEU7MCA5oUP7ipmIAp4y43syu7CtbkLYiikkfC7bXeN+gMztdNKG6QVl+aa8MbFHkW51
         eQKg==
X-Gm-Message-State: APjAAAWny8WfK38Ssa4cvotHf8QgzZWtVf/P34lA+DmK+pPezkhKzJuH
        JPz4QXyk/8ny16gQwya8fDA=
X-Google-Smtp-Source: APXvYqw6cmfmo9AXeaA/6PNPYna5Sy45xMeJsdrUgB9nQ2v9qSpqAVADlK2OSgsjVLgaV9TKQhd3TA==
X-Received: by 2002:a5d:6211:: with SMTP id y17mr14064070wru.344.1578845557744;
        Sun, 12 Jan 2020 08:12:37 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-19-5.as13285.net. [92.22.19.5])
        by smtp.gmail.com with ESMTPSA id u16sm10939610wmj.41.2020.01.12.08.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2020 08:12:37 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Problems with ra/rebase-i-more-options - should we revert it?
To:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Message-ID: <f2fe7437-8a48-3315-4d3f-8d51fe4bb8f1@gmail.com>
Date:   Sun, 12 Jan 2020 16:12:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm concerned that there are some bugs in this series and think
it may be best to revert it before releasing 2.25.0. Jonathan
Nieder posted a bug report on Friday [1] which I think is caused
by this series. While trying to reproduce Jonathan's bug I came
up with the test below which fails, but not in the same way. The
test coverage of this series has always been pretty poor and I
think it needs improving for us to have confidence in it. I'm
also concerned that at least one of the
tests ('--committer-date-is-author-date works with rebase -r')
does not detect failures properly in the code below

	while read HASH
	do
		git show $HASH --pretty="format:%ai" >authortime
		git show $HASH --pretty="format:%ci" >committertime
		test_cmp authortime committertime
	done <rev_list


Best Wishes

Phillip

[1] https://lore.kernel.org/git/20200110231436.GA24315@google.com/

--- >8 ---
diff --git a/t/t3433-rebase-options-compatibility.sh b/t/t3433-rebase-options-compatibility.sh
index 5166f158dd..c81e1d7167 100755
--- a/t/t3433-rebase-options-compatibility.sh
+++ b/t/t3433-rebase-options-compatibility.sh
@@ -6,6 +6,7 @@
 test_description='tests to ensure compatibility between am and interactive backends'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
 
 GIT_AUTHOR_DATE="1999-04-02T08:03:20+05:30"
 export GIT_AUTHOR_DATE
@@ -99,6 +100,22 @@ test_expect_success '--committer-date-is-author-date works with rebase -r' '
        done <rev_list
 '
 
+test_expect_success '--committer-date-is-author-date works when committing conflict resolution' '
+       git checkout commit2 &&
+       (
+               set_fake_editor &&
+               FAKE_LINES=2 &&
+               export FAKE_LINES &&
+               test_must_fail git rebase -i HEAD^^
+       ) &&
+       echo resolved > foo &&
+       git add foo &&
+       git rebase --continue &&
+       git log -1 --format=%at commit2 >expect &&
+       git log -1 --format=%ct HEAD >actual &&
+       test_cmp expect actual
+'
+
 # Checking for +0000 in author time is enough since default
 # timezone is UTC, but the timezone used while committing
 # sets to +0530.
