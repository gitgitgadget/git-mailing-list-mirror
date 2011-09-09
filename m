From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: The imporantance of including http credential caching in 1.7.7
Date: Fri, 09 Sep 2011 05:15:09 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87pqjaxbrm.fsf@lifelogs.com>
References: <CAFcyEthzW1AY4uXgpsVxjyWCDXAJ6=GdWGqLFO6Acm1ovJJVaw@mail.gmail.com>
	<4E6769E3.4070003@drmicha.warpmail.net>
	<20110908191053.GA16064@sigill.intra.peff.net>
	<4E69C8F0.9070204@drmicha.warpmail.net>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 12:15:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1y7e-0005zm-5O
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 12:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933269Ab1IIKPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 06:15:35 -0400
Received: from lo.gmane.org ([80.91.229.12]:58261 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758667Ab1IIKPc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 06:15:32 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R1y7P-0005uE-6D
	for git@vger.kernel.org; Fri, 09 Sep 2011 12:15:31 +0200
Received: from 38.98.147.133 ([38.98.147.133])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 12:15:31 +0200
Received: from tzz by 38.98.147.133 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 12:15:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 38.98.147.133
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
Mail-Copies-To: never
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/24.0.50 (gnu/linux)
Cancel-Lock: sha1:ll16fx+faneYC+tGGW57ldJJ9CM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181043>

On Fri, 09 Sep 2011 10:06:08 +0200 Michael J Gruber <git@drmicha.warpmail.net> wrote: 

>> In the meantime, the best thing we can do to push it forward is to write
>> helpers. I implemented some basic ones that should work anywhere, but
>> aren't as nice as integration with existing keychains. Some people are
>> working on Linux ones. The single best thing GitHub can do to push this
>> forward right now is to provide a well-written OS X Keychain helper, and
>> to provide feedback on whether git's end of the API is good enough.

MJG> ... and one for Git on Windows? It seems we're lacking both Win and OS X
MJG> developers here.

Windows doesn't have a standard keychain service, does it?

The OS X Keychain helper should be pretty easy in terms of the system
calls (he says after a quick Google search), the hard part IMHO is
figuring out the right way to store credentials in it.  There are
several ways to structure the schema.

For modern Linux systems it's best to target the Secrets API, which is
DBUS and XML-based and works with both the KDE and GNOME keychains.  I
only know about it what I have learned from Michael Albinus' interface
in the Emacs source tree, but it certainly seems capable enough.  This
is what Jeff King was alluding to, I think, about what I'm working on.
I have not been able to work on it so far, not for lack of trying.

My #1 target is to implement a GPG-based credential helper using a
netrc-style file.  I believe that would be the most useful one, though
not the easiest one to set up for inexperienced users.

Ted
