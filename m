Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A0ED1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 09:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfA1JmG (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 04:42:06 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38101 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfA1JmG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 04:42:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so7508409plb.5
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 01:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tJVodi4wuBKE9ISqxzqIAaoKN/YbqMRC85zVrRMzUE0=;
        b=kPdHlX8HDcyQQO4BmFsjRduJIEjGnB3iWgVbiBAXOZxCYpeuYhuyna1VbzQHK8Yow/
         N5TdSEhOAq9g3iV7fFQBY58m+m1dMwBlGFg3UcyVVcRU0tu2cPpB4MrreQNXz3WHjbQL
         bywLcmriCu14rg+UNwsqeZ9Bj6DX7oiwupz0b/r81u+85BOktAJnagh3+ksOS0QfQTmN
         AkvtAtVflzoFd5W+jmPVT6KKfNS3mawN/ME0oZ5Bq84dE1PrBc2LdF0zJMKMgTiMqXdk
         o+KVtbZUMu8TNop+cnQXl7ZMOz7NKu79TWVewaahMhcTXj0+SZUx7Msuv081etngAoCG
         CKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tJVodi4wuBKE9ISqxzqIAaoKN/YbqMRC85zVrRMzUE0=;
        b=e5IISRLG+rVMYRuWePn0TcobX/Q4NmwXxQDbkWW4sChCvc2NT0GF5jTyKvtg+7HnvN
         AJ3i2iF3mQNurLVCI1O1znQPoOG65xkLB9VdPtZVB0Z4C+ntrXgXkLkuG2IPtHCLP7Un
         qfF5SQNiuEc4XoEMdo2RfDhi7XNPlzfmEf1qcyejGVPibv/fk4iAGQe55hR5gHxVS7jI
         3+P9WfEFHIUTqTJyhMgbUvbDl/4nhYFas0i1aTHvt4X8m3N1z89uZ3LWu/aNfYLCCxVK
         4eWnToX+ybhQo+NPOOeFFOEUafIYz1lyDfed4r34kJwLX2aevCHIcF16yL0T0HStINN1
         pc8A==
X-Gm-Message-State: AJcUukcexFSQRpfuKtj4x8jhoPSpM5B5l8tpfEd6htQDVqDt5LC4cJaG
        id72Y8cYvXuLPht3/8DXa48ps+qn
X-Google-Smtp-Source: ALg8bN65iCd6imHSI5Q5Z1VcgQ7plsxUEWr/AdNHrL+LqkusDrKA37YXkbGZvRFghae/MP4jVaU9EQ==
X-Received: by 2002:a17:902:4d46:: with SMTP id o6mr20210927plh.302.1548668525001;
        Mon, 28 Jan 2019 01:42:05 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id m67sm54725957pfb.25.2019.01.28.01.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 01:42:03 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 28 Jan 2019 16:42:00 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH/RFC] completion: complete refs in multiple steps
Date:   Mon, 28 Jan 2019 16:41:55 +0700
Message-Id: <20190128094155.2424-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is in the same spirit of f22f682695 (completion: complete general
config vars in two steps - 2018-05-27). Instead of considering all full
refs as completion candidates, it completes one "path" component at a
time, e.g.

    $ git switch-branch -d j<TAB>
    jch/            junio-gpg-pub

    $ git switch-branch -d jch/<TAB>
    Display all 154 possibilities? (y or n)
    jch/ab/            jch/fc/
    ....

    $ git switch-branch -d jch/nd/<TAB>
    jch/nd/attr-pathspec-fix
    jch/nd/attr-pathspec-in-tree-walk
    ...

For refs organized in multiple levels like this (and I've seen refs in 4
levels), especially when there a lot of refs, incremental completion
this way makes it easier to get to what you want.

The cost of course is more complicated completion and also slower on
systems with slow process creation. So maybe there will be a switch to
turn this on or off?

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 499e56f83d..d74ee79866 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -742,6 +742,17 @@ __git_refs ()
 	esac
 }
 
+__git_collapse_refs ()
+{
+	local regex="$(echo "$1" | sed 's/[^/]\+/[^\/]*/g')"
+	case "$regex" in
+		'') regex='[^\/]*';;
+		*/) regex="${regex}[^/]*";;
+	esac
+	regex="$(echo "$regex" | sed 's/\//\\\//g')"
+	sed -ne "s/\\($regex\\/\\?\\).*/\\1/p"
+}
+
 # Completes refs, short and long, local and remote, symbolic and pseudo.
 #
 # Usage: __git_complete_refs [<option>]...
@@ -769,7 +780,7 @@ __git_complete_refs ()
 		shift
 	done
 
-	__gitcomp_direct "$(__git_refs "$remote" "$track" "$pfx" "$cur_" "$sfx")"
+	__gitcomp_direct "$(__git_refs "$remote" "$track" "$pfx" "$cur_" "$sfx" | __git_collapse_refs "$cur_")"
 }
 
 # __git_refs2 requires 1 argument (to pass to __git_refs)
-- 
2.20.1.560.g70ca8b83ee

