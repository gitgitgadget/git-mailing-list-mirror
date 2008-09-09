From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Tracking OpenOffice files/other compressed files with Git
Date: Tue, 09 Sep 2008 12:57:32 +0200
Message-ID: <48C6569C.60000@viscovery.net>
References: <Pine.LNX.4.64.0809090715520.19359@ds9.cixit.se> <48C61F94.3060400@viscovery.net> <loom.20080909T085002-376@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sergio <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 12:58:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd0vk-0001uE-4p
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 12:58:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752044AbYIIK5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 06:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751949AbYIIK5g
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 06:57:36 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:43684 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbYIIK5f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 06:57:35 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kd0ua-0006qr-R5; Tue, 09 Sep 2008 12:57:33 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9572B69F; Tue,  9 Sep 2008 12:57:32 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <loom.20080909T085002-376@post.gmane.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95372>

[please reply to all and keep the Cc list.]

Sergio schrieb:
> Johannes Sixt <j.sixt <at> viscovery.net> writes:
> 
>> Peter Krefting schrieb:
>>> Since OpenOffice doucuments are just zipped xml files, I wondered how
>>> difficult it would be to create some hooks/hack git to track the files
>>> inside the archives instead?
>> You could write a "clean" filter that "recompresses" the archive with
>> level 0 upon git-add.
...
> It could be possible to write a clean filter to uncompress before commit.
> However there is a trick with the complementary smudge filter to be used at
> checkout. If you do not smudge properly, git always shows the file as changed
> wrt the index.  Smudging correctly would mean using the very same compression
> ratio and compress method that OO uses, which can be a little tricky. I have
> tried using the zip binary both in the clean and the smudge phases and it does
> not work nicely. The smudged file is always different from the original one. One
> should probably work at a lower level to have a finer control on what is
> happening (libzip) and prepend to the uncompressed file the compression
> parameters to be restored on smudging.

You don't need to smudge the OOo file on checkout iff OOo can read a file
that is "compressed" at level 0.

A file that you have just 'git add'ed must not show up as dirty even if it
was processed by a "clean" filter. If it does, then this indicates a bug
in git, and not that a corresponding "smudge" filter is missing or
misbehaves. Yes, I have observed this with my own "clean" filter some time
ago, but I have not yet tried hard enough to find a reproducible test case.

> The bigger issue is however that the clean/smudge thing can be really slow when
> dealing with large OO files.

True indeed.

-- Hannes
