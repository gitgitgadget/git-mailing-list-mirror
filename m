From: "Luck, Tony" <tony.luck@intel.com>
Subject: git checkout -f branch doesn't remove extra files
Date: Fri, 12 Aug 2005 10:31:17 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F04214AC7@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-From: git-owner@vger.kernel.org Fri Aug 12 19:32:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3dNm-0006k8-HE
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 19:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVHLRbf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 13:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbVHLRbf
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 13:31:35 -0400
Received: from fmr14.intel.com ([192.55.52.68]:7814 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750748AbVHLRbe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2005 13:31:34 -0400
Received: from fmsfmr101.fm.intel.com (fmsfmr101.fm.intel.com [10.253.24.21])
	by fmsfmr002.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j7CHVOfg013129
	for <git@vger.kernel.org>; Fri, 12 Aug 2005 17:31:24 GMT
Received: from fmsmsxvs043.fm.intel.com (fmsmsxvs043.fm.intel.com [132.233.42.129])
	by fmsfmr101.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id j7CHVJpc025351
	for <git@vger.kernel.org>; Fri, 12 Aug 2005 17:31:22 GMT
Received: from fmsmsx332.amr.corp.intel.com ([132.233.42.148])
 by fmsmsxvs043.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2005081210311823394
 for <git@vger.kernel.org>; Fri, 12 Aug 2005 10:31:18 -0700
Received: from fmsmsx312.amr.corp.intel.com ([132.233.42.227]) by fmsmsx332.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 12 Aug 2005 10:31:19 -0700
Received: from scsmsx401.amr.corp.intel.com ([10.3.90.12]) by fmsmsx312.amr.corp.intel.com with Microsoft SMTPSVC(6.0.3790.211);
	 Fri, 12 Aug 2005 10:31:18 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git checkout -f branch doesn't remove extra files
Thread-Index: AcWfY6VeYIPCbtCjT62AGqMcvEoKoQ==
To: <git@vger.kernel.org>
X-OriginalArrivalTime: 12 Aug 2005 17:31:18.0923 (UTC) FILETIME=[A6388DB0:01C59F63]
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I've just got around to noticing some of the new (to
me) features in git, and started experimenting with
branches.

I see that when I switch view to a different
branch with:

	$ git checkout -f someoldbranch

that any files that exist in my previous branch view
but not in "someoldbranch" are not deleted.  I can
find and remove them easily with:

	$ git-ls-files --others | xargs rm -f

but I wondered whether this was a deliberate choice
(to avoid clobbering .o files etc. for people who
have run a make in their tree).

Currently git-ls-files doesn't have a way to specify
a branch ... but it it did, the something like:

	comm -1 <(git-ls-files -b oldbranch) \
		  <(git-ls-files -b newbranch) | xargs rm -f

would clean up the spurious files.

-Tony
