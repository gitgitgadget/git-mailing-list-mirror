Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D89C433E2
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 02:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD1F2088E
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 02:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="le1I8k2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731761AbgFRCS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:18:59 -0400
Received: from ms11p00im-qufo17281501.me.com ([17.58.38.52]:39406 "EHLO
        ms11p00im-qufo17281501.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730131AbgFRBT3 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 Jun 2020 21:19:29 -0400
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jun 2020 21:19:29 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1592442803;
        bh=CqnYEO1QCBCHnPZE9BrtmBFY6WhjfyLgnKlzFJyrUtY=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=le1I8k2IJn56P3Yfho9AcdIMGhSV4hAOYLu6D/+LIShYxYfLAieP/9/s6/G5TMLCY
         +LlHmkKgzizxPWOjbD7fmc7bPdlRrlPm5/b8dfzsX2rJVbFRCaUfBrxqMAbWoPDsgA
         xxfi0iaTge/4nIfjPzDDQBtof8+rbbSEoPPsvMnTTsUvgNJ12I8IoViPdzEyH4EXUj
         gC3vKrVnYDyfO05DZEP3rADx7aAtPFH7c/tB7z+pIvYcwOarYfDmG4j6xCZwAKyxSA
         EB7eeUXI+XWRl+CNTn64S4VuvQz80Lecl3oPh1k6knEb31opqWbF+l8O6vRs18J3gh
         GftjG45hZL+Bg==
Received: from toms-mbp.hub (unknown [101.114.111.168])
        by ms11p00im-qufo17281501.me.com (Postfix) with ESMTPSA id CD54DB40189;
        Thu, 18 Jun 2020 01:13:18 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: git-subtree split misbehaviour with a commit having empty ls-tree
 for the specified subdir
From:   Tom Clarkson <tqclarkson@icloud.com>
In-Reply-To: <CAPyFy2CMSGwPgGLh2Jbfvuf8oRBcvZ1LRv-m7AVvPybtpEybnw@mail.gmail.com>
Date:   Thu, 18 Jun 2020 11:13:02 +1000
Cc:     git mailing list <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5CD94CF2-48D4-4EFD-9581-625E6C117F89@icloud.com>
References: <CAPyFy2AKSVQJtSY0RNgJDJ5k1P=-gjNXVjDgPh+CdghhZtJXDw@mail.gmail.com>
 <F0FBE3B6-0DF5-40A4-B1A3-18EF65D48FF3@icloud.com>
 <CAPyFy2Ar+OncJtgZZyAzxs0PkXy5rSU6ALS+MimK8x5TzWjLug@mail.gmail.com>
 <CAPyFy2CMSGwPgGLh2Jbfvuf8oRBcvZ1LRv-m7AVvPybtpEybnw@mail.gmail.com>
To:     Ed Maste <emaste@freebsd.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_12:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2004280000 definitions=main-2006180006
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 18 Jun 2020, at 12:46 am, Ed Maste <emaste@freebsd.org> wrote:
>=20
> On Fri, 20 Dec 2019 at 10:56, Ed Maste <emaste@freebsd.org> wrote:
>>=20
>> On Wed, 18 Dec 2019 at 19:57, Tom Clarkson <tqclarkson@icloud.com> =
wrote:
>>>=20
>>>> Overall I think your proposed algorithm is reasonable (even though =
I
>>>> think it won't address some of the cases in our repo). Will your
>>>> algorithm allow us to pass $dir to git rev-list, for the initial
>>>> split?
>>>=20
>>> Is this just for performance reasons? As I understand it that was =
left out because it would exclude relevant commits on an existing =
subtree, but it could make sense as an optimization for the first split =
of a large repo.
>>=20
>> Yes, it's for performance reasons on a first split that I'd like to
>> see it. On the FreeBSD repo the difference is some 40 minutes vs. a
>> few seconds.
>=20
> Following up on this old thread, I plan to revisit the optimization,
> implementing something on top of your work in
> https://github.com/gitgitgadget/git/pull/493. I might look at adding a
> --initial flag to subtree split, having it essentially auto-detect a
> revision to use as the value for --onto. For the common case of an
> initial merge commit with two parents I think we can relatively easily
> determine which is the subtree parent. If that's not sufficiently
> general (or broadly useful outside of our context) we could just
> create a helper script wrapping `subtree split` tailored to the
> FreeBSD cases. We have something like 100 projects we're looking to
> split, as part of our svn to git migration.

The new use command might be a better fit than onto in this case - it =
does the same thing as onto, except it also marks the commit as =
processed and therefore excludes them from the initial rev list.

Actually, on reading the code, I=E2=80=99m not sure onto does quite what =
the documentation suggests it does - by updating the cache it will =
shortcut processing of subtree commits that have already been merged =
into mainline, but has no mechanism for building onto an existing =
unrelated history.

Reliably differentiating subtree and mainline commits has always been =
tricky, but should be ok as part of an advanced flag/new command. =
Perhaps rev-list --merges <path> to find potential unmarked subtree =
merges, then take the one where the root tree matches the post merge =
subdir tree. No doubt it won=E2=80=99t catch everything, but I=E2=80=99d =
say that=E2=80=99s less of a risk than false positives.

In the context of a helper script, a new command or adding a --auto flag =
to use might be better than adding a flag to split - that way you could =
easily tell if the expected initial state was found rather than having =
to wait for the full process to produce something weird.=20

That would also let you mark the other side of the merge as ignored =
mainline history - a significant optimization when you=E2=80=99re =
excluding 200k commits, but risky to include more generally.

