From: Charles Bailey <charles@hashpling.org>
Subject: Re: [RFC/PATCH] Teach git mergetool to use custom commands defined at config time
Date: Sun, 17 Feb 2008 10:15:38 +0000
Message-ID: <20080217101538.GA21823@hashpling.org>
References: <20080216185349.GA29177@hashpling.org> <CD749541-1B3B-4EA7-82A5-0DFC67B953BE@zib.de> <20080217002029.GA504@hashpling.org> <alpine.LSU.1.00.0802170045210.30505@racer.site> <20080217005620.GB504@hashpling.org> <7vbq6g758h.fsf@gitster.siamese.dyndns.org> <FBA2E61E-5CAF-49E3-A917-ACDD10586928@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Feb 17 11:16:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQgZU-0002lT-Jp
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 11:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707AbYBQKPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 05:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754666AbYBQKPy
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 05:15:54 -0500
Received: from pih-relay06.plus.net ([212.159.14.133]:48102 "EHLO
	pih-relay06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754679AbYBQKPx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 05:15:53 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay06.plus.net with esmtp (Exim) id 1JQgYl-0001uk-7c; Sun, 17 Feb 2008 10:15:47 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1HAFdXO022319;
	Sun, 17 Feb 2008 10:15:39 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1HAFc2E022318;
	Sun, 17 Feb 2008 10:15:38 GMT
Content-Disposition: inline
In-Reply-To: <FBA2E61E-5CAF-49E3-A917-ACDD10586928@zib.de>
User-Agent: Mutt/1.4.2.1i
X-Plusnet-Relay: ff152c449f9e67754aaced1608e8c4f8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74110>

On Sun, Feb 17, 2008 at 08:59:31AM +0100, Steffen Prohaska wrote:
> On Feb 17, 2008, at 1:20 AM, Charles Bailey wrote:
> >>
> >>I don't believe that git installs a system config by default, but one
> >>idea I had was to rip out all of the native tools support in git
> >>mergetool and replace it with a list of predefined custom tools
> >>configs. This would put all merge tools on an equal footing and  
> >>should
> >>make extra tool support patches simpler and easier to integrate. This
> >>doesn't have any legs without a system default config, though.
> 
> ... but I am slightly opposed to this idea.  Note that at least
> in one case there is a trick needed to launch the tool.  Such a
> trick can easily be coded if the tool is directly added in
> "git mergetool"; but it would be much harder to capture by a
> generic mechanism via config variables.  The example I mean is
> opendiff that needs to be piped to cat (opendiff ... | cat).
> Otherwise opendiff detaches FileMerge and returns immediately
> without waiting for the user to complete the merge.

I just wanted to say that in my patch, as the configuration is a
sub-shell, that it is perfectly possible to do this in a custom
mergetool as well.

I have different reasons for not liking a default system config file,
namely the whole customize vs. updgrade conflict issues.

An alternative that I have considered is to include a
$(sharedir)/gitcore/mergetools.gitconfig which could contain the
default native mergetool configs (both the commands and the
'trustExitCode' settings.

Submitting a new merge tool patch becomes a simple matter of: "I've
used and tested this in my system (or global) gitconfig, please add to
the git distribution mergetool.gitconfig."

I know that most git developers are just as at ease (if not more so)
editing a git shell script as they are at using git config but I still
believe that there is a significant group of users and potential users
for whom there is an import barrier between configuring software and
'having' to hack it to get it to work.

Charles.
