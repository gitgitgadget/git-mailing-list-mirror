From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Tue, 3 Aug 2010 12:02:52 +0200
Message-ID: <201008031202.53804.jnareb@gmail.com>
References: <i372v0$3np$1@dough.gmane.org> <m3hbjcptyr.fsf@localhost.localdomain> <4C57D997.5010003@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Joel C. Salomon" <joelcsalomon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 03 12:02:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgEKe-0005OD-Fe
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 12:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314Ab0HCKCk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Aug 2010 06:02:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:35226 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194Ab0HCKCj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 06:02:39 -0400
Received: by fxm14 with SMTP id 14so1917260fxm.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 03:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=6munztwURmLqGMy49cir9ErACDDh+bv286x7fSxi0SI=;
        b=dxCs8sjKmz00Y17UtURbj8aLVvT8uc7Tua49ByrCV/CtEaJ4bCfkUEEWfxUxLc5/hE
         vwBN9z4knW9kdovA7UDPBVbKVUWJdCw+zJ2OjqoxLx7WSZWIx0FkmKWbedP28QUbXT9+
         O4U5yLwILCes8saXLfay3KEBZuXymFdf7kIb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Aht1ME7hWjmVNy7eQCt6RoVVP3NCMHDE7w44CAermMA8ccsr9IdWaQqwHg3xQE4oF7
         NgQ4GUgIPvOIoNWKQcWyzuUG6Qz3i3KpjN8MI+y9Ef0jMlMtdsg1RlxW1F3H0W8cVaw4
         56pv5Aajgo5WQZUdnuqcLqtqT8SM6hrnBhEsc=
Received: by 10.223.126.84 with SMTP id b20mr6983507fas.98.1280829757509;
        Tue, 03 Aug 2010 03:02:37 -0700 (PDT)
Received: from [192.168.1.13] (abws244.neoplus.adsl.tpnet.pl [83.8.242.244])
        by mx.google.com with ESMTPS id b9sm2402840faq.7.2010.08.03.03.02.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 03:02:36 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4C57D997.5010003@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152497>

On Tue, 3 Aug 2010, Michael J Gruber wrote:
> Jakub Narebski venit, vidit, dixit 02.08.2010 23:48:
>> "Joel C. Salomon" <joelcsalomon@gmail.com> writes:
=20
>>> [...] I'm trying to get the dates right, and I'm missing something.=
  For
>>> example, I made the initial commit with the line
>>>
>>> 	$ git commit --author=3D"The Philadelphia Convention <>" \
>>> 	 --date=3D"Mon, 17 Sep 1787 12:00:00 EST"
>>>
>>> but that's not actually setting the commit date to 1787.
>>>
>>> Am I doing something wrong, or is Git (quite reasonably) unable to
>>> accept commit dates that far in the past?
>>=20
>> Git encodes author and commit (and tagger) time using Unix epoch
>> (POSIX epoch) plus timezone.  As Shawn and =C3=86var wrote on 32-bit
>> systems time_t can cover a range of about 136 years in total around
>> January 1, 1970, which means that the maximum representable time on
>> 32-bit system is 2038-01-19 (the year 2038 problem), but what is mor=
e
>> important to you is that minimum representable time is 1901-12-13.
>> 1787 is too old for 32-bit time_t.
>>=20
>> The headers inside commit (and tag) objects are stored in text form,
>> so they are not limited to 32-bit value.  You would have to use syst=
em
>> that has 64-bit time_t, or patch git.
>=20
> Hmm, sizeof(time_t) =3D=3D 8 for my x86_64 Fedora, but committing anc=
ient
> times fails.

That's because git *porcelain* either does not use time_t consistently,
or has some sanity checks that are good heuristic for ordinary use (lik=
e
e.g. commit time not too far in past where git didn't even exists),
or both.

It is not a problem on lowest level, i.e. repository format and plumbin=
g.
I was able to create a commit that had author time before Unix epoch=20
using plumbing:


1. create an ordinary commit as a template (so I don't have to go down
   to the level of gitcore-tutorial:

  $ git commit -a
  [master 8ddcf60] foo
  1 files changed, 1 insertions(+), 0 deletions(-)

2. save commit object in a file, to be edited

  $ git cat-file -p HEAD > tmp.txt

3. edit tmp.txt, changing sign of author time

  $ [edit tmp.txt]
  $ cat tmp.txt
  tree 953e0e451fdcb5c21a25ee7ef9faade5791b95ee
  parent 6a28c9c996d785b716559f57149a9b5c11fd83ff
  author Jakub Narebski <jnareb@gmail.com> -12808209400 +0200
  committer Jakub Narebski <jnareb@gmail.com> 1280820940 +0200
 =20
  git-hash-object

4. replace just created commit by handcrafted one

  $ git reset --hard HEAD^
  $ git hash-object -t commit -w tmp.txt
  fa5e5a2b6f27f10ce920ca82ffef07ed3eb3f26f
  $ git update-ref -m 'commit: foo' refs/heads/master \
  fa5e5a2b6f27f10ce920ca82ffef07ed3eb3f26f

5. check that porcelain parses date correctly

  $ git show
  commit a5f4eaace56c6887846ea77725e1ac6827bb13b0
  Author: Jakub Narebski <jnareb@gmail.com>
  Date:   Fri May 31 18:24:20 1929 +0200
 =20
      git-hash-object


Though when I tried to create commit with authordate further in the pas=
t,
porcelain shown 1970 (Unix epoch) as a date, but my system has 32-bit
time_t.

> My ctime() happily converts negative numbers into dates before the ep=
och.

Try ./test-date in git sources...
=20
> Junio replied:
>>
>> I thought the internal representation of our time was "unsigned long=
",>no?
>> How can you represent anything before Unix epoch?
>=20
> We have a mix of time_t and unsigned long (not signed, not long long!=
),
> and we have our own tm_to_time_t() in date.c which explicitly forbids
> years before 1970. It seems we don't use standard ctime() and friends
> because the standards is not so standard and want to be independent o=
f
> that, but sizeof(long) is still system dependent.
>=20
> Removing the check in tm_to_time_t() by brute force let's me commit
> ancient times, but the parser gets them wrong (either on input or on
> output, I haven't checked), 1787 ends up output as 1899.

Hmmm...

--=20
Jakub Narebski
Poland
