From: Ted Zlatanov <tzz@lifelogs.com>
Subject: credential helpers (was: What's cooking in git.git (Aug 2011, #07; Wed, 24))
Date: Fri, 26 Aug 2011 10:42:17 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87aaawnpra.fsf_-_@lifelogs.com>
References: <7vk4a2mjx6.fsf@alter.siamese.dyndns.org>
	<20110825202057.GB6165@sigill.intra.peff.net>
	<7vhb55i11i.fsf@alter.siamese.dyndns.org>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 17:42:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwyYN-0001CZ-MN
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 17:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754427Ab1HZPmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 11:42:39 -0400
Received: from lo.gmane.org ([80.91.229.12]:51004 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754352Ab1HZPmi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 11:42:38 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QwyYG-00018o-N1
	for git@vger.kernel.org; Fri, 26 Aug 2011 17:42:36 +0200
Received: from 38.98.147.133 ([38.98.147.133])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Aug 2011 17:42:36 +0200
Received: from tzz by 38.98.147.133 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Aug 2011 17:42:36 +0200
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 38.98.147.133
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
Mail-Copies-To: never
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/24.0.50 (gnu/linux)
Cancel-Lock: sha1:9PcV/SAF3x4KinGKF/m5HQVsgos=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180175>

On Thu, 25 Aug 2011 15:22:49 -0700 Junio C Hamano <gitster@pobox.com> wrote: 

JCH> We need to add "auth-domain" support, perhaps from the command line option
JCH> and configuration, if we ever need to support such a site.

JCH> We can consider what you already have as the default case for a more
JCH> general "we cut off at the hostname and take that as the auth-domain
JCH> boundary unless told otherwise". We may not have the way to "tell
JCH> otherwise" yet, but as long as we are reasonably confident that we know
JCH> how to extend the system in a backward compatible way, it is not a
JCH> show-stopper.

How about a config variable with regular expressions like

auth-domain.xyz.url = https://(.*@)?github.com/.*

so then accessing a remote with that URL with or without a username
would pass "auth-domain=xyz" to the helper?  If there's no defined
auth-domain then it's not passed to the helper, so it has to just use
the host name (if there is an auth-domain the helper gets it PLUS the
hostname, of course).  

I specify the "url" sub-key so we can add more auth-domain selection
criteria or other functionality in the future.

That gives the user a way to do, for instance:

auth-domain.internalcompany.url = https://.*.mycompany.com/.*

I also wanted to suggest that the credential helper should be able to
specify a SSL private user key and the passphrase for it for HTTPS
connections to servers that require such keys.

JCH> The primary reason why I wanted to hold this topic off was because of the
JCH> frequency of bug report we saw this round to topics _after_ they hit the
JCH> "master" branch, indicating that not many people are testing "next" during
JCH> the development cycle as they used to in olden days.

I'll be sure to test credential helpers next week.

Thank you
Ted
