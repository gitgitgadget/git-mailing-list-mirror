Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF30B1F404
	for <e@80x24.org>; Tue, 20 Feb 2018 22:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbeBTWMy (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 17:12:54 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34224 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbeBTWMx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 17:12:53 -0500
Received: by mail-qt0-f193.google.com with SMTP id d14so18458924qtg.1
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 14:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=9FVg/T075k5zGx5WsRO9Y8128HbLWEgQrIn2pPDdpYI=;
        b=Of+39FrMJyaAzE81GT1L0MdmJEujFYuJEd4YnR0jwFFrkg9ZxbtLhYqYrdC4AzNoDS
         Ts4s8DF4qYNLUJmB3iU3AbN416GUbMvp+vVHVDkjxOB1vCYkuy9F505wj37SuDbFUwa+
         TwFIylYeAWVBAtPU8N8UUl9+3PCgPm0IAAaaPAcJAi5Uiw3KGs9PEHX3U//M4mrAzboz
         ahFRbQkQ0BEuB44+S7P2hHXAoTUuLuq1d5GJI8tV7KIRNK2eLiT++aFhpsYB0CKdjl4h
         RN52FlT0H3SXe+9Fhyct9M1Ope08KV0b2fZF9IK/0pyikjbjJ009gEoq7w7C9MCLBSdl
         I0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=9FVg/T075k5zGx5WsRO9Y8128HbLWEgQrIn2pPDdpYI=;
        b=nPwNG/qRfkIo7DhrOgizwTfUNPyyR7xkYcRNzT393YTaoeQHLJTnPSpmFnJ/q9efg5
         grPXIgLKR/FnDVHUi6rkeHdsH/6qXe5mGMIDNUawb6e2/JF+RUEAwRr2WkDBvnW0DzjQ
         /OgwRzyJ864Vs8dBd2j0CD06XZGFkBg5n5jJUSTsOgDPaQdf6H5YFOeCqBZ1eH9ec4ZP
         6Qz4iyac/+HHZaDX/pHrpyG2y8LT0aWNIDwTdJQAyCgFV0DElklVNvZtoPIQJWwdx+nE
         uKXjWu8hQcL4Y8gVJzlv2EkDEZ8EbLuMCZ4wLKylodfomJActy1yg1p5b9g3ILv8ldJl
         aQTA==
X-Gm-Message-State: APf1xPAaK2LibNx5cbaZb/NbIBShm8hKEQRpq+dTY+Cj5k55SsjoEEkJ
        ygKqVKbwNaafrLSzBA2i/tM7Z8SS
X-Google-Smtp-Source: AH8x225KpD/vizh1l6QAkj/nYxwpft8k53WE/5Xv96Av4qTMrATPF8emx/EuDtCHJu6PR4+iRbld5A==
X-Received: by 10.200.58.161 with SMTP id x30mr1987027qte.62.1519164773043;
        Tue, 20 Feb 2018 14:12:53 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id u17sm7155664qka.46.2018.02.20.14.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Feb 2018 14:12:52 -0800 (PST)
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
From:   Derrick Stolee <stolee@gmail.com>
Subject: Question about get_cached_commit_buffer()
Message-ID: <ecbbe515-b7a8-3dc8-7d14-32412e7b12c3@gmail.com>
Date:   Tue, 20 Feb 2018 17:12:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While working on my commit-graph patch [1] and using a local build in my 
usual workflows, I found a bug in my branch.

Essentially, when calling `git rev-list --header`, the header 
information is actually missing for many commits except the first. This 
was not caught in my testing since t6000-rev-list-misc.sh creates a test 
repo with only one commit.

The root cause is that the serialized commit graph gets its speedup by 
not loading buffers for every commit. For many use-cases (merge bases, 
--topo-order, etc.) we do not need the buffer for most of the commits. 
In the rev-list example, the buffer is loaded due to a side-effect of 
being referenced by HEAD or a branch. A similar effect happened in `git 
log`, hence the following change in my patch:

diff --git a/log-tree.c b/log-tree.c
index 580b3a9..14735d4 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -647,8 +647,7 @@ void show_log(struct rev_info *opt)
  		show_mergetag(opt, commit);
  	}
  
-	if (!get_cached_commit_buffer(commit, NULL))
-		return;
+	get_commit_buffer(commit, NULL);
  
  	if (opt->show_notes) {
  		int raw;


In rev-list, the "--header" option outputs a value and expects the 
buffer to be cached. It outputs the header info only if 
get_cached_commit_buffer() returns a non-null buffer, giving incorrect 
output. If it called get_commit_buffer() instead, it would immediately 
call get_cached_commit_buffer() and on failure actually load the buffer.

This has not been a problem before, since the buffer was always loaded 
at some point for each commit (and saved because of the 
save_commit_buffer global).

I propose to make get_cached_commit_buffer() static to commit.c and 
convert all callers to get_commit_buffer(). Is there any reason to _not_ 
do this? It seems that there is no functional or performance change.

After the serialized commit graph exists and is used, the only change is 
that we delay loading the buffer until we need to read the commit 
metadata that is not stored in the graph (message, author/committer).

Thanks,
-Stolee

[1] 
https://public-inbox.org/git/4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com/T/#m381bfd3f2eafbd254e35a5147cd198bc35055e92
     [Patch v4 00/14] Serialized Git Commit Graph

[2] 
https://public-inbox.org/git/20140610214039.GJ19147@sigill.intra.peff.net/
     [Patch 10/17] provide helpers to access the commit buffer
