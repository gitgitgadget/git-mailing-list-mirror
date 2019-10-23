Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F8221F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 15:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406461AbfJWPD4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 11:03:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39653 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390431AbfJWPD4 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 23 Oct 2019 11:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571843034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cy3EDS4djcxdRnyFqaKi9iyZ9aRUhpiH3M4IStzyL7I=;
        b=C9TfRwaEcSUZmwk849kUHvYe8sO6WltXL6ysqc1esS5a95Lgt0TpJG0fK7i++3yDBZ3QxC
        9JCul701yjYEGdDcKpTtaRWlG88gfTuPLgAL0rTH5KXGFdCHiQ4A+zuSjM5DSIW+BQTNtL
        UAzd5WLuAgHfnDZfJYG5d62D8e5VQKM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-kAerFoL0O_KIQPzWURFE-A-1; Wed, 23 Oct 2019 11:03:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4F49801E5C;
        Wed, 23 Oct 2019 15:03:51 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E17D60C5D;
        Wed, 23 Oct 2019 15:03:51 +0000 (UTC)
Subject: Re: [PATCH] pretty: Add "%aU"|"%au" option to output author's
 username
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20191022232847.5212-1-prarit@redhat.com>
 <xmqqy2xcjqc8.fsf@gitster-ct.c.googlers.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <987b7743-df0c-dbcf-6336-23f2903c061a@redhat.com>
Date:   Wed, 23 Oct 2019 11:03:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqy2xcjqc8.fsf@gitster-ct.c.googlers.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: kAerFoL0O_KIQPzWURFE-A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/22/19 7:46 PM, Junio C Hamano wrote:
> Prarit Bhargava <prarit@redhat.com> writes:
>=20
>> Subject: Re: [PATCH] pretty: Add "%aU"|"%au" option to output author's u=
sername
>=20
> Downcase "Add" (see "git shortlog --no-merges -100 master" and
> mimick the project convention).

I'll fix that.

>=20
>> Add a "%aU"|"%au" option that outputs the author's email username.
>=20
> Even though I personally do not see the use for it, I agree it would
> make sense to have an option to show the local part only where the
> e-mail address is shown. =20
>=20
> I do not know if u/U is a good mnemonic; it hints too strongly that
> it may come from GIT_{AUTHOR/COMMITTER}_NAME but that is not what
> you are doing---isn't there a letter that better conveys that this
> is about RFC 2822 local-part (cf. page 16 ieft.org/rfc/rfc2822.txt)?

I'll go with "l" and "L" for local-part as defined on page 16.  I will also
include a comment in braces that says (the portion of the email address
preceding the '@' symbol)".  Admittedly that doesn't convey the meaning of =
the
mailbox concept of the email address it does tell a user what is going to b=
e output.

>=20
>> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-for=
mats.txt
>> index b87e2e83e6d0..479a15a8ab12 100644
>> --- a/Documentation/pretty-formats.txt
>> +++ b/Documentation/pretty-formats.txt
>> @@ -163,6 +163,9 @@ The placeholders are:
>>  '%ae':: author email
>>  '%aE':: author email (respecting .mailmap, see linkgit:git-shortlog[1]
>>  =09or linkgit:git-blame[1])
>> +'%au':: author username
>> +'%aU':: author username (respecting .mailmap, see linkgit:git-shortlog[=
1]
>> +=09or linkgit:git-blame[1])
>>  '%ad':: author date (format respects --date=3D option)
>>  '%aD':: author date, RFC2822 style
>>  '%ar':: author date, relative
>=20
>> diff --git a/pretty.c b/pretty.c
>> index b32f0369531c..2a5b93022050 100644
>> --- a/pretty.c
>> +++ b/pretty.c
>> @@ -706,6 +706,11 @@ static size_t format_person_part(struct strbuf *sb,=
 char part,
>>  =09=09strbuf_add(sb, mail, maillen);
>>  =09=09return placeholder_len;
>>  =09}
>> +=09if (part =3D=3D 'u' || part =3D=3D 'U') {=09/* username */
>> +=09=09maillen =3D strstr(s.mail_begin, "@") - s.mail_begin;
>> +=09=09strbuf_add(sb, mail, maillen);
>> +=09=09return placeholder_len;
>> +=09}
>=20
> I think users get %eu and %eU for free with this change, which should
> be documented.
>=20

Did you mean %cu and %cU?  Or am I missing something with "%e"?

P.

