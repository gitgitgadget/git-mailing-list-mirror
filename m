From: Andreas Ericsson <ae@op5.se>
Subject: Re: Making submodules easier to work with (auto-update on checkout
 or merge, stash & restore submodules)
Date: Wed, 30 Apr 2008 08:14:05 +0200
Message-ID: <48180E2D.6020907@op5.se>
References: <8B885217-8C18-417E-8F11-BB6661792CD3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Tim Harper <timcharper@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 08:15:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr5au-0006Ru-1X
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 08:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759470AbYD3GOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2008 02:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758568AbYD3GOL
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Apr 2008 02:14:11 -0400
Received: from mail.op5.se ([193.201.96.20]:52090 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756177AbYD3GOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2008 02:14:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 7AB271F08038;
	Wed, 30 Apr 2008 08:14:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ym2iYK+UH7N3; Wed, 30 Apr 2008 08:14:15 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id 2C7FD1F0801D;
	Wed, 30 Apr 2008 08:14:15 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <8B885217-8C18-417E-8F11-BB6661792CD3@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80798>

Tim Harper wrote:
> OVERVIEW:
> On the Git TextMate Bundle, I've automated a lot of the submodule 
> commands to make them not a terrible pain to work with. (don't get me 
> wrong - I really like the git submodule implementation, I just don't 
> like how hard it is to work with).
> 
> "WARTS" WITH EXISTING IMPLEMENTATION
> 1) The submodule stays in the working copy when changing to a branch 
> that does not have a submodule.  This can break a build and cause 
> problems.  To work around, I have to delete the folder completely 
> (git-clean).  Then, when I switch back to the branch again, I have to 
> re-download the submodule.
> 2) I have to type "git checkout branch && git submodule init && git 
> submodule update" to be sure that I really have the whole contents of 
> the branch.  That's 3 commands, and a lot of typing.
> 3) If I don't run "git submodule update", and carelessly run "git commit 
> -a" or "git add .", I risk propagating a submodule version from another 
> branch or undoing an important change.
> 
> SUGGESTED ALGORITHM (AS HAS BEEN IMPLEMENTED IN THE GIT TEXTMATE BUNDLE)
> When pulling / merging / changing branches:
> 1) cache all submodules to ~/.git/submodules_cache
>    a) move from the working directory to a folder that is a MD5 hex-hash 
> of both the submodule path and the submodule url
> 2) execute the pull / merge / branch change
> 3) restore all defined submodules to ~/.git/submodules_cache (only the 
> submodules that are still defined after the merge / change / pull)
> 4) execute git submodule init && git submodule update
> 
> 
> PITFALLS:
> pitfall)
> If you commit a change on a submodule that's not on a branch, 
> auto-updating submodules will make it difficult to revive that change.
> 
> workaround)
> Don't allow the user to commit unless they are on a branch.
> 
> ... couldn't think of anymore.  Anyone?
> 
> CONCLUSION
> So far, this algorithm holds up well in my use cases, and has made 
> submodule management seamless for me (I don't have to know that I'm 
> working with submodules).  It's resolved every one of the above outlined 
> interface warts.
> 
> Would it be a good idea to build this algorithm into git?  What would be 
> the best approach?  Am I completely overlooking something by designing 
> the Git TextMate bundle to handle submodules this way?
> 

I don't use submodules at the moment, but I have several "lib-ish" pieces
of code that would benefit greatly from becoming submodules. The not-exactly
seamlessness of them has so far been a hindrance though, but it sounds as
if your changes (assuming they don't affect anything else) should make lessen
the submodule headaches somewhat.

So, where be the patches?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
