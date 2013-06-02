From: Anthony Ramine <n.oxyde@gmail.com>
Subject: Re: [PATCH v5] wildmatch: properly fold case everywhere
Date: Mon, 3 Jun 2013 01:42:51 +0200
Message-ID: <586F64C2-0F44-4DAB-B91A-DB88C624FEC2@gmail.com>
References: <1369903506-72731-1-git-send-email-n.oxyde@gmail.com> <1369909150-73114-1-git-send-email-n.oxyde@gmail.com> <7vppw4mb77.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 01:43:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjHvQ-0003KZ-CV
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 01:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755516Ab3FBXm5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Jun 2013 19:42:57 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:47361 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755224Ab3FBXmz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Jun 2013 19:42:55 -0400
Received: by mail-wi0-f175.google.com with SMTP id hn14so2165145wib.2
        for <git@vger.kernel.org>; Sun, 02 Jun 2013 16:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=tXNn7ALF68he/kMEJpWO4pj0zGIFmGdlNdKQ9rf2EHM=;
        b=pFVplehqYNvXiW2o223+6FRRUQuLvPPxVEJhVC1cyfngCF/IddccBgGNalnQ/5S0O9
         5/ib0Ye5Wt5BsKKr1OlSq6k+Btd1vrMSr/O8tXfD2CDP+vbAffgS10VeUIF7WHkf5yd+
         tX2PmJl9MahXaDg1hSTK1LVB3C7grziS+Ffhssl46Z4rhSKk7S1QezD4mPPdTH0/qDhU
         3kTJcNRk7ztmVgu8Z6bCiB6Li27d03Bwn/4CXfNZVCgCMs14WK1KTEqpn7suE0I1am5b
         lkmPaqwgB4UUpswX0UT+vscRk12yMe99c+Gv2m04zTprz07n0eqL9v9uXVIj0xxBSf/z
         XP6g==
X-Received: by 10.180.198.49 with SMTP id iz17mr10363212wic.39.1370216573962;
        Sun, 02 Jun 2013 16:42:53 -0700 (PDT)
Received: from [192.168.1.44] (vol75-16-88-182-187-128.fbx.proxad.net. [88.182.187.128])
        by mx.google.com with ESMTPSA id d10sm19868034wik.0.2013.06.02.16.42.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Jun 2013 16:42:52 -0700 (PDT)
In-Reply-To: <7vppw4mb77.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226194>

Hello Junio,

Replied inline.

Regards,

--=20
Anthony Ramine

Le 2 juin 2013 =E0 23:53, Junio C Hamano a =E9crit :

