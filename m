Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E9EC433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 10:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238003AbiAGKyI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 05:54:08 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:37259 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237935AbiAGKyF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 Jan 2022 05:54:05 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 48C365C010F
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 05:54:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 07 Jan 2022 05:54:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=fm3; bh=EYCjY5wPlBl/gffNP5OB06cXP9VunJ76bc/ochfR
        BrA=; b=mW9pfO7j6DbSfSB5duIq13CxcGuOvHoaSXHrP40Om9jSKddUwgGPfyeR
        9xYcdBYQg4uANWKYUKuZDXIarHHFNK5TrrNx6FQYVdhbPeQfn/+jitxCxW//+nCt
        wJ2kPE5XQRS8hEN9/PXfXh9H+IuJ5o3HUL/FkWGu6Q37TWdOMC44KGRcZKQXxJ4W
        fFLAAeHC97gTpr2NkEC8K5ctqARmF5RLu0g7qKz3jSJrtqI5JGTkZksU/G/wB9su
        X2loXHz9KkeRcEv7cvYM3CWpa/AjvOC3l+FUjiH+hUODbjfWFsZEnAVrvlio7YyR
        XpzXc83bkQ5rzVndOKy0JUvFk3iQgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=EYCjY5
        wPlBl/gffNP5OB06cXP9VunJ76bc/ochfRBrA=; b=dZ3/jiL+y+luGJS9LKJHkB
        1XBjobfgvK+vMbSxsJ4czLi9PIFHnTkefvO08e3bvBeHK+4WQdjl0mKHYbfrTELp
        VV621YCkmW00nxIcQtfKaDIYidSBIAX9oGVReSpM9JBcGoOyf7IK3+gJfkth0qbl
        tDc/TRu9UYK1QXk7j9frzgBJPyCuDD/fbAS+j2XB5tFYg3zLi7oN16j/TYJkboMq
        SVJIQ/kMHjfqaG+sWW9sw8vJaq7inWd0anKqo1NyrC0DsxgjzC3tk35QAXmjogHR
        nI/kJGx1sIF065i+brXHKG876LtvuPO+ROPrlKcOYNjWMVzt6zxIlt59wRonCJhA
        ==
X-ME-Sender: <xms:zRvYYbEuavRmogAsm4rGzObzsqklu13ecDT-V4PnhHuEiloSw8ytDQ>
    <xme:zRvYYYUDS0jAIUPC5RW4pVKtc5-LkxMNmpy_ox4P9KUBfbmsaLsfLrA758HvZGyC7
    IqSvTrrku7hMY_MUQ>
X-ME-Received: <xmr:zRvYYdJVFrml91Q5Y4HuPgHi6esjlgyoKlHr-10xIbu6DLw-QjHja0noWYvzwwuhmFhIPEwjcw7JPmaUh9KeVFWFkT7bwBu9dUnFZD5LVp1WeSUg3qlGa5Wy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrudeguddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:zRvYYZGiGF7p-q8ni0hcJMGPE4b3O71DPrO_4bUoMl0nXk71WjCkgA>
    <xmx:zRvYYRVCewqLZZsfQHStYBasJ3JJW2qwDf6njSfiXby8S55qcoTs3g>
    <xmx:zRvYYUOdHNYz7YHyS15vRlbId_uq8cI7pzyO3JgJfmazGy061LxO2w>
    <xmx:zRvYYQBC2HXIEIoXfYe-iHAeHQiKbZnMUsdilJ0gsc-ZaOGV0AmRKQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 7 Jan 2022 05:54:04 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 2687e273 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Fri, 7 Jan 2022 10:54:04 +0000 (UTC)
Date:   Fri, 7 Jan 2022 11:53:39 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 1/1] fetch: fix deadlock when cleaning up lockfiles in async
 signals
Message-ID: <c46f42a3a3cbf8e1fc523093f733846d52bf59d3.1641551066.git.ps@pks.im>
References: <cover.1641551066.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ynd8olyxMUmgBEZh"
Content-Disposition: inline
In-Reply-To: <cover.1641551066.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Ynd8olyxMUmgBEZh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When fetching packfiles, we write a bunch of lockfiles for the packfiles
we're writing into the repository. In order to not leave behind any
cruft in case we exit or receive a signal, we register both an exit
handler as well as signal handlers for common signals like SIGINT. These
handlers will then unlink the locks and free the data structure tracking
them. We have observed a deadlock in this logic though:

    (gdb) bt
    #0  __lll_lock_wait_private () at ../sysdeps/unix/sysv/linux/x86_64/low=
