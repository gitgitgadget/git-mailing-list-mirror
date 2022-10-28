Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44693ECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 14:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJ1Om6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 10:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiJ1Omd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 10:42:33 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399991D3E94
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 07:42:30 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A398C5C00C2
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 10:42:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 28 Oct 2022 10:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1666968149; x=1667054549; bh=Kz9wSJMi82
        Vwhy8R25UVQPkyLqMgrLWhJJAybFTLSr0=; b=TX0ywOYWjOH+DMlzVpuN47KPdb
        EdGCZ9qJ4JGbecm8p40klqKH2ix2B6j0cZJX6MTL2/4NpnqRdhqzrCbPyLeDBgID
        jP/uAl1ExcCp8eNw8K4Dkbqcx5/3o3Sk0J7Oce2pXhl1ot7Fz1f0q3KC7aIR3oMX
        CHqlkRv+VEPEoIpo4U1XDEZ4CAc20ROftrD/1iWspQYgEUqU7ZBK5VHOUewBVbbP
        EYvBXrvgbb9UHxqW9VvUyuqxVQ8q1HGAfu7AgGxyNrhiMzYaX637Q0g7+7DtBCGa
        6wU1HycgRwiYJ+QZqiYNXJwDVeTzWEcHO03DLgOZzSiPJ5lkKWzKKwV+2guA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666968149; x=1667054549; bh=Kz9wSJMi82Vwhy8R25UVQPkyLqMg
        rLWhJJAybFTLSr0=; b=Xe8sAn0IuvUek/CM8hH0FUMdfAxtEAnb4C0ikm8lLhER
        ZU6w9o0Oqidwp8S6qbGQ3/wKZawk7EsFJuFpGE9zcyJc8LlMRKqNHUEMrEPwdi+N
        Q0N33sOiFEk/hqmbdTC1Filc0UJZBUEOP3PqyB5PihdKOdfmCZ4GreDDonD7+/vz
        /VGm+QSZuBrzUansKRrQanHCtseP/vzTbFB+b9qhnjX3SaLCQbZ8Q1/4zGcP6KEh
        jUeTInRVaVJXtgS1HZGrQ5NdEKb+fP6SjA46Z7UfOMCMOMlQLbASmDXTvQhPIt8U
        qSJb04+noCImsZ+B2tm0KCQj6+M0QT1lUjmuqslTKw==
X-ME-Sender: <xms:VepbY1l1NF2NUUKFWUIzCCKcD5GaauMcGXn1dZt_6diETVos0wPBaQ>
    <xme:VepbYw0JxnRrAKPOGm7eEzSKGVGOr4-jR8WuSeHCcAGB4tTX8frGfw8TZ61sZvOeO
    6v3HHpc9XxdsFsTRQ>
X-ME-Received: <xmr:VepbY7rgzzk5tByJZ2VdhdZMCAwQhKvlo3a_CovAsF0UAJsGwmozTtCxCUkZmCPDAZRLW18tystzB_fb1GIK9rMiXf9s5eg8L25nay2tBfpX3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeigdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgfejueevjeetudehgffffeffvdejfeejie
    dvkeffgfekuefgheevteeufeelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:VepbY1k3xR1Pr3SiJuFHGfCfjUO84HZ1K4DWu1wSqMfexYp7T6J34A>
    <xmx:VepbYz1LAk2ytZACEbc9Jz75h1FG4r-3WeBTq0gEIZ1LnNAB5eg0ew>
    <xmx:VepbY0tztZzwMuVxv6xB-NBAP3N7k4k3XohK7amKixn_7tlEJgFu0g>
    <xmx:VepbY4hwy94ep0QSRLuktLiNK-m_mN425bz9dy3AUs-IibLQbB16PQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 28 Oct 2022 10:42:28 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id ea34f43a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Fri, 28 Oct 2022 14:42:22 +0000 (UTC)
Date:   Fri, 28 Oct 2022 16:42:27 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] receive-pack: use advertised reference tips to inform
 connectivity check
Message-ID: <006e89f384be1227b922fb6fdc8755ae84cac587.1666967670.git.ps@pks.im>
References: <cover.1666967670.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G3xYM+2XhxAIeiw6"
Content-Disposition: inline
In-Reply-To: <cover.1666967670.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--G3xYM+2XhxAIeiw6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When serving a push, git-receive-pack(1) needs to verify that the
packfile sent by the client contains all objects that are required by
the updated references. This connectivity check works by marking all
preexisting references as uninteresting and using the new reference tips
as starting point for a graph walk.

This strategy has the major downside that it will not require any object
to be sent by the client that is reachable by any of the repositories'
references. While that sounds like it would be indeed what we are after
with the connectivity check, it is arguably not. The administrator that
manages the server-side Git repository may have configured certain refs
to be hidden during the reference advertisement via `transfer.hideRefs`
or `receivepack.hideRefs`. Whatever the reason, the result is that the
client shouldn't expect that any of those hidden references exists on
the remote side, and neither should they assume any of the pointed-to
objects to exist except if referenced by any visible reference. But
because we treat _all_ local refs as uninteresting in the connectivity
check, a client is free to send a packfile that references objects that
are only reachable via a hidden reference on the server-side, and we
will gladly accept it.

