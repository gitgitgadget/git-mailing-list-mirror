Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C1BA1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 12:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754787AbeDTMR4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 08:17:56 -0400
Received: from mout.gmx.net ([212.227.17.22]:59933 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754736AbeDTMRz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 08:17:55 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3ARX-1eJsGf05yh-00sst3; Fri, 20
 Apr 2018 14:17:50 +0200
Date:   Fri, 20 Apr 2018 14:17:33 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/3] rebase -i: avoid stale "# This is a combination of" in
 commit messages
Message-ID: <cover.1524226637.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:n8b6tYRpjiYZ/3aUNHScErZ7PHeAcYM+74tD6cpZTXxhyX1BayL
 k5cpqku8uc7qHm6HxH7j+PtKmkZx8/PCsgqKifbe93Luyq7j0iWEQwBTbKMqYIjQOeKARox
 oiDCIShpd7BL+uFbbQ5KZKYxUz+HekOdW/5+PAr57+M3+yRvPs2MoNr0o3rZKdZWhTEwsFb
 Uz4h3m9kXOAmGdKSXjxdA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cbZ0eb1pvjY=:i0J3qPz2zM8V5ur9Z/5+Ce
 1koHv5G/LOKrhBtu+m1h+CCsEU2znuV+c82JrKERBXu1WXH/mshgiUkVhGqH3cKD/KLx4KZad
 +jlcFnNfsRRJdxgRsXa+4AM2/ZS9cemaZdQvcB91pCzD8kQhAePmeJEi2E4K+y7YN+jf4pxxD
 QNQ7nZEFuF+Xo5kFTKZySWfxRDpFAjcTzeysTG6E6N/Bt7JNcWM3/xP2oD6sRsvml2zbLXTIx
 lQLnagIcMLvLKhnMAKb4e3WL4PynChhdUH/Nb+so82FNzNY+Mqww9tl4/oxyOkQn0S4TTssSi
 p2BkKENiAtWyXxj+TVYhCNs9LaE4yaNrHDvfXqxmOoJvgavQju47vxvxmR0tHoZfzM9XjwsMv
 H6fFXx6CXAXWDDdjAZTvmOV5XcJa3l0cVDJXWwXRlF8jNWh1O6j6zPS9IyLf5X8r4rvV6TTCc
 tgTEqMqQ61scaBP0sylSlWs8tPg4mcvnhTvKlELSdpfO54hoOzlWp2ypF+pGSd87a3yG20gC0
 /ZSv7pSeKt+m+KktFmoO0Rc6S5V/9Zv227jTn3YJU1Ii2CYum3WMYeuKgkUSLPN/d+3q2S3H9
 qo05djlvPx4wQIeAP+ivFWKpddH0g2b3xHmQowlYC00zb4nXLQPyj26emPRyqYoaP8pW5j1yL
 krIHTvkfSp7Q2R3O9Ix0EGx+Vjw5R5RRx9LMInwz8ex+TLiP1pCpotnEF//jhs95zrF0JCpuB
 qNVPl/kv3WPa9uQ4MVUX4IyxrqRVw+j5eh6tPSF60JaUYGsp45ZX8w84WfgTfTiHNFfYSp+JE
 m57K4b3hwM1YlZ/tShhSJjrDVJFf/s3kC+hHfcGH/VxsKhnhiI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine pointed out that I had such a commit message in
https://public-inbox.org/git/CAPig+cRrS0_nYJJY=O6cboV630sNQHPV5QGrQdD8MW-sYzNFGQ@mail.gmail.com/
and I went on a hunt to figure out how the heck this happened.

Turns out that if there is a fixup/squash chain where the *last* command
fails with merge conflicts, and we either --skip ahead or resolve the
conflict to a clean tree and then --continue, our code does not do a
final cleanup.

Contrary to my initial gut feeling, this bug was not introduced by my
rewrite in C of the core parts of rebase -i, but it looks to me as if
that bug was with us for a very long time (at least the --skip part).

The developer (read: user of rebase -i) in me says that we would want to
fast-track this, but the author of rebase -i in me says that we should
be cautious and cook this in `next` for a while.


Johannes Schindelin (3):
  rebase -i: demonstrate bug with fixup!/squash! commit messages
  sequencer: leave a tell-tale when a fixup/squash failed
  rebase --skip: clean up commit message after a failed fixup/squash

 sequencer.c                | 57 ++++++++++++++++++++++++++++++++------
 t/t3418-rebase-continue.sh | 21 ++++++++++++++
 2 files changed, 69 insertions(+), 9 deletions(-)


base-commit: fe0a9eaf31dd0c349ae4308498c33a5c3794b293
Published-As: https://github.com/dscho/git/releases/tag/clean-msg-after-fixup-continue-v1
Fetch-It-Via: git fetch https://github.com/dscho/git clean-msg-after-fixup-continue-v1
-- 
2.17.0.windows.1.15.gaa56ade3205

