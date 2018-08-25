Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F11E61F428
	for <e@80x24.org>; Sat, 25 Aug 2018 18:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbeHYW3n (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Aug 2018 18:29:43 -0400
Received: from mout.web.de ([212.227.15.14]:60999 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbeHYW3n (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Aug 2018 18:29:43 -0400
Received: from [192.168.178.36] ([91.20.53.4]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MCvVz-1g2gJu3sDz-009hcm; Sat, 25
 Aug 2018 20:49:45 +0200
Subject: Re: [PATCH 2/2] fsck: use oidset for skiplist
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
 <54a5367f-f832-402c-f51b-3225c92b41ad@web.de>
 <87lg9csv2u.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <113aa2d7-6f66-8d03-dda4-7337cda9b2df@web.de>
Date:   Sat, 25 Aug 2018 20:49:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87lg9csv2u.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:MkI3/2zkPt+KZZefNaRNOyQi/G3jncdKqr9YZ2VypRxoxgDeggZ
 JuV4vmuVqf+DpEfDm/0qn42smpvyYY2lyEhEzEIU2z/pfsBdJBuPY9kRbOe/luvPLFDboFk
 eqAi1xhuH9873McCjTgr+1Tgs9VX+5S5HM1PjKn38BSmf4O6v1DjnvxzK6a88tQ2uC4m83b
 y7hUBRbUeHZzDE+/xmbXg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QSRgwUOX1ik=:1bcYcWEGEFxTRn38G/b9mI
 jfJRpnYbKq6ZRpZretqwS10+cqKjLSnOKjMxbiLDmz5SOmbnKP6WN3TKB7JMzZLYBUNvyHEqE
 rbZk9LlLWaE7tEz+3PCzR8H0fruIbv8mcf18E1JzXdYLKkjcEU4QaGFNsqCBfSVPxOcGjvFUm
 uf5n2WjMxKSWcVft/Klc1RRQATNv2X5AaNeimLZwOPS1jdsoVgE39bdH9Vys8sm4XqWYyrlQu
 SiTejudqu9XU4x3AotatH/8aE/jjcWhbD1uqtvTNWv1oI/ffC9mHPcjhqh60XORO/YyBhSyq+
 ghs/1W+5GqnBysUqK9z2Ewlr4G3YFA0aen+RqZc48pLCFOmP+wSeXS8KGWFrrvnGovlb4OepW
 77KwaingQMHhoSHGxbyz/S56MnhXUIFFXt8VJ3Zl8y3r84hv0GbICWJYn3LACEO0x7NKFuP/1
 ZL+25Oz/+uRa1f7k/HGttjhp4n8R+K+GysvXKr7yVIz3QWLiTwEGQfS+HVysOUr+seBEo2waI
 gW6fDGPAllSkIvvwAlk6vY8FJM076PP6hMSf0bvC2H0xBQdHK1xseG7EVxc22f2gEtbgN33Xr
 JIJVdSsNLBzFsfe/VSdigP7r9UiOp5DZ0VpjGsEofCnGaEO4/WuT7q4VTt6TLrPDJVHVuEOJU
 ZDQezFr4H16vWJEKzGSoupF14oZGbsRZe7+ERTlIhLIbm3jyrnaQ04y0sGXS3b9zc1ti5kQkO
 0bH6EZ6KdgpWM1sn7eBrmQ7eEidQFeGcXZ15KC0+P1F8H6yRFfHTqbVs5b1eFLyjOmHr7vQz/
 ynHgrUF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.08.2018 um 18:54 schrieb Ævar Arnfjörð Bjarmason:
> 
> On Sat, Aug 11 2018, René Scharfe wrote:
> 
>> Object IDs to skip are stored in a shared static oid_array.  Lookups do
>> a binary search on the sorted array.  The code checks if the object IDs
>> are already in the correct order while loading and skips sorting in that
>> case.
> 
> I think this change makes sense, but it's missing an update to the
> relevant documentation in Documentation/config.txt:
> 
>     fsck.skipList::
>     	The path to a sorted list of object names (i.e. one SHA-1 per
>     	line) that are known to be broken in a non-fatal way and should
>     	be ignored. This feature is useful when an established project
>     	should be accepted despite early commits containing errors that
>     	can be safely ignored such as invalid committer email addresses.
>     	Note: corrupt objects cannot be skipped with this setting.
> 
> Also, while I use the skipList feature it's for something on the order
> of 10-100 objects, so whatever algorithm the lookup uses isn't going to
> matter, but I think it's interesting to describe the trade-off in the
> commit message.
> 
> I.e. what if I have 100K objects listed in the skipList, is it only
> going to be read lazily during fsck if there's an issue, or on every
> object etc? What's the difference in performance?

The list is loaded once up-front and a lookup is done for each
reportable issue and .gitmodules file.  Repositories without them
won't be affected at all.

100K bad objects sounds a bit extreme, but a fast-import can create
such a repository relatively quickly.  Here are the numbers with and
without the two patches:

Test                                            origin/master     HEAD
----------------------------------------------------------------------------------------
1450.3: fsck with 0 skipped bad commits         0.84(0.78+0.05)   0.83(0.80+0.03) -1.2%
1450.5: fsck with 1 skipped bad commits         0.84(0.77+0.07)   0.84(0.79+0.05) +0.0%
1450.7: fsck with 10 skipped bad commits        0.86(0.81+0.05)   0.84(0.78+0.06) -2.3%
1450.9: fsck with 100 skipped bad commits       0.85(0.78+0.07)   0.84(0.78+0.05) -1.2%
1450.11: fsck with 1000 skipped bad commits     0.85(0.80+0.05)   0.84(0.79+0.05) -1.2%
1450.13: fsck with 10000 skipped bad commits    0.85(0.78+0.07)   0.82(0.75+0.06) -3.5%
1450.15: fsck with 100000 skipped bad commits   0.73(0.64+0.09)   0.64(0.62+0.02) -12.3%

They look the same for most sizes, but with all 100000 bad objects in
the skiplist the oidset wins decisively.  Dialing it up a notch:

Test                                             origin/master     HEAD
-----------------------------------------------------------------------------------------
1450.3: fsck with 0 skipped bad commits          8.61(7.94+0.66)   8.72(8.14+0.58) +1.3%
1450.5: fsck with 1 skipped bad commits          8.51(7.87+0.63)   8.53(7.93+0.60) +0.2%
1450.7: fsck with 10 skipped bad commits         8.56(7.98+0.57)   8.54(7.91+0.63) -0.2%
1450.9: fsck with 100 skipped bad commits        8.65(8.00+0.65)   8.47(7.93+0.53) -2.1%
1450.11: fsck with 1000 skipped bad commits      8.69(8.16+0.53)   8.49(8.00+0.49) -2.3%
1450.13: fsck with 10000 skipped bad commits     8.69(8.13+0.56)   8.50(7.93+0.56) -2.2%
1450.15: fsck with 100000 skipped bad commits    8.78(8.18+0.60)   8.36(7.85+0.50) -4.8%
1450.17: fsck with 1000000 skipped bad commits   7.83(7.07+0.76)   6.55(6.42+0.12) -16.3%

So it looks like successful lookups are faster in the oidset and
the oid_array is quicker with just a handful of entries.

A L1 cache line of 64 bytes holds 3 consecutive SHA1 hashes, which
might explain it.

Here's the perf test code:

---
 t/perf/p1450-fsck.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100755 t/perf/p1450-fsck.sh

diff --git a/t/perf/p1450-fsck.sh b/t/perf/p1450-fsck.sh
new file mode 100755
index 0000000000..7c89690777
--- /dev/null
+++ b/t/perf/p1450-fsck.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+test_description='Test fsck skipList performance'
+
+. ./perf-lib.sh
+
+test_perf_fresh_repo
+
+n=100000
+
+test_expect_success "setup $n bad commits" '
+	for i in $(test_seq 1 $n)
+	do
+		echo "commit refs/heads/master" &&
+		echo "committer C <c@example.com> 1234567890 +0000" &&
+		echo "data <<EOF" &&
+		echo "$i.Q." &&
+		echo "EOF"
+	done | q_to_nul | git fast-import
+'
+
+skip=0
+while test $skip -le $n
+do
+	test_expect_success "create skipList for $skip bad commits" '
+		git log --format=%H --max-count=$skip |
+		sort >skiplist
+	'
+
+	test_perf "fsck with $skip skipped bad commits"	'
+		git -c fsck.skipList=skiplist fsck
+	'
+
+	case $skip in
+	0) skip=1 ;;
+	*) skip=${skip}0 ;;
+	esac
+done
+
+test_done
-- 
2.18.0
