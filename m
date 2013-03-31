From: =?UTF-8?B?U2ViYXN0aWFuIEfDtnR0ZQ==?= <jaseg@physik.tu-berlin.de>
Subject: Re: [PATCH v5 4/5] merge/pull Check for untrusted good GPG signatures
Date: Sun, 31 Mar 2013 12:55:19 +0200
Message-ID: <51581617.1030107@physik.tu-berlin.de>
References: <7vy5d7qhmm.fsf@alter.siamese.dyndns.org> <cover.1364601337.git.jaseg@physik-pool.tu-berlin.de> <51562E79.7000202@physik.tu-berlin.de> <87obe0x94e.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 31 12:56:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMFvh-0002Fv-2C
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 12:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569Ab3CaKzg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Mar 2013 06:55:36 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:19017 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754270Ab3CaKzg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 06:55:36 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-3) with esmtp 
	id 1UMFvB-00051o-Db; Sun, 31 Mar 2013 12:55:35 +0200
Received: from [94.45.250.108] (unknown [94.45.250.108])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id 074F311402;
	Sun, 31 Mar 2013 12:55:29 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <87obe0x94e.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219610>

On 03/31/2013 10:32 AM, Thomas Rast wrote:
> Sebastian G=C3=B6tte <jaseg@physik.tu-berlin.de> writes:
>=20
>> When --verify-signatures is specified, abort the merge in case a goo=
d
>> GPG signature from an untrusted key is encountered.
> [...]
>> +test_expect_success GPG 'merge  commit with untrusted signature wit=
h verification' '
>                                   ^
>                                   `------------.
> Nit: you have a pointless(?) double space here-=C2=B4
Will fix that in the next revision ;)

>> +	test_must_fail git merge --ff-only --verify-signatures side-untrus=
ted 2>mergeerror &&
>> +	test_i18ngrep "from an untrusted key" mergeerror
>> +'
>=20
> This test gives me the following:
>=20
> =3D=3D26527=3D=3D Conditional jump or move depends on uninitialised v=
alue(s)
> =3D=3D26527=3D=3D    at 0x4C2D8BC: strchrnul (mc_replace_strmem.c:108=
4)
> =3D=3D26527=3D=3D    by 0x4989CC: parse_signature_lines (commit.c:107=
4)
> =3D=3D26527=3D=3D    by 0x498B33: check_commit_signature (commit.c:11=
00)
> =3D=3D26527=3D=3D    by 0x453719: cmd_merge (merge.c:1246)
> =3D=3D26527=3D=3D    by 0x4057B6: run_builtin (git.c:282)
> =3D=3D26527=3D=3D    by 0x405949: handle_internal_command (git.c:444)
> =3D=3D26527=3D=3D    by 0x405A63: run_argv (git.c:490)
> =3D=3D26527=3D=3D    by 0x405BF2: main (git.c:565)
>=20
> though I currently cannot see what's wrong, probably because I don't
> know the format that parse_signature_lines gives.  Can you look into =
it?
Against what version/combination of the patches are you running the tes=
t?
parse_signature_lines is called parse_gpg_output in v5.  Perhaps just t=
ry again
with v6 of the patch, the difference between v5 and v6 is parse_gpg_out=
put
(Junio did not like the v5 variant).

Thanks
Sebastian=20
