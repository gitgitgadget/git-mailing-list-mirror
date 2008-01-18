From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 16:35:19 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801171626470.2957@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
 <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org>
 <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org>
 <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <9BA6785F-A715-4F5C-B192-96471243FE20@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pedro Melo <melo@simplicidade.org>, Mark Junker <mjscod@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 01:35:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFfDC-0003Dq-3r
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 01:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757935AbYARAf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 19:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757803AbYARAf1
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 19:35:27 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47788 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757630AbYARAf0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jan 2008 19:35:26 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0I0ZK4v007171
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Jan 2008 16:35:21 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0I0ZJHT022319;
	Thu, 17 Jan 2008 16:35:19 -0800
In-Reply-To: <9BA6785F-A715-4F5C-B192-96471243FE20@sb.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.716 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70941>



On Thu, 17 Jan 2008, Kevin Ballard wrote:
> 
> I just don't understand why you insist that the filename is data, when it is
> clearly metadata.

Uhh. And exactly how do you know the difference, and why should it matter?

A lot of data is metadata. Look at the git index file. It's *all* 
metadata. Does that mean that the OS has the right to corrupt it?

IOW, why do you seem to argue that metadata something you can corrupt, but 
not then "regular" data?

Why is it ok to change a filename, when that same filename may *also* be 
encoded by the user in a regular data file (think about MD5SUM files, for 
example, that include the pathname, but now the pathname is part of the 
file data, not on a filesystem). 

So filenames are data, they're metadata, they're whatever. None of that 
means that it's acceptable to corrupt them, or gives the OS any reason to 
say that it "knows better" than the user in how users use them. It's still 
the *users* metadata, not the filesystems own metadata!

In many cases, users use filenames *as* data, ie the filename actually has 
a meaning in itself, not just as a handle to get the file contents.

If this was truly metadata that isn't visible to the user, and not under 
the users control (ie indirect block numbers etc), then you'd have a good 
point. At that point, it's obviously entirely up to the filesystem how the 
heck it encodes it.

But that's not what filenames are. Filenames are an index specified by the 
user, not by the computer. 

		Linus
