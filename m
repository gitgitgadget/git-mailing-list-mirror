Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BE311F97E
	for <e@80x24.org>; Wed, 14 Nov 2018 05:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeKNP03 (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 10:26:29 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40880 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbeKNP03 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 10:26:29 -0500
Received: by mail-io1-f67.google.com with SMTP id r7-v6so10671900iog.7
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 21:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=mTIhuNOEpHAM/JEPx+RJiOWbzu9NlA84P8j+6Ie409o=;
        b=jqQns+TO1WxXY8YggzVBqFgkNxC8v9hnIOR6t4MGDkHlywjjUnHiuhpwRaSqakcjb8
         HT8CgwQdZ3sYNTp0DfNZT9PrqG+96ibkBrflPg2q35oGZULqd2/bzH85i7lMGu8QcYY1
         7eAH6Kjha4SlvYDAn4+lGqfe7++loczB8dyULXj9JdtwLImtBQL8roEI1ZjmvPHeIhs/
         f843j/cUEUEvbmSy75uW7JeF/A6pkLzRR5PfSJVm58+wPibygUkvGqdK22oshbihUQ3t
         wAA6M54t/BF1k4HhmCqvV73VsISeyPsNPgoruvB3QwT8VMInwLtkqN/fyK8WLrAcYYR9
         bZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mTIhuNOEpHAM/JEPx+RJiOWbzu9NlA84P8j+6Ie409o=;
        b=c/MZRWNLRZYTGawxT7tjPJC2jA+0I9qzSFhF/4Iez6ef6tDWWPlHrlyFVclzJSKP3q
         f9CnxJaLy4BPwUIRUIsoj2aM9gFTWJrVcc+TauUVYn9jGDpAUZWDJwwgua0rPl2RJTXO
         Z5vWgPysYh8gD+ljpN9uHIAig0iJh2/RwpAw6byCocXOgSvTPEK+pxjatNSt6f7bSpgd
         9HDY9spPC4tXHo2f5YiBwKuorJlHYI+GR3xPjaWu/4hXoKD1eN8Gp/V50S8Evt32Gmmb
         2Jd8EUd8Q9oqetvIFkafw63rNtzGUMH1GlIbQU10P8iQ999T/lNikqGs3u9t/Q+1H0Iq
         GQYA==
X-Gm-Message-State: AA+aEWYo2YuNELbAawmeMNpNJ9yZWCJ5Pe6jixlIC/fM6Etan9/qypEo
        Z9Ep6hNQC9nhXyYau2yhdhtd1DlC
X-Google-Smtp-Source: AFSGD/V1VkNDtpve95o6f5qXehspniAnpyXzDpXEJckXh9y9UumEdVeOaAQlv1Cvqr87sDMDgb3CNg==
X-Received: by 2002:a6b:8d8a:: with SMTP id p132mr384728iod.290.1542173088907;
        Tue, 13 Nov 2018 21:24:48 -0800 (PST)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id a17-v6sm6816310ioc.28.2018.11.13.21.24.47
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 21:24:48 -0800 (PST)
Date:   Wed, 14 Nov 2018 00:24:45 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 0/2] Fix scissors bug during merge conflict
Message-ID: <cover.1542172724.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I discovered a bug in Git a while ago where if one is using
commit.cleanup = scissors, if making a commit after a merge conflict,
the scissors line will be placed after the `Conflicts:` section. As a
result, a careless Git user (e.g. me) may accidentally commit the
`Conflicts:` section.

Here is a test case to replicate the behaviour:

	mkdir test
	cd test/
	git init
	git config commit.cleanup scissors
	touch a
	git add a
	git commit -m 'test'
	echo a > a
	git commit -am 'test2'
	git checkout -b new HEAD^
	echo b > a
	git commit -am 'test3'
	git merge master
	echo c > a
	git add a
	git commit # look at the commit message here

And the resulting message that's sent to the text editor:

	Merge branch 'master' into new

	# Conflicts:
	#	a
	# ------------------------ >8 ------------------------
	# Do not modify or remove the line above.
	# Everything below it will be ignored.
	#
	# It looks like you may be committing a merge.
	# If this is not correct, please remove the file
	#	.git/MERGE_HEAD
	# and try again.


	# Please enter the commit message for your changes. Lines starting
	# with '#' will be kept; you may remove them yourself if you want to.
	# An empty message aborts the commit.
	#
	# On branch new
	# All conflicts fixed but you are still merging.
	#
	# Changes to be committed:
	#	modified:   a
	#

With this fix, the message becomes the following:

	Merge branch 'master' into new

	# ------------------------ >8 ------------------------
	# Do not modify or remove the line above.
	# Everything below it will be ignored.
	#
	# Conflicts:
	#	a
	#
	# It looks like you may be committing a merge.
	# If this is not correct, please remove the file
	#	.git/MERGE_HEAD
	# and try again.


	# Please enter the commit message for your changes. Lines starting
	# with '#' will be kept; you may remove them yourself if you want to.
	# An empty message aborts the commit.
	#
	# On branch new
	# All conflicts fixed but you are still merging.
	#
	# Changes to be committed:
	#	modified:   a
	#

Let me know what you think of the change. Of course, documentation and
testing will come after this leaves the RFC phase.

Denton Liu (2):
  commit: don't add scissors line if one exists
  merge: add scissors line on merge conflict

 builtin/commit.c | 11 +++++++++--
 builtin/merge.c  | 16 ++++++++++++++++
 2 files changed, 25 insertions(+), 2 deletions(-)

-- 
2.19.1

