From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [SoC RFC] libsvn-fs-git: A git backend for the subversion
 filesystem
Date: Thu, 20 Mar 2008 09:22:58 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0803200910410.21580@reaper.quantumfyre.co.uk>
References: <3e8340490803182108y40a9aec2q8e5bcb78b907bbb5@mail.gmail.com>
 <20080320045632.GB8410@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Bryan Donlan <bdonlan@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 10:24:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcH0r-0006yP-Q7
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 10:24:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372AbYCTJXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 05:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752765AbYCTJXv
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 05:23:51 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:46110 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751984AbYCTJXu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Mar 2008 05:23:50 -0400
Received: from neutron.quantumfyre.co.uk (neutron.datavampyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 1D8BF79C6D3
	for <git@vger.kernel.org>; Thu, 20 Mar 2008 09:23:49 +0000 (GMT)
Received: (qmail 21656 invoked by uid 103); 20 Mar 2008 09:22:58 +0000
Received: from 212.159.54.234 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.030247 secs); 20 Mar 2008 09:22:58 -0000
Received: from darkphoton.datavampyre.co.uk (212.159.54.234)
  by neutron.datavampyre.co.uk with SMTP; 20 Mar 2008 09:22:57 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <20080320045632.GB8410@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77645>

On Thu, 20 Mar 2008, Shawn O. Pearce wrote:

> Bryan Donlan <bdonlan@gmail.com> wrote:
>> I'm planning to apply for the git summer of code project. My proposal
>> is based on the project idea of a subversion gateway for git,
>> implemented with a new subversion filesystem layer. A draft of my
>> proposal follows; I'd appreciate any comments/questions on it before
>> the application period proper begins.
>
> Very cool.  Have you had a chance to look at the prototype python
> implementation of an SVN server that Julian Phillips started?
>
>  http://git.q42.co.uk/w/git_svn_server.git

(now with partial support for 'svn log' ... ;))

>> /props/{trunk/,branches/,tags/} - file properties; props on directories will be
>>   represented with a reserved filename (._GIT-SVN-DIRPROPS perhaps)
>>   copyfrom information might be in /props, or in a seperate tree
>
> How critical are file properties to an SVN client for proper
> functioning?  Given the challenges already in front of you for this
> project I would almost encourage you to avoid dealing with file
> level properties.  Its hard enough to make something that speaks SVN
> on the wire but reads/writes Git on disk, not to mention you have
> to somehow "flatten" the Git DAG down into a sequential revision
> namespace to make the SVN clients happy.  So deferring property
> support until later may be wise.

You might need to get svn:eol-style working to prevent the svn client from 
munging any binary files?  Can't think of any other vital properties atm.

>> /revprops/NNN - revision properties for the given revision number
>
> Ditto.  Aside from the special merge properties you mentioned,
> I wonder if you can simply avoid implementing support for these
> early on.

Since you have to explicitly enable revprop editing in the subversion 
repository by enabling a hook script, I should think that this was 
definately something that could be left at the bottom of the TODO list ...

Though you do need to be able to convert commit info into the appropriate 
revprops (e.g. commit msg -> svn:log revprop)

-- 
Julian

  ---
Often statistics are used as a drunken man uses lampposts -- for support
rather than illumination.
