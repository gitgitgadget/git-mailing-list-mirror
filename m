From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [RFC/PATCH 1/1] format-patch: add an option to record base tree
 info
Date: Tue, 23 Feb 2016 16:31:35 +0300
Message-ID: <20160223133135.GF5273@mwanda>
References: <1456109938-8568-1-git-send-email-xiaolong.ye@intel.com>
 <1456109938-8568-2-git-send-email-xiaolong.ye@intel.com>
 <xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com>
 <20160223014741.GA21025@wfg-t540p.sh.intel.com>
 <xmqqio1f3oi9.fsf@gitster.mtv.corp.google.com>
 <20160223091740.GA3830@wfg-t540p.sh.intel.com>
 <20160223103253.GE5273@mwanda>
 <20160223120015.GA10488@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Xiaolong Ye <xiaolong.ye@intel.com>, git@vger.kernel.org,
	ying.huang@intel.com, philip.li@intel.com, julie.du@intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Christoph Hellwig <hch@lst.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	LKML <linux-kernel@vger.kernel.org>
To: Fengguang Wu <fengguang.wu@intel.com>
X-From: linux-kernel-owner@vger.kernel.org Tue Feb 23 14:32:03 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aYD4K-0006my-1Y
	for glk-linux-kernel-3@plane.gmane.org; Tue, 23 Feb 2016 14:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbcBWNbu (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 23 Feb 2016 08:31:50 -0500
Received: from aserp1040.oracle.com ([141.146.126.69]:27116 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbcBWNbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Feb 2016 08:31:48 -0500
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u1NDVgMV026483
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Feb 2016 13:31:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by userv0022.oracle.com (8.14.4/8.13.8) with ESMTP id u1NDVf86030270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
	Tue, 23 Feb 2016 13:31:42 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id u1NDVfub005264;
	Tue, 23 Feb 2016 13:31:41 GMT
Received: from mwanda (/154.0.139.178)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Tue, 23 Feb 2016 05:31:39 -0800
Content-Disposition: inline
In-Reply-To: <20160223120015.GA10488@wfg-t540p.sh.intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Source-IP: userv0022.oracle.com [156.151.31.74]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287051>

Blergh...  You want it machine readable and I want it human readable.  I
don't care so much about the cover letter but for the first patch then I
really want something minimal (one line) and human readable.

base tree/branch: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
base commit: afd2ff9b7e1b367172f18ba7f693dfb62bdcb2dc
base patch-id: a849260a843115dbac4b1a330d44256ee6b16d7b
base patch-subject: Linux 4.4
base tag: v4.4

To me that looks like an unparseable wall of text.  My version of that
is:

Applies-to: afd2ff9b7e1b+ origin

As a human all I really want to know is the tree to apply this to.  If
it doesn't apply then I don't debug it, I just send an automatic note
"This doesn't apply to staging-next.  Please redo."

I think that Applies-to is a better name and also that grepping for
"^base " is less reliable than grepping for ^Applies-to.

I used "origin" because that's the name in Next/Trees.  The + means
private patches are applied.  That's what we already do in naming the
kernel.  If the + matters, then I would include a cover letter.

I have no idea what a "base patch-id" is so that doesn't work at all.

Including the tag is just duplicative since we already have the hash.

In my email, I proposed that we list all the other private patches in a
cover letter, but I think you are saying that we only need to know the
most recent private patch?  Another idea would be to list them newest
to oldest (git log order instead of email order) in the cover letter.

Btw, I always work against linux-next and Dave M is always getting
annoyed with me for not marking which patches go to net and which go to
net-next.  I don't use git format-patch, but I will probably start using
"Applies-to: net" or "Applies-to: net-next".

regards,
dan carpenter
