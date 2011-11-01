From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Tue, 1 Nov 2011 14:21:59 -0700
Message-ID: <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
References: <20111026202235.GA20928@havoc.gtf.org> <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike> <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org> <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-ide-owner@vger.kernel.org Tue Nov 01 22:22:27 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RLLms-00055u-0v
	for lnx-linux-ide@lo.gmane.org; Tue, 01 Nov 2011 22:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755991Ab1KAVWY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;lnx-linux-ide@m.gmane.org>); Tue, 1 Nov 2011 17:22:24 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56288 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188Ab1KAVWW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Nov 2011 17:22:22 -0400
Received: by wwi36 with SMTP id 36so3713958wwi.1
        for <multiple recipients>; Tue, 01 Nov 2011 14:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=RrXc6B/7ka5PPc4cbaMxXK12btFS74qL/ZyPkKbABRc=;
        b=RxnVuG9qEwKP6/oYnWi2RpvT9I0EJTjLDZIkSGvAVj4TgS54lyKMSsZiR0Yypmrh/m
         Lf/3nO/+gm3rFVAxqCqXJOMh2qcRiNW4l0vUwCQW9HG4IR0vwRjc1QYzxxbfEBdrRCLl
         zt1qblB3n18XUBS6dPoXF7b3w8HHYbfflGTgk=
Received: by 10.216.54.20 with SMTP id h20mr339623wec.97.1320182540082; Tue,
 01 Nov 2011 14:22:20 -0700 (PDT)
Received: by 10.216.166.3 with HTTP; Tue, 1 Nov 2011 14:21:59 -0700 (PDT)
In-Reply-To: <7vwrbjlj5r.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: SY85fzXpLhlzxB8zaWPG5u67P9Q
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184593>

On Tue, Nov 1, 2011 at 12:47 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> While I like the "an ephemeral tag is used only for hop-to-hop
> communication to carry information to be recorded in the resulting
> history" approach, I see a few downsides.

So I do agree.

I'd actually be *happier* with a generic multi-line "branch
description" thing that involves no git objects at all, just a nice
description of what the branch is.

The fact that you could also hide a signed version of the
top-of-branch there would be kind of a side effect, and wouldn't be a
requirement.

I hate how anonymous our branches are. Sure, we can use good names for
them, but it was a mistake to think we should describe the repository
(for gitweb), rather than the branch.

Ok, "hate" is a strong word. I don't "hate" it. I don't even think
it's a major design issue. But I do think that it would have been
nicer if we had had some branch description model.

The only reason I suggest a tag is really because it would fit with
existing tooling - especially the git transport protocol. So it's not
that I actually think that a tag is the right way to describe (and
sign) the branch, it's just that it's the way that wouldn't require
any changes other than in "git push -s" and "git pull".

> =A0* To verify the commit C that was taken from the tip of lieutenant=
's tree
> =A0 some time ago, one has to find the merge commit that has C as a p=
arent,
> =A0 and look at the merge commit. =A0For example "git log --show-sign=
ature"
> =A0 would either show or not show the authenticity of C depending on =
where
> =A0 the traversal comes from. You certainly can implement it that way=
, but
> =A0 "some child describes an aspect of its parent, but not necessaril=
y all
> =A0 children do so" feels philosophically less correct than "the comm=
it has
> =A0 data to describe itself".

Yeah.

Having thought about it, I'm also not convinced I really want to
pollute the "git log" output with information that realistically
almost nobody cares about. The primary use is just for the person who
pulls things to verify it, after that the information is largely stale
and almost certain to never be interesting to anybody ever again. It's
*theoretically* useful if somebody wants to go back and re-verify, but
at the same time that really isn't expected to be the common case.

So I'm wondering if we want to save it at all. it's quite possible
that realistically speaking "google the mailing list archives" is the
*right* way to look up the signature if it is ever needed later.

Maybe just verifying the email message (with the suggested kind of
change to "git request-pull") is actually the right approach. And what
I should do is to just wrap my "git pull" in some script that I can
just cut-and-paste the gpg-signed thing into, and which just does the
"gpg --verify" on it, and then does the "git pull" after that.

Because in many ways, "git request-pull" is when you do want to sign
stuff. A developer might well want to push out his stuff for some
random internal testing (linux-next, for example), and then only later
decide "Ok, it was all good, now I want to make it 'official' and ask
Linus to pull it", and sign it at *that* time, rather than when
actually pushing it out.

And I suspect signing the pull request fits better into peoples
existing workflow anyway - sending out the email to ask the maintainer
to pull really is the "special event", rather than pushing out the
code itself.

                      Linus
