Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 822D91F453
	for <e@80x24.org>; Mon, 21 Jan 2019 07:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfAUHUO (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 02:20:14 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:46909 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727228AbfAUHUO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 02:20:14 -0500
Received: by mail-lj1-f175.google.com with SMTP id v15-v6so16541503ljh.13
        for <git@vger.kernel.org>; Sun, 20 Jan 2019 23:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GUbZU1WAw80nBDrbs/q5S3HwX8AR4jmTjosX2/3Y3FU=;
        b=vP5FBzVsVCYd/dw4jPT0PyIz6Jea3XpJyBtUnGrLmXF+cJCm/RDW0UFeS4c7PdoL+b
         Z30Wivg2jyaZre64dFrIVsz3K1FTX5uvIYVGh0HMXFCYIWBbKB6Yi1e6GctNV6IHB+A0
         EvmMbEx2myYADsErfzWH9fKLIu/9d+/N45h1beNee8BvtT1d/pQyQ8hQddWOaJ+wu1L9
         W9Nlls3DNgSsMsw6wIWQSoWMNU6Y7UxFf5xYj0c+5fGDSB1YjDO+kmoD1QAKJ2t/+OTm
         5ow52UPfQTW1vDg17NW61Zk9Whsk8XiBaSA4xwGTRojV62oXZ1v70lGYH2fN2sVY7wDN
         993g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GUbZU1WAw80nBDrbs/q5S3HwX8AR4jmTjosX2/3Y3FU=;
        b=lQBvi0JoVLQArnYODBnGas9IjaYqRWBQ5J4lyfTA3NQptJ1PqN6XxwGEkyN+R5Wggl
         2KLdVVgAUpChz9jibYmnE1YD6qXvOU/oixuGlKqiSRkbm1Kq2qUdNQTfLpTvu0PmXjNo
         uv/RknRoD4MnIUopOg+9s1U1eEeD/g3Vm57Bix7v0btGNtaqaNQs+a8WzRLJowcs4gjG
         dWjdGO0JQhUF0GyYDxl0ZPIkxlnE/kGL7ULZ9cb5XCUmk86xoMybdccrbopGZQSooNr0
         5Qn2bkwDCt6QmBG/ZmfHE1R1gcGYwdePfZcaEMvk5nQ7kd+PGXqBLq1IHMaY6h0gsCbi
         kRxg==
X-Gm-Message-State: AJcUukefE1OKKrbAMXkehzdPliSGWNLaqyQUey8+p1d0zIUVfWYoNpye
        Y1EYU4rskSJ7gO0ac9Ee+swB4ERvnAW/8ffpRtFRQf6q
X-Google-Smtp-Source: ALg8bN4A2BOEFaOUYhVO4LtnoJEinKU1kjTaN7BPj292VbvQP31Qwe3ho0J6A8i87ukTmdt820YQAVISu/yrWzXt4lw=
X-Received: by 2002:a2e:5b1d:: with SMTP id p29-v6mr17062051ljb.176.1548051334022;
 Sun, 20 Jan 2019 22:15:34 -0800 (PST)
MIME-Version: 1.0
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Date:   Mon, 21 Jan 2019 11:45:20 +0530
Message-ID: <CA+ARAtpAN_DJ-zgiwPEBqV1EotgsmggRRQWB59u8O_OPR_kFrw@mail.gmail.com>
Subject: protocol v2: More data transmitted between client and server since v2.20.0
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I recently came across a blog[1] about how protocol v2 speeds up the
transfer between the client and the server. It states that the amount
of data transmitted between the client and the server is less when
using the protocol v2.

To demonstrate the difference between v0 and v2 two commands were
mentioned in the blog. The results hold true for me when I test using
Git v2.18.1. The commands given there worked as mentioned in the blog
until Git v2.18.1. But when I run the same commands using Git v2.20.0
or the one I built from source in the 'next' branch (at aa96b0ce6b).
I'm not sure why this is the case. Some observations below:

Protocol v0
===========
# Git version: 2.18.1
$ GIT_TRACE_PACKET=1 git -c protocol.version=0 ls-remote
git@gitlab.com:gitlab-org/gitlab-ce.git master
2>git_protocol_0_git_2.18.1_stderr.txt
d4d4ebadfb373518013382560b1f505eb6217f13        refs/heads/master

$ wc -l git_protocol_0_git_2.18.1_stderr.txt
36848 git_protocol_0_git_2.18.1_stderr.txt


# Git version: 2.19.0
$ GIT_TRACE_PACKET=1 git -c protocol.version=0 ls-remote
git@gitlab.com:gitlab-org/gitlab-ce.git master
2>git_protocol_0_git_2.19.0_stderr.txt
d4d4ebadfb373518013382560b1f505eb6217f13        refs/heads/master

$ wc -l git_protocol_0_git_2.19.0_stderr.txt
36848 git_protocol_0_git_2.19.0_stderr.txt


# Git version: 2.20.0
$ GIT_TRACE_PACKET=1 git -c protocol.version=0 ls-remote
git@gitlab.com:gitlab-org/gitlab-ce.git master
2>git_protocol_0_git_2.20.0_stderr.txt
d4d4ebadfb373518013382560b1f505eb6217f13        refs/heads/master

$ wc -l git_protocol_0_git_2.20.0_stderr.txt
36848 git_protocol_0_git_2.20.0_stderr.txt


# Git version: 2.20.1.495.gaa96b0ce6b
$ GIT_TRACE_PACKET=1 git -c protocol.version=0 ls-remote
git@gitlab.com:gitlab-org/gitlab-ce.git master
2>git_protocol_0_git_2.20.1-source_stderr.txt
d4d4ebadfb373518013382560b1f505eb6217f13        refs/heads/master

$ wc -l git_protocol_0_git_2.20.1-source_stderr.txt
36848 git_protocol_0_git_2.20.1-source_stderr.txt


Protocol v2
===========
# Git version: 2.18.1
$ GIT_TRACE_PACKET=1 git -c protocol.version=2 ls-remote
git@gitlab.com:gitlab-org/gitlab-ce.git master
2>git_protocol_2_git_2.18.1_stderr.txt
d4d4ebadfb373518013382560b1f505eb6217f13        refs/heads/master

$ wc -l git_protocol_2_git_2.18.1_stderr.txt
22 git_protocol_2_git_2.18.1_stderr.txt


# Git version: 2.19.0
$ GIT_TRACE_PACKET=1 git -c protocol.version=2 ls-remote
git@gitlab.com:gitlab-org/gitlab-ce.git master
2>git_protocol_2_git_2.19.0_stderr.txt
d4d4ebadfb373518013382560b1f505eb6217f13        refs/heads/master

$ wc -l
22 git_protocol_2_git_2.19.0_stderr.txt


# Git version: 2.20.0
$ GIT_TRACE_PACKET=1 git -c protocol.version=2 ls-remote
git@gitlab.com:gitlab-org/gitlab-ce.git master
2>git_protocol_2_git_2.20.0_stderr.txt
d4d4ebadfb373518013382560b1f505eb6217f13        refs/heads/master
04845fdeae75ba5de7c93992a5d55663edf647e0
refs/remotes/remote_mirror_630f74462b3b08a952486da866d5e702/master
04845fdeae75ba5de7c93992a5d55663edf647e0
refs/remotes/remote_mirror_655ad545056a2ad17e7ebc5461a986e4/master
d4d4ebadfb373518013382560b1f505eb6217f13
refs/remotes/remote_mirror_d612bbe5bee4fbc624df371bc7caa759/master

$ wc -l git_protocol_2_git_2.20.0_stderr.txt
160971 git_protocol_2_git_2.20.0_stderr.txt


# Git version: 2.20.1.495.gaa96b0ce6b
$ GIT_TRACE_PACKET=1 git -c protocol.version=2 ls-remote
git@gitlab.com:gitlab-org/gitlab-ce.git master
2>git_protocol_2_git_2.20.1-source_stderr.txt
d4d4ebadfb373518013382560b1f505eb6217f13        refs/heads/master
04845fdeae75ba5de7c93992a5d55663edf647e0
refs/remotes/remote_mirror_630f74462b3b08a952486da866d5e702/master
04845fdeae75ba5de7c93992a5d55663edf647e0
refs/remotes/remote_mirror_655ad545056a2ad17e7ebc5461a986e4/master
d4d4ebadfb373518013382560b1f505eb6217f13
refs/remotes/remote_mirror_d612bbe5bee4fbc624df371bc7caa759/master

$ wc -l git_protocol_2_git_2.20.1-source_stderr.txt
160971 git_protocol_2_git_2.20.1-source_stderr.txt


Also, note that there are more refs printed when using v2 which is
spooky too. I thought of running a bisect to find the actual culprit
but wanted to know if this was *actually* an issue or not? Any
thoughts?


References
==========
[1]: https://about.gitlab.com/2018/12/10/git-protocol-v2-enabled-for-ssh-on-gitlab-dot-com/

--
Sivaraam

P.S.: I previously sent this email but it doesn't seemed to have reached the
mailing list (as verified by checking the archives) for some unknown reason.
So, I've re-sent this email. Sorry if this was redundant.
