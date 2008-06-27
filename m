From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Using url.insteadOf in git-clone
Date: Fri, 27 Jun 2008 11:35:02 +0200
Message-ID: <27C25D70-0BFC-4362-A771-C7CAD89BC198@ai.rug.nl>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 27 11:36:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCANA-0007uE-CT
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 11:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbYF0JfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 05:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbYF0JfH
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 05:35:07 -0400
Received: from smtp-4.orange.nl ([193.252.22.249]:4276 "EHLO smtp-4.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979AbYF0JfG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 05:35:06 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6306.online.nl (SMTP Server) with ESMTP id 89B0D7000087;
	Fri, 27 Jun 2008 11:35:04 +0200 (CEST)
Received: from [192.168.1.11] (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6306.online.nl (SMTP Server) with ESMTP id 248667000081;
	Fri, 27 Jun 2008 11:35:03 +0200 (CEST)
X-ME-UUID: 20080627093504149.248667000081@mwinf6306.online.nl
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86537>

Hi,

I sometimes use url.insteadOf to create a shortcut to a central  
repository.
For example, having something like[*1*]

[url "git://repo.or.cz/git/"]
	insteadOf = "repo:"

in my global gitconfig allows me to do a 'git fetch repo:dscho.git'.  
I'd also
like to use that with git clone :). Currently if I try that, I get

Vienna:~ pieter$ git clone repo:dscho.git
Initialize dscho/.git
Initialized empty Git repository in /Users/pieter/dscho/.git/
ssh: Error resolving hostname repo: nodename nor servname provided, or  
not known
fatal: The remote end hung up unexpectedly

Which I think comes from the fact that the global config isn't read in  
by
remote.c when running git clone.

Now, I seem to remember there was a good reason for this (both builtin- 
clone
and git-clone.sh have the same behaviour). Also, trying to quickly  
hack in
something failed for me, even though it seems like a trivial change to  
make
for someone more familiar with the code path.

Is there an easy fix for this?

- Pieter

[1] This is not really true. If I try that, I get an error:
Vienna:git pieter$ git fetch -v repo:dscho.git
fatal: I don't handle protocol 'it'

If I change the url to "ggit://.." it does work. It seems there is an  
off-by-one
error somewhere? It does work for another url.insteadOf I have in my  
global
config though..
