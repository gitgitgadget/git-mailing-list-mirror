From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: git-diff-tree inordinately (O(M*N)) slow on files with many
 changes
Date: Mon, 16 Oct 2006 09:54:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610160953480.7697@alien.or.mcafeemobile.com>
References: <87slhopcws.fsf@rho.meyering.net> <Pine.LNX.4.64.0610160838200.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610160904400.3962@g5.osdl.org> <87mz7wp6ek.fsf@rho.meyering.net>
 <Pine.LNX.4.64.0610160941270.7697@alien.or.mcafeemobile.com>
 <87ejt8p5l9.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 16 18:55:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZVk7-0001dw-OI
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 18:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422677AbWJPQyw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 12:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422731AbWJPQyv
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 12:54:51 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:19683 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1422677AbWJPQyu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 12:54:50 -0400
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by xmailserver.org with [XMail 1.23 ESMTP Server]
	id <S1F52AE> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Mon, 16 Oct 2006 09:54:48 -0700
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Jim Meyering <jim@meyering.net>
In-Reply-To: <87ejt8p5l9.fsf@rho.meyering.net>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28973>

On Mon, 16 Oct 2006, Jim Meyering wrote:

> Davide Libenzi <davidel@xmailserver.org> wrote:
> > On Mon, 16 Oct 2006, Jim Meyering wrote:
> >
> >> Linus Torvalds <torvalds@osdl.org> wrote:
> >> > On Mon, 16 Oct 2006, Linus Torvalds wrote:
> >> ...
> >> > So I think xdiff has chosen too small a hash. Can you try what happens if
> >> > you change xdl_hashbits() (in xdiff/xutil.c) instead? Try making it return
> >> > a bigger value (for example, by initializing "bits" to 2 instead of 0),
> >> > and see if that makes a difference.
> >>
> >> It makes no difference.
> >>
> >> Bear in mind that there are a *lot* of duplicate lines in the files
> >> being compared: filtering each through "sort -u" removes 40-50k lines.
> >
> > Ok, try to bring down XDL_MAX_EQLIMIT to something like 8 or 16 ...
> 
> That helps a little.
> Now, instead of taking 63s, my test takes ~30s.
> (32 for XDL_MAX_EQLIMIT = 16, 30 for XDL_MAX_EQLIMIT = 8)

That's too much still. May I have the offending files?



- Davide