> Anthony Ramine <n.oxyde@gmail.com> writes:
>=20
>> ase folding is not done correctly when matching against the [:upper:=
]
>> character class and uppercased character ranges (e.g. A-Z).
>> Specifically, an uppercase letter fails to match against any of them
>> when case folding is requested because plain characters in the patte=
rn
>> and the whole string are preemptively lowercased to handle the base =
case
>> fast.
>>=20
>> That optimization is kept and ISLOWER() is used in the [:upper:] cas=
e
>> when case folding is requested, while matching against a character r=
ange
>> is retried with toupper() if the character was lowercase, as the bou=
nds
>> of the range itself cannot be modified (in a case-insensitive contex=
t,
>> [A-_] is not equivalent to [a-_]).
>>=20
>> Signed-off-by: Anthony Ramine <n.oxyde@gmail.com>
>> Reviewed-by: Duy Nguyen <pclouds@gmail.com>
>> ---
>=20
> Thanks.
>=20
>> t/t3070-wildmatch.sh | 55 ++++++++++++++++++++++++++++++++++++++++++=
++++------
>> wildmatch.c          |  7 +++++++
>> 2 files changed, 56 insertions(+), 6 deletions(-)
>>=20
>> I added Duy as reviewer and fixed a typo in the commit message repor=
ted by
>> Eric Sunshine.
>>=20
>> diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
>> index 4c37057..38446a0 100755
>> --- a/t/t3070-wildmatch.sh
>> +++ b/t/t3070-wildmatch.sh
>> @@ -6,20 +6,20 @@ test_description=3D'wildmatch tests'
>>=20
>> match() {
>>     if [ $1 =3D 1 ]; then
>> -	test_expect_success "wildmatch:    match '$3' '$4'" "
>> +	test_expect_success "wildmatch:     match '$3' '$4'" "
>> 	    test-wildmatch wildmatch '$3' '$4'
>> 	"
>>     else
>> -	test_expect_success "wildmatch: no match '$3' '$4'" "
>> +	test_expect_success "wildmatch:  no match '$3' '$4'" "
>> 	    ! test-wildmatch wildmatch '$3' '$4'
>> 	"
>>     fi
>>     if [ $2 =3D 1 ]; then
>> -	test_expect_success "fnmatch:      match '$3' '$4'" "
>> +	test_expect_success "fnmatch:       match '$3' '$4'" "
>> 	    test-wildmatch fnmatch '$3' '$4'
>> 	"
>>     elif [ $2 =3D 0 ]; then
>> -	test_expect_success "fnmatch:   no match '$3' '$4'" "
>> +	test_expect_success "fnmatch:    no match '$3' '$4'" "
>> 	    ! test-wildmatch fnmatch '$3' '$4'
>> 	"
>> #    else
>=20
> Is the above about aligning $3/$4 across checks of different types
> (i.e. purely cosmetic)?  I am not complaining; just making sure if
> there is nothing deeper going on.

Yes purely cosmetic.

> It is outside the scope of this change, but the shell style of this
> script (most notably use of [] instead of test) needs to be fixed
> someday, preferrably soon, including the commented out else clause
> at the end of the hunk.
>=20
>> @@ -235,4 +247,35 @@ pathmatch 1 abcXdefXghi '*X*i'
>> pathmatch 1 ab/cXd/efXg/hi '*/*X*/*/*i'
>> pathmatch 1 ab/cXd/efXg/hi '*Xg*i'
>>=20
>> +# Case-sensitivy features
>> +match 0 x 'a' '[A-Z]'
>> +match 1 x 'A' '[A-Z]'
>> +match 0 x 'A' '[a-z]'
>> +match 1 x 'a' '[a-z]'
>> +match 0 x 'a' '[[:upper:]]'
>> +match 1 x 'A' '[[:upper:]]'
>> +match 0 x 'A' '[[:lower:]]'
>> +match 1 x 'a' '[[:lower:]]'
>> +match 0 x 'A' '[B-Za]'
>> +match 1 x 'a' '[B-Za]'
>> +match 0 x 'A' '[B-a]'
>> +match 1 x 'a' '[B-a]'
>> +match 0 x 'z' '[Z-y]'
>> +match 1 x 'Z' '[Z-y]'
>> +
>> +imatch 1 'a' '[A-Z]'
>=20
> Do we want "# Case-insensitivity features" commment here as well?

I don't particularly care, some sections have titles, some don't.

>> +imatch 1 'A' '[A-Z]'
>> +imatch 1 'A' '[a-z]'
>> +imatch 1 'a' '[a-z]'
>> +imatch 1 'a' '[[:upper:]]'
>> +imatch 1 'A' '[[:upper:]]'
>> +imatch 1 'A' '[[:lower:]]'
>> +imatch 1 'a' '[[:lower:]]'
>> +imatch 1 'A' '[B-Za]'
>> +imatch 1 'a' '[B-Za]'
>> +imatch 1 'A' '[B-a]'
>> +imatch 1 'a' '[B-a]'
>> +imatch 1 'z' '[Z-y]'
>> +imatch 1 'Z' '[Z-y]'
>=20
>> +
>> test_done
>> diff --git a/wildmatch.c b/wildmatch.c
>> index 7192bdc..f91ba99 100644
>> --- a/wildmatch.c
>> +++ b/wildmatch.c
>> @@ -196,6 +196,11 @@ static int dowild(const uchar *p, const uchar *=
text, unsigned int flags)
>> 					}
>> 					if (t_ch <=3D p_ch && t_ch >=3D prev_ch)
>> 						matched =3D 1;
>> +					else if ((flags & WM_CASEFOLD) && ISLOWER(t_ch)) {
>> +						uchar t_ch_upper =3D toupper(t_ch);
>> +						if (t_ch_upper <=3D p_ch && t_ch_upper >=3D prev_ch)
>> +							matched =3D 1;
>> +					}
>> 					p_ch =3D 0; /* This makes "prev_ch" get set to 0. */
>=20
> Hmm, this looks somewhat strange.
>=20
> * At the beginning of the outermost "per characters in the text"
>   loop, we seem to downcase t_ch when WM_CASEFOLD is set.
> * Also at the same place, we also seem to downcase p_ch under the
>   same condition.
>=20
> which makes me wonder why the fix is not like this:
>=20
> 	+	if (flags & WM_CASEFOLD) {
>        +		if (ISUPPER(p_ch))
>        +			p_ch =3D tolower(p_ch);
>        +		if (prev_ch && ISUPPER(prev_ch))
>        +			prev_ch =3D tolower(prev_ch);
> 	+	}
> 		if (t_ch <=3D p_ch && t_ch >=3D prev_ch)
> 			matched =3D 1;
> 		p_ch =3D 0; /* This sets "prev_ch" to 0 */
>=20
>=20
> Ahh, OK, the "seemingly strange" construct is about handling a range
> like "[Z-y]"; we do not want to upcase or downcase the p_ch/prev_ch
> make the range "[z-y]" (empty) which would exclude bytes like "^",
> "_" or even "Z".
>=20
> And it is also OK to downcase p_ch in a single-letter case, not the
> characters in a range, at the beginning of the outermost loop,
> because we always compare for equality against t_ch (which is
> downcased) in that case.

Yeah I tried to explain that in the commit message but it is surely too=
 dense.

>> @@ -245,6 +250,8 @@ static int dowild(const uchar *p, const uchar *t=
ext, unsigned int flags)
>> 					} else if (CC_EQ(s,i, "upper")) {
>> 						if (ISUPPER(t_ch))
>> 							matched =3D 1;
>> +						else if ((flags & WM_CASEFOLD) && ISLOWER(t_ch))
>> +							matched =3D 1;
>=20
> This also looks somewhat strange but correct in that t_ch is already
> downcased so we do not need a corresponding change for CC_EQ("lower")
> codepath.

I chose to still lowercase everything first, to keep the common path as=
 is.

> Interesting.  Will apply.
>=20
> Thanks.

Great. You're welcome.
