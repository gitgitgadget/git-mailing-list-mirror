From: David Abrahams <dave@boostpro.com>
Subject: Re: "malloc failed"
Date: Wed, 28 Jan 2009 13:53:49 -0800
Organization: Boostpro Computing
Message-ID: <c26bbb3fe074f6f6e0634a4ae8611239@206.71.190.141>
References: <878wow7pth.fsf@mcbain.luannocracy.com> <20090128050225.GA18546@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 28 23:06:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSIXx-0007It-GA
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 23:06:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904AbZA1WEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 17:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752712AbZA1WEi
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 17:04:38 -0500
Received: from boost-consulting.com ([206.71.190.141]:52941 "EHLO
	boost-consulting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbZA1WEh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 17:04:37 -0500
Received: by boost-consulting.com (Postfix, from userid 80)
	id 95F1E1CC1F; Wed, 28 Jan 2009 13:53:49 -0800 (PST)
In-Reply-To: <20090128050225.GA18546@coredump.intra.peff.net>
X-Sender: dave@boostpro.com
User-Agent: RoundCube Webmail/0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107586>


On Wed, 28 Jan 2009 00:02:25 -0500, Jeff King <peff@peff.net> wrote:

> On Tue, Jan 27, 2009 at 10:04:42AM -0500, David Abrahams wrote:

> 

>> I've been abusing Git for a purpose it wasn't intended to serve:

>> archiving a large number of files with many duplicates and

>> near-duplicates.  Every once in a while, when trying to do something

>> really big, it tells me "malloc failed" and bails out (I think it's

>> during "git add" but because of the way I issued the commands I can't

>> tell: it could have been a commit or a gc).  This is on a 64-bit linux

>> machine with 8G of ram and plenty of swap space, so I'm surprised.

>> 

>> Git is doing an amazing job at archiving and compressing all this stuff

>> I'm putting in it, but I have to do it a wee bit at a time or it craps

>> out.  Bug?

> 

> How big is the repository? How big are the biggest files? I have a

> 3.5G repo with files ranging from a few bytes to about 180M. I've never

> run into malloc problems or gone into swap on my measly 1G box.

> How does your dataset compare?



I'll try to do some research.  Gotta go pick up my boy now...



> As others have mentioned, git wasn't really designed specifically for

> those sorts of numbers, but in the interests of performance, I find git

> is usually pretty careful about not keeping too much useless stuff in

> memory at one time.  And the fact that you can perform the same

> operation a little bit at a time and achieve success implies to me there

> might be a leak or some silly behavior that can be fixed.

> 

> It would help a lot if we knew the operation that was causing the

> problem. Can you try to isolate the failed command next time it happens?



root@recovery:/olympic/deuce/review# ulimit -v

unlimited

root@recovery:/olympic/deuce/review# git add hydra.bak/home-dave

fatal: Out of memory, malloc failed





The process never even gets close to my total installed RAM size, much less

my whole VM space size.



-- 

David Abrahams

Boostpro Computing

http://www.boostpro.com
