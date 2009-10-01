From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: gitignore: how to exclude a directory tree from being ignored
Date: Thu, 01 Oct 2009 14:39:44 +0200
Message-ID: <4AC4A310.8000507@viscovery.net>
References: <4AC48D5F.6060401@mycircuit.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter <vmail@mycircuit.org>
X-From: git-owner@vger.kernel.org Thu Oct 01 14:43:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtKwr-0003OT-8y
	for gcvg-git-2@lo.gmane.org; Thu, 01 Oct 2009 14:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbZJAMjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2009 08:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756544AbZJAMjn
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Oct 2009 08:39:43 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:32020 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756543AbZJAMjn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2009 08:39:43 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MtKwj-0006MB-0l; Thu, 01 Oct 2009 14:39:45 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B6BDC9614; Thu,  1 Oct 2009 14:39:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4AC48D5F.6060401@mycircuit.org>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129390>

Peter schrieb:
> Hi
> I want to exclude binaries except in a dir tree that I do not control.
> 
> In .gitignore  I have:
> 
> 
> I would expect that all *.exe and *.o are ignored except those somewhere
> in the vendor dir tree.
> However, the *.exe and *.o in the vendor dir tree are also ignored.

This works for me:

 *.exe
 *.o
 !vendor/*.exe
 !vendor/*.o

Note that git-status does not descend into directories from which no files
are tracked. Therefore, this will work only after you have git-added at
least one file from vendor/.

git ls-files -o --exclude-standard does descend into the directory.

Furthermore, the !vendor/*.exe patterns are not recursive. Perhaps it is
easier for you to have a separate vendor/.gitignore that has:

 !*.exe
 !*.o

These _are_ recursive.

-- Hannes
