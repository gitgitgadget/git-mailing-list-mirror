From: Andreas Gruenbacher <agruen@suse.de>
Subject: Merge format documented?
Date: Mon, 23 Mar 2009 04:19:49 +0100
Organization: SUSE Labs / Novell
Message-ID: <200903230419.50000.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 04:25:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llan9-0005No-Jd
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 04:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416AbZCWDYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 23:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755398AbZCWDYG
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 23:24:06 -0400
Received: from cantor.suse.de ([195.135.220.2]:37089 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754275AbZCWDYF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 23:24:05 -0400
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id F0EA493608
	for <git@vger.kernel.org>; Mon, 23 Mar 2009 04:24:01 +0100 (CET)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114238>

Hello,

is the format that git normally uses for indicating merge conflicts in files 
(the <<< === >>> markers) documented somewhere?  How exactly does it differ 
from the diff3 format (<<< ||| === >>>)?  Diff3's -m mode seems to come close 
to what git does, except that git doesn't produce the ||| section:

	$ seq 1 7 > a
	$ seq 1 7 | sed -e 's/4/4b/' > b
	$ seq 1 7 | sed -e 's/3/3c/' > c
	$ diff3 -m c a b
	> 1
	> 2
	> <<<<<<< c
	> 3c
	> 4
	> ||||||| a
	> 3
	> 4
	> =======
	> 3
	> 4b
	> >>>>>>> b
	> 5
	> 6
	> 7

Git's output in this case is:

	> 1
	> 2
	> <<<<<<< this-branch
	> 3c
	> 4
	> =======
	> 3
	> 4b
	> >>>>>>> merged-branch
	> 5
	> 6
	> 7

Does git ever output a ||| section?

Thanks,
Andreas
