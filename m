From: Tommy Nordgren <tommy.nordgren@comhem.se>
Subject: Re: [ANNOUNCE] GIT 1.6.4.rc1
Date: Thu, 16 Jul 2009 05:51:48 +0200
Message-ID: <057D2A1F-0383-4AE4-A431-54D6C1F90D85@comhem.se>
References: <7vmy75bg2f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 05:52:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRI0s-0008Uk-5i
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 05:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757380AbZGPDv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 23:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757368AbZGPDv6
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 23:51:58 -0400
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:58564 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757345AbZGPDv5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jul 2009 23:51:57 -0400
Received: from c213-89-136-212.bredband.comhem.se ([213.89.136.212]:34004 helo=[192.168.0.4])
	by ch-smtp02.sth.basefarm.net with esmtp (Exim 4.69)
	(envelope-from <tommy.nordgren@comhem.se>)
	id 1MRI0f-0006hf-8z; Thu, 16 Jul 2009 05:51:55 +0200
In-Reply-To: <7vmy75bg2f.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.935.3)
X-Originating-IP: 213.89.136.212
X-Scan-Result: No virus found in message 1MRI0f-0006hf-8z.
X-Scan-Signature: ch-smtp02.sth.basefarm.net 1MRI0f-0006hf-8z e244be2601cb3d529ef8f6f4b2e558ad
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123359>

Testing a build of this version fails at a late stage, with an error  
that aborts testing.
My system is Mac OS X 10.5.8
Fragment of output at failure:
*** t9200-git-cvsexportcommit.sh ***
*   ok 1: New file
..snip
* FAIL 14: re-commit a removed filename which remains in CVS attic
	
	
	    (cd "$CVSWORK" &&
	     echo >attic_gremlin &&
	     cvs -Q add attic_gremlin &&
	     cvs -Q ci -m "added attic_gremlin" &&
	     rm attic_gremlin &&
	     cvs -Q rm attic_gremlin &&
	     cvs -Q ci -m "removed attic_gremlin") &&
	
	    echo > attic_gremlin &&
	    git add attic_gremlin &&
	    git commit -m "Added attic_gremlin" &&
		git cvsexportcommit -w "$CVSWORK" -c HEAD &&
	    (cd "$CVSWORK"; cvs -Q update -d) &&
	    test -f "$CVSWORK/attic_gremlin"
	
* failed 1 among 14 test(s)

On Jul 16, 2009, at 2:57 AM, Junio C Hamano wrote:

> A release candidate GIT 1.6.4.rc1 is available at the usual places
> for testing:
>
>  http://www.kernel.org/pub/software/scm/git/
>
>  git-1.6.4.rc1.tar.{gz,bz2}			(source tarball)
>  git-htmldocs-1.6.4.rc1.tar.{gz,bz2}		(preformatted docs)
>  git-manpages-1.6.4.rc1.tar.{gz,bz2}		(preformatted docs)
>
> The RPM binary packages for a few architectures are found in:
>
>  testing/git-*-1.6.4.rc1-1.fc9.$arch.rpm	(RPM)
>
> GIT v1.6.4 Release Notes (draft)
> ================================
>
> With the next major release, "git push" into a branch that is
> currently checked out will be refused by default.  You can choose
> what should happen upon such a push by setting the configuration
> variable receive.denyCurrentBranch in the receiving repository.
>
> To ease the transition plan, the receiving repository of such a
> push running this release will issue a big warning when the
> configuration variable is missing.  Please refer to:
>
>  http://git.or.cz/gitwiki/GitFaq#non-bare
>  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007
>
> for more details on the reason why this change is needed and the
> transition plan.
>
> For a similar reason, "git push $there :$killed" to delete the branch
> $killed in a remote repository $there, if $killed branch is the  
> current
> branch pointed at by its HEAD, gets a large warning.  You can choose  
> what
> should happen upon such a push by setting the configuration variable
> receive.denyDeleteCurrent in the receiving repository.
>
> When the user does not tell "git push" what to push, it has always
> pushed matching refs.  For some people it is unexpected, and a new
> configuration variable push.default has been introduced to allow
> changing a different default behaviour.  To advertise the new feature,
> a big warning is issued if this is not configured and a git push  
> without
> arguments is attempted.
>
> 	Side note: we might want to tone this down, as it does not seem
> 	likely for us to change the default behaviour when this option is
> 	not set.
>
>
> Updates since v1.6.3
> --------------------
>
> (subsystems)
>
> * gitweb Perl style clean-up.
>
> * git-svn updates, including a new --authors-prog option to map author
>   names by invoking an external program.
>
> (portability)
>
> * We feed iconv with "UTF-8" instead of "utf8"; the former is
>   understood more widely.
>
> (performance)
>
> (usability, bells and whistles)
>
> * "git add --edit" lets users edit the whole patch text to fine-tune  
> what
>   is added to the index.
>
> * "git log --graph" draws graphs more compactly by using horizonal  
> lines
>   when able.
>
> * "git log --decorate" shows shorter refnames by stripping well-known
>   refs/* prefix.
>
> * "git send-email" understands quoted aliases in .mailrc files (might
>   have to be backported to 1.6.3.X).
>
> * "git send-email" can fetch the sender address from the configuration
>   variable "sendmail.from" (and "sendmail.<identity>.from").
>
> * "git show-branch" can color its output.
>
> * "add" and "update" subcommands to "git submodule" learned -- 
> reference
>   option to use local clone with references.
>
> (developers)
>
> * A major part of the "git bisect" wrapper has moved to C.
>
> Fixes since v1.6.3
> ------------------
>
> All of the fixes in v1.6.3.X maintenance series are included in this
> release, unless otherwise noted.
>
> Here are fixes that this release has, but have not been backported to
> v1.6.3.X series.
>
> * The way Git.pm sets up a Repository object was not friendly to  
> callers
>   that chdir around.  It now internally records the repository  
> location
>   as an absolute path when autodetected.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

------------------------------------------------------
"Home is not where you are born, but where your heart finds peace" -
Tommy Nordgren, "The dying old crone"
tommy.nordgren@comhem.se
