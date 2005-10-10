From: Junio C Hamano <junkio@cox.net>
Subject: Re: First cut at git port to Cygwin
Date: Mon, 10 Oct 2005 13:34:12 -0700
Message-ID: <7vhdbp3yd7.fsf@assigned-by-dhcp.cox.net>
References: <20051005155457.GA30303@trixie.casa.cgf.cx>
	<20051005191741.GA25493@steel.home>
	<20051005202947.GA6184@trixie.casa.cgf.cx>
	<81b0412b0510060205v4cd510c9wb4b06a3ed9242c8@mail.gmail.com>
	<81b0412b0510060307q431b64edt4196553bce28346c@mail.gmail.com>
	<81b0412b0510070544v3e7cf0b4n521db8ff7e4e335a@mail.gmail.com>
	<Pine.LNX.4.64.0510070828270.31407@g5.osdl.org>
	<20051007205450.GA14827@steel.home> <20051007212250.GA1423@steel.home>
	<4346E8AC.5030503@citi.umich.edu> <20051007213952.GA8821@steel.home>
	<Pine.LNX.4.64.0510080900510.31407@g5.osdl.org>
	<Pine.LNX.4.63.0510082023130.25971@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vr7avrgr2.fsf@assigned-by-dhcp.cox.net> <434AB663.8050205@zytor.com>
	<Pine.LNX.4.63.0510102100010.7688@wbgn013.biozentrum.uni-wuerzburg.de>
	<434AC058.60803@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Oct 10 22:34:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP4Lh-0000HA-RJ
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 22:34:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbVJJUeP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 16:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbVJJUeO
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 16:34:14 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:34515 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751211AbVJJUeO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 16:34:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051010203414.SWMR9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Oct 2005 16:34:14 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <434AC058.60803@zytor.com> (H. Peter Anvin's message of "Mon, 10
	Oct 2005 12:26:16 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9923>

"H. Peter Anvin" <hpa@zytor.com> writes:

>>>Junio C Hamano wrote:
>>>
>>>>PROT_WRITE is true, but we do MAP_PRIVATE, and if I recall
>>>>correctly we do not write file via mmap -- at least we do not
>>>>intend to.
>>>>
>
> In the above sentence, emphasis on "at least we do not intend to."  If 
> writes are done legitimately then that's fine, but we shouldn't have 
> "accidental writes" -- those would be program bugs!

What I meant to say was "we do not intend to write back the
changes by expecting the modification on mapped area are written
back by mmap() mechanism -- the updates to index file is done by
creat - write - close - rename".  So your saying "the overkill
being actively wrong" was technically correct, but that wrongly
written data was renamed out anyway and no real harm was done.