Besides the correctness issue there is also a performance issue. Git
forges tend to do internal bookkeeping to keep alive sets of objects for
internal use or make them easy to find via certain references. These
references are typically hidden away from the user so that they are
neither advertised nor writeable. At GitLab, we have one particular
repository that contains a total of 7 million references, of which 6.8
million are indeed internal references. With the current connectivity
check we are forced to load all these references in order to mark them
as uninteresting, and this alone takes around 15 seconds to compute.

We can fix both of these issues by changing the logic for stateful
invocations of git-receive-pack(1) where the reference advertisement and
packfile negotiation are served by the same process. Instead of marking
all preexisting references as unreachable, we will only mark those that
we have announced to the client.

Besides the stated fix to correctness this also provides a huge boost to
performance in the repository mentioned above. Pushing a new commit into
this repo with `transfer.hideRefs` set up to hide 6.8 million of 7 refs
as it is configured in Gitaly leads to an almost 7.5-fold speedup:

    Benchmark 1: main
      Time (mean =C2=B1 =CF=83):     29.902 s =C2=B1  0.105 s    [User: 29.=
176 s, System: 1.052 s]
      Range (min =E2=80=A6 max):   29.781 s =E2=80=A6 29.969 s    3 runs

    Benchmark 2: pks-connectivity-check-hide-refs
      Time (mean =C2=B1 =CF=83):      4.033 s =C2=B1  0.088 s    [User: 4.0=
71 s, System: 0.374 s]
      Range (min =E2=80=A6 max):    3.953 s =E2=80=A6  4.128 s    3 runs

    Summary
      'pks-connectivity-check-hide-refs' ran
        7.42 =C2=B1 0.16 times faster than 'main'

Unfortunately, this change comes with a performance hit when refs are
not hidden. Executed in the same repository:

    Benchmark 1: main
      Time (mean =C2=B1 =CF=83):     45.780 s =C2=B1  0.507 s    [User: 46.=
908 s, System: 4.838 s]
      Range (min =E2=80=A6 max):   45.453 s =E2=80=A6 46.364 s    3 runs

    Benchmark 2: pks-connectivity-check-hide-refs
      Time (mean =C2=B1 =CF=83):     49.886 s =C2=B1  0.282 s    [User: 51.=
168 s, System: 5.015 s]
      Range (min =E2=80=A6 max):   49.589 s =E2=80=A6 50.149 s    3 runs

    Summary
      'main' ran
        1.09 =C2=B1 0.01 times faster than 'pks-connectivity-check-hide-ref=
s'

This is probably caused by the overhead of reachable tips being passed
in via git-rev-list(1)'s standard input, which seems to be slower than
reading the references from disk.

It is debatable what to do about this. If this were only about improving
performance then it would be trivial to make the new logic depend on
whether or not `transfer.hideRefs` has been configured in the repo. But
as explained this is also about correctness, even though this can be
considered an edge case. Furthermore, this slowdown is really only
noticeable in outliers like the above repository with an unreasonable
amount of refs. The same benchmark in linux-stable.git with about
4500 references shows no measurable difference:

    Benchmark 1: main
      Time (mean =C2=B1 =CF=83):     375.4 ms =C2=B1  25.4 ms    [User: 312=
=2E2 ms, System: 155.7 ms]
      Range (min =E2=80=A6 max):   324.2 ms =E2=80=A6 492.9 ms    50 runs

    Benchmark 2: pks-connectivity-check-hide-refs
      Time (mean =C2=B1 =CF=83):     374.9 ms =C2=B1  36.9 ms    [User: 311=
=2E6 ms, System: 158.2 ms]
      Range (min =E2=80=A6 max):   319.2 ms =E2=80=A6 583.1 ms    50 runs

    Summary
      'pks-connectivity-check-hide-refs' ran
        1.00 =C2=B1 0.12 times faster than 'main'

Let's keep this as-is for the time being and accept the performance hit.
It is arguably extremely noticeable to a user if a push now performs 7.5
times faster than before, but a lot less so in case an already-slow push
becomes about 10% slower.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/receive-pack.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 44bcea3a5b..50794539c6 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -326,13 +326,10 @@ static void show_one_alternate_ref(const struct objec=
t_id *oid,
 	show_ref(".have", oid);
 }
