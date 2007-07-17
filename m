From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do _not_ call unlink on a directory
Date: Tue, 17 Jul 2007 11:34:55 -0700
Message-ID: <7vlkdeang0.fsf@assigned-by-dhcp.cox.net>
References: <11846059721204-git-send-email-sithglan@stud.uni-erlangen.de>
	<7vtzs3a0xg.fsf@assigned-by-dhcp.cox.net>
	<20070717101527.GB7774@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Tue Jul 17 20:35:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IArt2-0005Ta-Ha
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 20:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752682AbXGQSe6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 14:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754551AbXGQSe6
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 14:34:58 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:60832 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbXGQSe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 14:34:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070717183456.EEZS1393.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 17 Jul 2007 14:34:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Qiaw1X0021kojtg0000000; Tue, 17 Jul 2007 14:34:56 -0400
In-Reply-To: <20070717101527.GB7774@cip.informatik.uni-erlangen.de> (Thomas
	Glanzmann's message of "Tue, 17 Jul 2007 12:15:27 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52787>

Thomas Glanzmann <thomas@glanzmann.de> writes:

>> I wonder if anybody involved in the discussion has actually
>> tested this patch (or the other one, that has the same problem)?
>
> I tested it. But I did not test it with symlinks.
>
>> Does the following replacement work for you?  It adds far more lines
>> than your version, but they are mostly comments to make it clear why
>> we do things this way.
>
> Yes, it does. Excuse the delay but my build machine is not the fastest.
>
> 	(faui04a) [/var/tmp] git clone ~/work/repositories/public/easix.git test-10
> 	Initialized empty Git repository in /var/tmp/test-10/.git/
> 	remote: Generating pack...
> 	remote: Done counting 317 objects.
> 	remote: Deltifying 317 objects...
> 	remote: te: % (317/317) done: ) done
> 	Indexing 317 objects...
> 	remote: Total 317 (delta 182), reused 278 (delta 157)
> 	100% (317/317) done
> 	Resolving 182 deltas...
> 	100% (182/182) done
> 	(faui04a) [/var/tmp] cd test-10
> 	./test-10
> 	(faui04a) [/var/tmp/test-10] git status
> 	# On branch master
> 	nothing to commit (working directory clean)

Ahhhh, by "testing", I meant "runnnig the testsuite shipped with
the source".  Both of your patches were failing in somewhere in
t2000 series of tests.

> I rebased your patch on top of current HEAD (as I can access it on
> git.kernel.org) and removed trailing whitspace from one line (git-apply
> complained)

I am thinking that this fix should go to 'maint' and merged to
'master', as it is a grave problem in at least one setup.
