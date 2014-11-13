From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Git archiving only branch work
Date: Thu, 13 Nov 2014 14:19:37 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.02.1411131416010.8007@perkele.intern.softwolves.pp.se>
References: <5464a4e8.4a0.2bfa0e00.3067f800@geldenhuys.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <mailinglists@geldenhuys.co.uk>
X-From: git-owner@vger.kernel.org Thu Nov 13 14:36:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XouZA-0007kt-51
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 14:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933065AbaKMNfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 08:35:07 -0500
Received: from cm-84.215.100.88.getinternet.no ([84.215.100.88]:39781 "EHLO
	perkele.intern.softwolves.pp.se" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S933032AbaKMNfG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Nov 2014 08:35:06 -0500
X-Greylist: delayed 923 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Nov 2014 08:35:06 EST
Received: from peter (helo=localhost)
	by perkele.intern.softwolves.pp.se with local-esmtp (Exim 4.80)
	(envelope-from <peter@softwolves.pp.se>)
	id 1XouJF-0002JH-Lt; Thu, 13 Nov 2014 14:19:37 +0100
In-Reply-To: <5464a4e8.4a0.2bfa0e00.3067f800@geldenhuys.co.uk>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Graeme Geldenhuys:

> This works very well. The only problem we have so far is that if we have 
> files with spaces in the name (eg: SQL update scripts), then the command 
> breaks.

If you add -z to the git diff command-line, it will give you the names 
with nul terminators instead. If you couple that with xargs -0, you 
should be able to do something like this (untested):

deply = !sh -c 'git diff --name-only -z -D $2 | xargs -x -0 git archive --prefix=$1/ -o 
deploy_$1.zip HEAD'

-- 
\\// Peter - http://www.softwolves.pp.se/
