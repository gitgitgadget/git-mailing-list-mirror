From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] t/t3700: convert two uses of negation operator '!' to use 
	test_must_fail
Date: Tue, 20 Jul 2010 18:25:49 +0000
Message-ID: <AANLkTilf4Z0FI9jkREJx6EJHv1OH1J4XZOQmE1rR_Mu4@mail.gmail.com>
References: <tMTpk3TmiYV54AYDiNJMBdnlXhSooJQQ1gRoAEsSwmcSwJ9ROgOpr75wpEQNx6_kZkqBtD71_QU@cipher.nrlssc.navy.mil>
	<AANLkTil9jA8Dva_KqW67c1ZgWk9_a5S1rBViui8Jn0Os@mail.gmail.com>
	<fVE942wHC3SFihkQG8AthPTKiTZtYJ9zmR2TT7F5OlkGD4IA9xPcMA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jul 20 20:25:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObHVt-0001xA-DP
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 20:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761205Ab0GTSZw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 14:25:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40426 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758607Ab0GTSZv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 14:25:51 -0400
Received: by iwn7 with SMTP id 7so5904704iwn.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 11:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wjWQdbpJ/qRVHEmqpnnU7odnw1FWLAoGOI0X64l0ATg=;
        b=VV+eyN0Y4MEvCz1otMhHjyB7uNMlNWkyPGTlWjuBLnXJzIFF2Mp8fgy930qz5ziCSa
         JqnEz/jH7u/IwrXzUuIc48lnVISYu4JnJeFObL9ElH2OerV9I6UGEoZgt06ubFD94bke
         rwrs12bsNZCDxDfeeZPpYMgWFms2XlaomXseY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=deBycNanZCOx4efDLv4Qbrm7sRwa92NjDRXuXXgqXPQCvGt69CYTPFUg9XivUudpQZ
         CDnkZTqPZIHgWg3DyGve0pIRsgrOIH76KXfZHyRqF7mtSxvHz/2BHZ5/lBh+N5upaaM3
         Fg9BhYcyQi/vKecBh97zZZrHplSF16y8esOXw=
Received: by 10.231.60.5 with SMTP id n5mr7576071ibh.162.1279650349697; Tue, 
	20 Jul 2010 11:25:49 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 20 Jul 2010 11:25:49 -0700 (PDT)
In-Reply-To: <fVE942wHC3SFihkQG8AthPTKiTZtYJ9zmR2TT7F5OlkGD4IA9xPcMA@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151344>

On Tue, Jul 20, 2010 at 16:32, Brandon Casey <casey@nrlssc.navy.mil> wr=
ote:

>>> This was noticed because the second use of '!' does not include a s=
pace
>>> between the '!' and the opening parens. =C2=A0Ksh interprets this a=
s follows:
>>>
>>> =C2=A0 !(pattern-list)
>>> =C2=A0 =C2=A0 =C2=A0Matches anything except one of the given patter=
ns.
>>>
>>> Ksh performs a file glob using the pattern-list and then tries to e=
xecute
>>> the first file in the list. =C2=A0If a space is added between the '=
!' and the
>>> open parens, then Ksh will not interpret it as a pattern list, but =
in this
>>> case, it is preferred to use test_must_fail, so lets do so.
>>
>> Isn't this a completely seperate thing? Was this test really the onl=
y
>> bit in the test suite that did "!foo" instead of "! foo" ?
>
> This was the only instance of "!()" that was failing for me. =C2=A0I =
didn't
> look before, but now that I have, there is another instance of "!()" =
in
> t5541 that should be fixed. =C2=A0t5541 hasn't caused a problem for m=
e because
> GIT_TEST_HTTPD must be set in order to enable it, and I haven't done =
so.
>
>> Does the test pass for you if you just:
>
> Yes.
>
>> =C2=A0 =C2=A0 @@ -281,7 +281,7 @@ add 'track-this'
>> =C2=A0 =C2=A0 =C2=A0EOF
>>
>> =C2=A0 =C2=A0 =C2=A0test_expect_success 'git add --dry-run --ignore-=
missing of
>> non-existing file' '
>> =C2=A0 =C2=A0 - =C2=A0 =C2=A0 =C2=A0 !(git add --dry-run --ignore-mi=
ssing track-this
>> ignored-file >actual 2>&1) &&
>> =C2=A0 =C2=A0 + =C2=A0 =C2=A0 =C2=A0 ! (git add --dry-run --ignore-m=
issing track-this
>> ignored-file >actual 2>&1) &&
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_cmp expect actual
>> =C2=A0 =C2=A0 =C2=A0'

A seperate patch to clean up those two + doc patch to the "Do's,
don'ts & things to keep in mind" section in t/README would be really
useful IMO. I had no idea that "!cmd" was an issue no ksh.
