From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: [PATCH/RFC v1 1/1] +5 cases (4 fail), diff whitespace tests
Date: Sun, 18 Jan 2009 11:25:54 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0901181106150.5969@kiwi.cs.ucla.edu>
References: <alpine.GSO.2.00.0901141633030.9831@kiwi.cs.ucla.edu> <7vd4elys21.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 18 20:27:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOdIu-0005hd-OJ
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 20:27:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753355AbZART0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 14:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753180AbZART0E
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 14:26:04 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:34037 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752897AbZART0D (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 14:26:03 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n0IJPuZ6006342;
	Sun, 18 Jan 2009 11:25:56 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n0IJPsQH006339;
	Sun, 18 Jan 2009 11:25:54 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <7vd4elys21.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106265>

On Sat, 17 Jan 2009, Junio C Hamano wrote:

> Hmm.  Are these three supposed to be orthogonal?

The semantics of those 3 flags are not orthogonal, no.  Their relationship 
amongst each other is one of transitive implication:

-w                    implies the other two
-b                    implies --ignore-space-at-eol
--ignore-space-at-eol implies only itself

Therefore, it is never *necessary* to specify more than one of these flags on 
the command line.  However, it is not hard to imagine scenarios where software 
wrappers around git (e.g. GUIs, etc), generate command lines with more than one 
of these flags.  I thought about it, and it seems unreasonable to make it an 
error to specify more than one, since a new user might not immediately grasp the 
way they imply each other.  I think Git could and should treat it as a legal 
case.  I contacted Dscho about fixing it, but he is busy so I will submit a fix 
patch myself.
