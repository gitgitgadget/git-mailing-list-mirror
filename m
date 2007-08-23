From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Thu, 23 Aug 2007 12:25:47 +0100
Message-ID: <3f4fd2640708230425h3cb793fbg17b09f561ede07ae@mail.gmail.com>
References: <46CC3090.7080500@gmail.com> <46CC3C17.8040901@op5.se>
	 <864pirej6w.fsf@lola.quinscape.zz>
	 <alpine.LFD.0.999.0708221154150.16727@xanadu.home>
	 <Pine.LNX.4.64.0708221713540.20400@racer.site>
	 <86mywjcwv7.fsf@lola.quinscape.zz>
	 <3f4fd2640708221434i4f5650e0u9adb523742666f40@mail.gmail.com>
	 <Pine.LNX.4.64.0708231006220.20400@racer.site>
	 <20070823102036.GG7267@thunk.org>
	 <e1dab3980708230355x1d5d2febw6814e8f24d745ddd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "David Tweed" <david.tweed@gmail.com>,
	"Theodore Tso" <tytso@mit.edu>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 23 13:26:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOApE-0002yr-6j
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 13:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757168AbXHWLZu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 07:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757000AbXHWLZu
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 07:25:50 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:56401 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756770AbXHWLZs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 07:25:48 -0400
Received: by rv-out-0910.google.com with SMTP id k20so368828rvb
        for <git@vger.kernel.org>; Thu, 23 Aug 2007 04:25:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EJ0GcIFuVBoDtxQzgM3mo8PnzT7vFL0d96+Ej3gFaUEZzy+SWuer9ODk6fL+yfr+B0WctvGyDhT+1n0gvFZ/pDJjThfqejwvxZ7aO/1GRAMqrd8+XUvBBMYE7RKcKrjxyKbwvJ6ZC0FZMKiDVH2OpuayXQvHp6K5gcDQHQ7MTm8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oSO6Zi97qnNAWBKtXmvmzofiSqfWgTXt5cNzmAb/Qk5RD0QvFNcX1pdM7gafcXgsKDg7DKTNSfw+HO+WxgSpIqpsmp7vMKh0F7oK2UIkAkeptD4OMCilm3TwQ5jfTmdIwYVzp+w9Pxg2AialNU+Xwp0DchpdW1zGxALEGwTSaEE=
Received: by 10.141.153.14 with SMTP id f14mr767545rvo.1187868348004;
        Thu, 23 Aug 2007 04:25:48 -0700 (PDT)
Received: by 10.141.87.20 with HTTP; Thu, 23 Aug 2007 04:25:47 -0700 (PDT)
In-Reply-To: <e1dab3980708230355x1d5d2febw6814e8f24d745ddd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56496>

On 23/08/07, David Tweed <david.tweed@gmail.com> wrote:
> On 8/23/07, Theodore Tso <tytso@mit.edu> wrote:
> > (To accomodate those Windows users who for some silly reason refuse to
> > install Cygwin, bash, and perl on their Windows development box.  :-)
>
> I personally don't care exactly what's used implementing git on non-unix
> platforms, but I get nervous as more and more "layers" are added so
> it becomes more and more difficult to figure which layer a user problem
> is occurring at. If it looks to difficult to "help out with" issues on Windows,
> that would be a big enough reason for me not to use git on such projects.

This is one of the reasons I _suggested_ C# for the _Windows_
porcelian. That way, you have the git plumbing written in C, and the
porcelain is implemented in supported tools for the target platform.

I don't mind what the porcelain is written in. However, standardizing
on a single language improves the ability to target more people,
especially as a shell, perl and python are not supported out of the
box on Windows like they are on posix systems. This is important for
some Windows developers and setting up build machines and the like
(most, if not all, Windows users expect each application to be
independant of anything else). It also reduces the surface area in
which problems can occur.

Therefore, we come back to porting the stable scripts to "pure" C.
Doing this for git-rebase _helped_ the Windows port. With a purely C
implementation you have fewer places where problems can arise and
platform issues can be dealt with in a unified way, instead of
duplicating them in each script.

This does not prevent new commands from being prototyped in a
scripting language. Nor does it prevent the user from running the
commands in their own shell/perl/python scripts. It would limit the
"bleeding edge" commands to posix platforms (including cygwin), until
they are supported natively, but that would not hinder adoption of git
on Windows platforms.

- Reece
