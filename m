From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: I don't want the .git directory next to my code.
Date: Wed, 16 Jan 2008 10:25:20 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801161019250.2806@woody.linux-foundation.org>
References: <478D79BD.7060006@talkingspider.com> <86hcheig3n.fsf@blue.stonehenge.com> <478D82FA.2030404@talkingspider.com> <478D95D8.5040806@theory.org> <478E3D8E.1090300@talkingspider.com> <alpine.LFD.1.00.0801161000310.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Neil Macneale <mac4-git@theory.org>, git@vger.kernel.org
To: Mike <fromlists@talkingspider.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 19:26:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFCxx-0001a8-5G
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 19:26:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811AbYAPSZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 13:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752602AbYAPSZv
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 13:25:51 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53178 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752524AbYAPSZu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 13:25:50 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0GIPK9H016178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Jan 2008 10:25:21 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0GIPKi1017658;
	Wed, 16 Jan 2008 10:25:20 -0800
In-Reply-To: <alpine.LFD.1.00.0801161000310.2806@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.717 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70715>



On Wed, 16 Jan 2008, Linus Torvalds wrote:
> 
>    Yes, it's certainly quite possible that you simply don't have any 
>    management scripts etc, and that you don't generate any files, and you 
>    simply want to just deploy the exact files that you also want to track. 
>    But that really is a fairly unusual thing to do.

Example management scripts: let's say that you have a logo that shows up 
in multiple different sizes. You can just have it as <n> number of 
different files that you check in and update separately, or you can have 
it as *one* scalable master file, and then the deployment script will 
create all the generated files and put them in the deployment area.

So the common issue with SCM's is that you want to share two totally 
different things:

 - the actual "source" (which obviously doesn't have to be source code per 
   se), which is the thing you want to have for yourself and people you 
   work with, and which you want the history of.

 - the "output" for external entities, which may often contain a lot of 
   the "source" verbatim, but quite often doesn't contain it all (some of 
   the stuff you need to manage things may be rather private and purely 
   for *your* management info), and almost invariably contains some 
   post-processing.

Some people don't split this up, and they tend to make horrible horrible 
mistakes, like checking in the *results* of the post-processing too (ie 
binary result blobs that can be regenerated from the other files), because 
they don't make a clear separation between the parts they do development 
on, and the end result.

			Linus
