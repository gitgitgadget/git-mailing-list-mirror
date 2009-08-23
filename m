From: Daniel Convissor <danielc@analysisandsolutions.com>
Subject: Re: hitting home directory's parent
Date: Sun, 23 Aug 2009 01:12:44 -0400
Message-ID: <20090823051244.GB10761@panix.com>
References: <20090821200503.GA19660@panix.com> <fcaeb9bf0908212110o5ed1233ek11183fa37b474a06@mail.gmail.com> <20090822150542.GA29507@panix.com> <fcaeb9bf0908220920g29ec24e9v23d0504d10ca6cfb@mail.gmail.com> <20090822181607.GA25823@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 23 07:14:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mf5PN-00060b-R4
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 07:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbZHWFMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 01:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbZHWFMn
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 01:12:43 -0400
Received: from mail1.panix.com ([166.84.1.72]:54215 "EHLO mail1.panix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267AbZHWFMn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 01:12:43 -0400
Received: from panix5.panix.com (panix5.panix.com [166.84.1.5])
	by mail1.panix.com (Postfix) with ESMTP id BED9E1F08E
	for <git@vger.kernel.org>; Sun, 23 Aug 2009 01:12:44 -0400 (EDT)
Received: by panix5.panix.com (Postfix, from userid 14662)
	id AA1C324204; Sun, 23 Aug 2009 01:12:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20090822181607.GA25823@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126844>

Hi Jeff:

On Sat, Aug 22, 2009 at 02:16:07PM -0400, Jeff King wrote:
> 
> Without looking, I would not be surprised if it is a side effect of
> git trying to look up help-related config.

That explains what's happening.  cmd_help() calls git_config().  Though 
it seems it would be more, uh, helpful, if help produced basic usage 
output no matter what, and then produce the more detailed config based 
output if possible.


> Probably it is calling "setup_git_directory_gently" and ignoring an
> error return, but there is a die() inside that function. The bug
> then is that the _gently form is calling die().

Yep.  setup.c, lines 391 and 392 (master branch):
		if (chdir(".."))
			die_errno("Cannot change to '%s/..'", cwd);


> As for fixing the setup code, I am sadly way behind on my git queue and
> not likely to catch up to this anytime soon. So if anybody feels like
> taking a stab at it, that would be very welcome.

Is there a bug tracker y'all use where I can enter a ticket?

Thanks,

--Dan

-- 
 T H E   A N A L Y S I S   A N D   S O L U T I O N S   C O M P A N Y
            data intensive web and database programming
                http://www.AnalysisAndSolutions.com/
 4015 7th Ave #4, Brooklyn NY 11232  v: 718-854-0335 f: 718-854-0409
