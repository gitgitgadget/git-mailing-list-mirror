From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] gitk: Add a "Copy commit summary" command
Date: Sat, 18 Jul 2015 22:23:25 +1000
Message-ID: <20150718122325.GA6817@yogo.paulus.ozlabs.org>
References: <1437060565-4716-1-git-send-email-dev+git@drbeat.li>
 <20150717092251.GB5916@iris.ozlabs.ibm.com>
 <xmqqvbdi3ipb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 18 14:23:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGR9e-0005aL-BU
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 14:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbbGRMXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 08:23:32 -0400
Received: from ozlabs.org ([103.22.144.67]:49285 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbbGRMXb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 08:23:31 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id AD7B5140D16; Sat, 18 Jul 2015 22:23:28 +1000 (AEST)
Content-Disposition: inline
In-Reply-To: <xmqqvbdi3ipb.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274162>

On Fri, Jul 17, 2015 at 08:30:24AM -0700, Junio C Hamano wrote:
> Paul Mackerras <paulus@samba.org> writes:
> 
> > We have an item in the preferences menu to control the SHA1 length
> > that is automatically selected when going to a new commit.  It's
> > stored in the variable $autosellen.  That seems like it would be a
> > reasonable choice for the SHA1 length to use here.
> 
> Reusing a configuration that is used to control something similar
> sounds sensible to me.
> 
> > The only possible
> > problem is that it defaults to 40 and so might give an overly long
> > result for some users.  Maybe you could use $autosellen but limit it
> > to at most 12 or 16 or something like that.
> 
> How is the thing that is "automatically selected when going to a new
> commit" used by the end user?  What is the reason why people may
> want to configure it?  I understand that this is the string that
> goes into the selection buffer, so presumably people are using this
> selection to paste elsewhere?  If so, that sounds like very similar
> to Beat's use case---perhaps if 40 is too long for Beat's use case
> as a sensible default, then it is also too long for its original use
> case?

It's used for pasting into commit messages and emails, and it's used
for pasting onto the command line when typing git commands.  For the
second, the length doesn't matter; the limit was added for the first
case.

> Or do you expect it to be common to want to use autosellen set to 40
> and Beat's abbrev len set to much shorter, e.g. 16?  If so they may
> deserve two different settings, with different defaults.

I would think that if $autosellen is 40 it's almost certainly because
the user hasn't found that control in the preferences window. :)

> Artificially limiting it to 12 or 16 does not sound all that
> sensible, though.

Adding --abbrev=$autosellen if $autosellen is not 40 sounds like it
would do what we want.

Paul.
