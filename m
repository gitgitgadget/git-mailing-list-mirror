From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/4] push: add 'prune' option
Date: Thu, 23 Feb 2012 04:30:10 +0200
Message-ID: <CAMP44s1i6LaXgfbMfx+hhE20NbaBZ+npAZXNSUb79nRkKzpVWg@mail.gmail.com>
References: <1329950621-21165-1-git-send-email-felipe.contreras@gmail.com>
	<1329950621-21165-5-git-send-email-felipe.contreras@gmail.com>
	<7v1upm8jnq.fsf@alter.siamese.dyndns.org>
	<CAMP44s1s_NeXeUpxDR0cLoLGjSaf-0E_62MzAxeiHS=-6c045A@mail.gmail.com>
	<7vlinu72ui.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 03:30:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0ORo-0006he-0R
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 03:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779Ab2BWCaN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 21:30:13 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:55454 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752626Ab2BWCaM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 21:30:12 -0500
Received: by lagu2 with SMTP id u2so860920lag.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 18:30:10 -0800 (PST)
Received-SPF: pass (google.com: domain of felipe.contreras@gmail.com designates 10.112.84.233 as permitted sender) client-ip=10.112.84.233;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of felipe.contreras@gmail.com designates 10.112.84.233 as permitted sender) smtp.mail=felipe.contreras@gmail.com; dkim=pass header.i=felipe.contreras@gmail.com
Received: from mr.google.com ([10.112.84.233])
        by 10.112.84.233 with SMTP id c9mr11369824lbz.1.1329964210812 (num_hops = 1);
        Wed, 22 Feb 2012 18:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=+eGyLPWCnkgzKy5xVZ7p6e9A3vPaiAbVGQYX3v6dEE0=;
        b=Uk/y0qCcUj8/fUdp4ig1kaCdIr0X6C99UeAZrZmQmdekqGX2sXQgWRbAdWhJe8QxrF
         6xIKQpm7MucW8GQp0M30fS4SyY1IeGl95XheqeF1C64Drf2qw/3gY92wHYy6MVqWkalc
         YVGN5nbAF42cALii7Kx628sA1y62ncz4BxzgU=
Received: by 10.112.84.233 with SMTP id c9mr9541282lbz.1.1329964210679; Wed,
 22 Feb 2012 18:30:10 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Wed, 22 Feb 2012 18:30:10 -0800 (PST)
In-Reply-To: <7vlinu72ui.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191322>

On Thu, Feb 23, 2012 at 3:31 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, Feb 23, 2012 at 2:42 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>
>> Yeah, but that's 'git push --all', and that's not the common
>> operation--'git push' is.
>
> "git push" is common but that does not give you a solid base to guess=
 what
> the reader's assumption would be. =C2=A0Are you assuming "matching" s=
emantics?

But if you want to spell the assumption, why not spell the most common =
one?

>> So that's what I presumed the reader would
>> assume,...
>
> I do not want let us guess what the reader assumes, as many people se=
em to
> suggest setting push.default to different values and that would chang=
e
> what the reader would assume.

No, it wouldn't. Almost all readers are familiar about what 'git push'
does by default--I would even adventure to say all--the ones that set
a custom push.default would do it because they _know_ they don't want
the default.

And in fact, as I said, it doesn't matter what the reader has set in
push.default, or if the reader is assuming 'git push --all', or 'git
push :', or 'git push --tags', or 'git push refs/heads/*', the end
result is the same.

> That was the whole reason that I suggested
> to spell the assumption out, so that the reader's assumption does not=
 have
> to get into the picture.

I don't think it matters what the reader assumes, because the end
result is the same, so there's no reason to spell any assumption.

>> This reuses the name `tmp`, which seems to be your objective, but it
>> doesn't explain _why_ it would remove `tmp`; is it because `tmp` is
>> the upstream branch, or is it because it has the same name?
>
> The example is to clarify "local counterpart" in the main text. =C2=A0=
I
> actually would prefer to get rid of `tmp` but I left it as-is as you
> wrote. =C2=A0The exact name used in the example does not matter, whet=
her it is
> `tmp` or `xyzzy`.

I believe `tmp` is more useful than `xyzzy`, or even more than
`master`. I already explained why.

>> Unfortunately, I as a reader have trouble understanding this. More
>> specifically I have trouble understanding where `refs/remotes/laptop=
/`
>> is coming from, and what it is meaning. I have always pictured
>> `refs/remotes` as something that 'git fetch' updates, and always fro=
m
>> the relevant repository.
>
> The layout is the recommended set-up to emulate a fetch with a push i=
n the
> reverse direction, which I thought anybody should notice. =C2=A0It is=
 a failure
> in our documentation that even an expert didn't.

The problem is not figuring out the `refs/remotes/foo`, but picturing
the fact that there are two repositories, the user ran on one of them
'git remote add laptop', and then 'git remote add pc', and then 'git
push --prune refs/heads*:refs/remotes/laptop/*'. Lots of things to
keep in mind for this paragraph. And, as you say, it's the reverse
direction of a fetch, so it's immediately weird.

Moreover, I find it strange that you want to rely on the assumption
that the reader is familiar with the pattern `refs/remotes/foo`, and
the refspec syntax, which is pretty deep plumbing, and not on the
default action of 'git push', which is high-level porcelain, and as I
said, not even needed to understand my example.

>>>> diff --git a/remote.h b/remote.h
>>>> index b395598..341142c 100644
>>>> --- a/remote.h
>>>> +++ b/remote.h
>>>> @@ -145,7 +145,8 @@ int branch_merge_matches(struct branch *, int =
n, const char *);
>>>> =C2=A0enum match_refs_flags {
>>>> =C2=A0 =C2=A0 =C2=A0 MATCH_REFS_NONE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 0,
>>>> =C2=A0 =C2=A0 =C2=A0 MATCH_REFS_ALL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0=3D (1 << 0),
>>>> - =C2=A0 =C2=A0 MATCH_REFS_MIRROR =C2=A0 =C2=A0 =C2=A0 =3D (1 << 1=
)
>>>> + =C2=A0 =C2=A0 MATCH_REFS_MIRROR =C2=A0 =C2=A0 =C2=A0 =3D (1 << 1=
),
>>>> + =C2=A0 =C2=A0 MATCH_REFS_PRUNE =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D (1=
 << 2),
>>>> =C2=A0};
>>>
>>> Lose the ',' at the end, for the same reason why deleted line did n=
ot have
>>> one.
>>
>> And why is that?
>
> Because I told you so ;-).

You didn't tell me anything about the previous line :)

> More seriously, we have had patches to accomodate other people's comp=
ilers
> by dropping the last comma in enum {}. =C2=A0See c9b6782 (enums: omit=
 trailing
> comma for portability, 2011-03-16), 4b05548 (enums: omit trailing com=
ma
> for portability, 2010-05-14) for examples.

Yeah, I remembered those patches after sending the mail. Shame. Maybe
next decade =3D/

Cheers.
--=20
=46elipe Contreras
