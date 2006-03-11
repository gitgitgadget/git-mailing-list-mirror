From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: git-diff-tree -M performance regression in 'next'
Date: Sat, 11 Mar 2006 18:28:18 +0100
Message-ID: <20060311172818.GB32609@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Mar 11 18:28:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FI7tM-0001wU-Gk
	for gcvg-git@gmane.org; Sat, 11 Mar 2006 18:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWCKR21 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Mar 2006 12:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbWCKR21
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Mar 2006 12:28:27 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:8584 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1751297AbWCKR21
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Mar 2006 12:28:27 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 2B4A94103; Sat, 11 Mar 2006 18:44:01 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FI7t4-0002C9-00; Sat, 11 Mar 2006 18:28:18 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17503>

Hi,

I added some time logging code to git-merge-recursive to see exactly
what we spend all the time on in merges which involves many changes,
such as a merge of a slightly modified v2.6.12 and an unmodified
v2.6.15.

I turned out that the rename detection took almost 10 minutes on my
machine. More specifically,

   git-diff-tree -r -M --diff-filter=R v2.6.12 v2.6.14

takes ~9 minutes with the current 'next'.

With 65416758cd83772f2f3c69f1bd1f501608e64745, which uses the delta
code to compute the similarity measure, the above git-diff-tree
invocation takes 1.50 minutes.

- Fredrik
