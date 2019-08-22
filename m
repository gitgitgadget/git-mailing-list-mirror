Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 790EB1F461
	for <e@80x24.org>; Thu, 22 Aug 2019 20:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404549AbfHVUyd (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 16:54:33 -0400
Received: from st43p00im-ztbu10073701.me.com ([17.58.63.183]:57883 "EHLO
        st43p00im-ztbu10073701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731775AbfHVUyd (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 22 Aug 2019 16:54:33 -0400
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Thu, 22 Aug 2019 16:54:32 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mac.com; s=1a1hai;
        t=1566506683; bh=NzUUIRTCiWgviltRJpCSGOVF7wbuw+PfSXlYS9aCSlk=;
        h=From:Content-Type:Subject:Message-Id:Date:To;
        b=kHFoAiNHAdVT/c4as8vAgzCMv3nZQKWWptO690zlY2RsguDVRz7qUDi3lWb8ecnUq
         L0n252wnABsMZljs1DrX+RaRdwCHfXlfDz2Q6eVArB0uRI/9RthGl5MDTsJc0Plv6f
         pk5MW3nWbbEAxkFZ1HMqt47LJzrhQFetl5wunk/dJG0LfNA5p61hxm5VNwaO/OZYmp
         40zocE4lf8cZuQcNIrk4cqi3twyiCNrky8bZ/kqgDGW2FXRb93fbPyGib4sJyNUAEn
         igPAfcEvSA0zlCSr0Cap07yaxjCj/+sxmIqxj1KAttG2DmkGYIsqfB6cr6j/tSwc4F
         RP1pLkWVEAcMQ==
Received: from [172.20.10.5] (mobile-166-170-34-87.mycingular.net [166.170.34.87])
        by st43p00im-ztbu10073701.me.com (Postfix) with ESMTPSA id 1BC414C03DD;
        Thu, 22 Aug 2019 20:44:42 +0000 (UTC)
From:   Christopher Sean Morrison <brlcad@mac.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Bug Report: notes disassociated after history edits
Message-Id: <01F35983-BC98-4518-8ED3-C0E1AFC7507A@mac.com>
Date:   Thu, 22 Aug 2019 16:44:37 -0400
Cc:     Cliff Yapp <cliffyapp@gmail.com>
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-22_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1812120000 definitions=main-1908220180
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

We=E2=80=99re migrating a very large old repository to Git (the oldest =
in continuous development!) and using the notes feature to preserve Svn =
data like revision IDs and branch information.  We=E2=80=99ve run into =
what seems like an incomplete feature or bug in that notes get =
orphaned/disassociated if an old commit is changed (e.g., edit a =
committer's e-mail or the commit message).

The changed commit and all children commits get sha updates, but the =
notes remain associated with the original sha.  This can be particularly =
catastrophic, for example, if an early commit is changed as all notes =
become orphaned.

I presume this is a bug but perhaps we may be doing something wrong?  Is =
there a better way to preserve old Svn information that will work with =
filter-branch?

We want to be able to look up commits by the old Svn commit ID because =
they are pervasively referenced in commit messages, issue trackers, =
mailing lists, etc.  We also simply don=E2=80=99t want to lose the data =
on philosophical grounds as we have a detailed continuous development =
history that goes back 30+ years.  Thank you in advance for any =
assistance or insights.

Cheers!
Sean

