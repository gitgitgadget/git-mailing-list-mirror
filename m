Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E8121F404
	for <e@80x24.org>; Mon, 27 Aug 2018 03:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbeH0HAV (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 03:00:21 -0400
Received: from mail-oi0-f52.google.com ([209.85.218.52]:39696 "EHLO
        mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbeH0HAV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 03:00:21 -0400
Received: by mail-oi0-f52.google.com with SMTP id c190-v6so24822395oig.6
        for <git@vger.kernel.org>; Sun, 26 Aug 2018 20:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=XEnTzPG/xSU0rs5VVUHZoSTMUEHlyzQARla9H2iEGys=;
        b=gk7ylr8Y+LlatC+3Y8eDhTcKTNQd1ymKhjIZTGc5eBuwWsX7wDV0Mc+8EbooiyUwN8
         8vN8ryw43sdvOMd2wrjy0+SQBx64sIb1lfzlfp4O2uTix6fgqHhH4vHxQAWO8+XLkUJJ
         PYF2UBRcaTizzwsRx01TLhFHI4sLj9K7LIuYD2TvOBwVk/Clrup6Aih0MH1qS5H0gieo
         /hqFS2p62X7G97ANrZqBOQ0Ve+7vIR4Oc5yjayuyJBAyzaKy/V76mn/MjQW3fEEA2e+n
         SDfdg7JJ4j6K6z48hNBJkSGn0CeYHrwBcPm245DzcQTMYgUiR4hX7mZXFk0dBRSynivB
         cOhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XEnTzPG/xSU0rs5VVUHZoSTMUEHlyzQARla9H2iEGys=;
        b=sMaVAjFU8c3D8T6w37i32qojxHFRPlDijlIN9olD0goC+BV9zWhQ8StARXAW9uHA/G
         UXMAiunqX3KYLkz/zp/JVNhir3nNXe+T4712ZRYX/CJm7CqjAuvZ7wA88zk2F48V8643
         PY/aUxvT/6pUMr04jb5WoGZ6EFwH12w93caSw4kVUu2NnJDikaDKQ+1fLDN5L3i8Jd3G
         cQ+TLKWWlPkyYJDcXQulQqQ6hIeVzzaiVytz3aG2giyZdnLUqjd8pm2BrNJZP9HJPfhn
         kQst4sSKsb1iWZBL4pKDRkx0QZJD75gpfBfJvRwkTLPcDKaQ8YqKOo9IzBYJukvHtE9G
         6MGQ==
X-Gm-Message-State: APzg51DMYjg9ModOL0HCORC5JA3V9Qw42EvcnFxNBpuERZmOr4rWT5KS
        6pAqd0s2lQnMsm705PnxT/FNCx3Panp2esh9wtWtFpIb
X-Google-Smtp-Source: ANB0VdakPLAw7ltauI9PxyYndEGJNHgDJ0AUUaOr9mG0qnFexiS3pd19ixj+gUC1Nz1ol63/qB98BlhZQk9E+s7QoLY=
X-Received: by 2002:aca:e155:: with SMTP id y82-v6mr11269138oig.90.1535339738227;
 Sun, 26 Aug 2018 20:15:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4a21:0:0:0:0:0 with HTTP; Sun, 26 Aug 2018 20:15:37
 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
Date:   Mon, 27 Aug 2018 11:15:37 +0800
Message-ID: <CAD8Lp45mBWtxsXBVgKuDmhP1rUzVkLJRTff=v1NKjMHZR5g87A@mail.gmail.com>
Subject: Strange commit count shown by "git describe"
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Using git 2.17.1 in Ubuntu 18.04 I'm seeing some strange behaviour
when using "git describe" with the repo at
http://github.com/endlessm/linux

First to rewind to a recent commit on the eos3.4 branch and observe:
$ git reset --hard 282b7f72f11f5617947df941a247b0a286faac35

$ git describe
Version_4.15.0-32.35-724859-g282b7f72f11f
$ git describe --match 'Version_*'
Version_4.15.0-32.35-185-g282b7f72f11f

Why is the commit count vastly different when I specify a glob to
match the same (annotated) tag? 724859 vs 185.

185 is what I would have expected.. at least this shows 182 commits:
$ git rev-list Version_4.15.0-32.35..HEAD

Same again with --debug output:

$ git describe --debug
describe HEAD
No exact match on refs or tags, searching to describe
 annotated     724859 Version_4.15.0-32.35
 annotated        117 Version_4.15.0-30.32
 annotated        124 Ubuntu-4.15.0-29.31
 annotated        142 Ubuntu-4.15.0-28.30
 annotated        146 Ubuntu-4.15.0-27.29
 annotated        149 Ubuntu-4.15.0-26.28
 annotated        152 Ubuntu-4.15.0-25.27
 annotated        167 Ubuntu-4.15.0-24.26
 annotated        919 Release_3.4.6
 annotated        926 Release_3.4.4
traversed 728431 commits
more than 10 tags found; listed 10 most recent
gave up search at f30048d13c9ea1763af8c8e448d9e91de116c114
Version_4.15.0-32.35-724859-g282b7f72f11f

$ git describe --debug --match 'Version_*'
describe HEAD
No exact match on refs or tags, searching to describe
finished search at 2261ba7c40893b3659d8b48a77745bfe79e66526
 annotated        185 Version_4.15.0-32.35
 annotated        289 Version_4.15.0-30.32
 annotated       1100 Version_4.15.0-23.25
 annotated       1234 Version_4.15.0-22.24
 annotated       1274 Version_4.15.0-20.21
 annotated       1813 Version_4.15.0-15.16
 annotated       2949 Version_4.15.0-12.13
 annotated       3564 Version_4.15.0-10.11
 annotated       3607 Version_4.15.0-9.10
 annotated       3754 Version_4.15.0-5.6
traversed 3757 commits
Version_4.15.0-32.35-185-g282b7f72f11f


A similar problem occurs on the current HEAD
(773a8ad2c3b6a54993bc88381b509621aac5be4f) of the eos3.4 branch.
However in that case, even with the --match arg I get a strange commit
count:

$ git describe --match 'Version_*'
Version_4.15.0-33.36-724860-g773a8ad2c3b6

but I would have expected to see a commit count of ~183:
$ git rev-list Version_4.15.0-33.36..HEAD | wc -l
183


Daniel