=20
-static void write_head_info(void)
+static void write_head_info(struct oidset *announced_objects)
 {
-	static struct oidset seen =3D OIDSET_INIT;
-
-	for_each_ref(show_ref_cb, &seen);
-	for_each_alternate_ref(show_one_alternate_ref, &seen);
-	oidset_clear(&seen);
+	for_each_ref(show_ref_cb, announced_objects);
+	for_each_alternate_ref(show_one_alternate_ref, announced_objects);
 	if (!sent_capabilities)
 		show_ref("capabilities^{}", null_oid());
=20
@@ -1896,12 +1893,20 @@ static void execute_commands_atomic(struct command =
*commands,
 	strbuf_release(&err);
 }
=20
+static const struct object_id *iterate_announced_oids(void *cb_data)
+{
+	struct oidset_iter *iter =3D cb_data;
+	return oidset_iter_next(iter);
+}
+
 static void execute_commands(struct command *commands,
 			     const char *unpacker_error,
 			     struct shallow_info *si,
-			     const struct string_list *push_options)
+			     const struct string_list *push_options,
+			     struct oidset *announced_oids)
 {
 	struct check_connected_options opt =3D CHECK_CONNECTED_INIT;
+	struct oidset_iter announced_oids_iter;
 	struct command *cmd;
 	struct iterate_data data;
 	struct async muxer;
@@ -1928,6 +1933,12 @@ static void execute_commands(struct command *command=
s,
 	opt.err_fd =3D err_fd;
 	opt.progress =3D err_fd && !quiet;
 	opt.env =3D tmp_objdir_env(tmp_objdir);
+	if (oidset_size(announced_oids) !=3D 0) {
+		oidset_iter_init(announced_oids, &announced_oids_iter);
+		opt.reachable_oids_fn =3D iterate_announced_oids;
+		opt.reachable_oids_data =3D &announced_oids_iter;
+	}
+
 	if (check_connected(iterate_receive_command_list, &data, &opt))
 		set_connectivity_errors(commands, si);
=20
@@ -2462,6 +2473,7 @@ int cmd_receive_pack(int argc, const char **argv, con=
st char *prefix)
 {
 	int advertise_refs =3D 0;
 	struct command *commands;
+	struct oidset announced_oids =3D OIDSET_INIT;
 	struct oid_array shallow =3D OID_ARRAY_INIT;
 	struct oid_array ref =3D OID_ARRAY_INIT;
 	struct shallow_info si;
@@ -2524,7 +2536,7 @@ int cmd_receive_pack(int argc, const char **argv, con=
st char *prefix)
 	}
=20
 	if (advertise_refs || !stateless_rpc) {
-		write_head_info();
+		write_head_info(&announced_oids);
 	}
 	if (advertise_refs)
 		return 0;
@@ -2554,7 +2566,7 @@ int cmd_receive_pack(int argc, const char **argv, con=
st char *prefix)
 		}
 		use_keepalive =3D KEEPALIVE_ALWAYS;
 		execute_commands(commands, unpack_status, &si,
-				 &push_options);
+				 &push_options, &announced_oids);
 		if (pack_lockfile)
 			unlink_or_warn(pack_lockfile);
 		sigchain_push(SIGPIPE, SIG_IGN);
@@ -2591,6 +2603,7 @@ int cmd_receive_pack(int argc, const char **argv, con=
st char *prefix)
 		packet_flush(1);
 	oid_array_clear(&shallow);
 	oid_array_clear(&ref);
+	oidset_clear(&announced_oids);
 	free((void *)push_cert_nonce);
 	return 0;
 }
--=20
2.38.1


--G3xYM+2XhxAIeiw6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNb6lIACgkQVbJhu7ck
PpTYNhAApX/cqJUucqzoTdWSVHGJggRlYhipn9UHJWdQcY80T9r9HwaJ0QsGdoDu
oiW0GWVbsiaqF9kFsv2011bpaVfYrQE5HJNUsAAG0mT86d0SRuihWm2BE1+AResn
UN7hcelg/bAoKR5GETbwqDzDxWYR++X81MPMBlb29RNc9ZiS67dVTU2fYJWqjSgG
Lex/1VxXrJS/+bECW1sb66+OXv0fpm7sY7ZwX/8IJegF7u60pIx53TdHeElfIyJC
1iIXDSLg+rRjrfbKpXw0BYJY8Mrbw07qW7DHpMRPlezTtK13zd+fn82uGFYYJhxy
kJZkWaLk6qaHEB68PRxrhUYmFJecVJw3+jBxdNzIsNusLSnJqCN3Xi1DEsmz0uUL
/Q6gSUtO+d4rlTebOdQxy+y72CU+8LJx5Om3B2XVZF0GHR+avAIpVsFYMc93mDbn
zJ1USYGwBeFRgMfAnAaqc52ofFRyLIqqP5WT/wKFhgLs64oCCD9erRjcpSZPTTNK
fDRUe6ShQYBKnRA1UnomQ1Iw+67dDyUlRUjFLR/Rbral9k5VnhQQGaEyR5Qqy3jU
1eOsliP5L29/gaKjrR/6gd+A2EZCaC9D8zXJozv88FAqUGu87IaHwNilGRW+7v4s
5GjU1x3GGDXGAwzGSh2766pY+aEyFxxXiazh4+NuwcIgkniO5qU=
=fA0A
-----END PGP SIGNATURE-----

--G3xYM+2XhxAIeiw6--
