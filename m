Received: from mail-10699.protonmail.ch (mail-10699.protonmail.ch [79.135.106.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C087FD
	for <git@vger.kernel.org>; Sat, 18 Jan 2025 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737219015; cv=none; b=u99RQsExwLS/TOsBxT8Fq0dfwcQ/mAQ8DEheRhMg4t6PHobgJctvrwTgSkkvQOSHExKMmb2ZJKShJloi/VilV0nzo0734Qb65GqG40DeQUIUpgJJb5m7o6hdl75LsiFhhpEQPXdz4IyGpVHW+C5ML+SSnrG+awVfsYTI/D6BjEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737219015; c=relaxed/simple;
	bh=mGyTIhxzHtpIMGvCncRYshiZK7jjzKmGlCZmgAYgSIQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lOz9Qiny0QRbRetGZ4kpzhJe5vsI3cBpFJavHsvfXsDMnkL6mVwwEjXfc/sfkffq+yrqP++VuhE0nuTMK3VZkZ/qSr4TbT86pbZE5NgtdmdTumJfqndZKELWuQxYgm78KhGhZFwBXYvRXtgwZykDxvKpQ3HCOInpTyZBDW0ZH3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=H09djUwa; arc=none smtp.client-ip=79.135.106.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="H09djUwa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1737219006; x=1737478206;
	bh=mGyTIhxzHtpIMGvCncRYshiZK7jjzKmGlCZmgAYgSIQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=H09djUwabMKwXDmjHxB1OuTTO2mrkjyZoGgWyTKMwFQiWZbGkR5hFpOE2RUsy67yF
	 BKK2fhsbEqFSWMq8bEZt5V+LKzSCknfv0g2OknZ6x7z3vG64njUw3zGiXAH6YKNFnc
	 1ZzIzyS0CrYOe/uyx3EfS4cNJJm/n2kGoLGVNLIIU0EQReMSltfNJ9ufkNqTeHYhgL
	 ve0gIdF3TFmk0hXRka00ozenbqII+pJT/uxO7eenfGmMZUSr8SfuULTo9fQgczwJRw
	 7qFxZlXga10EaaPcbLOwpBFAmAqqWpPIv99E9eLdMvDaQbV0Kz8ftqx3Zd43Pvi8Xc
	 RvfcSK+fzJL2w==
Date: Sat, 18 Jan 2025 16:50:01 +0000
To: Jeff King <peff@peff.net>
From: Koakuma <koachan@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] git crashes with a SIGBUS on sparc64 during pull
Message-ID: <WnIqKOrqOA2N9RtHmebZaMv3F-XW203leJkiT-5GFU61g3xHbkoJgXwkLfr5G-09fjbU-AX6Eji8kBMUDtjngAw0yRxQuy-rna6Eiov_E4I=@protonmail.com>
In-Reply-To: <20250118092048.GA3474411@coredump.intra.peff.net>
References: <xd6Mn7uXpDxaT8zF28BwOIdV98lnvm3S0rBgxmm97nuRW3z0GQSUi_KeYe0fUuRfz8rCgo6Uialw5rnraqp5tjzMFQkFH0MZV_n4fEQg8go=@protonmail.com> <20250117121121.GA2356599@coredump.intra.peff.net> <20250117125207.GB2356599@coredump.intra.peff.net> <nwg0r52UT4d_kBbQa7V7xCWKxE1xtHiwXKtBvzEwxtJa-3nKpXcWG2DRGUENDSJQ9QOkk4jrEaXYjAbiSAZds2ynH1TZPcX3x6T_t4zm8s4=@protonmail.com> <20250118092048.GA3474411@coredump.intra.peff.net>
Feedback-ID: 6608610:user:proton
X-Pm-Message-ID: 64cfdb020a1778b7e4ca313b4a0006626db1c843
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jeff King <peff@peff.net> wrote:
> The union thing should be portable, I'd think, but unfortunately has a
> lot of fallout through the code because the name of "buffer" changes (we
> could also declare the storage separately and make "buffer" a pointer to
> it, but we'd have to be careful about calls to sizeof()).
>=20
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index 2197d6d933..65db435b46 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -23,7 +23,10 @@ static int dry_run, quiet, recover, has_errors, strict=
;
> static const char unpack_usage[] =3D "git unpack-objects [-n] [-q] [-r] [=
--strict]";
>=20
> /* We always read in 4kB chunks. */
> -static unsigned char buffer[4096];
> +static union {
> + struct pack_header hdr;
> + unsigned char bytes[4096];
> +} buffer;
> static unsigned int offset, len;
> static off_t consumed_bytes;
> static off_t max_input_size;
> @@ -65,24 +68,24 @@ static void add_object_buffer(struct object *object, =
char *buffer, unsigned long
> static void *fill(int min)
> {
> if (min <=3D len)
> - return buffer + offset;
> - if (min > sizeof(buffer))
>=20
> + return buffer.bytes + offset;
> + if (min > sizeof(buffer.bytes))
>=20
> die("cannot fill %d bytes", min);
> if (offset) {
> - the_hash_algo->update_fn(&ctx, buffer, offset);
>=20
> - memmove(buffer, buffer + offset, len);
> + the_hash_algo->update_fn(&ctx, buffer.bytes, offset);
>=20
> + memmove(buffer.bytes, buffer.bytes + offset, len);
> offset =3D 0;
> }
> do {
> - ssize_t ret =3D xread(0, buffer + len, sizeof(buffer) - len);
> + ssize_t ret =3D xread(0, buffer.bytes + len, sizeof(buffer.bytes) - len=
);
> if (ret <=3D 0) {
> if (!ret)
> die("early EOF");
> die_errno("read error on input");
> }
> len +=3D ret;
> } while (len < min);
> - return buffer;
> + return buffer.bytes;
> }
>=20
> static void use(int bytes)
> @@ -645,18 +648,16 @@ int cmd_unpack_objects(int argc,
> continue;
> }
> if (starts_with(arg, "--pack_header=3D")) {
> - struct pack_header *hdr;
> char *c;
>=20
> - hdr =3D (struct pack_header *)buffer;
> - hdr->hdr_signature =3D htonl(PACK_SIGNATURE);
>=20
> - hdr->hdr_version =3D htonl(strtoul(arg + 14, &c, 10));
>=20
> + buffer.hdr.hdr_signature =3D htonl(PACK_SIGNATURE);
> + buffer.hdr.hdr_version =3D htonl(strtoul(arg + 14, &c, 10));
> if (*c !=3D ',')
> die("bad %s", arg);
> - hdr->hdr_entries =3D htonl(strtoul(c + 1, &c, 10));
>=20
> + buffer.hdr.hdr_entries =3D htonl(strtoul(c + 1, &c, 10));
> if (*c)
> die("bad %s", arg);
> - len =3D sizeof(*hdr);
> + len =3D sizeof(buffer.hdr);
> continue;
> }
> if (skip_prefix(arg, "--max-input-size=3D", &arg)) {
> @@ -671,7 +672,7 @@ int cmd_unpack_objects(int argc,
> }
> the_hash_algo->init_fn(&ctx);
>=20
> unpack_all();
> - the_hash_algo->update_fn(&ctx, buffer, offset);
>=20
> + the_hash_algo->update_fn(&ctx, buffer.bytes, offset);
>=20
> the_hash_algo->init_fn(&tmp_ctx);
>=20
> the_hash_algo->clone_fn(&tmp_ctx, &ctx);
>=20
> the_hash_algo->final_oid_fn(&oid, &tmp_ctx);
>=20
> @@ -686,7 +687,7 @@ int cmd_unpack_objects(int argc,
> use(the_hash_algo->rawsz);
>=20
>=20
> /* Write the last part of the buffer to stdout /
> - write_in_full(1, buffer + offset, len);
> + write_in_full(1, buffer.bytes + offset, len);
>=20
> / All done */
> return has_errors;

This patch works well here, yes.

> I guess that's not too surprising. Probably an application of get_be32()
> would solve it. But I do wonder if it would be simpler just to make sure
> the buffer is aligned. You mentioned that you tried that before and it
> worked. How did you do it? With a pragma/attribute, or with a union (as
> below)?

I did it by adding an attribute, though probably a better implementation wo=
uld
query for the alignment of `structack_hdr` instead of hardcoding it.

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 842a90353a..98f270ec0c 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -23,7 +23,7 @@ static int dry_run, quiet, recover, has_errors, strict;
 static const char unpack_usage[] =3D "git unpack-objects [-n] [-q] [-r] [-=
-strict]";
=20
 /* We always read in 4kB chunks. */
-static unsigned char buffer[4096];
+static unsigned char buffer[4096] __attribute__((aligned(16)));
 static unsigned int offset, len;
 static off_t consumed_bytes;
 static off_t max_input_size;

