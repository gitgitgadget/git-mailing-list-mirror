From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 01/13] Use 'Git' in help messages
Date: Sun, 24 Feb 2013 14:11:12 -0800
Message-ID: <CAJDDKr4sCBJs_Dq8MdfCJAH4wW7k0TtimW6B01wS6k0zcJ9XHQ@mail.gmail.com>
References: <1361660761-1932-1-git-send-email-philipoakley@iee.org>
	<1361660761-1932-2-git-send-email-philipoakley@iee.org>
	<CAJDDKr5VG_c_RRK3Z++RNUev=3swmT0HUDocJE1h1QtSHYrYJA@mail.gmail.com>
	<7vr4k65box.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>, GitList <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 23:11:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9jnJ-0000fY-Hl
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 23:11:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759314Ab3BXWLP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 17:11:15 -0500
Received: from mail-wg0-f53.google.com ([74.125.82.53]:34572 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759307Ab3BXWLN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 17:11:13 -0500
Received: by mail-wg0-f53.google.com with SMTP id fn15so1962554wgb.20
        for <git@vger.kernel.org>; Sun, 24 Feb 2013 14:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=fanoKHjfpmR3TxNUf83GVHNwMWXXQGA+Chdv1QWRNPA=;
        b=wblxiLU3MC9ZVPOwTiUcjMEQPdD+PQv4tNPmXFEYzuCnHv3cQ2ks79kIXEfx66pyQP
         pX/0eentw/p89AcFCczXIqhH4PoU1Til3uYclFGdHFHdU/DFPXdEe6fNFdDmxY+ErVyQ
         YDs2nJO1dbNPn965bNiilCAJQyQyqf9B7znWXrmktZuX1cSAGc3qdzDOy74iSg4bpb+T
         PdbecmOlHRZ4PZ3r640boF2DIc3g1VJDW/2TCLEzFVhVUlzjr9kerqgEM13GR/0VMC9+
         8DTAfWF0rmtywD6J63mhE0ltLFOrpe2ljd0Ikmev3XVsGm7ri8Fp+i2KAhdrINUwKcOx
         qCgg==
X-Received: by 10.180.8.4 with SMTP id n4mr8392769wia.13.1361743872275; Sun,
 24 Feb 2013 14:11:12 -0800 (PST)
Received: by 10.194.13.129 with HTTP; Sun, 24 Feb 2013 14:11:12 -0800 (PST)
In-Reply-To: <7vr4k65box.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217007>

On Sun, Feb 24, 2013 at 12:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> This is referring to "git the command", not "git the system",
>> so it should not be changed according to the rule that was
>> applied when many "git" strings were changed to "Git".
>
> That sounds like a sensible objection.
>
>> There are scripts, etc. in the wild that parse this output.
>> which is another reason we would not want to change this.
>
> Are there?  For what purpose?
>
> Especially when these are all _("l10n ready"), I find that somewhat
> unlikely.

A script might conditionally use new git behavior and parse the
output of "git version" to determine whether or not it can use it.
oh-my-zsh does this, for example [*].

Changing the git to Git is probably fine for some scripts that
do something interesting based on the git version since they
might be doing something simple like splitting the string on
whitespace and taking the last element as the version number.

These won't be broken by this change, but this approach is
already broken for a different reason. Apple's build of git
prints "git version 1.7.12.4 (Apple Git-37)" so they would
need to account for the last parens section optionally
being there.  Changing "git" to "Git" only breaks anyone that
has assumed that they could get the version by doing
s/git version// on the string.

I think being able to find the version at runtime is something
that is typically used by packagers and folks that want to be
portable across git versions.  For these, it would be helpful
to have a consistent and stable output that can be easily parsed.

By deciding to not mark these l10n ready and keeping the output
consistent we could help that use case.

[*] I'm not saying this is a good idea or something that scripts
should do, I'm just pointing out that it is done in practice,
so it is worth considering their use cases.
-- 
David
