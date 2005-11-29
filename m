From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] Re: keeping remote repo checked out?
Date: Tue, 29 Nov 2005 13:14:07 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.11.29.12.14.05.485826@smurf.noris.de>
References: <m3k6et9rdw.fsf@lugabout.cloos.reno.nv.us> <7vbr051ad1.fsf@assigned-by-dhcp.cox.net> <20051128105736.GO22159@pasky.or.cz> <7vsltgtvk4.fsf@assigned-by-dhcp.cox.net> <20051128212804.GV22159@pasky.or.cz> <Pine.LNX.4.64.0511281420390.3263@g5.osdl.org> <Pine.LNX.4.64.0511281845280.25300@iabervon.org> <Pine.LNX.4.64.0511281637480.3177@g5.osdl.org> <Pine.LNX.4.64.0511282027360.25300@iabervon.org> <Pine.LNX.4.64.0511281837040.3177@g5.osdl.org> <Pine.LNX.4.64.0511282208050.25300@iabervon.org> <Pine.LNX.4.64.0511282029290.3177@g5.osdl.org> <Pine.LNX.4.64.0511282337170.25300@iabervon.org> <7vmzjom00m.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511290141220.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Nov 29 15:43:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eh6Ei-000796-OH
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 15:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbVK2ONd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 09:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbVK2ONd
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 09:13:33 -0500
Received: from main.gmane.org ([80.91.229.2]:58843 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751355AbVK2ONc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 09:13:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Eh5Ke-0005wq-4w
	for git@vger.kernel.org; Tue, 29 Nov 2005 14:15:40 +0100
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Nov 2005 14:15:40 +0100
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 Nov 2005 14:15:40 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12942>

Hi, Daniel Barkalow wrote:

> That's what I'm doing currently, actually (with work pushing to 
> "production", but server having checked out "deploy"), and I find it 
> annoying to have to do the pull each time and have a separate head.

Why? I think "what's currently deployed" and "the latest commit on the
production branch" are two distinct concepts, and should be treated as
such.

That way, a clean push (update of PRODUCTION, controlled by the update
hook) and an update of DEPLOY (the fast-forward merge (unless you need
to roll back something) from your production branch, controlled by the
post-update hook) are also distinct, can be handled individually.

Personally I just use "git-read-tree -m -u deploy master && \
cat refs/heads/master > refs/heads/deploy" in the post-update trigger.
I don't care about HEAD at all; nobody is supposed to change that
directory manually anyway.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Bringing computers into the home won't change either one, but may
revitalize the corner saloon.
