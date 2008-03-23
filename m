From: Jonathan Watt <jwatt@jwatt.org>
Subject: Re: Working copy revision and push pain
Date: Sun, 23 Mar 2008 18:24:14 +0100
Message-ID: <47E6923E.1050904@jwatt.org>
References: <47E64F71.3020204@jwatt.org> <47E668E1.80804@jwatt.org> <alpine.LSU.1.00.0803231534050.4353@racer.site> <200803231720.44320.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Mar 23 18:25:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdTwa-00050D-Oq
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 18:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756928AbYCWRYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 13:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756523AbYCWRY3
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 13:24:29 -0400
Received: from sd-green-bigip-83.dreamhost.com ([208.97.132.83]:35250 "EHLO
	spunkymail-a16.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753012AbYCWRY2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Mar 2008 13:24:28 -0400
Received: from [192.168.1.6] (ip1-182-173-82.adsl2.versatel.nl [82.173.182.1])
	by spunkymail-a16.g.dreamhost.com (Postfix) with ESMTP id 1584D7D06D;
	Sun, 23 Mar 2008 10:24:23 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
In-Reply-To: <200803231720.44320.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77928>

Johan Herland wrote:
> I'm starting to think it's worth changing the default behaviour of push as follows:
> 
> Upon receiving a push into a non-bare repository, if the working copy is on the same branch as is being pushed, then refuse the push with a helpful message describing why the push was refused, and how to resolve this issue (i.e. referring to the tutorials you mention).
> 
> This would:
> - Not clobber the working copy
> - Tell newbies what happened and why
> - Hopefully make this issue pop up less frequently
> - Not affect you if you only push into bare repos
> - Not affect you if you take care to never push into a checked-out branch

The detach-HEAD idea does all these things, but rather:

- There's no need to tell newbies anything
- It don't just reduce the frequency of the problem, it eliminates it

:-) Also,

- You eliminate the problem of git thinking the working copy came from a
  revision it didn't come from, and thus eliminate the "any commit will
  now overwrite the push" problem
- You can still write hooks to update the working copy if you like
- It's completely intuitive to anyone coming from Mercurial (and it's these
  people who are going to be doing the pushing into non-bare repositories,
  because that's the workflow they're familiar with)

It might also be a good idea to print a warning about the working copy needing
to be updated or else committing changes will create a branch. That seems
obvious, and if you're pushing into a checked out branch, you probably know that
though.

> Of course, you should be able to set a config option to get the old behaviour, and from there you can write hooks to either update the working copy, or detach HEAD, or whatever you please.
> 
> Is this acceptable to people?

>From my perspective it makes things more complicated rather than simpler I'm afraid.

Johannes is apparently fed up of trying to explain to me why people want their
working copy associated with the wrong revision so that their commits will
overwrite the pull. ;-) If anyone else cares to give it ago I'd appreciate it,
since I still don't see the utility.

Jonathan
Hoping Johannes has a sense of humour...
