Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B6B320288
	for <e@80x24.org>; Fri, 21 Jul 2017 15:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754099AbdGUP1j (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 11:27:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751464AbdGUP1C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 11:27:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 70142C00BB06;
        Fri, 21 Jul 2017 15:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 70142C00BB06
Authentication-Results: ext-mx07.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=redhat.com
Authentication-Results: ext-mx07.extmail.prod.ext.phx2.redhat.com; spf=pass smtp.mailfrom=eblake@redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com 70142C00BB06
Received: from [10.3.117.102] (ovpn-117-102.phx2.redhat.com [10.3.117.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B96717AC3;
        Fri, 21 Jul 2017 15:27:02 +0000 (UTC)
Subject: Re: [PATCH] git-contacts: Add recognition of Reported-by
To:     Junio C Hamano <gitster@pobox.com>
References: <20170721141530.25907-1-eblake@redhat.com>
 <xmqqbmodj1pa.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Eric Blake <eblake@redhat.com>
Openpgp: url=http://people.redhat.com/eblake/eblake.gpg
Organization: Red Hat, Inc.
Message-ID: <a8b47a45-0100-dbef-0bff-fdfdb9cbccb4@redhat.com>
Date:   Fri, 21 Jul 2017 10:27:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqbmodj1pa.fsf@gitster.mtv.corp.google.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="bGgOH3ABX16d6RoNNNII99ri0N03Tph27"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 21 Jul 2017 15:27:02 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bGgOH3ABX16d6RoNNNII99ri0N03Tph27
Content-Type: multipart/mixed; boundary="a39v2sEUaLCQet4Usg7htsPV4FkoqE7eg";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-ID: <a8b47a45-0100-dbef-0bff-fdfdb9cbccb4@redhat.com>
Subject: Re: [PATCH] git-contacts: Add recognition of Reported-by
References: <20170721141530.25907-1-eblake@redhat.com>
 <xmqqbmodj1pa.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqbmodj1pa.fsf@gitster.mtv.corp.google.com>

--a39v2sEUaLCQet4Usg7htsPV4FkoqE7eg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 09:37 AM, Junio C Hamano wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> It's nice to cc someone that reported a bug, in order to let
>> them know that a fix is being considered, and possibly even
>> get their help in reviewing/testing the patch.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>=20
> I don't know if this new one deserves to be part of the hardcoded
> defaults; it would be different between the projects and depends on
> their convention.  I notice that there is no way to configure this
> script and I suspect that it would be a more generally useful update
> to have it read a configuration variable that lists what kind of sob
> like things to take addresses from.

You mean, something like

git config --add contacts.autocc Reported-by
git config --add contacts.autocc Suggested-by

where contacts.autocc would be a new multi-valued config option
specifying additional Tag: patterns to scrape out of the commit message?

The idea seems reasonable, except that I have less experience with
writing patches that interact with git config than I do for my one-liner
attempt, so I would welcome any help from someone with more familiarity
with the code base.

Also, putting it in 'git config' still means that it is a per-developer
responsibility to choose which patterns to add to their list.  Is there
any easy way to make a particular repository supply the same list for
all developers who check it out, without them having to munge things?

Also, I'm worried about sendemail.cccmd - that's a script that could
usefully call 'git contacts' under the hood, but that argues that there
should be a command-line override (and not just 'git config') for
choosing an alternative list of autocc tag patterns on a per-invocation
basis.  Again, it requires a per-developer setup to wire in a cccmd, but
telling developers a one-liner config to set up the command is easier
than telling them multiple lines for contacts.autocc.

And while we're on the topic of per-project useful defaults, it would be
nice if diff.orderFile could easily be set to a per-project default,
rather than requiring per-developer efforts to set that up.

But yes, I _definitely_ want to be able for a given project to easily
autocc the tags that it finds appropriate.  Your point that different
projects have different tags makes total sense (I'm hoping to use
Suggested-by as one of the tags in qemu, but agree that it is not as
easy to argue that Suggested-by should be in the hardcoded defaults,
which is why my initial submission only added Reported-by).

>=20
> Thanks.
>=20
>>  contrib/contacts/git-contacts | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/contrib/contacts/git-contacts b/contrib/contacts/git-cont=
acts
>> index dbe2abf27..85ad732fc 100755
>> --- a/contrib/contacts/git-contacts
>> +++ b/contrib/contacts/git-contacts
>> @@ -11,7 +11,7 @@ use IPC::Open2;
>>
>>  my $since =3D '5-years-ago';
>>  my $min_percent =3D 10;
>> -my $labels_rx =3D qr/Signed-off-by|Reviewed-by|Acked-by|Cc/i;
>> +my $labels_rx =3D qr/Signed-off-by|Reviewed-by|Acked-by|Cc|Reported-b=
y/i;
>>  my %seen;
>>
>>  sub format_contact {
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--a39v2sEUaLCQet4Usg7htsPV4FkoqE7eg--

--bGgOH3ABX16d6RoNNNII99ri0N03Tph27
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllyHUUACgkQp6FrSiUn
Q2rZbAf9FpR9TFzptYaJzZKaP989HFDDbIxGS7VxaFZ63rNaP9P7kKQGAqRq4Fwb
vR0ninEyHcHXPNOA3h6VXOwnLrJHjNiuC+cef1mx2wgK40+lJQOghW+HPB6g+Get
10hYtSkf1KRauOzRiAj2t5b92yN2VoQhsDX8npPi8i0Ir2QhkZQH0w9pZYMiIp7X
/xCaka9w5PMDsaTt8z7ghsFcGHHrXxJKlRp/iX82xveadIIghk2W8j4pMok5Ldnn
4nboHXdbHhXGGzr3vNcSMPjL1JzCl0H/d7spzGRcKqp1v99Qe2DFIGLq05qQKbuT
8FgrMgF4hw/9tqTBvrzQzrUqWR1LEg==
=t7+b
-----END PGP SIGNATURE-----

--bGgOH3ABX16d6RoNNNII99ri0N03Tph27--
