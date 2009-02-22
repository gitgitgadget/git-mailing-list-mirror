From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] revision.c: add --format option for 'git log'
Date: Sun, 22 Feb 2009 20:14:09 +0200
Message-ID: <94a0d4530902221014i46e52542j2380386405b559e2@mail.gmail.com>
References: <1235230015-17641-1-git-send-email-felipe.contreras@gmail.com>
	 <7vtz6m1knv.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530902220918oc6f8ab9vc1fd0b55cad014a2@mail.gmail.com>
	 <7v63j2z7bh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 19:15:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbIra-0006bg-PR
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 19:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451AbZBVSOO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2009 13:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753076AbZBVSON
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 13:14:13 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:40574 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751504AbZBVSOM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Feb 2009 13:14:12 -0500
Received: by fg-out-1718.google.com with SMTP id 16so2553105fgg.17
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 10:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=d3epHS49MbeICxuBltyjInjLcRWMnQ0gKuhUa3TWalE=;
        b=NeUNFqEanbLzGcQ00m85bfRXW+xxHkl9ZsZ5kKPk1hYaXsEqQNCtkHrwsgPQ1Q9u5Y
         SkvU3Yzrym3mRXg1vCYCWp1YTuVH8cFh0b2XDOuNIMJH6gtVLtYc5IlgKorOYZ/2QT6H
         rRm7p4vjN1kLG8bA3dmK+YQIHtd7UxnPYLLis=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DgusYXVVkQUAc6/qTe4SI1VmPJiY2gZwfToj/IAI7nE1DjFxZQ+gsHWNZs54bWFhYq
         qNXW1iLRv54sH27GUDEwlTcjNMmIm66PWZaGVm/bEXp8XMZNJev1ZBK6SVbLd3dlFVat
         1woqSdWhww5WzoE7uYtfP4JAwWQ2STmbIj+hY=
Received: by 10.86.96.18 with SMTP id t18mr2424570fgb.17.1235326449031; Sun, 
	22 Feb 2009 10:14:09 -0800 (PST)
In-Reply-To: <7v63j2z7bh.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111039>

On Sun, Feb 22, 2009 at 7:53 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Sun, Feb 22, 2009 at 6:49 PM, Junio C Hamano <gitster@pobox.com> =
wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> --format=3D:foo is a shorthand for --pretty=3Dtformat:foo, otherwi=
se this
>>>> new option acts just like --pretty=3Dfoo, except it's more intuiti=
ve for
>>>> users of 'git log'.
>>>
>>> It's been quite a long time since the earlier discussion, but I won=
der why
>>> you need the colon before "foo" for this new shorthand. =C2=A0I *th=
ink* you are
>>> also introducing "--format=3Dshort" as a synonym to "--pretty=3Dsho=
rt", but
>>> I do not think it is necessary.
>>
>> Well, my hope was to replace --pretty=3Dshort with --format=3Dshort,=
 but
>> you said that would break other scripts.
>
> It is not just scripts you break. =C2=A0You also break people's train=
ed
> fingers.
>
> You can specify the kind of canned pretty printing with --pretty=3Dsh=
ort,
> and it is not any longer to type than --format. =C2=A0For use in scri=
pts that
> you write once and forget, there is no need to even apply this patch.
>
> The only reason why new --format=3D<fmt> could be an useful addition =
is
> because --pretty=3Dformat:<fmt> may be too long to type interactively=
=2E

That's not the main reason I suggested the change.

At least to me (and other people agreed on the original thread), when
I want to see the output of 'git log' in a different format the first
thing that pops into my mind is 'git log --format=3Dfoo'. The other
command I can recall right now that has something similar is 'find',
which has a 'printf' option, but 'find' can do much more than just
output stuff, like -delete, 'git log' on the other hand only prints
stuff, so --printf would not make sense, so only the f (format)
remains.

'git log --pretty=3Dfoo' is very unintuitive, no one would ever find
that option by intuition. Are there different kinds of pretties? Is
the default behavior --ugly?

Maybe 'git log --pretty' makes sense, but not 'git log --pretty=3Dmediu=
m'.

>>>> As discussed in the mailing list, this is implemented as an undocu=
mented
>>>> option.
>>>
>>> Maybe somebody wants to document it.
>>
>> Ah, I would gladly add the documentation, shall I write that it's an
>> 'alternative' option similar to --pretty?
>
> I do not think we want to introduce a new way to say the same thing f=
or
> the canned short options; "alternative" is not a good word for it.
>
> Putting it in another way...
>
> The output format is controlled by --pretty, which knows a set of can=
ned
> output formats. =C2=A0You can specify --format=3D<fmt> if you want so=
mething
> different from any of the canned format. =C2=A0If your git does not s=
upport
> this new notation, you can say --pretty=3Dtformat:<fmt> to get the sa=
me
> effect. =C2=A0The old --pretty=3Dtformat:<fmt> (and --pretty=3Dformat=
:<fmt>) is not
> deprecated in any way.

Again, I don't see why 'canned format' =3D=3D 'pretty' while 'custom
format' =3D=3D 'format'. All this wording seems to suggest the canned
formats are pretty, while the custom formats are not.

I understand the option should be kept for people that are used to it,
but I don't think new users should suffer because of historic reasons.
And actually I believe many current users would not find
--pretty=3Demail more natural than --format=3Demail.

Cheers.

--=20
=46elipe Contreras
