Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C788A2035F
	for <e@80x24.org>; Wed, 26 Oct 2016 00:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755033AbcJZAxU (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 20:53:20 -0400
Received: from mr25p46im-ztdg02111301.me.com ([17.111.255.92]:44508 "EHLO
        mr25p46im-ztdg02111301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754358AbcJZAxU (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 25 Oct 2016 20:53:20 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Oct 2016 20:53:19 EDT
Received: from process-dkim-sign-daemon.mr25p46im-ztdg02111301.me.com by
 mr25p46im-ztdg02111301.me.com
 (Oracle Communications Messaging Server 7.0.5.38.0 64bit (built Feb 26 2016))
 id <0OFM00J00NM2F800@mr25p46im-ztdg02111301.me.com> for git@vger.kernel.org;
 Tue, 25 Oct 2016 23:53:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=4d515a;
        t=1477439598; bh=L6INejf/4mYnv2ZUbFZxW5sM6mq96RkEd8LpGAxQxuQ=;
        h=From:Content-type:MIME-version:Subject:Message-id:Date:To;
        b=HrUOX7o7oXUja8SXSAT7Gb9hRMjVfSg28nW6USF04xXcBh3EBg6HmpkHGJeOyZiid
 Mt6dQd8BbIGoXCAGtYH4zmzMfezERxIfMOmYi0gRRJd15UNiGRUI0hm6rGzymQJPL1
 D/O83nMfPDBBqtLdjeqCSWGkt6XSsOB+9FICltDB3RxA5sg3MhY6LDwVl69dfQi+Bm
 G/7XAyKmDyCvvwSAyVCR6aQQK23L5FtTheRI0nQNtX97y36auTcJOu0KB7/ZvH/nkE
 REb5HYEpVnsl9vloLw7qutT9KPW1WFt6ycUF6OueoYGkLRvzc1FfT4WT/9HrB7vbRA
 f7z4upXJHRJ2g==
Received: from pengtao.apple.com (unknown [17.213.34.1])
 by mr25p46im-ztdg02111301.me.com
 (Oracle Communications Messaging Server 7.0.5.38.0 64bit (built Feb 26 2016))
 with ESMTPSA id <0OFM00I4MNOTRZ50@mr25p46im-ztdg02111301.me.com> for
 git@vger.kernel.org; Tue, 25 Oct 2016 23:53:18 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2016-10-25_22:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1034 suspectscore=15 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1603290000 definitions=main-1610250385
From:   Tao Peng <pengtao@me.com>
Content-type: text/plain; charset=utf-8
Content-transfer-encoding: quoted-printable
MIME-version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: A bug with "git svn show-externals"
Message-id: <B8D25850-A4DE-435C-A856-240D612D59DA@me.com>
Date:   Tue, 25 Oct 2016 16:53:17 -0700
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3251)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

I met a bug of the "git svn show-externals=E2=80=9D command.  If a =
subdirectory item has a svn:externals property, and the format of the =
property is =E2=80=9CURL first, then the local path=E2=80=9D, running =
"git svn show-externals=E2=80=9D command at the root level will result =
in an unusable output.

Example:
$ svn pg svn:externals svn+ssh://src.foo.com/svn/ref/English.lproj/
=
svn+ssh://src.foo.com/svn/orig/trunk/Resources/English.lproj/Localizable.s=
trings Localizable.strings

$ git svn show-externals
# /English.lproj/
=
/English.lproj/svn+ssh://src.foo.com/svn/orig/trunk/Resources/English.lpro=
j/Localizable.strings Localizable.strings


This bug is preventing my script from correctly finishing the svn-to-git =
repo migration work. Does anyone know a workaround to this bug?

Thanks,
Peng=
