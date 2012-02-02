From: demerphq <demerphq@gmail.com>
Subject: Re: General support for ! in git-config values
Date: Thu, 2 Feb 2012 02:14:26 +0100
Message-ID: <CANgJU+XQWdFmfmBJ4KX4GBz1a=TrVbp9BphGmhEb5Gphmzogjw@mail.gmail.com>
References: <CACBZZX6U+1Fmdaz2ikbbc6zUyF=pMGQOqUGVOWCkUFBUkovCBw@mail.gmail.com>
	<20120201184020.GA29374@sigill.intra.peff.net>
	<CACBZZX5mX55Rh8b2GYv7wKbCCypCkrn5AiM9BpXydgcYxHWdQA@mail.gmail.com>
	<7v62fq2o03.fsf@alter.siamese.dyndns.org>
	<CANgJU+X+UZmycwE6xkJ-zHfT7ai6nV9zbeR4WYnAXczL5JtqjA@mail.gmail.com>
	<7vliom13lm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 02:15:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RslGK-0005kR-1X
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 02:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308Ab2BBBO2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 20:14:28 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:58712 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab2BBBO1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2012 20:14:27 -0500
Received: by werb13 with SMTP id b13so1443103wer.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 17:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=eRxfv/r80jpWpQMWvci9+0iV+25yUEhPmCFx7K/zZFE=;
        b=YHitZoWthNPbKlQQwWuzpNayMR0gv6rir5FkYjKws005q6SRaJYOzPIHcuwyoYwlj+
         c/Vf2wYy1AdzBP0CWfpYELWopkMXaPHYRLXA4f86d73JybdrqNkGyhmVC1T7BLb7zkjs
         seFOYH0x9ZvYRIP+NVlYuEhQlXKazp+S6OlJE=
Received: by 10.216.132.139 with SMTP id o11mr3670197wei.32.1328145266389;
 Wed, 01 Feb 2012 17:14:26 -0800 (PST)
Received: by 10.216.174.145 with HTTP; Wed, 1 Feb 2012 17:14:26 -0800 (PST)
In-Reply-To: <7vliom13lm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189566>

On 2 February 2012 01:27, Junio C Hamano <gitster@pobox.com> wrote:
> demerphq <demerphq@gmail.com> writes:
>
>> If =C6var's proposal was implemented without a --with-exec switch th=
en
>>
>> user.name =3D !me
>>
>> would set your name to the result of executing the "me" command, whi=
ch
>> likely would have the same result as not having set your name at all=
,
>> but presumably with a warning about a bad command.
>>
>> user.name=3D!ldap_full_name
>> user.email=3D!ldap_email
>
> I didn't get the impression that that was what he was proposing, but
> regardless of who's suggesting it, the above does not make any sense,
> from the syntax point of view.

Does that mean that from a utility point of view it does?

As for the suggestion and who is making it, this came up because =C6var
and I were discussing git-deploy and a scenario much like I described,
where we use tags to mark out rollouts and we have multiple users
using a common staging server and git repo to do the rollouts from, we
want the tags to have proper details, so we have to go through some
hoops to ensure that users have properly configured things before the
do their first rollout. Since =C6var was aware of the "!" notation for
aliases and thought it made some kind of sense to reuse the syntax
elsewhere he decided to see what people thought. I was not aware of
the notation until he pointed it out. I don't use git-alias.

> When you say "alias.co =3D !git checkout --foo-bar", you are not sayi=
ng
> "instead of usual aliases like 'alias.co =3D checkout' that defines w=
hat
> string replaces the 'co' alias, please run !whatever command, capture
> its output, and that is the _value_ of alias.co variable, i.e. the co=
mmand
> line that is going to be run".

I think I see your point. Using the same "!" notation for "execute
this command and exit" and "execute this command and use its result as
the config value" might be confusing.

Do you have a suggestion for a better syntax? Backtick quoting perhaps?

cheers,
yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
