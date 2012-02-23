From: Beat Bolli <bbolli@ewanet.ch>
Subject: Re: [PATCH] cherry-pick -x: always insert an empty line
Date: Thu, 23 Feb 2012 09:39:13 +0100
Message-ID: <4F45FB31.4000808@ewanet.ch>
References: <1329599690-9152-1-git-send-email-bbolli@ewanet.ch> <7vhaynp605.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3895BDFBD3820342EE9CAE94"
Cc: git@vger.kernel.org, Eric Raible <raible@nextest.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 09:47:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0ULF-0008IF-2B
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 09:47:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752304Ab2BWIrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 03:47:52 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:38549 "EHLO mx1.2b3w.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861Ab2BWIrv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 03:47:51 -0500
X-Greylist: delayed 509 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Feb 2012 03:47:51 EST
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
	by mx1.2b3w.ch (Postfix) with ESMTP id 8B35BC34C7;
	Thu, 23 Feb 2012 09:39:19 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on dilbert.2b3w.ch
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	NORMAL_HTTP_TO_IP autolearn=ham version=3.3.2
Received: from [10.23.0.73] (gateway-2.swissqual.com [195.137.175.3])
	by mx1.2b3w.ch (Postfix) with ESMTPSA id 6340CC34AC;
	Thu, 23 Feb 2012 09:39:19 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <7vhaynp605.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.3.5
OpenPGP: url=http://drbeat.li/pubkey.asc
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191334>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3895BDFBD3820342EE9CAE94
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2012-02-19 09:44, Junio C Hamano wrote:
> Beat Bolli <bbolli@ewanet.ch> writes:
>=20
>> When cherry-picking a commit that has only a summary, the -x option
>> creates an invalid commit message because it puts the hash of the comm=
it
>> being picked on the second line which should be left empty.
>>
>> This patch fixes this buglet by always inserting an empty line before
>> the added line.
>>
>> Aside from that, even with a non-trivial commit the generated note
>> "(cherry picked from commit 555c9864971744abb558796aea28e12a1ac20839)"=

>> seems abrupt when appended directly.
>>
>> Cc: Eric Raible <raible@nextest.com>
>> Signed-off-by: Beat Bolli <bbolli@ewanet.ch>
>> ---
>>  sequencer.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index 5fcbcb8..63fd589 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -382,7 +382,7 @@ static int do_pick_commit(struct commit *commit, s=
truct replay_opts *opts)
>>  		}
>> =20
>>  		if (opts->record_origin) {
>> -			strbuf_addstr(&msgbuf, "(cherry picked from commit ");
>> +			strbuf_addstr(&msgbuf, "\n(cherry picked from commit ");
>=20
> Doesn't this need to be conditional?
>=20
> If we cherry pick your commit somewhere else with "-x -s", the resultin=
g
> commit log message would end like this:
>=20
>     Aside from that, even with a non-trivial commit the generated note
>     "(cherry picked from commit 555c9864971744abb558796aea28e12a1ac2083=
9)"
>     seems abrupt when appended directly.
>=20
>     Cc: Eric Raible <raible@nextest.com>
>     Signed-off-by: Beat Bolli <bbolli@ewanet.ch>
>=20
>     (cherry picked from commit 555c9864971744abb558796aea28e12a1ac20839=
)
>     Signed-off-by: Frotz Xyzzy <nitfol@example.xz>
>=20
> which clearly is worse-looking with the extra LF you added in this patc=
h.

What should the condition then be? What is the canonical format for
cherry-picks with Signed-off-by: and Cc: footer lines?

>=20
>>  			strbuf_addstr(&msgbuf, sha1_to_hex(commit->object.sha1));
>>  			strbuf_addstr(&msgbuf, ")\n");
>>  		}

--=20
mail: echo '<bNbolOli@ewaSPnetAM.ch>' | tr -d '[A-S]'
pgp: 0x506A903A; 49D5 794A EA77 F907 764F  D89E 304B 93CF 506A 903A
gsm: 4.7.7.6.0.7.7.9.7.1.4.e164.arpa
icbm: 47.0452 N, 7.2715 E
http: www.drbeat.li

"It takes love over gold, and mind over matter" -- Dire Straits


--------------enig3895BDFBD3820342EE9CAE94
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9F+zQACgkQMEuTz1BqkDo8TACffMdbUKTJ6FHC6birSL0KbwVM
EEIAn1YlCGi8P3Bccw6dCplwqOewP6Jr
=S9Zt
-----END PGP SIGNATURE-----

--------------enig3895BDFBD3820342EE9CAE94--
