From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: Use a *real* built-in diff generator
Date: Sat, 25 Mar 2006 21:33:36 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603252130190.12437@alien.or.mcafeemobile.com>
References: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org>
 <118833cc0603250544h289f385fo683ec7b40cdb0ed@mail.gmail.com>
 <Pine.LNX.4.64.0603250734130.15714@g5.osdl.org> <Pine.LNX.4.64.0603250742340.15714@g5.osdl.org>
 <Pine.LNX.4.64.0603251009500.11968@alien.or.mcafeemobile.com>
 <Pine.LNX.4.64.0603251040190.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Morten Welinder <mwelinder@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 26 07:34:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNNt2-0004Zi-Ae
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 07:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWCZFdq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 00:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWCZFdq
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 00:33:46 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:13706 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1750716AbWCZFdq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Mar 2006 00:33:46 -0500
X-AuthUser: davidel@xmailserver.org
Received: from alien.or.mcafeemobile.com
	by x35.dev.mdolabs.com with [XMail 1.23 ESMTP Server]
	id <S1C6B64> for <git@vger.kernel.org> from <davidel@xmailserver.org>;
	Sat, 25 Mar 2006 21:33:41 -0800
X-X-Sender: davide@alien.or.mcafeemobile.com
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603251040190.15714@g5.osdl.org>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18027>

On Sat, 25 Mar 2006, Linus Torvalds wrote:

> Btw, git-apply does it, and it's actually quite simple: the code to handle
> the "\ No newline" case is literally just this:
>
>                /*
>                 * "plen" is how much of the line we should use for
>                 * the actual patch data. Normally we just remove the
>                 * first character on the line, but if the line is
>                 * followed by "\ No newline", then we also remove the
>                 * last one (which is the newline, of course).
>                 */
>                plen = len-1;
>                if (len < size && patch[len] == '\\')
>                        plen--;
>
> if we just remove the last '\n' on a line, if the _next_ line starts with
> a '\\' (so the git-apply code actually depends on knowing that the patch
> text is dense, and that it's also padded out so that you can look one byte
> past the end of the diff and it won't be a '\\').
>
> I don't know how well that fits into xpatch (I never looked at the patch
> side, since I already had my own ;), but my point being that handling this
> special case _can_ be very simple if the data structures are just set up
> for it.

Yeah, should be a pretty trivial fix in the xpatch parsing code. Thanks 
for remembering me the missing-eol issue, that fell forgotten somewhere in 
my todo list :D



- Davide
