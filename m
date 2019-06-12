Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D879F1F462
	for <e@80x24.org>; Wed, 12 Jun 2019 02:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406508AbfFLCEr (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 22:04:47 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:46906 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404880AbfFLCEq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jun 2019 22:04:46 -0400
Received: by mail-pf1-f173.google.com with SMTP id 81so8603728pfy.13
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 19:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arilinc-com.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=SJXoYETu+yv74Kp43YcAfBNMYY7k7ylcCvFXhq8JtW4=;
        b=QCva9gxxhTZo1TlybVEgf47uoIaX58mPMJm7aFK7PHB5p93TMpoUCRi4uyguRgGlsh
         sVSSpUYRNYZH7jijLJXy29AgBrUnS/Seat9Jf2Un1CpNYsum5SicbJ2jwMOlAFTcb5F4
         MteoPH/nhlIcYIk739pABeuxaQ2PzmFGWVww2s0w8+HsmGPdg9KvNKrApPAyMVXQMysB
         zojfL9CpD/Zv0R6BIrcx0AYtuM6bCODMLT1Zr87H02ZbfQW2wyfj1vfjc1q9YcwNVvc+
         PzmajmVF4kYWCRGY1zD8OEucJm5ATEnO4IXVaveMmLT1TboUSBy/t/YpgncxXJzlYkSv
         t2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=SJXoYETu+yv74Kp43YcAfBNMYY7k7ylcCvFXhq8JtW4=;
        b=cnFg0OYBAk2jY5fm9SR/mTigSUlFA/PYnnz6I3FbtWnYqHFls9D9nOBTwwm1b9DGKR
         F/LfVwelq+QizGZm2dPQ7WJwpB5M/zWzozTkdDXxjGVZSPREDvnCiZbV5V+j1UDl5KSY
         VuDEw++2ZT0An7zSMIn5T4+N8DWH0Iy4SQsmq2dNvyISafL3LUYGdvpyFlAxTwJIuc7R
         7nfFFVjvt+EKxBLadJsegJgjFfRh6jduVidGB5MAfMsec9h9vDn7cC/z1Q41QHP2QX3S
         9fDb90tzTnOFR4FdiLraHqkqArUGHaE4Ir6OrpJjX0TVT77IUixb/iWkoqvifbwUDfjY
         fK/A==
X-Gm-Message-State: APjAAAUsutmvrHjPg4cLDjZa/RtkkmnexIRxXyiV0tc1SK5lb5xvUXcc
        Uc57Zg6thwy1y20AJiV82XGpkL6k2UtQNw==
X-Google-Smtp-Source: APXvYqzkisEa9XYvqlq2pXe72kAs4fD8WXd6+v3d0+MGlu0HzdmC/zOH/PA2c7vSxn1Sd1wLK2VW+g==
X-Received: by 2002:aa7:8394:: with SMTP id u20mr72036437pfm.252.1560305085610;
        Tue, 11 Jun 2019 19:04:45 -0700 (PDT)
Received: from ?IPv6:2603:3024:15db:8800:5003:4c35:a582:148a? ([2603:3024:15db:8800:5003:4c35:a582:148a])
        by smtp.gmail.com with ESMTPSA id r9sm13561928pgv.24.2019.06.11.19.04.43
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 19:04:44 -0700 (PDT)
From:   Scott Johnson <scott.johnson@arilinc.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: push.recurseSubmodules=check doesn't consider tags
Message-Id: <62F6F2E3-FAED-4EE9-BDB8-D484252A845F@arilinc.com>
Date:   Tue, 11 Jun 2019 19:04:40 -0700
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I occasionally rebase my submodules. I realize the danger (historical =
submodule pointers could point to commits that get garbage-collected =
away) so I always create and push a tag before the rebase, to make sure =
the old commits will never get purged. I believe this is safe, based on =
some experiments I=E2=80=99ve run.

The issue: I set the config var push.recurseSubmodules=3Dcheck, and it =
seems to insist on having a branch and not merely a tag. When I push the =
parent repo=E2=80=99s commits, I get failures: "The following submodule =
paths contain changes that can not be found on any remote=E2=80=9D. This =
is overly pessimistic: the commits are there on the remote, and the tag =
demonstrates that.

Expected behavior: when the submodule remote has a branch or a tag with =
the submodule pointer as ancestor, the push.recurseSubmodules=3Dcheck =
should succeed.

Actual behavior: the push.recurseSubmodules=3Dcheck fails when only a =
tag, and not any branch, contains the specific commit hash.

I=E2=80=99m using Git 2.18.0, but I=E2=80=99ve checked newer Release =
Notes and didn=E2=80=99t see anything.

Below is a Makefile that demonstrates the unexpected failure. The =
=E2=80=9Cpre-rebase=E2=80=9D tag should be sufficient to allow the check =
to succeed. Run this in an empty directory.
----
.PHONY: all clean

# Make sure no config settings, either /etc/gitconfig or ~/.gitconfig,
# affect this experiment. We will create our own ./.gitconfig.
GIT :=3D GIT_CONFIG_NOSYSTEM=3D1 HOME=3D$(PWD) XDG_CONFIG_HOME=3D git

all:
        # Configure globally (into ./.gitconfig)
        $(GIT) config --global user.email "you@example.com"
        $(GIT) config --global user.name "Your Name"
        $(GIT) config --global push.recurseSubmodules check
        # Create upstream repos
        mkdir sub.git && cd sub.git && $(GIT) init --bare
        mkdir repo.git && cd repo.git && $(GIT) init --bare
        # Create local repos
        $(GIT) clone repo.git repo
        $(GIT) clone sub.git sub
        # Populate submodule
        cd sub && echo "foo" > foo && $(GIT) add foo && $(GIT) commit -m =
'rev 1 of foo' && $(GIT) push
        # Add submodule to parent repo
        cd repo && $(GIT) submodule add ../sub.git && $(GIT) commit -m =
'Add submodule' && $(GIT) push
        # Track a new branch in the submodule
        cd repo/sub && $(GIT) checkout -b aril && $(GIT) push -u origin =
aril
        # Add commits to sub repo
        cd repo/sub && echo "bar" > bar && $(GIT) add bar && $(GIT) =
commit -m 'Add bar' && $(GIT) push
        cd repo/sub && echo "foo2" >> foo && $(GIT) commit -am 'Add more =
to foo' && $(GIT) push
        # Update parent with new submodule commits. Note: no push
        cd repo && $(GIT) add sub && $(GIT) commit -m 'Update sub'
        # Sub's master branch diverges
        cd sub && echo "three" > three && $(GIT) add three && $(GIT) =
commit -m 'Add three' && $(GIT) push
        # Rebase submodule: this tag is enough to keep the old commits =
from being garbage collected
        cd repo/sub && $(GIT) tag pre-rebase && $(GIT) push --tags =
origin
        cd repo/sub && $(GIT) checkout master && $(GIT) pull --ff-only
        cd repo/sub && $(GIT) checkout aril
        cd repo/sub && $(GIT) rebase master && $(GIT) push =
--force-with-lease
        # Update parent repo with newly rebased sub: this will FAIL due =
to push.recurseSubmodules=3Dcheck unable to find HEAD^'s submodule =
pointer in any pushed branch in repo/sub
        cd repo && $(GIT) add sub && $(GIT) commit -m 'Add rebased =
submodule' && $(GIT) push

clean:
        rm -rf repo repo2 repo.git sub sub.git .gitconfig

