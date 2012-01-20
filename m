From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 2/2] diff --word-diff: use non-whitespace regex by default
Date: Fri, 20 Jan 2012 09:14:51 +0800
Message-ID: <CALUzUxq8dsc-rO6fVcOEvkaAtuJv7vHRYoUS++3D1nsJsyCrbw@mail.gmail.com>
References: <1326302702-4536-1-git-send-email-rctay89@gmail.com>
	<1326302702-4536-2-git-send-email-rctay89@gmail.com>
	<87lipexawp.fsf@thomas.inf.ethz.ch>
	<CALUzUxo3DcKqC6sQFQ1Oi0vgASFSHCcmOgHAj2_4c3vEjy663w@mail.gmail.com>
	<87ipkhqnr8.fsf@thomas.inf.ethz.ch>
	<CALUzUxqXTXZv4RE=4rBa79T3_1y7UdqZ6okjC1y-Ve+=NDbQ2g@mail.gmail.com>
	<87bopzofir.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jan 20 02:15:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ro34E-0001lV-GO
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 02:14:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754291Ab2ATBOx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jan 2012 20:14:53 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48947 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab2ATBOw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2012 20:14:52 -0500
Received: by wgbdq11 with SMTP id dq11so48879wgb.1
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 17:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=jijIRwU9Fp+SYHTqps325QHDXvbyhpGUMkXVO5iBvUY=;
        b=gmI+cgf5YKflKLyYpnww7oGP6XDl8+EAQCCfEvd0fH+KqFHdBX8EyZYANWwibQYN+L
         qslggCyquCl9zT/cwQu8BW+nkmITmp2J/1JG6wOQe/DC8l1FgVZhmVOvBs9FHjuzVmZi
         yIjgR7/aiKXQYLLKfzYbJ5XLYD3hfFnGGUKog=
Received: by 10.180.109.198 with SMTP id hu6mr191202wib.16.1327022091359; Thu,
 19 Jan 2012 17:14:51 -0800 (PST)
Received: by 10.223.92.135 with HTTP; Thu, 19 Jan 2012 17:14:51 -0800 (PST)
In-Reply-To: <87bopzofir.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188847>

On Thu, Jan 19, 2012 at 11:53 PM, Thomas Rast <trast@student.ethz.ch> w=
rote:
>[snip]
> Under [^[:space:]]+ neither of the examples would work. =A0Actually,
> [^[:space:]]+ is the same as today's default, the [^[:space:]]* I
> mentioned later is (strictly speaking) broken as it allows for a
> 0-length match. =A0(It doesn't really matter because IIRC the engine
> ignores 0-length words.)

My bad.

>[snip]
> I tried measuring it across a few commits, but it mostly gets drowned
> out by the diff effort. =A0For a commit with stat
>
> =A0exercises/cgal/cover/cover.cpp =A0| =A0 =A05 +-
> =A0exercises/cgal/cover/cover.in1 =A0|27014 +++++++++++++++-----
> =A0exercises/cgal/cover/cover.in2 =A0|48996 +++++++++++++++++++++++--=
----------
> =A0exercises/cgal/cover/cover.in3 =A0|55041 +++++++++++++++++++++++++=
--------------
> =A0exercises/cgal/cover/cover.in4 =A0|47600 ++++++++++++++++++++-----=
---------
> =A0exercises/cgal/cover/cover.int =A0|43491 ++++++++++++++++++++++---=
------
> =A0exercises/cgal/cover/cover.out1 | =A0 53 +-
> =A0exercises/cgal/cover/cover.out2 | =A0 24 +-
> =A0exercises/cgal/cover/cover.out3 | =A0 11 +-
> =A0exercises/cgal/cover/cover.out4 | =A0 =A02 +-
> =A0exercises/cgal/cover/cover.outt | =A0 23 +-
> =A0exercises/cgal/cover/gen =A0 =A0 =A0 =A0| =A0 39 +-
> =A0exercises/cgal/cover/gen-1.cpp =A0| =A0 =A04 +-
> =A0exercises/cgal/cover/gen-2.cpp =A0| =A0 =A06 +-
> =A0exercises/cgal/cover/gen-3.cpp =A0| =A0 =A06 +-
>
> (sorry, can't share as those testcases are secret) I get best-of-5
> timings
>
> =A0--word-diff-regex=3D'[^[:space:]]+' =A0 =A00:07.50real 7.40user 0.=
07system
> =A0--word-diff =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00:0=
7.47real 7.41user 0.03system
>
> In conclusion, "meh". =A0I think ripping out the isspace() part would=
 make
> for a nice code reduction.

Thanks for the numbers. Well, that agrees with the intuition that
regex is slower than isspace(), since you have run it through the
regex engine.

>>> and your proposal is equivalent to
>>>
>>> =A0[^[:space:]]|UTF_8_GUARD
>>>
>>> I think there is a case to be made for a default of
>>>
>>> =A0[^[:space:]]|([[:alnum:]]|UTF_8_GUARD)+
>>>
>>> or some such. =A0There's a lot of bikeshedding lurking in the (non)=
extent
>>> of the [[:alnum:]] here, however.
>>
>> Care to explain further? Not to sure what you mean here.
>
> For natural language, it may or may not make sense to match numbers a=
s
> part of a word.
>
> For typical use in e.g. emails, a lot of punctuation has a double rol=
e;
> breaking words in
>
> =A0http://article.gmane.org/gmane.comp.version-control.git/188391
>
> may or may not make sense.
>
> For some uses, especially source code, it would be better to match an
> underscore _ as part of a complete word, too.
>
> For some programming languages, say lisp, a dash - would also belong =
in
> the same category.
>
> There's no real reason other than ease of implementation why the patt=
ern
> handles ASCII non-alphanumerics separately, but non-ASCII UTF-8
> non-alnums (like, say, unicode NO-BREAK SPACE which would show as \xc=
2
> \xa0) always goes into a word. =A0But if you were to make UTF-8 seque=
nces
> a single word, text in (say) many European languages would become
> chunked at accented letters.
>
> I'm sure you can find more items for this list. =A0It's a grey area.

Thanks.

--=20
Cheers,
Ray Chuan
