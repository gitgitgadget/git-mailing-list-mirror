From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Feature request: show branches in interactive commit
Date: Thu, 28 Jun 2012 10:53:57 +0200
Message-ID: <4FEC1BA5.8030307@viscovery.net>
References: <fd93774cb5ed6d4dee090eb2b0be952e.squirrel@webmail.hitco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Philipp Marek <philipp@marek.priv.at>
X-From: git-owner@vger.kernel.org Thu Jun 28 10:54:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkAUS-0003Gk-7r
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 10:54:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633Ab2F1IyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jun 2012 04:54:05 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:59269 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932133Ab2F1IyC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2012 04:54:02 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SkAVW-0007Q6-Iv; Thu, 28 Jun 2012 10:55:22 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A65611660F;
	Thu, 28 Jun 2012 10:53:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <fd93774cb5ed6d4dee090eb2b0be952e.squirrel@webmail.hitco.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200784>

Am 6/28/2012 9:54, schrieb Philipp Marek:
> Say that "123458" is a commit with "branch1" associated; then I'd hope for output like
> 
>     pick 123456 ...
>     pick 123457 ...
>     pick 123458 ...
>     #x git branch "branch1" --force # move the branch?
>     pick 123459 ...
>     pick 12345a ...
> 
> I have a few feature branches that are stacked upon each other; when moving a commit
> "down" to the release-branch I'd like to have the other branches at the matching "new"
> commit.
> 
> Of course I can simply fix up the "rebase" output in my editor - but I guess that might
> help a few people, that's why I'm proposing it here.

I happen to have one such topic branch stack myself that I carry around
since a while. But the implementation must be a bit smarter: What should
happen if you --abort after e.g. 123459 was picked?

I used this scheme sometimes:

     pick 123456 ...
     pick 123457 ...
     pick 123458 ...
     x git rev-parse HEAD >sha1
     pick 123459 ...
     pick 12345a ...
     x git branch --force "branch1" $(cat sha1)

Granted, an indication where the topic branch heads would have to go in
the todo list, as you suggest, would be nice first step.

-- Hannes
