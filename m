From: Boris Faure <billiob@gmail.com>
Subject: Re: [PATCH/RFC] branch: add optional parameter to -r to specify remote
Date: Mon, 20 Jun 2011 21:12:41 +0200
Message-ID: <BANLkTikWvkLdiF1hvbwL9ep3vyEtmN8uqw@mail.gmail.com>
References: <1308511149-10933-1-git-send-email-billiob@gmail.com>
	<1308511149-10933-2-git-send-email-billiob@gmail.com>
	<7vtyble9k8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 20 21:12:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYjtw-0006hp-Vm
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 21:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755723Ab1FTTMm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jun 2011 15:12:42 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44256 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755640Ab1FTTMm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2011 15:12:42 -0400
Received: by iwn6 with SMTP id 6so1438789iwn.19
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 12:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=skLOTQ84eeMyxPdedTb6bClmqqFX13cNW62HLcEbk7Q=;
        b=HUsUCCz96d1wpn1V7Q1gyDjtOzg1lDcqNoWjwwfj6+nT3cUtUnqEJTt5B8+SKqxXgr
         NBN94xV7Wqm9U6tqGXrWUEwwB9WDZJncfLYMs0bAL5BB80tOfUmw1P0AD2fsicEvy0MM
         SmiAH68DsLNn7EwE8/Fo+cV8yIFPAzCC3VXCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=THMgWOh5WsGgE246oSzpzzYYR3u5M16qx4HJtySyqtml6DiCDFpYu7TWnJd9my75fy
         tOXAYBQGsTh6E4U9LQs4YYQpKZ1Sw8eTlzm4/oYACV8fEDWRU7UIYNFT1OJWtpM738I+
         KxxiBx80rUKYtHkXJMF5zJHDZOartSgrbhsgI=
Received: by 10.42.19.71 with SMTP id a7mr5606663icb.311.1308597161349; Mon,
 20 Jun 2011 12:12:41 -0700 (PDT)
Received: by 10.42.179.129 with HTTP; Mon, 20 Jun 2011 12:12:41 -0700 (PDT)
In-Reply-To: <7vtyble9k8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176086>

On Mon, Jun 20, 2011 at 00:32, Junio C Hamano <gitster@pobox.com> wrote=
:
> Boris Faure <billiob@gmail.com> writes:
>
>> add '--remote' as long version for '-r'
>> update documentation
>> add tests
>
> (style) Sentences begin with a capital letter and ends with a period.
>
> This commit does a lot more than the above, no? It adds an optional r=
emote
> name parameter to the existing "-r" option and limits the output to t=
he
> remote tracking branches of the remote when it is specified.
>
>> ---
>
> Sign-off?

I missed it.

>> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch=
=2Etxt
>> index c50f189..242da9c 100644
>> --- a/Documentation/git-branch.txt
>> +++ b/Documentation/git-branch.txt
>> ...
>> @@ -99,8 +99,10 @@ OPTIONS
>> =C2=A0 =C2=A0 =C2=A0 default to color output.
>> =C2=A0 =C2=A0 =C2=A0 Same as `--color=3Dnever`.
>>
>> --r::
>> - =C2=A0 =C2=A0 List or delete (if used with -d) the remote-tracking=
 branches.
>> +-r[=3D<remote>]::
>> +--remote[=3D<remote>]::
>> + =C2=A0 =C2=A0 List or delete (if used with -d) the remote-tracking=
 branches from
>> + =C2=A0 =C2=A0 <remote> if specified.
>
> It is now unspecified what the command would do when the optional <re=
mote>
> is left unspecified.

My english is not excellent and for sure a better wording can be found.


>> =C2=A0#define REF_LOCAL_BRANCH =C2=A0 =C2=A00x01
>> =C2=A0#define REF_REMOTE_BRANCH =C2=A0 0x02
>> +static int kinds =3D REF_LOCAL_BRANCH;
>
> This used to be nicely scoped out of global space and got passed arou=
nd as
> parameter, but now it has become a global? I do not see a good reason=
 for
> this change.
>
>> +static const char *remote =3D NULL;

I put those variables in global space in order to access them within th=
e
parse_opt callback.


> Two issues.
>
> =C2=A01. Presumably you wanted to have this change because you have t=
oo many
> =C2=A0 =C2=A0remotes, way more than two, and wanted to filter the out=
put from
> =C2=A0 =C2=A0remotes that you are not interested in. Is it entirely i=
mplausible
> =C2=A0 =C2=A0that you might be interested in not just one, but two re=
motes out of
> =C2=A0 =C2=A0many remotes you have? A single string variable would no=
t suffice for
> =C2=A0 =C2=A0that but you should be able to make this an array of str=
ings.

I wanted to replace a git branch -r | grep 'someRemoteName' to filter
in fact one remote in particular.

>> +static int parse_opt_remote_cb(const struct option *opt, const char=
 *arg,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int unset)
>> +{
>> + =C2=A0 =C2=A0 kinds =3D REF_REMOTE_BRANCH;
>> + =C2=A0 =C2=A0 if (unset)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kinds =3D REF_LOCAL_BRAN=
CH;
>
> What is this "unset" check about? Wouldn't that be an error if the co=
mmand
> line said "--no-remote"?
>
> And you do not return but proceed to look at "arg", presumably to han=
dle a
> case where the command line said "--no-remote=3Dfoobar"?

It's just a missing return.

>> + =C2=A0 =C2=A0 if (arg) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ( *arg =3D=3D '=3D')
>
> (style) Unwanted SP after an open parenthesis.
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 remote =3D arg + 1; /* skip '=3D' */
>
> (style) It is clear enough what this does without the extra comment.
>
> Does this forbid remote names that begin with a "=3D"? =C2=A0I.e.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git branch -r =3Dtemporary

arg is '=3Dtemporary' if called with git branch -r=3Dtemporary but 'tem=
porary'
if called with git branch --remote=3Dtemporary. I didn't know to check =
whether
the option triggered was from the long or the short version and skip '=3D=
'
accordingly.

> As to the design of the new feature, I see you tried to make it possi=
ble
> to perform what
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git branch -d -r origin/master
>
> does with
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git branch -d --remote=3Dorigin master
>
> I do not think it is particularly a good idea. Adding yet another way=
 to
> do the same thing, unless that new way is vastly superiour (e.g. easi=
er to
> use, easier to explain, more efficient to perform, etc.), does not ad=
d
> much value to the system.
>
> It would make much more sense to restrict this feature to the "listin=
g"
> side of the branches. =C2=A0It would be nice if you can do:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git branch -r --match alice --match bob
>
> to show only remote tracking branches under refs/remotes/{alice,bob}
> and also
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git branch --match "jk/*"
>
> to show only local topic branches whose names match the given blob.

I agree that it doesn't make much sense with -d option. I added the fea=
ture
with '-r=3D<remote>' so that it works with '-d'.
I would have preferred to just list branches from a given remote 'aa' w=
ith
'git branch -r aa' but I'll see where the discussion ends up.

--=20
Boris Faure
