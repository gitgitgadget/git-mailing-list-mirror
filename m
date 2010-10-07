From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Useful tracking branches and auto merging
Date: Thu, 7 Oct 2010 13:04:30 +0300
Message-ID: <AANLkTinqw06t88fkbyW3BbU-ZpWFAWBmjMQLPrTkXrci@mail.gmail.com>
References: <AANLkTimq0sKUavKiXepDOz+DvrymuRAVUyAyV+FzbCBD@mail.gmail.com>
	<20101004204625.GH6466@burratino>
	<7vk4lw7g2m.fsf@alter.siamese.dyndns.org>
	<AANLkTinXJ5E_U=5uP_zvWLQBssQsYC74JyVv1N3-eMXK@mail.gmail.com>
	<7vvd5g5rjq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 12:04:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3nL4-0003sq-NR
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 12:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754276Ab0JGKEd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 06:04:33 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57194 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938Ab0JGKEb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 06:04:31 -0400
Received: by bwz11 with SMTP id 11so319052bwz.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 03:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rSYP7x7EIh09h6c7XarYr/J3C6z5bWkNGY2fqK121QA=;
        b=gbTLOz6klpsyVyGlycTG5XQhXWLtASXQ6Xb/IYQNFS9abJPiLmiQPA0z3+sst2D+Lv
         ZgU4DBM37sgCdZ/Uq4mfmE+omBQ7uCk0r/jStRc+1/1LWwY3O/JEDj1kBol39hsV43T6
         dOQG9y0bnwybGwwTs/Q5CTI0v1Q9adyGtVXB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RZ/xEk6yow2qqfx/DM3ju4xJ8OrX/2gUFZUuNbw243UdNTEwIbBrdPoFSsZS5BYCLJ
         +S/B2oel1j6GzBBqW/xfuv0DUS2LYTZ09+Bnh5fz6Sk0b1Jo3V5MyTmAgCm6HL1Cbcbk
         m5GWgoki1QX7BiLdwvtHlTAHklQlBF4B5z6x0=
Received: by 10.204.68.144 with SMTP id v16mr485134bki.58.1286445870482; Thu,
 07 Oct 2010 03:04:30 -0700 (PDT)
Received: by 10.204.152.142 with HTTP; Thu, 7 Oct 2010 03:04:30 -0700 (PDT)
In-Reply-To: <7vvd5g5rjq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158391>

On Tue, Oct 5, 2010 at 11:10 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> I believe this use-case is valid:
>>
>> * The user wants *all* his remote tracking branches to point to the
>> latest branch head in all the repos in the case the can be
>> fast-forwarded, and in the case they can't, print an error and
>> continue with the rest.
>
> I would not be so sure about the validity of that use case.
>
> If your tracking branches are always trailing, never having any real =
work
> of your own, there is no reason to have them locally, instead of chec=
king
> them out on demand. =C2=A0So let's forget about that case.

Don't be so quick. Typing 'master' is certain easier than
'origin/master', or 'stable' rather than 'linux-stable/master', or
'vj-feature-1' rather than 'whatever-repo-this-came-from/feature-1'.
The fact that you don't do it doesn't mean it's not a valid use-case.

> On the other hand, if you have forked a topic branch to build your ne=
w
> nifty feature at some known point (e.g. immediately after the upstrea=
m
> reached a new stable point), but you haven't done any real work on it=
, it
> is doubtful that it is even a good idea to fast-forward it automatica=
lly
> to begin with. =C2=A0C.f.

=46ortunately we have 'git checkout --no-track -b origin/foo'. Problem =
solved.

But rather, what I do is:
% git branch -t origin/foo
% git checkout -b nifty-feature foo

> =C2=A0 Message-ID: <AANLkTim85sH_2o=3DxCiDuoQrHq_7ZL96Y91xQMGxUP5Fy@m=
ail.gmail.com>
>
> =C2=A0 "The real problem is that maintainers often pick random - and =
not at
> =C2=A0 =C2=A0all stable - points for their development to begin with.=
 They just
> =C2=A0 =C2=A0pick some random "this is where Linus -git tree is today=
", and do
> =C2=A0 =C2=A0their development on top of that. THAT is the problem - =
they are
> =C2=A0 =C2=A0unaware that there's some nasty bug in that version."
>
> IOW, once I decided one point is a good place to fork a topic, create=
d a
> branch off of it, but didn't have a chance to do a real work on it ye=
t, it
> would be very irritating if "git pull" updated that branch only becau=
se I
> do not have my own commit on it yet.

Then either:
1) fork of a local branch
2) use --no-track
3) don't do 'git pull --all'

> I see little sanity in doing this with any option whose name has "all=
"; it
> largely depends on the workflow, and in a single repository, some bra=
nches
> may want to get fast-forwarded automatically while others don't [*2*]=
=2E

I think if you are issuing 'git pull --all' you want your remote
tracking branches to fast forward if possible, if not, why are you
doing 'git pull --all'?

Cheers.

--=20
=46elipe Contreras
