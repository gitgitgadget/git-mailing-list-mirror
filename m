From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH/RFC] Change t0204-gettext-reencode-sanity.sh to pass under
 Mac OSX
Date: Thu, 08 Mar 2012 06:54:54 +0100
Message-ID: <4F5849AE.1070807@web.de>
References: <201203052039.16893.tboegi@web.de> <7vzkbuzss7.fsf@alter.siamese.dyndns.org> <CACBZZX4P=JSdP_vLOMx5r3R+YO8SMSs5W8+vf2DMibKMwBx_Vg@mail.gmail.com> <7vfwdkm6xs.fsf@alter.siamese.dyndns.org> <CACBZZX4q0Da=H=-fO86f2YN+CmE25QfEgAp8Efmdyf65CGckiQ@mail.gmail.com> <7v4nu0m5tb.fsf@alter.siamese.dyndns.org> <CACBZZX6W=-ZchaCsLGdpZ420L_9=w8AHD8BNVb7XV5M-hc0Qhg@mail.gmail.com> <7vd38okmp0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 06:55:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5WJg-00088Z-4P
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 06:55:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752246Ab2CHFzD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 00:55:03 -0500
Received: from smtp-out12.han.skanova.net ([195.67.226.212]:47230 "EHLO
	smtp-out12.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752234Ab2CHFzB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 00:55:01 -0500
Received: from birne.lan (194.22.188.61) by smtp-out12.han.skanova.net (8.5.133) (authenticated as tboegi@telia.com)
        id 4EFC380E0129AE35; Thu, 8 Mar 2012 06:54:55 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vd38okmp0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192521>

On 08.03.12 00:36, Junio C Hamano wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>=20
>> Having that information doesn't cost us a lot, in this case we can
>> just amend the test to assert that on OSX the output should be the
>> same as under the UTF-8 output.
>=20
> Known modes of error behaviour are to show:
>=20
>  - runs of "?", saying "I dunno";
>=20
>  - the key used to query the message catalog ("TEST: Old English
>    Runes"), saying "I don't do i18n"; or
>=20
>  - the raw value stored in the message catalog (runes in UTF-8).
>=20
> and each makes sort-of sense in its own way.
>=20
> I would be OK if the patch read like the attached, but I do not
> think treating the "show key" and "stuff with ?" case differently
> like the original code did makes any sense.
>=20
> It may be better to clarify in the "say" comment that this test is
> not about finding if the user's system is *broken* but about seeing
> if the "undefined" behaviour upon user error is one that we
> recognize, though.
>=20
>  t/t0204-gettext-reencode-sanity.sh |   21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/t/t0204-gettext-reencode-sanity.sh b/t/t0204-gettext-ree=
ncode-sanity.sh
> index 189af90..8911e93 100755
> --- a/t/t0204-gettext-reencode-sanity.sh
> +++ b/t/t0204-gettext-reencode-sanity.sh
> @@ -7,6 +7,7 @@ test_description=3D"Gettext reencoding of our *.po/*.=
mo files works"
> =20
>  . ./lib-gettext.sh
> =20
> +RUNES=3D"TILRAUN: =E1=9A=BB=E1=9B=96 =E1=9A=B3=E1=9A=B9=E1=9A=AB=E1=9A=
=A6 =E1=9A=A6=E1=9A=AB=E1=9B=8F =E1=9A=BB=E1=9B=96 =E1=9B=92=E1=9A=A2=E1=
=9B=9E=E1=9B=96 =E1=9A=A9=E1=9A=BE =E1=9A=A6=E1=9A=AB=E1=9B=97 =E1=9B=9A=
=E1=9A=AA=E1=9A=BE=E1=9B=9E=E1=9B=96 =E1=9A=BE=E1=9A=A9=E1=9A=B1=E1=9A=A6=
=E1=9A=B9=E1=9B=96=E1=9A=AA=E1=9A=B1=E1=9B=9E=E1=9A=A2=E1=9B=97 =E1=9A=B9=
=E1=9B=81=E1=9A=A6 =E1=9A=A6=E1=9A=AA =E1=9A=B9=E1=9B=96=E1=9B=A5=E1=9A=
=AB"
> =20
>  test_expect_success GETTEXT_LOCALE 'gettext: Emitting UTF-8 from our=
 UTF-8 *.mo files / Icelandic' '
>      printf "TILRAUN: Hall=C3=B3 Heimur!" >expect &&
> @@ -15,7 +16,7 @@ test_expect_success GETTEXT_LOCALE 'gettext: Emitti=
ng UTF-8 from our UTF-8 *.mo
>  '
> =20
>  test_expect_success GETTEXT_LOCALE 'gettext: Emitting UTF-8 from our=
 UTF-8 *.mo files / Runes' '
> -    printf "TILRAUN: =E1=9A=BB=E1=9B=96 =E1=9A=B3=E1=9A=B9=E1=9A=AB=E1=
=9A=A6 =E1=9A=A6=E1=9A=AB=E1=9B=8F =E1=9A=BB=E1=9B=96 =E1=9B=92=E1=9A=A2=
=E1=9B=9E=E1=9B=96 =E1=9A=A9=E1=9A=BE =E1=9A=A6=E1=9A=AB=E1=9B=97 =E1=9B=
=9A=E1=9A=AA=E1=9A=BE=E1=9B=9E=E1=9B=96 =E1=9A=BE=E1=9A=A9=E1=9A=B1=E1=9A=
=A6=E1=9A=B9=E1=9B=96=E1=9A=AA=E1=9A=B1=E1=9B=9E=E1=9A=A2=E1=9B=97 =E1=9A=
=B9=E1=9B=81=E1=9A=A6 =E1=9A=A6=E1=9A=AA =E1=9A=B9=E1=9B=96=E1=9B=A5=E1=
=9A=AB" >expect &&
> +    printf "%s" "$RUNES" >expect &&
>      LANGUAGE=3Dis LC_ALL=3D"$is_IS_locale" gettext "TEST: Old Englis=
h Runes" >actual &&
>      test_cmp expect actual
>  '
> @@ -28,15 +29,19 @@ test_expect_success GETTEXT_ISO_LOCALE 'gettext: =
Emitting ISO-8859-1 from our UT
> =20
>  test_expect_success GETTEXT_ISO_LOCALE 'gettext: Emitting ISO-8859-1=
 from our UTF-8 *.mo files / Runes' '
>      LANGUAGE=3Dis LC_ALL=3D"$is_IS_iso_locale" gettext "TEST: Old En=
glish Runes" >runes &&
> -
> -	if grep "^TEST: Old English Runes$" runes
> +	runes=3D$(cat runes) &&
> +	if test "z$runes" =3D "zTEST: Old English Runes"
> +	then
> +		say "Your system gives back the key to message catalog for an impo=
ssible request"
> +	elif test "z$runes" =3D "zTILRAUN: ?? ???? ??? ?? ???? ?? ??? ?????=
 ??????????? ??? ?? ????"
> +	then
> +		say "Your system replaces an impossible character with ?"
> + 	elif test "z$runes" =3D "z$RUNES"
>  	then
> -		say "Your system can not handle this complexity and returns the st=
ring as-is"
> +		say "Your system gives back the raw message for an impossible requ=
est"
>  	else
> -		# Both Solaris and GNU libintl will return this stream of
> -		# question marks, so it is s probably portable enough
> -		printf "TILRAUN: ?? ???? ??? ?? ???? ?? ??? ????? ??????????? ??? =
?? ????" >runes-expect &&
> -		test_cmp runes-expect runes
> +		say "We error behaviour your system shows"
> +		false
>  	fi
>  '
> =20
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

With that patch the t0204 test is passed.

(based on 1.7.10-rc0).

 And all the other tests passed as well.

/Torsten



Applying: Change t0204-gettext-reencode-sanity.sh to pass under Mac OSX
/Users/tb/projects/git/git_git/.git/rebase-apply/patch:35: space before=
 tab in indent.
        elif test "z$runes" =3D "z$RUNES"
warning: 1 line adds whitespace errors.
~/projects/git/git_git> cd t
~/projects/git/git_git/t> ./t0204-gettext-reencode-sanity.sh
# lib-gettext: No is_IS UTF-8 locale available
# lib-gettext: No is_IS ISO-8859-1 locale available
ok 1 # skip gettext: Emitting UTF-8 from our UTF-8 *.mo files / Iceland=
ic (missing GETTEXT_LOCALE)
ok 2 # skip gettext: Emitting UTF-8 from our UTF-8 *.mo files / Runes (=
missing GETTEXT_LOCALE)
ok 3 # skip gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files / Ic=
elandic (missing GETTEXT_ISO_LOCALE)
ok 4 # skip gettext: Emitting ISO-8859-1 from our UTF-8 *.mo files / Ru=
nes (missing GETTEXT_ISO_LOCALE)
ok 5 # skip gettext: Fetching a UTF-8 msgid -> UTF-8 (missing GETTEXT_L=
OCALE)
ok 6 # skip gettext: Fetching a UTF-8 msgid -> ISO-8859-1 (missing GETT=
EXT_ISO_LOCALE)
ok 7 # skip gettext.c: git init UTF-8 -> UTF-8 (missing GETTEXT_LOCALE)
ok 8 # skip gettext.c: git init UTF-8 -> ISO-8859-1 (missing GETTEXT_IS=
O_LOCALE)
# passed all 8 test(s)
1..8
