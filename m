From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCHv3 1/4] parse-remote: function to get the tracking branch 
	to be merge
Date: Tue, 9 Jun 2009 10:50:12 +0200
Message-ID: <adf1fd3d0906090150k575c538ds28cd8c1a96909e9e@mail.gmail.com>
References: <1244451651-22651-2-git-send-email-santi@agolina.net>
	 <7v8wk2wbfs.fsf@alter.siamese.dyndns.org>
	 <adf1fd3d0906090029s2aa7fe19j7b1005997d70b92c@mail.gmail.com>
	 <adf1fd3d0906090107w994de3chb39071e5911a59ae@mail.gmail.com>
	 <7veittrete.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 10:50:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDx2F-0002xV-5D
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 10:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757658AbZFIIuN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jun 2009 04:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757589AbZFIIuN
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 04:50:13 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:37187 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756461AbZFIIuM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2009 04:50:12 -0400
Received: by bwz9 with SMTP id 9so3638541bwz.37
        for <git@vger.kernel.org>; Tue, 09 Jun 2009 01:50:12 -0700 (PDT)
Received: by 10.204.70.135 with SMTP id d7mr7629455bkj.87.1244537412157; Tue, 
	09 Jun 2009 01:50:12 -0700 (PDT)
In-Reply-To: <7veittrete.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121157>

2009/6/9 Junio C Hamano <gitster@pobox.com>:
> Santi B=E9jar <santi@agolina.net> writes:
>
>>> git pull --rebase tags v1.6.0
>>
>> In fact: git pull --rebase remote tags v1.6.0
>>
>> But this still works because oldremoteref defaults to defaults_merge=
=2E
>> So the only behavior change is when a remote branch is
>> rebased/retagged, and you have worst problems then. I think noone us=
ed
>> the rebased functionality in this way, so I don't think it is worth =
to
>> support it. But if someone think it is important I'll do it.
>
> I personally do not think supporting such a form of input is absolute=
ly
> necessary. =A0Even though technically it might be a regression, if it=
 is so
> rare a form, we can simply say "this strange form used to work, but n=
ow it
> does not; you can use this form instead to do the same thing", and mo=
ve
> on.

OK.

>
> However, at least we should describe the change, both in the commit l=
og
> and documentation. =A0Simply saying "No behaviour change" is not acce=
ptable,
> when the code clearly is doing something else. =A0It needs to be back=
ed by
> some explanation, e.g. "Even though this returns different results fr=
om
> the original, the caller behaves the same because of such and such
> reasons".

OK.

>
> What caught my attention was not the difference between the new code =
and
> the original codepath, but your "FIXME" comment that said "Currently =
only
> works with the default mapping". =A0My initial reaction was "What? =A0=
The new
> code that introduces a function for the specific task of figuring out=
 the
> mapping does not work if the user uses a custom mapping? =A0What kind=
 of
> improvement is that???".

The original code (in git-pull.sh) behaves like this, I only made it
more explicit.

>
> The reaction was followed by "Even if that were the case, if the orig=
inal
> code did not work in the case anyway, then it is not a regression. =A0=
The
> proposed commit log message claims that there is no behaviour change,=
 so
> that FIXME might not be so grave an offense. =A0Is it really the case=
? =A0Was
> the original broken?"

Yes, the original is broken.

>
> While trying to figure it out, I noticed that the new code does quite=
 a
> different thing (I still haven't figured out the answer to my origina=
l
> question about FIXME, by the way).
>
> In any case, if we were changing behaviour by deprecating support for=
 a
> rarely-if-ever used syntax, it would be nice if we at least diagnosed=
 it,
> instead of failing, or worse yet, silently doing something different =
from
> the old behaviour.

I am not changing the behaviour. The old code worked exactly like the n=
ew one.
But I agree that this has to be documented(/deprecated?) somewhere.

The only change in behavior is when a remote tag is rebased/retagged.

Santi
