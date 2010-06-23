From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 00/11 GSoC] gitweb: Split gitweb into modules
Date: Wed, 23 Jun 2010 09:59:26 +0200
Message-ID: <201006230959.28098.jnareb@gmail.com>
References: <1277157648-6029-1-git-send-email-pavan.sss1991@gmail.com> <201006222229.17623.jnareb@gmail.com> <AANLkTimIDet95GgvjyiQQPHSU2FSkJcC7WKv7fILiz-y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 23 09:59:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORKs5-0006WE-QD
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 09:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478Ab0FWH7k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jun 2010 03:59:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43991 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab0FWH7j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 03:59:39 -0400
Received: by fxm10 with SMTP id 10so2878082fxm.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 00:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=2pdGKW3dr24t7NQYSqmMJlG1lkPxuoucFGgo8gJNamE=;
        b=ioNUgjPad6S8TRBhxHIrUNffWH6wi0Sg9iTGXtqe4aj0OB3tcMrtG2I1hGGCVNEK8k
         SS25W5/BiPVlI556dMBh+HTCGZEiZAf69+vrwp+GUe1hRWNKSkM12kTchuv48IoOuQSc
         rNLZFOm5D09ho5iiXgkdmFceCzUrrxcAUwxSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=F4X8gRgVyXE+YKCrFwtq9svpajWhYS3kleghBDB3GcpnNdkVTvqrXSiSArstm+dOIb
         nUBjwZL4qLY1IExXn8W7+MmDvl978+25Glp8lu/qeKNIKQaCc67JBDQ1FMht8QygKoa7
         mXHDrP2oQxzAeoB4M4UraZx0J1xN25eu/cbxA=
Received: by 10.223.117.164 with SMTP id r36mr7209343faq.28.1277279977606;
        Wed, 23 Jun 2010 00:59:37 -0700 (PDT)
Received: from [192.168.1.15] (abwj124.neoplus.adsl.tpnet.pl [83.8.233.124])
        by mx.google.com with ESMTPS id y2sm31988473faj.15.2010.06.23.00.59.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jun 2010 00:59:36 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTimIDet95GgvjyiQQPHSU2FSkJcC7WKv7fILiz-y@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149499>

On Tue, 22 June 2010, Pavan Kumar Sunkara wrote:
> On Wed, Jun 23, 2010 at 1:59 AM, Jakub Narebski <jnareb@gmail.com> wr=
ote:
>> On Tue, 22 June 2010, Pavan Kumar Sunkara wrote:
>>>
>>> Yes, due to either unment dependency or circular dependency problem=
=2E
>>> But no need to worry as they are very small.
>>
>> Could you _*LIST*_ those subroutines that you feel should belong in
>> Gitweb::Config but could not be put in it, and write _why_ they coul=
d not
>> be put (on what subroutines / variables do they depend that it makes
>> impossible to move them)?
>=20
> feature_* subs. They can't be put in it because they use
> git_get_project_config from Gitweb::RepoConfig module

O.K., but that information should IMHO be in the commit message.
But shouldn't feature_* subs (except perhaps utility feature_bool etc.)
be in Gitweb::RepoConfig rather than Gitweb::Config anyway?

[...]
>> Perhaps it would be better then to move _all_ validate_* subroutines=
 to
>> separate Gitweb::Request::Validate module... unless they are used by=
 some
>> subroutine from Gitweb::Request.
>=20
> or even better if we leave them untouched for now. (in gitweb.perl sc=
ript)
> and move them later along with the evaluate_validate_params function

That's good enough for me.

>>>>> 6. gitweb: Create Gitweb::Escape module
>>>>>
>>>>> Create a Gitweb::Escape module in 'gitweb/lib/Gitweb/Escape.pm'
>>>>> to store all the quoting/unquoting and escaping subroutines
>>>>> regarding the gitweb.perl script.
>>>>>
>>>>> This module imports $fallback_encoding variable from
>>>>> Gitweb::Config module to use it in sub 'to_utf8'
>>>>>
>>>>> Subroutines moved:
>> [...]
>>>>> =A0 =A0 =A0 unquote
>>>>
>>>> Shouldn't unquote be in Gitweb::Parse, as contrary to the rest of
>>>> subroutines is is not about gitweb output escaping/quoting, but
>>>> about processing (parsing) output of git commands? =A0Perhaps it
>>>> could even be provate to Gitweb::Parse (i.e. not exported by
>>>> default)...
>>>
>>> It would result in circular dependency. So, Escape module is best f=
or
>>> it's place.
>>
>> Errr... how? =A0If unquote is used only by subroutines in Gitweb::Pa=
rse
>> (and I think it is), it could be local to Gitweb::Parse, not even
>> exported (by default). =A0Please explain.
>=20
> Oh! I didn't know that.
> I will change it.

O.K.
=20

>>>>> 8. gitweb: Create Gitweb::View module
>>>>>
>>>>> Create Gitweb::View module in 'gitweb/lib/Gitweb/View.pm'
>>>>> to store the subroutines related to the HTML output
>>>>> for gitweb.
>>>>
>>>> I find that this module looks a bit like a collection of fairly un=
related
>>>> subroutines at very different levels of abstractions.
>>>>
>>>> I guess that you don't want to split gitweb into too many modules,
>>>> and splitting gitweb is more of one of steps to final goal of addi=
ng
>>>> write functionality to gitweb, rather than the goal in and of itse=
lf.
>>>> Nevertheless it would be good to be able to immediately know from =
the
>>>> description of module what kind of subroutines should be there.
>>
>> Any comment on this, if you don't mind? =A0Even "I don't want to thi=
nk more
>> about better split" would be all right for me.
>=20
> I don't want to think more about better split :)

NOTE that the goal of splitting gitweb was to make it possible to put
write functionalities for gitweb in separate module(s).  Would it be
possible with this proposed split?  If it is, then further enhancements
and refactoring to how gitweb is split into modules could be done=20
"in tree", after this GSoC 2010 project is completed.
=20
BTW. what write feature would be easiest to write?  Authentication
(only localhost / 127.0.0.1)?  Creating lightweight tags?  Scanning
for repositories and saving them in project index file?

>>>>> This module depends on Git.pm, Config.pm, Request.pm,
>>>>> Escape.pm and RepoConfig.pm. Some subroutines which
>>>>> output HTML but are not included in this module due
>>>>> to unmet dependencies.
>>>>
>>>> Which subroutines and what unmet dependencies?
>>>
>>> action specific HTML divs. They include format_* and parse_* subs.
>>
>> Thanks for this info. =A0It should be, IMHO, in the comit message.
>>
>> But... Shouldn't all format_* subs be in Gitweb::Format anyway?
>> Shouldn't all parse_* subs be in Gitweb::Parse anyway? =A0Which of f=
ormat_*
>> and parse_* do you feel that belong here?
>=20
> Yes. I think you misunderstood me.

Ah, format_* and parse_* were "unment dependencies", not "not included
subroutines".

So what were those "not includes subroutines"?

>
> Gitweb::Parse and Gitweb::Formst depend on Gitweb::View.
> So, action specific HTML divs can't be placed in Gitweb::View because
> they depend on Gitweb::Format and Gitweb::Parse.
>=20
> I think it's better if they are in GitwebAction::* modules

All right.


P.S. Unentangling interdependencies between gitweb subroutines can be
left for later, but it looks like it would have to be necessary later.

--=20
Jakub Narebski
Poland
