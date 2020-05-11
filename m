Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27086C54E4B
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE05020736
	for <git@archiver.kernel.org>; Mon, 11 May 2020 11:21:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="S8IUjonL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgEKLVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 07:21:10 -0400
Received: from mr85p00im-zteg06012001.me.com ([17.58.23.197]:57163 "EHLO
        mr85p00im-zteg06012001.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726068AbgEKLVJ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 07:21:09 -0400
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 May 2020 07:21:09 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
        s=1a1hai; t=1589195491;
        bh=SaZEjFpr4lneT1755hV6+HKE7V6qGM3AtLMxiukZntU=;
        h=Content-Type:Subject:From:Date:Message-Id:To;
        b=S8IUjonLC3zKcWeO332U859eUwqCi/CV0kJZCirOWU5VcKBIiKyc1G/Asuz5XeOss
         5SATqMKtXHddP837qVZd4AU97JLmvtbMGYw0/cqpfi52cKTiXU6Tby3M/ZkAbIlySG
         v9ftq9cP6BSM6KvCZ0RtuZ7OVkaBOtpTQOvYQSCDHS/As5yDeVNS3SWCJ0bM+V7TiT
         U1rA8qiBZ4cJEpKl7DzEz2GrmN1DO3+2buZ+/4VfsCpbqjK2bSb//40QtEPGDylXyA
         KTvfoJcGZli3L6Ed4h2N0GiOLMkkMweUYDOQgXt4jzHvZDBqSYwuAlr0gAmqKov+1r
         DJXdvzXhsKL7A==
Received: from toms-mbp.hub (unknown [101.114.127.198])
        by mr85p00im-zteg06012001.me.com (Postfix) with ESMTPSA id 4C720A0036C;
        Mon, 11 May 2020 11:11:31 +0000 (UTC)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [RFC] subtree: say last line of progress when all commits has
 been processed
From:   Tom Clarkson <tqclarkson@icloud.com>
In-Reply-To: <CA+GP4brP8rtTxtKCPaq0q8VisOa9=fRJWU86SE61zB7S6CaGzw@mail.gmail.com>
Date:   Mon, 11 May 2020 21:11:28 +1000
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C681EF54-1CB9-4223-A59E-D2A7C9FE50DA@icloud.com>
References: <CA+GP4bozGEP_kJ1V5df_UEh46kDhPV48h_OqkPWfNJLQ2V4yCg@mail.gmail.com>
 <CA+GP4bpUs8ZArrf6sZDHDPHEJYu5Z_jrq4c5Bz4Sm6M24LuRMw@mail.gmail.com>
 <CA+GP4brP8rtTxtKCPaq0q8VisOa9=fRJWU86SE61zB7S6CaGzw@mail.gmail.com>
To:     Claus Schneider <claus.schneider@eficode.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-11_04:2020-05-11,2020-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=635 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2002250000 definitions=main-2005110092
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 6 May 2020, at 11:12 pm, Claus Schneider =
<claus.schneider@eficode.com> wrote:

> Suggest to record the last line and then "say" it after all commits
> have been processed. It is then more informative to run from the
> command line.

Seems reasonable enough. Looks like it might need an extra check on how =
it behaves in quiet mode, but other than that go ahead and try =
submitting a patch via GitGitGadget.