levellock.S:95
    #1  0x00007f4932bea2cd in _int_free (av=3D0x7f4932f2eb20 <main_arena>, =
p=3D0x3e3e4200, have_lock=3D0) at malloc.c:3969
    #2  0x00007f4932bee58c in __GI___libc_free (mem=3D<optimized out>) at m=
alloc.c:2975
    #3  0x0000000000662ab1 in string_list_clear ()
    #4  0x000000000044f5bc in unlock_pack_on_signal ()
    #5  <signal handler called>
    #6  _int_free (av=3D0x7f4932f2eb20 <main_arena>, p=3D<optimized out>, h=
ave_lock=3D0) at malloc.c:4024
    #7  0x00007f4932bee58c in __GI___libc_free (mem=3D<optimized out>) at m=
alloc.c:2975
    #8  0x000000000065afd5 in strbuf_release ()
    #9  0x000000000066ddb9 in delete_tempfile ()
    #10 0x0000000000610d0b in files_transaction_cleanup.isra ()
    #11 0x0000000000611718 in files_transaction_abort ()
    #12 0x000000000060d2ef in ref_transaction_abort ()
    #13 0x000000000060d441 in ref_transaction_prepare ()
    #14 0x000000000060e0b5 in ref_transaction_commit ()
    #15 0x00000000004511c2 in fetch_and_consume_refs ()
    #16 0x000000000045279a in cmd_fetch ()
    #17 0x0000000000407c48 in handle_builtin ()
    #18 0x0000000000408df2 in cmd_main ()
    #19 0x00000000004078b5 in main ()

The process was killed with a signal, which caused the signal handler to
kick in and try free the data structures after we have unlinked the
locks. It then deadlocks while calling free(3P).

The root cause of this is that it is not allowed to call certain
functions in async-signal handlers, as specified by signal-safety(7).
Next to most I/O functions, this list of disallowed functions also
includes memory-handling functions like malloc(3P) and free(3P) because
they may not be reentrant. As a result, if we execute such functions in
the signal handler, then they may operate on inconistent state and fail
in unexpected ways.

Fix this bug by just not free'ing memory when running in the signal
handler. We're about to re-raise the signal anyway and will thus exit,
so it's not much of a problem to keep the string list of lockfiles
untouched. Note that it's fine though to call unlink(2), so we'll still
clean up the lockfiles correctly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c |  2 +-
 builtin/fetch.c | 17 +++++++++++------
 transport.c     |  5 +++--
 transport.h     | 14 +++++++++++++-
 4 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5bed37f8b5..585eef9b9a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1290,7 +1290,7 @@ int cmd_clone(int argc, const char **argv, const char=
 *prefix)
 	 */
 	submodule_progress =3D transport->progress;
=20
-	transport_unlock_pack(transport);
+	transport_unlock_pack(transport, 0);
 	transport_disconnect(transport);
