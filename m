From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Tue, 13 Nov 2007 14:50:49 -0500
Message-ID: <CBAEC42B-9F50-4723-9847-640D9832532E@silverinsanity.com>
References: <Pine.LNX.4.64.0711121715090.4362@racer.site> <18232.35893.243300.179076@lisa.zopyra.com> <Pine.LNX.4.64.0711121727130.4362@racer.site> <vpq7iknqrtp.fsf@bauges.imag.fr> <Pine.LNX.4.64.0711121755460.4362@racer.site> <vpqy7d3pck0.fsf@bauges.imag.fr> <Pine.LNX.4.64.0711121804400.4362@racer.site> <vpqoddzpc88.fsf@bauges.imag.fr> <7v4pfr2kmh.fsf@gitster.siamese.dyndns.org> <vpqzlxiiii6.fsf@bauges.imag.fr> <20071113100209.GE14735@spearce.org> <vpqpryefmhj.fsf@bauges.imag.fr>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Nov 13 20:51:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is1n2-0004NM-9x
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 20:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755640AbXKMTux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 14:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753663AbXKMTux
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 14:50:53 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:51064 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbXKMTuw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 14:50:52 -0500
Received: from [192.168.1.5] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 9E32E1FFC230;
	Tue, 13 Nov 2007 19:50:50 +0000 (UTC)
In-Reply-To: <vpqpryefmhj.fsf@bauges.imag.fr>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64842>


On Nov 13, 2007, at 5:50 AM, Matthieu Moy wrote:

> While clone normally does a bit more:
>
> [remote "origin"]
>        url = /tmp/git1/.git
>        fetch = +refs/heads/*:refs/remotes/origin/*
> [branch "master"]
>        remote = origin
>        merge = refs/heads/master

But how is clone expected to do that when the origin is an empty  
repo?  There is no branch for it to track, and automagically setting  
it to master is bogus because then it's tracking something that  
doesn't exist.

The easy way to set up the last bit is "git checkout -b master --track  
origin/master".  But that won't work if origin/master doesn't exist.   
The following will always work:

git config branch.master.remote origin
git config branch.master.merge refs/heads/master

But asking git-clone do do this sort of odd magic for an empty repo is  
dubious at best.  Perhaps convenient for your situation, but creates  
repos that don't actually work.  (Will give errors when trying to  
merge a non-existent branch, at the very least.)

~~ Brian
