From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH 4/5] gitweb: Add a feature for adding more branch refs
Date: Thu, 5 Dec 2013 12:40:42 +0100
Message-ID: <CANQwDwdfbAyJyCWwEXBDp5BGz1JvVj_eUn5NOCWEthUtKfF5Lg@mail.gmail.com>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
 <1386164583-14109-5-git-send-email-krzesimir@endocode.com>
 <CANQwDwe+a2P0Jxqw0k7sHWv3exdb4k+NU3jL3ogR-rcetd82TQ@mail.gmail.com> <1386237635.2186.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 12:41:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoXJA-0005OT-9M
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 12:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100Ab3LELlZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 06:41:25 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:64859 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372Ab3LELlX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Dec 2013 06:41:23 -0500
Received: by mail-wi0-f178.google.com with SMTP id ca18so9655916wib.5
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 03:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2UJrwxlYVm0GpDLwjnNYAtJE+melH/Wt2xOTkaNRZWY=;
        b=LcR6h38q4JN0lKsBlrqEsCAin9HHtzvqvNI7d/8UZ58xWHKFxJhjnpQd5cBHi/Ymzk
         oacCEGEptmObmn+/2gPPI2xy0g26mRGeugm3keZ2Odlc7dkwg6aK1xudePYmiUcbh1qG
         15aD+Fy+2EB+y4bCEQ2ewD7g8iHxpwkpGAPenn9Lt3IuVjfoUZjpJYiXezJxo8CLF+LD
         CLR3qjmNoN5ObUz2t5WnHA0hFwbXNQgtB7O5C4jUXLOby34UHsSdj/WCOe77PUDF7InE
         Fd97vDxhJVGOwh/ErewNuGXAQV4K6K6YLTbP6tiUvHMnc5oolWwY2lagZrsKt/6IbY9o
         DZ+A==
X-Received: by 10.194.173.163 with SMTP id bl3mr69361381wjc.10.1386243682168;
 Thu, 05 Dec 2013 03:41:22 -0800 (PST)
Received: by 10.227.108.131 with HTTP; Thu, 5 Dec 2013 03:40:42 -0800 (PST)
In-Reply-To: <1386237635.2186.22.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238854>

On Thu, Dec 5, 2013 at 11:00 AM, Krzesimir Nowak <krzesimir@endocode.co=
m> wrote:
> On Wed, 2013-12-04 at 19:06 +0100, Jakub Nar=C4=99bski wrote:
>> On Wed, Dec 4, 2013 at 2:43 PM, Krzesimir Nowak <krzesimir@endocode.=
com> wrote:

>>> +The gitweb.extrabranchrefs is actually a multi-valued configuratio=
n
>>> +variable, so following example is also correct and the result is t=
he
>>> +same as of the snippet above:
>>> ++
>>> +------------------------------------------------------------------=
--------------
>>> +[gitweb]
>>> +       extrabranchrefs =3D sandbox
>>> +       extrabranchrefs =3D wip other
>>> +------------------------------------------------------------------=
--------------
>>
>> I think this part should be better left for a separate patch. There =
is
>> important difference between single-valued and multi-valued configur=
ation
>> variable: with single-valued later occurrences override earlier ones=
,
>> which includes settings in more specific config file (e.g. per-repos=
itory)
>> overriding setting in more general one (e.g. per-user or system-wide=
).
>>
>> With multi-valued we won't be able to override earlier / more generi=
c
>> settings... well, unless we add support for no-value, or empty-value
>> as clearer, i.e.
>>
>>   [gitweb]
>>            extrabranchrefs =3D sandbox
>>            extrabranchrefs
>>  # or    extrabranchrefs =3D
>>            extrabranchrefs =3D wip other
>>
>> resulting in ('wip', 'other').

What I didn't notice is that gitweb already supports and *uses* multi-v=
alue
configuration variables: gitweb.url and gitweb.ctag (note: the feature =
is
called 'ctags' and is not overridable), though not for %feature-s.

So the point is moot, sorry for distraction.

BTW. there is config_to_multi() subroutine that you can use.

> That point in this example is a bit moot IMO - if you don't want sand=
box
> ref to appear in list of branches view then just delete the offending
> line.

I was thinking about more complicated situation: if you have gitweb
configured in "scan for repositories" mode (like mod_homedir), then
repository owner may change gitweb configuration for own repository
via repo config file.  But gitweb reads also web server user config fil=
e
and system wide git config file (/etc/gitconfig).  If gitweb.extraBranc=
hRefs
is set in one of those files, repo owner cannot override, but only add
to it.

But I think this is worrying about nothing. I'm sorry for distraction.

> I also made a small experiment. In per-instance config I have
> $feature{'extra-branch-refs'}{'default'} =3D ['wip'];
> $feature{'extra-branch-refs'}{'override'} =3D 1;
>
> In per-repository config I have:
> [gitweb]
>         extrabranchrefs =3D sandbox
>         extrabranchrefs =3D other
>
> List of branches view shows only branches from sandbox and other. So
> clearly per-repository config overrides per-instance config.

That's why is called 'override'... but it is not what I was worrying ab=
out,
see above.

--=20
Jakub Narebski
