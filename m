From: jidanni@jidanni.org
Subject: git ls-tree prints wacko file sizes if it can't find the blob
Date: Fri, 02 Jan 2009 07:18:42 +0800
Message-ID: <87eizmty25.fsf_-_@jidanni.org>
References: <20090101192153.GA6536@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 02 00:22:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIWrk-0006P5-80
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 00:22:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754268AbZAAXSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 18:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753863AbZAAXSr
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 18:18:47 -0500
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:40205 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753000AbZAAXSq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jan 2009 18:18:46 -0500
Received: from jidanni.org (122-127-33-68.dynamic.hinet.net [122.127.33.68])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id B4E4AD25E0
	for <git@vger.kernel.org>; Thu,  1 Jan 2009 15:18:44 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104340>

git ls-tree prints wacko file sizes if it can't find the blob:
$ git ls-tree --abbrev=4 -l 76e4
error: unable to find ae832f2245892ddde5221357466448b409775142
100644 blob ae83 3220821896     words

It is even affected by --abbrev:
$ for i in 4 5 40 999; do git ls-tree --abbrev=$i -l 76e4; done 2>&-|
perl -nwale 'print $F[3]'
3214344536
3219092952
3216251688
3217198088
$ git version
git version 1.6.0.6
