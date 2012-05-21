From: mhagger@alum.mit.edu
Subject: [PATCH v2 0/4] Fix some constness errors in fetch-pack
Date: Mon, 21 May 2012 09:59:55 +0200
Message-ID: <1337587199-21099-1-git-send-email-mhagger@alum.mit.edu>
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 21 10:07:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWNeZ-0002Ux-De
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 10:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109Ab2EUIHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 04:07:33 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:50194 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755897Ab2EUIH3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 May 2012 04:07:29 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 May 2012 04:07:29 EDT
X-AuditID: 1207440e-b7f256d0000008c1-23-4fb9f61ae792
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id D6.67.02241.A16F9BF4; Mon, 21 May 2012 04:00:27 -0400 (EDT)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4L80LNv006950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 21 May 2012 04:00:26 -0400
X-Mailer: git-send-email 1.7.10
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsUixO6iqCv9bae/wZYOZouuK91MFg29V5gt
	bq+Yz2zRPeUtowOLx9/3H5g8ds66y+5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGafuWhV8
	Ya04N28iewPjS5YuRk4OCQETiW+H5jJC2GISF+6tZ+ti5OIQErjMKPFh3T1mCOcMk8SNll1g
	HWwCUhIvG3vYQWwRATWJiW2HgOIcHMwCxRKXF5uAhIUF7CXm/dvBCmKzCKhKzO/YC9bKK+Ai
	8f3cZqhl8hJP7/exTWDkXsDIsIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11gvN7NELzWldBMj
	JBj4djC2r5c5xCjAwajEw+s0Y6e/EGtiWXFl7iFGSQ4mJVFe009AIb6k/JTKjMTijPii0pzU
	4kOMEhzMSiK8dx8C5XhTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKErxT
	vwI1ChalpqdWpGXmlCCkmTg4QQQXyAYeoA0JIIW8xQWJucWZ6RBFpxgVpcR5m0ESAiCJjNI8
	uAGwuH3FKA70jzDvUpAqHmDMw3W/AhrMBDQ46AXY4JJEhJRUA6Pq0zvf/lS1srJrFb1dlduw
	mefe01OySk8el01pWXVs4Qdnebs53Dd2/ta/a39loWr3rrCJtYzHzJuao03Y7p3Rllw8odEg
	z6A7IaZpdpRNhtyB7toJd+5deV3YmeesNeGot9uDtLtfVBaGPDiam+1b4R5z7s+sP2VrI3ae
	PLnz/yWlJ/fLJ/1UYinOSDTUYi4qTgQAKmB/K7YCAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198090>

From: Michael Haggerty <mhagger@alum.mit.edu>

Fix some constness errors that I noticed while reading the code in
builtin/fetch-pack.c.

This version differs from v1 as follows:

* cmd_fetch_pack() is not made to free the memory that it allocates.

* The second patch is broken into separate pieces to make each piece
  more readable.

Michael Haggerty (4):
  cmd_fetch_pack(): declare dest to be const
  cmd_fetch_pack(): handle non-option arguments outside of the loop
  cmd_fetch_pack(): combine the loop termination conditions
  cmd_fetch_pack(): respect constness of argv parameter

 builtin/fetch-pack.c |  145 ++++++++++++++++++++++++--------------------------
 1 file changed, 71 insertions(+), 74 deletions(-)

-- 
1.7.10
