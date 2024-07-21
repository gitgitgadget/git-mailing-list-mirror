Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2BF10E3
	for <git@vger.kernel.org>; Sun, 21 Jul 2024 00:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721520070; cv=none; b=bXFgGwjN6ORV5K/Yc85Ajc2s0tLVgU3jUXgEpnnAr7absmjKvfTWw0OjfKmmlqQglHeZET6Bb+mn4bAc5XEAicrgNURIAfebRj8lih+zHD+HUzqBfbM5UJK0RqR8p4JPtABYOcS7IxGDOI6c436anCPpW9Yhz+JMYRKja428Hgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721520070; c=relaxed/simple;
	bh=aFSOE9N1A0xjGKp4udtiIa3y5gNwROqNm1J5TL0DsI8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VambX+2BUtBwz3pe6P4p+8KJjodm3U5g72Bse8g42spxd+zalc+rKqDdVk3IJe72Cs2SaLWF8AYFfZ9sbqGApYr/e3QyM8MxP0JaKIMtq+q8v8SOcsaMR8D8A2WPiVFjc0P4mf5/+nT3f2427bOCVTzzgH9xhQz1mGtv78I2Qhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=qYDkEEmg; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qYDkEEmg"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3B0C62C0EF;
	Sat, 20 Jul 2024 20:01:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=aFSOE9N1A0xj
	GKp4udtiIa3y5gNwROqNm1J5TL0DsI8=; b=qYDkEEmgFDw+lXxX32i3BYBfk9X1
	3usjCyW8zg2PsKdw78BshvoPZqXuSO/bzhyhmE+Phb2E7gJcTAKkvQMlsRCOXF3a
	ERXBOR2ObgeY3avSHwrf16jQjXn5dervPQIF4QCu+qOAVMjnBAOAY0NtnRv3jwYW
	3NNH/Z9scNOUQDA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 339172C0EE;
	Sat, 20 Jul 2024 20:01:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B12BB2C0E8;
	Sat, 20 Jul 2024 20:01:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] asciidoctor: fix `synopsis` rendering
In-Reply-To: <xmqqsew3hdmv.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	20 Jul 2024 16:01:12 -0700")
References: <pull.1749.git.git.1721507416683.gitgitgadget@gmail.com>
	<xmqqsew3hdmv.fsf@gitster.g>
Date: Sat, 20 Jul 2024 17:01:02 -0700
Message-ID: <xmqqr0bnfwap.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 523C8646-46F4-11EF-862D-9625FCCAB05B-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> The rendered result is bad in the same way with or without this
> patch applied, and "git clone" manual page is simply incorrect by
> mangling a handful of command line options.  A recent bug report in
> the thread that contains
>
>     https://lore.kernel.org/git/xmqqle1xjm1s.fsf@gitster.g/
>
> gives us more details.

With Jean-No=C3=ABl Avila's {empty} patch applied, would this patch be
still necessary? =20

I am wondering if the reason why "git clone" page needs this patch
while others do not may have something to do with the mistaken
triggering of "generalized roles" feature (whatever it is).  Even
though I dislike that we have to resort to the {empty} hack, if the
misrendered block display you are fixing with this patch is due to
the "generalized roles" problem, fixing the latter would also be the
right fix for your problem.

Thanks.


>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>> index 3f2383a12c7..78e407e4bd1 100644
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -202,6 +202,7 @@ ASCIIDOC_DOCBOOK =3D docbook5
>>  ASCIIDOC_EXTRA +=3D -acompat-mode -atabsize=3D8
>>  ASCIIDOC_EXTRA +=3D -I. -rasciidoctor-extensions
>>  ASCIIDOC_EXTRA +=3D -alitdd=3D'&\#x2d;&\#x2d;'
>> +ASCIIDOC_EXTRA +=3D -adocinfo=3Dshared
>>  ASCIIDOC_DEPS =3D asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
>>  DBLATEX_COMMON =3D
>>  XMLTO_EXTRA +=3D --skip-validation
>> diff --git a/Documentation/docinfo.html b/Documentation/docinfo.html
>> new file mode 100644
>> index 00000000000..fb3560eb92b
>> --- /dev/null
>> +++ b/Documentation/docinfo.html
>> @@ -0,0 +1,5 @@
>> +<style>
>> +pre>code {
>> +   display: inline;
>> +}
>> +</style>
>>
>> base-commit: 76880f0510c6be9f6385f2d43dcfcba4eca9ccbc
