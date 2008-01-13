From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Digging through old vendor code
Date: Sat, 12 Jan 2008 20:41:31 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801122034090.2806@woody.linux-foundation.org>
References: <9e4733910801122009k5658488bx69c04a5cbf7d832a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 13 05:42:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDufm-0005K9-EH
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 05:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282AbYAMElh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 23:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753329AbYAMElh
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 23:41:37 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:46095 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753259AbYAMElg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jan 2008 23:41:36 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0D4fVp9020054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 12 Jan 2008 20:41:33 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0D4fVaU029147;
	Sat, 12 Jan 2008 20:41:31 -0800
In-Reply-To: <9e4733910801122009k5658488bx69c04a5cbf7d832a@mail.gmail.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70368>



On Sat, 12 Jan 2008, Jon Smirl wrote:
>
> I have a file that a vendor has modified. It's a serial driver so I
> know which directory the original file came from. Is there a way to
> ask git to search through all of the past versions of all of the files
> in this directory and give me the top two or three choices as to what
> file the vendor originally copied before staring to edit? This is the
> same problem as picking the best diff base.

Heh. Maybe you could just use the rename logic?

Example of what *might* work:

 - go to the directory in the git tree you think the file came from

 - delete all the files that are *potential* sources (eg "rm *.c")

 - add the new file to that directory

 - commit the end result

 - ask git to find the best rename possibility, using a low rename 
   detection score, something like:

	git show -M1%

(and no, I don't guarantee that that "-M1%" is the right syntax, and in 
general you might well want to play with this concept a bit..)

No guarantees, but it just might work..

		Linus
