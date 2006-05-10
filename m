From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Implementing branch attributes in git config
Date: Wed, 10 May 2006 18:03:35 +0200
Organization: At home
Message-ID: <e3t2sq$4v9$1@sea.gmane.org>
References: <1147037659.25090.25.camel@dv> <e3p5om$djs$1@sea.gmane.org> <Pine.LNX.4.63.0605091321350.7652@wbgn013.biozentrum.uni-wuerzburg.de> <7vzmhr3wje.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0605091215340.3718@g5.osdl.org> <BAYC1-PASMTP02C02EAC2F64AC00BB5801AEA90@CEZ.ICE> <BAYC1-PASMTP04D623089E043F1C792A37AEA90@CEZ.ICE> <Pine.LNX.4.64.0605091543100.3718@g5.osdl.org> <BAYC1-PASMTP037EBB0237B35C5F92FB0BAEAE0@CEZ.ICE> <Pine.LNX.4.64.0605091854380.3718@g5.osdl.org> <46a038f90605100019q3b44b87kf49e456668f2e249@mail.gmail.com> <Pine.LNX.4.64.0605100823350.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed May 10 18:07:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdrDq-0004pF-Vr
	for gcvg-git@gmane.org; Wed, 10 May 2006 18:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbWEJQHG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 12:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964988AbWEJQHG
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 12:07:06 -0400
Received: from main.gmane.org ([80.91.229.2]:5596 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964929AbWEJQHC (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 May 2006 12:07:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FdrBY-00048W-RW
	for git@vger.kernel.org; Wed, 10 May 2006 18:05:12 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 May 2006 18:05:12 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 10 May 2006 18:05:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19886>

Linus Torvalds wrote:


> On Wed, 10 May 2006, Martin Langhoff wrote:
>> 
>> Good one. I'm following this thread with interest, but it feels we've
>> been attacked by the 'bike shed bug' in the act of redesigning
>> Windows.ini.
[...]
>> As an end-user, I have personally stayed away from the increasingly
>> complex scheme for remotes waiting for it to settle, and stuck with
>> the old-styled .git/branches stuff which is slam-dunk simple and it
>> just works.

> And I'm personally actually pretty fed up with the .git/branches/ and
> .git/remotes/ thing, partly because I can never remember which file is
> which. I had to look at the code of git-parse-remote.sh to remind me which
> had what semantics. We could remove the old one entirely, of course (and
> no, I don't remember which is which now either), and avoid that particular
> problem, but it kind of soured me on it.
> 
> And if we truly have separate files, we should go all the way, and have
> the good old "one file, one value" rule. Which we don't, and which I think
> everybody admits would be horrible for this case for users (even if it
> might be very nice for scripting).

On one hand the remotes/ (or older branches/) is similar to refs/heads and
refs/tags that it contains shortcut names for pulling and pushing. On the
other hand configuration should belong to configuration.

Besides, AFAICT we did not have the place to have branch specific
configuration (like description, default place to pull from + marking
branch as immutable, default place to push to, etc.) and if I understand
correctly branches/ was used for something else. refs/heads/`name` stored
branches, including temporary branches which did not need configuration.

I guess that for the time being we can have remotes both in remotes/ and in
config file, plus script to freely transform between them (unless some
config would be unattainable by remotes/ file).

-- 
Jakub Narebski
Warsaw, Poland
