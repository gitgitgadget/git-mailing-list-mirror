Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB91A1F71B
	for <e@80x24.org>; Tue,  2 Aug 2016 16:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933438AbcHBQqx (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 12:46:53 -0400
Received: from smtprelay0091.hostedemail.com ([216.40.44.91]:41942 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932962AbcHBQqU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2016 12:46:20 -0400
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Aug 2016 12:46:19 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
	by smtpgrave07.hostedemail.com (Postfix) with ESMTP id D41BD11BC9F;
	Tue,  2 Aug 2016 16:37:25 +0000 (UTC)
Received: from filter.hostedemail.com (unknown [216.40.38.60])
	by smtprelay06.hostedemail.com (Postfix) with ESMTP id 742DB9EA1C;
	Tue,  2 Aug 2016 16:36:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: steam26_71e7f52b5d11d
X-Filterd-Recvd-Size: 3651
Received: from XPS-9350.home (unknown [96.251.125.34])
	(Authenticated sender: joe@perches.com)
	by omf09.hostedemail.com (Postfix) with ESMTPA;
	Tue,  2 Aug 2016 16:36:22 +0000 (UTC)
Message-ID: <1470155781.3998.181.camel@perches.com>
Subject: get_maintainer.pl and .mailmap entries with more than 2 addresses
From:	Joe Perches <joe@perches.com>
To:	Florian Mickler <florian@mickler.org>
Cc:	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, git <git@vger.kernel.org>
Date:	Tue, 02 Aug 2016 09:36:21 -0700
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hello Florian.

There is at least an oddity with get_maintainer handling of a
.mailmap entry form.

For instance:

Mauro's .mailmap entry is:
Mauro Carvalho Chehab <mchehab@kernel.org> <maurochehab@gmail.com> <mchehab@infradead.org> <mchehab@redhat.com> <m.chehab@samsung.com> <mchehab@osg.samsung.com> <mchehab@s-opensource.com>

Is this a valid form?

get_maintainer output for Mauro is:

$ ./scripts/get_maintainer.pl drivers/media/ -f
Mauro Carvalho Chehab <mchehab@kernel.org> <maurochehab@gmail.com> <mchehab@infradead.org> <mchehab@redhat.com> <m.chehab@samsung.com> <mchehab@osg.samsung.com> (maintainer:MEDIA INPUT INFRASTRUCTURE (V4L/DVB))

I believe the Mauro's and Shuah's .mailmap entries are improper and
should be changed, but I'm not completely aware of git .mailmap
handling and the documentation seems weakly specified.

https://git-scm.com/docs/git-check-mailmap

Maybe get_maintainer.pl needs a change or perhaps this patch
is  appropriate.
---
 .mailmap | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index c0d5704..c7f92ca 100644
--- a/.mailmap
+++ b/.mailmap
@@ -96,7 +96,12 @@ Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@web.de>
 Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@ascom.ch>
 Mark Brown <broonie@sirena.org.uk>
 Matthieu CASTET <castet.matthieu@free.fr>
-Mauro Carvalho Chehab <mchehab@kernel.org> <maurochehab@gmail.com> <mchehab@infradead.org> <mchehab@redhat.com> <m.chehab@samsung.com> <mchehab@osg.samsung.com> <mchehab@s-opensource.com>
+Mauro Carvalho Chehab <mchehab@kernel.org> <maurochehab@gmail.com>
+Mauro Carvalho Chehab <mchehab@kernel.org> <mchehab@infradead.org>
+Mauro Carvalho Chehab <mchehab@kernel.org> <mchehab@redhat.com>
+Mauro Carvalho Chehab <mchehab@kernel.org> <m.chehab@samsung.com>
+Mauro Carvalho Chehab <mchehab@kernel.org> <mchehab@osg.samsung.com>
+Mauro Carvalho Chehab <mchehab@kernel.org> <mchehab@s-opensource.com>
 Matt Ranostay <mranostay@gmail.com> Matthew Ranostay <mranostay@embeddedalley.com>
 Matt Ranostay <mranostay@gmail.com> <matt.ranostay@intel.com>
 Mayuresh Janorkar <mayur@ti.com>
@@ -132,7 +137,10 @@ Santosh Shilimkar <santosh.shilimkar@oracle.org>
 Sascha Hauer <s.hauer@pengutronix.de>
 S.Çağlar Onur <caglar@pardus.org.tr>
 Shiraz Hashim <shiraz.linux.kernel@gmail.com> <shiraz.hashim@st.com>
-Shuah Khan <shuah@kernel.org> <shuahkhan@gmail.com> <shuah.khan@hp.com> <shuahkh@osg.samsung.com> <shuah.kh@samsung.com>
+Shuah Khan <shuah@kernel.org> <shuahkhan@gmail.com>
+Shuah Khan <shuah@kernel.org> <shuah.khan@hp.com>
+Shuah Khan <shuah@kernel.org> <shuahkh@osg.samsung.com>
+Shuah Khan <shuah@kernel.org> <shuah.kh@samsung.com>
 Simon Kelley <simon@thekelleys.org.uk>
 Stéphane Witzmann <stephane.witzmann@ubpmes.univ-bpclermont.fr>
 Stephen Hemminger <shemminger@osdl.org>

