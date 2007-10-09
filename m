From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git push (mis ?)behavior
Date: Tue, 9 Oct 2007 09:23:42 +0200
Message-ID: <5C3443FD-DEC3-4EDC-B10B-0C4307EF9492@zib.de>
References: <20070927130447.GH10289@artemis.corp> <7v3awzvrpr.fsf@gitster.siamese.dyndns.org> <9D61974D-E08D-49F6-9C88-6BE446D53C74@zib.de> <7vodfnqndc.fsf@gitster.siamese.dyndns.org> <20071009050533.GA2968@efreet.light.src>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Oct 09 09:23:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If9RD-0001CI-LG
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 09:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbXJIHXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 03:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbXJIHXX
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 03:23:23 -0400
Received: from mailer.zib.de ([130.73.108.11]:49402 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752089AbXJIHXW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 03:23:22 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l997MBfh016055;
	Tue, 9 Oct 2007 09:22:11 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db1f6fc.pool.einsundeins.de [77.177.246.252])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l997M9YO011612
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 9 Oct 2007 09:22:10 +0200 (MEST)
In-Reply-To: <20071009050533.GA2968@efreet.light.src>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60367>


On Oct 9, 2007, at 7:05 AM, Jan Hudec wrote:

> On Fri, Sep 28, 2007 at 00:07:27 -0700, Junio C Hamano wrote:
>> Steffen Prohaska <prohaska@zib.de> writes:
>>
>>> When "remote.<name>.push" is set I'd expect "git push" to
>>> choose only the 'right' remote.<name>.push lines, that is
>>> the lines that have the current branch as the local ref.
>
> I would like this for another reason and maybe in slightly  
> different way.
> Basically I would have configured something along the lines:
>     [remote "origin"]
>     push = refs/heads/*:refs/heads/jahu/*
> and would want to choose, via option, whether I want to push all  
> the branches
> or just the current one, but in any case with the renaming specified.
>
> The idea behind this is to have a shared repository, but not shared  
> branches.
> Everybody would have a subdirectory in refs/heads where he could push
> anything that the others should see and than somebody else (either  
> designated
> integrator, or just anybody different) would do a quick review and  
> merge it
> into master.
>
> Now I could of course push out everything, but usually I'd want to  
> push
> exactly the current branch, renaming it by the rule given, whether  
> it already
> existed in origin or not. Than there can be eg. a post-receive hook  
> notifying
> the integrator that there is something for review.

I had a similar scenario in mind. So a more general question is the  
following:

Git well supports the clone from read-only and push to private repo  
scheme.
In this case all repositories you're pushing to are by definition _your_
repositories. The only question left is, which subset of your  
branches are
pushed. But there's no need for renaming during push.

Now the question is, what is a sensible workflow on a shared repository?

One option is to use some kind of private 'namespace' scheme. For  
example
developers should push their topics to a branch prefixed with their  
name,
or to a 'subdirectory' ref/heads/needsreview/*.

This workflow may require to 'rename' branches during push. So how  
can this
be supported by git?  Supporting only renames that add a prefix, as  
suggested
by Jan, may be reasonable restriction.

	Steffen
