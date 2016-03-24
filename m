From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 1/3] parse-options.c: make OPTION__COUNTUP consider
 negative values
Date: Thu, 24 Mar 2016 19:34:25 -0400
Message-ID: <CAPig+cRszLsZh1ka7+y3EehQxUK67jMrVJse1EOzwLCcs-7x9Q@mail.gmail.com>
References: <01020153a7ba4e07-f326395b-63df-4f8a-b378-8f387b02d0bd-000000@eu-west-1.amazonses.com>
	<1458815593-11060-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Mar 25 00:34:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajEls-0005b7-JM
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 00:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbcCXXe2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Mar 2016 19:34:28 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33659 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbcCXXe1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2016 19:34:27 -0400
Received: by mail-vk0-f68.google.com with SMTP id a62so6092120vkh.0
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 16:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=ZaqWdx9SeallZDOfNQ8w++nsj/zo/ZWJDEqI4m0Vwr8=;
        b=OnsLM7aYiD030CXuyV2kN025QmYaAgMdExXLPgsICK8pBPck+4Tvp71FrQPcxhS/m3
         cKANCvuJkDQHj2RJudcrAAzxVX6ygagMax9hAxam8qvPVGfT62XaWPfaH6F0V5Qp2VtY
         nBTusIvuPmWLUj6GP3HV4JQFqCMDRp75eX6L0wiyCB6M2UesSPVNOZHkFi2x7I+SYsLV
         blWIEQqPWijpcrLGYvlb29ZkIQoH4yjioIExUg0EfOPtvxu/RuJs3MUpWx40ghaGHpPH
         hZ5WnqGDNhZkTxkLuJOeVoZ/ssFHOPgSjwZ/bemUxYU/60H9mkVTkEfgbECjAQAZIopL
         4zRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=ZaqWdx9SeallZDOfNQ8w++nsj/zo/ZWJDEqI4m0Vwr8=;
        b=i8yfgT1zawfUZ/1nl4m9TvJ29MjoHBFx4YMZfOO042NO6QcrdhyetNcaE8SpldQNXW
         yDxsw7Ve/6Z/mv9zfbGG6MyW5+kr+lKrObYD3oXesZs5c6xnhtBlO8e3NQrz12gUva2g
         omGQ/Z8CrEMNoutR0AU7Hv5zigQ0bWVEYLTKtaiwh+iDbTrgy045qb4ZtQPGguqwBcRI
         etYVMdzwV6mMDR6o/cNYY0S1pzowxk23W3rs6p1cHjZbqFQYN3bYIMQs9Wj5b3Urg3k/
         NJSESx9s3DP5xSFOYGkGEnbYP8811Ah8slGCDyOlNdt4qDvoX9Fe+nXd8KkfMpBS1OJt
         WQGA==
X-Gm-Message-State: AD7BkJJiM8/RDI8XcYwWiawZpKL/9f7oOf6Jm6G+pczIqixQumI0+jD25U6+q+Xf56vZLlPPDeK0gktwR7DzDg==
X-Received: by 10.176.6.193 with SMTP id g59mr5581046uag.67.1458862465907;
 Thu, 24 Mar 2016 16:34:25 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Thu, 24 Mar 2016 16:34:25 -0700 (PDT)
In-Reply-To: <1458815593-11060-1-git-send-email-szeder@ira.uka.de>
X-Google-Sender-Auth: 5J5urNbYF9VrzklSLiL97ygSNFc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289822>

On Thu, Mar 24, 2016 at 6:33 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de> =
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
>> ---
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

Agreed. It would be more helpful to explain that you are changing
OPT_COUNTUP so that --option always counts up from zero, even if the
initial value was negative, in order to allow the caller to determine
whether --option or --no-option was seen at all, by setting the
initial value to -1 and then checking if it still -1 after
parse_options(). If you explain that well, then the tabular example in
your commit message can go away altogether.

The subject ("make OPTION__COUNTUP consider negative values") could
use a little work too. OPTION__COUNTUP already works with negative
values, but not in the way you want. Instead, you want it to treat
negative values specially as "unspecified", and that's the real gist
of this patch, thus the subject ought, at the very least, have the
word "unspecified" in it.

>   - OPT_COUNTUP is used in several places, mostly indirecty, but the
>     commit message doesn't explain that possible side-effects to thes=
e
>     callers were considered and that they are not harmed by this
>     change.
>
>> diff --git a/Documentation/technical/api-parse-options.txt b/Documen=
tation/technical/api-parse-options.txt
>> @@ -144,8 +144,10 @@ There are some macros to easily define options:
>>  `OPT_COUNTUP(short, long, &int_var, description)`::
>>       Introduce a count-up option.
>> -     `int_var` is incremented on each use of `--option`, and
>> -     reset to zero with `--no-option`.
>> +     If the `int_var` is negative and `--option` is absent,
>> +     then it will retain its value. Otherwise it will first set
>> +     `int_var` to 0 and then increment it on each use of `--option`=
,
>> +     and reset to zero with `--no-option`.

This reads a little bit backward, but, more importantly, doesn't do a
good job of conveying to the reader that a negative value can
represent "unspecified". The best way to convey that would probably be
via example. For instance, something like this:

    Each use of `--option` increments `int_var`, starting from zero
    (even if initially negative), and `--no-option` resets it to
    zero. To determine if `--option` or `--no-option` was seen at
    all, set `int_var` to a negative value, and if it is still
    negative after parse_options(), then neither `--option` nor
    `--no-option` was seen.
