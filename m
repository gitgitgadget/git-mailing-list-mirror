Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F15639FFB
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 20:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717792534; cv=none; b=pzAv8V7IwxTZtkdfHocScdKB9tDJ4wDFvxDhy4TpBoKnBOuHQlBYPp4oo31JQ5O7IAOxXaa4J0w+aEf8k0TKc18DMUorFt31NeA6QwgRUag+Nw1hdMTBrHxqyF4CTXko5kYC7JVqLAFUXcoJgUZ7tQQEVcCa127Dh+K7dCpX9hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717792534; c=relaxed/simple;
	bh=uUX4XSSEh/wRRnDA/h8j8aLncHrUVzW6s09r8thacAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lu4OK1T9FCx3nAI+K9lwtU0J9Z+9gaf0MaJSejb7aYW7KU7I0jbkjt6atANTdvjCcptyM5M68nGFNhdsroaKdxSs4TSWb4IE5x1hd2XAdOhldgJhflFtJT3Gp+axhdgJLC/l4/6+QTBtsT7S1MkWEQJTk0XWgFi+PN7+khluybw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=j15CvPVi; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="j15CvPVi"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 58F9718842;
	Fri,  7 Jun 2024 16:35:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uUX4XSSEh/wR
	RnDA/h8j8aLncHrUVzW6s09r8thacAA=; b=j15CvPViN/ICCjUulyhVUY8J5RYV
	jZSUJp0BQSCF/oKOVhnjI7m0U65X1In4ZzQfrG43qi5jyzTGPBSTKu1y3ossdQ69
	dm/AYmyNIs+Riyrc9At15Wq3wRYt2eO+07QwpobiZD7+hHR+aEOOc6THoBGFOlQV
	UhC8zeHJvVS41po=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 51C5918841;
	Fri,  7 Jun 2024 16:35:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6FC1818840;
	Fri,  7 Jun 2024 16:35:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] ci: compile "linux-gcc-default" job with -Og
In-Reply-To: <xmqqed98d1wn.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	07 Jun 2024 11:48:56 -0700")
References: <20240606080552.GA658959@coredump.intra.peff.net>
	<cover.1717662814.git.ps@pks.im>
	<bdf0e40a770c57b63e7519983d37b97a85ce07bf.1717662814.git.ps@pks.im>
	<xmqqed98d1wn.fsf@gitster.g>
Date: Fri, 07 Jun 2024 13:35:28 -0700
Message-ID: <xmqq34pofq3z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 7AACD9A4-250D-11EF-B746-8F8B087618E4-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

>   pack-mtimes.c: In function =E2=80=98load_pack_mtimes_file=E2=80=99:
>   Error: pack-mtimes.c:89:25: =E2=80=98mtimes_size=E2=80=99 may be used=
 uninitialized in this function [-Werror=3Dmaybe-uninitialized]
>      89 |                         munmap(data, mtimes_size);
>         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
>   cc1: all warnings being treated as errors
>   make: *** [Makefile:2757: pack-mtimes.o] Error 1
>   make: *** Waiting for unfinished jobs....

The use on line 89 is guarded with "if (data)" and data can become
non-NULL only after mtimes_size is computed, so this is benign.

They have excuse for a false positive because the warning is about
"maybe" uninitialized, but that does not help our annoyance factor
X-<.

>   pack-revindex.c: In function =E2=80=98load_revindex_from_disk=E2=80=99=
:
>   Error: pack-revindex.c:260:25: =E2=80=98revindex_size=E2=80=99 may be=
 used uninitialized in this function [-Werror=3Dmaybe-uninitialized]
>     260 |                         munmap(data, revindex_size);
>         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>   cc1: all warnings being treated as errors
>   make: *** [Makefile:2757: pack-revindex.o] Error 1
>   cat: exit.status: No such file or directory

This follows exactly the same pattern established by the other one
(or perhaps the other one copied from here).  It is another false
positive.

I am not sure what the right fix would be.  For example, if we were
interested in avoiding to incur too much resources for revindex, we
might do something like this

--- i/pack-revindex.c
+++ w/pack-revindex.c
@@ -258,6 +258,8 @@ static int load_revindex_from_disk(char *revindex_nam=
e,
 	if (ret) {
 		if (data)
 			munmap(data, revindex_size);
+		fprintf(stderr, "would have fit %d revindex in 10MB\n",
+			10 * 1024 * 1024 / revindex_size);
 	} else {
 		*len_p =3D revindex_size;
 		*data_p =3D (const uint32_t *)data;

without even guarding with "if (data)".

If we "initialize" revindex_size to a meaningless dummy value like 0
like the attached would _hide_ such a real bug from the compiler, so
I dunno.

@@ -206,7 +206,7 @@ static int load_revindex_from_disk(char *revindex_nam=
e,
 	int fd, ret =3D 0;
 	struct stat st;
 	void *data =3D NULL;
-	size_t revindex_size;
+	size_t revindex_size =3D 0;
 	struct revindex_header *hdr;
=20
 	if (git_env_bool(GIT_TEST_REV_INDEX_DIE_ON_DISK, 0))
