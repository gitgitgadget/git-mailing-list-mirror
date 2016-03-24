From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v9 1/3] parse-options.c: make OPTION__COUNTUP consider
 negative values
Date: Thu, 24 Mar 2016 16:08:24 +0530
Message-ID: <CAFZEwPOwmJuLzUsAwqZttYcHaZsekpR_o9bXtXv73JBSFuxNYQ@mail.gmail.com>
References: <01020153a7ba4e07-f326395b-63df-4f8a-b378-8f387b02d0bd-000000@eu-west-1.amazonses.com>
	<1458815593-11060-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Mar 24 11:38:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj2et-000385-Uz
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 11:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755189AbcCXKi1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2016 06:38:27 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:34334 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754436AbcCXKiZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2016 06:38:25 -0400
Received: by mail-yw0-f195.google.com with SMTP id f6so4942397ywa.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 03:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=yxOFSfoHO0tFbzWyUaK/U+wc62KmhkA2ao06PaOv2Yo=;
        b=nVKqu8evv0koJme6xftS6nGwX7rlmlPsK7iIYewGgP/N87rfbx9dVgdTemLL+8XMVi
         0g+zuNGXIlqkHMJMvvXjGPbDrgv4VmyRA8o9H8586I9vH2Jr6okXfrDOeIWCuQ+I/0oU
         r0ZDfFXryuqM04rHcAJMae5PPrs50/AAYO3OekA+Fl+3jpoXdIjQYlyL+O6RobZ0zKop
         8c8gQX4z7ugqK2vduvVCHEr5CCBlTQ9SQ+7/pC7Jga2f1WQXH34OtpjleZhTBoB8Qt+O
         renA/zoT9OYxdlQPDkkL3eAG6qJD9f59x/DWVWrQvHVzVpB/tNXBGJ41w1pQkDYbHXbS
         ZEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=yxOFSfoHO0tFbzWyUaK/U+wc62KmhkA2ao06PaOv2Yo=;
        b=UpyoWMPoxcum6+3hPwjEE1XoAVE9qSDWZ244tWReUD5WEQpqy7a7zxDKYlvM3aAyzQ
         mI2z1EgYZu1Uus4YikDV9ej0APpwv0aTM6tylIcG9v6G+oFw1gH4v/YvPECV1ZVzFQt8
         27EbRHUtSz3CknxuSYObaTZAyR5C7Uwy2dNW3h0byAo29rBzGJYg1Jl6BCMjCO7Ze9MJ
         mP0WfVFmsbD0/YIY6W4vf6MnFi1dkHQM9YRxkEW8zGlSTdo5QJh2GaX5LgAkNlu/RJWD
         9CwabOPH3lI8gWaj31/Kk0d24qvStJ4WXvquo2dBtqpEUZI438kNH6PkAAeSA7S4/JRr
         0kvw==
X-Gm-Message-State: AD7BkJLbMADPplHNPJeg/0yrN4X+9DS5cApIT2nYFBOJmIfbmpz4q9TiAyM+ekkQAYrD4n/vomjsZIYVBChEuA==
X-Received: by 10.129.94.7 with SMTP id s7mr4166367ywb.93.1458815904833; Thu,
 24 Mar 2016 03:38:24 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Thu, 24 Mar 2016 03:38:24 -0700 (PDT)
In-Reply-To: <1458815593-11060-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289734>

On Thu, Mar 24, 2016 at 4:03 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
wrote:
>> The reason to make it consider negative values or more specifically
>> "unspecified" values is to give the ability to differentiate between
>> once, multiple time or with --no-option.
>>
>> Eg. :
>> initialize verbose =3D -1
>> `git commit` =3D> verbose =3D -1
>> `git commit -v` =3D> verbose =3D 1
>> `git commit -v -v` =3D> verbose =3D 2
>> `git commit --no-verbose` =3D> verbose =3D 0
>>
>> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
>>
>> ---
>> The discussion about this patch:
>> [1] : http://thread.gmane.org/gmane.comp.version-control.git/289027
>>
>> Previous version of the patch:
>> [v1] : http://thread.gmane.org/gmane.comp.version-control.git/289061
>>
>> Changes introduced:
>> Use a different language in commit message to make the change and it=
s
>> utility more clear.
>
> I don't see the mentioned change in the commit message.  In
> particular:
>
>   - As Eric pointed out in the previous round, the commit message
>     misses the single most important point of justification: to
>     determine whether '--option' or '--no-option' was specified at
>     all.  Explaining this would also make the examples unnecessary.

I will justify it in the commit message. Also will remove the examples.

>   - OPT_COUNTUP is used in several places, mostly indirecty, but the
>     commit message doesn't explain that possible side-effects to thes=
e
>     callers were considered and that they are not harmed by this
>     change.

I will include bits from my and Jeff's conversation into this commit me=
ssage.

>> ---
>>  Documentation/technical/api-parse-options.txt | 6 ++++--
>>  parse-options.c                               | 8 +++++++-
>>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> A couple of new tests to t0040-parse-options.sh would be great to
> ensure that starting from a negative value works as advertised, i.e.
> at least that '--option' jumps to 1 and '--no-option' resets to 0.
>
>> diff --git a/Documentation/technical/api-parse-options.txt b/Documen=
tation/technical/api-parse-options.txt
>> index 5f0757d..a908d8a 100644
>> --- a/Documentation/technical/api-parse-options.txt
>> +++ b/Documentation/technical/api-parse-options.txt
>> @@ -144,8 +144,10 @@ There are some macros to easily define options:
>>
>>  `OPT_COUNTUP(short, long, &int_var, description)`::
>>       Introduce a count-up option.
>> -     `int_var` is incremented on each use of `--option`, and
>> -     reset to zero with `--no-option`.
>> +     If the `int_var` is negative and `--option` is absent,
>> +     then it will retain its value. Otherwise it will first set
>> +     `int_var` to 0 and then increment it on each use of `--option`=
,
>> +     and reset to zero with `--no-option`.
>>
>>  `OPT_BIT(short, long, &int_var, description, mask)`::
>>       Introduce a boolean option.
>> diff --git a/parse-options.c b/parse-options.c
>> index 47a9192..86d30bd 100644
>> --- a/parse-options.c
>> +++ b/parse-options.c
>> @@ -110,7 +110,13 @@ static int get_value(struct parse_opt_ctx_t *p,
>>               return 0;
>>
>>       case OPTION_COUNTUP:
>> -             *(int *)opt->value =3D unset ? 0 : *(int *)opt->value =
+ 1;
>> +             if (unset)
>> +                     *(int *)opt->value =3D 0;
>> +             else {
>> +                     if (*(int *)opt->value < 0)
>> +                             *(int *)opt->value =3D 0;
>> +                     *(int *)opt->value +=3D 1;
>> +             }
>>               return 0;
>>
>>       case OPTION_SET_INT:
>>
>> --
>> https://github.com/git/git/pull/218
>>
>>
