From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v10.1 7/7] bisect: allow any terms set by user
Date: Mon, 29 Jun 2015 10:08:42 +0200
Message-ID: <CAP8UFD1gWXOZHfiELZYgvGP1dA-aeaxbyaokKCut9pfWghy9uQ@mail.gmail.com>
References: <xmqqsi9etjwy.fsf@gitster.dls.corp.google.com>
	<1435351183-27100-1-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqa8vmrtsh.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1PyS_qM3EHW_Nzmo=3aeTDkZ0M3hnhRQANAO+ShF3H1Q@mail.gmail.com>
	<CAPc5daXSnovQPxR5kVoeRy4kApH7DiuTDvAz1ooQFp=5DZZg4Q@mail.gmail.com>
	<558F8B55.1070708@alum.mit.edu>
	<CAPc5daWmhkqDL0pNYne4-kRoxWK7ObcOKxtE5DsfHA2cnMM1pQ@mail.gmail.com>
	<558F9854.5080605@alum.mit.edu>
	<CAP8UFD0NjExQJHQWix1+zc4_k15e3+aC5vAv=dHipg-X+2y1sQ@mail.gmail.com>
	<vpq1tgvnf2g.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 29 10:08:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9U7c-0000dx-LJ
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 10:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbbF2IIt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 04:08:49 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36344 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbbF2IIo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 04:08:44 -0400
Received: by wicnd19 with SMTP id nd19so63651037wic.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2015 01:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LUlKJN1RUu2aKKkzIwJroeTLfIr1Bg7npEqLwfbrjRs=;
        b=rAeuvHvznnUEaXQvc3YLs32HIpX3y9ekJI9zxIEHX4JVC5Rzhb3Jn/EeeZRGtQiYI9
         h4knrHpv5uscYhhfNcs96buFpAtj5+Q8zlVDFcV4tJ5EVslbxDIUgZgy4QlwU0pF1Jp/
         zFV9E7XNd5zC1DPcHmNdioLiN/a8KNge9/S5lODwIlWTBd6Vn4yY+umFEGI9nvKsqYQW
         TSeWb+jVx5tcW5qgVBFZ7F11xkqwUMYNk4rZIl2xrM6/DPURMs/XzWdlQbovAP5vquYR
         ImhqTMJAw6DYc4H0j56u0criO/534mReS6je8Ggtyda+WQ//yLbXqyRv1I9/K3n8dKqI
         jBnw==
X-Received: by 10.194.95.132 with SMTP id dk4mr28655617wjb.88.1435565322964;
 Mon, 29 Jun 2015 01:08:42 -0700 (PDT)
Received: by 10.194.221.229 with HTTP; Mon, 29 Jun 2015 01:08:42 -0700 (PDT)
In-Reply-To: <vpq1tgvnf2g.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272943>

On Mon, Jun 29, 2015 at 9:34 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Sun, Jun 28, 2015 at 8:46 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> I understand that the user might make a mistake when marking the initial
>>> commits, but as soon as bisect says
>>>
>>>     Commit <sha1-abbrev> is an ancestor of <sha1-abbrev>, so I
>>>     will look for the commit that caused the transition from
>>>     "xyzzy" to "plugh".
>>>
>>> then I hope the user will notice and correct her/his mistake.
>>
>> This looks fragile to me. Unfortunately many users will probably not
>> read it and continue, and then spend a lot of time later trying to
>> understand what went wrong,
>
> I don't understand what you mean by "went wrong".

It happens that users mistake the "good" and the "bad" commits when
giving them to git bisect.

Right now in the most common case, we can error out because we know
that a "bad" commit cannot be an ancestor of a "good" commit.

> As a user, when I
> discovered "git bisect", I was actually surprised that it expected one
> particular order between good and bad. I would have expected to be able
> to say "this is good, this is bad, tell me where it changed" without
> having an idea of who's good and who's bad.

Maybe, but it's not how it has been developed.

> In particular when bisecting
> from two branches, the user knows that branch A is good, and branch B is
> bad, but does not necessarily know whether it's a regression in B or a
> fix in A. The fact that bisect can find out should be just "normal" from
> the user point of view. There's no mistake involved, nothing to fix, and
> nothing that went wrong.

Well in this case, it's possible that the merge base is bad and what
the user is interested in is the first bad commit that was commited
before the merge base. We just don't know, in the case the merge base
is bad, what is more interesting for the user.

So I disagree with you and Michael that we should decide that the user
is interested by the fix in this case. It's better to error out like
we do now and let the user decide what he/she wants rather than decide
for him/her that he/she is interested by the fix.

>> By the way we could use "mark" or "term" instead of "name" in the
>> option name (like --mark-old or --term-old) and in the code too if it
>> looks clearer.
>
> I prefer "term" to "mark" because "mark" is both a verb and a noun, so
> --mark-old=foo could mean both "mark foo as old" or "the name of the
> marks for old commits is foo".
>
> I think I prefer "term" to "name".

Ok with that. I agree that it would be more consistent to have a "git
bisect terms" and "--term-{old,new,bad,good}".

Thanks,
Christian.
