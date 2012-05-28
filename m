From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/2] Add possibility to store configuration in
 ~/.config/git/config file
Date: Mon, 28 May 2012 14:05:39 -0700
Message-ID: <CAJDDKr63QET=Dn4hV1Q-=xGJ3p1up5ohDsDGcuyrPC43Jvohug@mail.gmail.com>
References: <1337975239-17169-1-git-send-email-nguyenhu@ensibm.imag.fr>
	<20120525203056.GC4364@sigill.intra.peff.net>
	<7vd35sq7fx.fsf@alter.siamese.dyndns.org>
	<20120525214406.GA10064@sigill.intra.peff.net>
	<CACsJy8BD_=6PtQeuDGEt2mee9tMWZB1hL2obu2f2KUmAENTEzA@mail.gmail.com>
	<20120526215405.GC29463@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensimag.imag.fr>,
	git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 28 23:06:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZ78a-000300-3N
	for gcvg-git-2@plane.gmane.org; Mon, 28 May 2012 23:06:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393Ab2E1VFw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 May 2012 17:05:52 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44758 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250Ab2E1VFj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 May 2012 17:05:39 -0400
Received: by yhmm54 with SMTP id m54so1835630yhm.19
        for <git@vger.kernel.org>; Mon, 28 May 2012 14:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=X/8fpZOQilXvdom7IKROEbMrNrUBscQNR8PjR30b4SA=;
        b=uh5gzdZnThMszjmYiE+1jyv2MEfLkMxQ/365fOAeN6pjDXlW3HIOuEnjX8P3MMHJhO
         lbYQR8RJj0kJnB5GJE+Jm/6atIwBQp+M+8T8TfBSCrnxW5WwTxeMlni9OrdcVTUljqcq
         vdikx+gY4zXJYZ851pYhfZT4WqIu3kJkrjZVkcrMbI1f2dWkmnxE/B6X/d81bzGfMYHU
         Wjjl4qIno9rNSoShfKlA+qvHHg69zcABqTh8ik3LWZBfJk2Vwsl6jX+EN9hugFQ7c0kZ
         1afxfVY+OQWU/iTmukLApHZqRyyO5gXJLYhz6s53PaxmAhhZi/dnxGhnagmFEF68cG31
         hfgw==
Received: by 10.236.115.163 with SMTP id e23mr8816807yhh.95.1338239139191;
 Mon, 28 May 2012 14:05:39 -0700 (PDT)
Received: by 10.146.249.15 with HTTP; Mon, 28 May 2012 14:05:39 -0700 (PDT)
In-Reply-To: <20120526215405.GC29463@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198722>

On Sat, May 26, 2012 at 2:54 PM, Jeff King <peff@peff.net> wrote:
> On Sat, May 26, 2012 at 05:15:13PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> > So I consider it the lesser of two evils. The rule is much simpler=
: "old
>> > versions of git do not know about this new location". Which is
>> > unavoidable, and easier to explain than "Old versions of git do no=
t know
>> > about this location. New versions do, but will sometimes ignore
>> > depending on whether this other file exists, which might have been
>> > created by an old version".
>>
>> We could amend Junio's version a bit:
>>
>> =C2=A0- if both versions exist, warn loudly (optionally refuse to wo=
rk) and
>> suggest to symlink .gitconfig to .config/git/config
>
> Yeah, that might help. At the same time, it is not necessarily an err=
or
> condition (e.g., if I track my ~/.config directory, but want to put
> one-offs in ~/.gitconfig. On the other hand, you can set that up
> manually with include.path =3D ~/.some-not-tracked-file, so maybe it =
is
> not a use case worth worrying about).
>
>> > =C2=A01. Start reading from the XDG location in addition to the ol=
d
>> > =C2=A0 =C2=A0 location. Always write to the old location.
>> >
>> > =C2=A02. Wait N time units until everybody reasonable has a versio=
n that
>> > =C2=A0 =C2=A0 does (1).
>> >
>> > =C2=A03. Start writing to the XDG location by default. Keep readin=
g from the
>> > =C2=A0 =C2=A0 old version for compatibility.
>>
>> Hang on.. this "by default" is only for Linux, or for every other OS=
 too?
>
> Sorry, I overstated a bit. It would be _safe_ to do step 3 like that
> after waiting N time units, but we could also do something much less
> drastic (like only writing to it when it exists, or when ~/.gitconfig
> does not exist, or whatever). And no, I wouldn't think following XDG =
on
> non-Linux machines would make much sense if no other programs on that
> platform do so (I don't know what OS X is like, but I can imagine nob=
ody
> uses XDG paths on Windows).

I completely disagree about the OS X thing.  We have shared home
directories across OS X and Linux.  There are many OS X apps that do
respect XDG because they use Qt.  Git configuration is core to the
system; I think we should avoid fragmentation.

Real-word scenario: At disney animation studio (and probably pixar
too) OS X is (thankfully) a 2nd-class citizen to Linux.  We would very
much appreciate the ability to have the OS X git behave exactly like
the Linux version, even if that means a Makefile switch.  IMO it
should do so by default, though; there's little to gain otherwise.

I would even suggest that windows should do the same.  .dotfiles are
not a regular windows thing in the first place.  It's the simplest and
easiest-to-explain thing to do, too.  Otherwise it means more
platform-specific documentation.  Less documentation is better
documentation (especially since no one reads it ;p)

So I think having OS X git follow XDG makes a lot of sense.  I don't
know of any alternatives short of adding something like an OS
X-specific System Preferences pane or some insane OS X `defaults`
=2Eplist-integrated thing ;-)
--=20
David
