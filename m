Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD30B1FAF4
	for <e@80x24.org>; Fri, 10 Feb 2017 06:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751580AbdBJGaO (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 01:30:14 -0500
Received: from mail-io0-f171.google.com ([209.85.223.171]:33722 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751542AbdBJGaN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 01:30:13 -0500
Received: by mail-io0-f171.google.com with SMTP id v96so43662612ioi.0
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 22:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daurnimator.com; s=daurnimator;
        h=mime-version:from:date:message-id:subject:to;
        bh=pZKrPdu8veM7RumRfpasnHomYsxg7Vzgvbrn9fp5fgY=;
        b=UNAWbdqba/Hk1eKVc09/u61gnkEyHO11XsA+tXd45B/sHuLJcVuBLUI5bja7nG5UA4
         4g/+srJJVFgE7r/UjN+cN7HOWwp+Firtt3d92lDFIE42BsqJGoLAYseQL48FAPMualy9
         AhfmBBerggSvXs/fz2mcLQUe4DmQDZ5H/kDS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pZKrPdu8veM7RumRfpasnHomYsxg7Vzgvbrn9fp5fgY=;
        b=UDIw4YKNGCUCeYXFF7RtR7BIfI+/E8EElX3PPZWmv8uyXQ9xCyrSA1FJR0DRmrYUHe
         djOeSCIlIKP0+7acQPSyrkPYp/XS3zrC0nuhN+oG2zaXWoe8pEHqJuIGNgs44W98X+xv
         pOYnuauoGk5TbPdSwJDmPAxYm5y4jJLALkXrc8PN1BPo3oMBe7W03Vc9eBMJRwfpBXJ6
         dF6vlq+J1OFPG21RmFFU+22o6OrbHXSfRWopfkXHCPOHZsr3xSzjnBdyWtBNcarnCxiz
         rw65vNLFi6lFKmaft+eYjRfmzKsbLcxos+7yCkjbMzBTRqpkae9EyAD/2iTzcpc1jRYN
         9kYQ==
X-Gm-Message-State: AMke39mbM5RYrsKZPgw7yczrbHY0ONNGCzFsnCbgu7wxBzLA89vTrdolJgfgqEfy4M//Rw==
X-Received: by 10.107.46.165 with SMTP id u37mr7369392iou.126.1486706626531;
        Thu, 09 Feb 2017 22:03:46 -0800 (PST)
Received: from mail-io0-f174.google.com (mail-io0-f174.google.com. [209.85.223.174])
        by smtp.gmail.com with ESMTPSA id v85sm607024iov.34.2017.02.09.22.03.46
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Feb 2017 22:03:46 -0800 (PST)
Received: by mail-io0-f174.google.com with SMTP id j13so43222969iod.3
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 22:03:46 -0800 (PST)
X-Received: by 10.107.16.156 with SMTP id 28mr6970729ioq.228.1486706625820;
 Thu, 09 Feb 2017 22:03:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.185.85 with HTTP; Thu, 9 Feb 2017 22:03:45 -0800 (PST)
From:   Daurnimator <quae@daurnimator.com>
Date:   Fri, 10 Feb 2017 17:03:45 +1100
X-Gmail-Original-Message-ID: <CAEnbY+fcGjaTCC5ZMUzgvz-44ii1A2a7JXJJTAib255fsNWpWA@mail.gmail.com>
Message-ID: <CAEnbY+fcGjaTCC5ZMUzgvz-44ii1A2a7JXJJTAib255fsNWpWA@mail.gmail.com>
Subject: git subtree add fails in new repository
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm trying to make a series of repository that only contain subtrees
for various other projects.
However git subtree does not like being on a newly created branch:

$ git init
$ git subtree add --prefix=git https://github.com/git/git.git master
fatal: ambiguous argument 'HEAD': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
Working tree has modifications.  Cannot add.