=20
 	if (option_dissociate) {
diff --git a/builtin/fetch.c b/builtin/fetch.c
index f1fe73a3e0..2c7a644d69 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -223,17 +223,22 @@ static struct option builtin_fetch_options[] =3D {
 	OPT_END()
 };
=20
-static void unlock_pack(void)
+static void unlock_pack(unsigned int flags)
 {
 	if (gtransport)
-		transport_unlock_pack(gtransport);
+		transport_unlock_pack(gtransport, flags);
 	if (gsecondary)
-		transport_unlock_pack(gsecondary);
+		transport_unlock_pack(gsecondary, flags);
+}
+
+static void unlock_pack_atexit(void)
+{
+	unlock_pack(0);
 }
=20
 static void unlock_pack_on_signal(int signo)
 {
-	unlock_pack();
+	unlock_pack(TRANSPORT_UNLOCK_PACK_SKIP_FREE);
 	sigchain_pop(signo);
 	raise(signo);
 }
@@ -1329,7 +1334,7 @@ static int fetch_and_consume_refs(struct transport *t=
ransport,
 	trace2_region_leave("fetch", "consume_refs", the_repository);
=20
 out:
-	transport_unlock_pack(transport);
+	transport_unlock_pack(transport, 0);
 	return ret;
 }
=20
@@ -1978,7 +1983,7 @@ static int fetch_one(struct remote *remote, int argc,=
 const char **argv,
 		gtransport->server_options =3D &server_options;
=20
 	sigchain_push_common(unlock_pack_on_signal);
-	atexit(unlock_pack);
+	atexit(unlock_pack_atexit);
 	sigchain_push(SIGPIPE, SIG_IGN);
 	exit_code =3D do_fetch(gtransport, &rs);
 	sigchain_pop(SIGPIPE);
diff --git a/transport.c b/transport.c
index 92ab9a3fa6..f636163d05 100644
--- a/transport.c
+++ b/transport.c
@@ -1456,13 +1456,14 @@ int transport_fetch_refs(struct transport *transpor=
t, struct ref *refs)
 	return rc;
 }
=20
-void transport_unlock_pack(struct transport *transport)
+void transport_unlock_pack(struct transport *transport, unsigned int flags)
 {
 	int i;
=20
 	for (i =3D 0; i < transport->pack_lockfiles.nr; i++)
 		unlink_or_warn(transport->pack_lockfiles.items[i].string);
-	string_list_clear(&transport->pack_lockfiles, 0);
+	if ((flags & TRANSPORT_UNLOCK_PACK_SKIP_FREE) =3D=3D 0)
+		string_list_clear(&transport->pack_lockfiles, 0);
 }
=20
 int transport_connect(struct transport *transport, const char *name,
diff --git a/transport.h b/transport.h
index 8bb4c8bbc8..8949ea9d04 100644
--- a/transport.h
+++ b/transport.h
@@ -279,7 +279,19 @@ const struct ref *transport_get_remote_refs(struct tra=
nsport *transport,
  */
 const struct git_hash_algo *transport_get_hash_algo(struct transport *tran=
sport);
 int transport_fetch_refs(struct transport *transport, struct ref *refs);
-void transport_unlock_pack(struct transport *transport);
+
+/*
+ * If this flag is set, then the data structures tracking the locked packf=
iles
+ * will not be free'd on unlock. This flag should only be passed when exec=
uted
+ * in a signal handler where free(3P) cannot be relied upon.
+ */
+#define TRANSPORT_UNLOCK_PACK_SKIP_FREE (1 << 0)
+
+/*
+ * Unlock all packfiles locked by the transport.
+ */
+void transport_unlock_pack(struct transport *transport, unsigned int flags=
);
+
 int transport_disconnect(struct transport *transport);
 char *transport_anonymize_url(const char *url);
 void transport_take_over(struct transport *transport,
--=20
2.34.1


--Ynd8olyxMUmgBEZh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHYG7IACgkQVbJhu7ck
PpS0rRAAivYQe15gXpFei4Z+6jKDHskZhU7qM+mDX7UGeh0AGu6asmyr/vaUOOew
uGIUxJEaoHjH3MrSlXyEF9X7aUXykPzaELhunqMWjh/8rBUYzDXpGM4WoAfAAc6H
f3slUmJfImZsKHM5VRdaA7xnvB648W4T1LPrqsaGDpHoT9useGfV1jiLdQt3Wozn
xqjDs4AaxKCAn9cK/+9XuqyP6xBCNzGBMd3pCVwTj3a9IkZNdIo29EgWfr3YVEVp
ODgkBbDev4nePNIEpHSqaI6j697ufZembSQbYbkcq7T2Ye47FMqjhhJWVvNLWzg4
BEgF/kG7tb6KZ+ncehOyCpeOU3falv8g0F4LOsBCw+xXUstiO4mPSVqUyeJRVl45
IhFZFCAqw/j5Q9TbXzga7QlRzUDA1GrkOO32zGuLqdlJSXDuj2rJgMC/u7xZECLx
9SwgsE4O/NwJkEvpm7ao10diOMt6Wy7AOKjIEGQSOzlZicFXr1iFGtpvjhU/M7jM
ZJe5s0VivKaUZwI2nZOOA1lJQC3agIr3Otzm1AVRYKTC8gaz23Nz8ivNMZO50Cdd
3vvXdix8LPv2Lqk85BWJ6fQgTJTIG1hYt+QiQ4kiyrBUiNZN6mfXKHNeZ0Telntp
5ehcauEmtQOzYE+nRvqcb/j8jHzrartP9W0JmUAC8Vza/h+Ab5I=
=hYxZ
-----END PGP SIGNATURE-----

--Ynd8olyxMUmgBEZh--
