From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Git on Windows, CRLF issues
Date: Tue, 22 Apr 2008 11:04:26 +0200
Message-ID: <480DAA1A.10507@viscovery.net>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se> <m3bq42ri56.fsf@localhost.localdomain> <Pine.LNX.4.64.0804220749080.22731@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Apr 22 11:06:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoERH-0004dA-9n
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 11:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762320AbYDVJEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 05:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762224AbYDVJEg
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 05:04:36 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:50192 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761661AbYDVJEe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 05:04:34 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JoEQM-0005mN-Iz; Tue, 22 Apr 2008 11:04:33 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 53D9E6C4; Tue, 22 Apr 2008 11:04:26 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <Pine.LNX.4.64.0804220749080.22731@ds9.cixit.se>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80083>

Peter Karlsson schrieb:
> Jakub Narebski:
> 
>> I think you can, by unsetting `crlf` attribute, i.e. putting the
>> following in .gitattributes:
>>
>>    * -crlf
> 
> Yeah, that does indeed seem to work, no matter how core.autocrlf is
> configured globally. I think this is the best way to go for the
> repositories I am working on (as they are very much DOS/Windows-only).
> 
> Does anyone know how to hack an existing repository so that I can add
> such a .gitattributes file to all commits? I've tried reading the
> git-filter-branch manual page a few times, but I am still confused by
> it.

Something like (untested, using bash):

X=$(echo "* -crlf" | git hash-object -w --stdin)
git filter-branch \
	--index-filter $'git-update-index --index-info <<< \
				"100644 $X\t.gitattributes"' \
	-- --all

-- Hannes
