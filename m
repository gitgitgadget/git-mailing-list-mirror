From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: interrupting "git rebase" (Re: git rebase +)
Date: Mon, 17 Oct 2011 15:33:23 +0530
Message-ID: <CALkWK0=QfXcFD7-0-Pz_uGPp5fNpRHqqgcYPXRR7=7uq92mzGg@mail.gmail.com>
References: <loom.20111013T134405-495@post.gmane.org> <4E96E5E1.7010103@viscovery.net>
 <20111014052653.GA5052@elie.hsd1.il.comcast.net> <CAOeW2eFK5vSKmf+nxzD-6yh5CWZRv4WqSerbSXTPtXmtNeNjxg@mail.gmail.com>
 <20111015194414.GB12893@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Adam Piatyszek <ediap@wp.pl>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 12:03:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFk2x-000706-Ae
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 12:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194Ab1JQKDq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Oct 2011 06:03:46 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:38961 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720Ab1JQKDp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2011 06:03:45 -0400
Received: by wyg36 with SMTP id 36so2012796wyg.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 03:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=BeWGfcK+UR+IPm1N8GL5QRc+z3MOqDsqbf2RPzrAPmg=;
        b=xz+qRn0NqRlv7jUNPWvGANUs2jD6JtpXJHLiNY97mnh4RiXbsPaGs698JVjG8Yhz4N
         fiPelH4V8vpRFz5/Jhe7naMuPoAH8BZyzNt7Qde6ep5A78S8rnYBtUDLWpzD/i5w+uWb
         Uxr1fwR9d1umvPN9nSNfJGjgj74NaG0b5kbX0=
Received: by 10.216.139.167 with SMTP id c39mr6232900wej.90.1318845823081;
 Mon, 17 Oct 2011 03:03:43 -0700 (PDT)
Received: by 10.216.51.75 with HTTP; Mon, 17 Oct 2011 03:03:23 -0700 (PDT)
In-Reply-To: <20111015194414.GB12893@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183787>

Hi,

Jonathan Nieder writes:
> Martin von Zweigbergk wrote:
>> On Thu, Oct 13, 2011 at 10:26 PM, Jonathan Nieder <jrnieder@gmail.co=
m> wrote:
>>> Johannes Sixt wrote:
>
>>>> Hitting Ctrl-C during git-rebase results undefined behavior.
> [...]
>>> Wait, really? =C2=A0That's bad, and unlike most git commands.
>>
>> If Ctrl-C is pressed while the state is being written, it could be
>> left with incomplete information, yes. It has been like that forever=
 I
>> think. I'll put it on my todo list, but it will not be my top priori=
ty
>> (and I have very little git time now anyways).
> [...]

Ah, yes.  I've been bitten by this behavior several times myself :)

>>> By the way, what happened to the "git rebase --abort-softly" synony=
m
>>> for "rm -fr .git/rebase-apply" discussed a while ago?
>>
>> I think we simply did not agree on a syntax, but here was also some
>> discussion about future plans for the sequencer. I remember seeing
>> some discussions about making "git reset --hard" remove the sequence=
r
>> state, but I don't remember the conclusion. It is not clear to me wh=
at
>> is ok to implement in git-rebase nowadays and what would just be
>> double work if it needs to be re-implemented in the sequencer.
> [...]
> Certainly, a lot of sequencer features were inspired by "git rebase".
> Improvements to "git rebase" are only likely to make future
> improvements to "git sequencer" easier. =C2=A0Part of what helps here=
 is
> that "git rebase" is a shell script, so it is a little easier to
> prototype features there.

I concur.  Work on `git rebase` should continue independently of the
sequencer because that's where we pick up ideas from!  I don't see it
as double-work: simply a translation of ideas.  Apart from the fixup
mini-series, the overall interface of the sequencer is still very
unclear to me (see long discussion with Junio, Jonathan).

Yes, 95eb88 (reset: Make reset remove the sequencer state, 2011-08-04)
is merged.  But it's pretty unrelated to the main issue at hand: sure,
"reset --hard" is a great hammer, but that shouldn't prevent us from
developing tools and interfaces that are more sophisticated and
elegant, no?  In other words, I think "--abort-softly" is a great
idea: we should pour ideas into our shell scripts!

Thanks.

-- Ram
