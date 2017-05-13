Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,BODY_8BITS,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34396201A4
	for <e@80x24.org>; Sat, 13 May 2017 09:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbdEMJR1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 05:17:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:49498 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751725AbdEMJR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 05:17:26 -0400
Received: from [192.168.1.106] ([95.91.234.171]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M5cpk-1dxrye02v2-00xdwG for
 <git@vger.kernel.org>; Sat, 13 May 2017 11:17:24 +0200
To:     git@vger.kernel.org
From:   Nikolai Hartmann <nikolai.hartmann@gmx.de>
Subject: git subtree merge deletes files in top directory
Message-ID: <aa3f2a1c-42d2-06df-9823-c455c798ffb0@gmx.de>
Date:   Sat, 13 May 2017 11:20:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:+NQqAD0gCeyNlR9TTS6eU24Y4Mgqh25A08kjxLeJtASw6lyc/wt
 nJuWN3DPlr4pem6gSq2Mu+zK6ISgtXRcDbZuzyw8dbU4mAqBtBizWfUt0mH1Wxy/BFe3YVs
 ozHcq2LTGHwb9+jNK+uGFKayo2D2OACsTns1do39p71/rZHpgN2FuSNeRNB/LlxwDOu1M4q
 sVqygbN+NgLl1o2vW3t3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:INXXmW86JFQ=:9GXtTqwrctLg95KPZVNXVu
 oFx1xXb3kHydcI+p6SCRMt5EX6ujK6LL1RWY/9vkiuy7dYMh7jAZIVNFUfTng6wl0tvfEyam2
 ovhy4FCUqnPGgUlsOhHATSHcA+Lprf+tJ1M8QNqMnqMZMwh2ViPauY3X6jAfJl6lDcy7qXBW0
 E5aQ4FHf3B5v4KFSpL97xLkFEVwjMg0jDtUkkW9ESmTj88aKeN+JPBYq8zl8l1fI6aIM0bRkA
 5wSkylnesZEgFZtzm7oZeIBfescpruIibkXXD73tnT5syyffYBdBWr3UUkOFJF9QOqI8gOhCK
 U1DA5v7TcfiYqkXReEZCqUx32WnR18SkrQfwKS5zzmPyKdKCHk7uYeIqZCLtdDnT/p7/E49Nc
 NFcHe1UsP+1OH0rYQmBR4RrRAjNXOaVmRNJTZb7Z9gfmVAl3zxzFhC8qZlvHXEK22YGQAKKYR
 VJ03rdhQgokL8IhObvR6Oy4Cjzvffcu1RNTuWBF8cjtasTAWaWAlO4VYAbrinheDQfGy/pwxr
 TmUlbkdGp27EqIC6Hy+iS+GU2uLkehk1pIrQkcFN3CxXYU9u0SMwqX4858TA2xnO70sYPVfpi
 8sjq/jrxuShZnRxtJ/pWyT8eGXDiYjOmwdAo3/wdYYAb9+/JuUNALoRHxMlHeXFY0ODUoWMj6
 yhIB1YCtKQEFI5mMJXBotg1/P9T/xr7Cscqbz0tAYjaLCjBXWuCXqGhd0E9rnKi7Go0vOC6B8
 JJtydCaIz+1IgwNzOWJWA2r9tK1UATavNF6ZcAESgdfCvZBP3qfiLJBkcWdh0YZHyvZ7eJoVD
 l43npls
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm trying to add a subtree which contains a folder with the same name
as the subtree directory itself.
Adding seems to work, but if i pull after the subtree remote changed,
files in my top directory are deleted and everything seems to have
"moved up" one directory - although i specify a subtree directory with "-P"

For example i start with top repository that contains one file:

.
└── topfile

Now i try to add another repository as a subtree which looks like this:

.
├── afile
└── subrep
    └── anotherfile

Running `git subtree add -P subrep origin_subrep master --squash` on the
top repository produces correctly

.
├── subrep
│   ├── afile
│   └── subrep
│       └── anotherfile
└── topfile

Now i change the subrep git by just adding files

.
├── afile
├── bfile
└── subrep
    ├── anotherfile
    └── yetanotherfile

When i try to merge these into the top repository by `git subtree pull
-P subrep origin_subrep master --squash` i get

[...]
Removing topfile
Removing subrep/subrep/anotherfile
Removing subrep/afile
Merge made by the 'recursive' strategy.
 subrep/subrep/anotherfile => anotherfile | 0
 subrep/afile                             | 0
 topfile => yetanotherfile                | 0
 3 files changed, 0 insertions(+), 0 deletions(-)
 rename subrep/subrep/anotherfile => anotherfile (100%)
 delete mode 100644 subrep/afile
 rename topfile => yetanotherfile (100%)

And my top repository looks like

.
├── anotherfile
└── yetanotherfile

The issue seems to be related to the subdirectory "subrep" of my
repository "surep" having the same name - if i rename it to something
else everything works as expected.

I could reproduce this behaviour in git 2.12.0 and the current next
branch (v2.13.0-303-g4ebf30216)

Thanks,
Nikolai
