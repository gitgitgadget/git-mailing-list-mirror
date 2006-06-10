From: Lars Johannsen <mail@lars-johannsen.dk>
Subject: Re: Figured out how to get Mozilla into git
Date: Sat, 10 Jun 2006 20:55:35 +0200
Message-ID: <20060610185535.GB19919@mail.Lars-Johannsen.dk>
References: <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org> <Pine.LNX.4.64.0606091837040.5498@g5.osdl.org> <9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com> <Pine.LNX.4.64.0606091853180.5498@g5.osdl.org> <46a038f90606092041neadcc54n2acb6272d1f71de7@mail.gmail.com> <Pine.LNX.4.64.0606092043460.5498@g5.osdl.org> <Pine.LNX.4.64.0606092109380.5498@g5.osdl.org> <9e4733910606092302h646ff554p107564417183e350@mail.gmail.com> <7vr71xk047.fsf@assigned-by-dhcp.cox.net> <9e4733910606100844v5f4765d8o85c9a6f239faed43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 10 20:56:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fp8cj-0001Sv-U6
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 20:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWFJSzl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 14:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbWFJSzl
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 14:55:41 -0400
Received: from 0x503e3922.hsnxx4.adsl-dhcp.tele.dk ([80.62.57.34]:61319 "HELO
	box4.last-soft.dk") by vger.kernel.org with SMTP id S1751278AbWFJSzk
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jun 2006 14:55:40 -0400
Received: (qmail 15047 invoked by uid 503); 10 Jun 2006 18:55:35 -0000
To: Jon Smirl <jonsmirl@gmail.com>
Mail-Followup-To: Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <9e4733910606100844v5f4765d8o85c9a6f239faed43@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21616>

On (10/06/06 11:44), Jon Smirl wrote:
> Date:	Sat, 10 Jun 2006 11:44:58 -0400
> From:	"Jon Smirl" <jonsmirl@gmail.com>
> To:	"Junio C Hamano" <junkio@cox.net>
> Subject: Re: Figured out how to get Mozilla into git
> Cc:	git@vger.kernel.org
> 
> On 6/10/06, Junio C Hamano <junkio@cox.net> wrote:
> >"Jon Smirl" <jonsmirl@gmail.com> writes:
> >
> >> Here's a new transport problem. When using git-clone to fetch Martin's
> >> tree it kept failing for me at dreamhost. I had a parallel fetch
> >> running on my local machine which has a much slower net connection. It
> >> finally finished and I am watching the end phase where it prints all
> >> of the 'walk' messages. The git-http-fetch process has jumped up to
> >> 800MB in size after being 2MB during the download. dreamhost has a
> >> 500MB process size limit so that is why my fetches kept failing there.
> >
> >The http-fetch process uses by mmaping the downloaded pack, and
> >if I recall correctly we are talking about 600MB pack, so 500MB
> >limit sounds impossible, perhaps?
> 
> The fetch on my local machine failed too. It left nothing behind, now
> I have to download the 680MB again.
> 
> walk 1f19465388a4ef7aff7527a13f16122a809487d4
> walk c3ca840256e3767d08c649f8d2761a1a887351ab
> walk 7a74e42699320c02b814b88beadb1ae65009e745
> error: Couldn't get
> http://mirrors.catalyst.net.nz/pub/mozilla.git//refs/tags/JS%5F1%5F7%5FALPHA%5FBASE
> for tags/JS_1_7_ALPHA_BASE
> Couldn't resolve host 'mirrors.catalyst.net.nz'
> error: Could not interpret tags/JS_1_7_ALPHA_BASE as something to pull
> [jonsmirl@jonsmirl mozgit]$ cg update
> There is no GIT repository here (.git not found)
> [jonsmirl@jonsmirl mozgit]$ ls -a
> .  ..
> [jonsmirl@jonsmirl mozgit]$

To prevent repeat (on this repo) your could grab it with a browser:
-mkdir tmp; cd tmp; git init-db;
-copy  mirror../pu/mozilla.git/objects/*  to .git/objects/
-copy   --||---.git/info/refs to refsinfo in tmp-dir
gawk '{if  ($2 !~ /\^\{\}$/) print $1 > sprintf(".git/%s",$2);}' refsinfo
 to extract branches and tags into ./git/refs/{heads,tags}
start playing (after a backup) with git-fsck-objects, git-checkout etc.
 
-- 
Lars Johannsen 
mail@Lars-johannsen.dk
