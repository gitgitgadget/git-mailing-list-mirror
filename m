Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD05361FD9
	for <git@vger.kernel.org>; Tue, 28 May 2024 06:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877905; cv=none; b=K2rA0mVvw+ouSxkl5phZOkuxtSKhD6btSM9MShYE6nvYhkPUr5QOihiwm6Fu7TEq6sv8WE67gdlvE/mhBr9J1aX+GiiijQmClYwxbAabWJQQ4BX8hNmTZKnCGWhMF2FbuqScKlv5fnozAXlI4sey61SCizqSGh0rlarLeuyeB0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877905; c=relaxed/simple;
	bh=wxqrIvHl4mcgF1rWswr01x79mDPh2xAHD9lQ6LY5Hfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MitrQTMHoAYFqLcc5SY7+XDsD9uaPzNElnXJz5OJGz+FCNm+/4U6x8B5scb/7Dp18aKdiHhO+gPWr0bflId0vayLdHhEaCTY3bwbC+wE7RIHmTFsWXnQSnKSO+yejcasb9iNS/UvlDHN1wp4jg6n+aGOVBXuYCa5KEt2jrl3WT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HOmsdAkm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bKY5U6rA; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HOmsdAkm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bKY5U6rA"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id DB3AF1140081;
	Tue, 28 May 2024 02:31:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 28 May 2024 02:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716877902; x=1716964302; bh=i6v8j4buon
	QvYUSr0NORYQlNMMWNXvrzs9C9tw3SREo=; b=HOmsdAkmni2AMpNMGQ02wlTj0T
	8gGwAjTxpswVI5nXMkuNEJ1SJh0z1bmlcGH7AVA8WcLQlKlnCULRU/bE4IXiSjvy
	hBcgtp2OfM0XYR1F5LxPBoQcxkcP3aAfLoqcPEovkiHUyJPvYlRJkXRFGRBdSg0S
	uZdtFH3FxeRk7oZsYS9xpvCNze3wxaiMstHwQq+gCfnIdZE5NPlwt2yKhedjl0hj
	0XN8FtUGMr+SKuiVxaTY+4OrgDKkQN/rlTlUrIeWoVLWXUc913kGa4vnn7IG575T
	P069bYjyiQhHstnKpPy4evopilMGMAucebwgkwRHqFTZZp8CEYYzYaqNx6hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716877902; x=1716964302; bh=i6v8j4buonQvYUSr0NORYQlNMMWN
	Xvrzs9C9tw3SREo=; b=bKY5U6rA/U5VnQmHYjNt60XRxfaDLLyqLWsv6qlqcO7a
	x8JMbVctPzzWkRFyCz/RnXJNi36EdAsfgfb2+zkJewLxpgVXXjzsYyLhLvt+vD85
	Ug6jF7e8douZFWqbzbl5h3lW9vzI8rUX4Y2vPOludRyvxrpU5xj2kAMtnPTRVcOx
	tUFReaO4hKQcspQ+APr8hlC0NTcwcnrxLuiskHA0VeF2Al1/ladKBqGFpy1n6V2L
	05K9kArSCku6TB81LBBxk+TvX/wqslhh9300moWlibqe79U0H4xJ5JOgJ6P6JAHT
	lToWO+uLlN3g21GM77z5ysc7vskxjzeGV0tQl754gA==
X-ME-Sender: <xms:TnpVZr4CWw5zyw-69uSV9-ppmUUQYU5VAzqRC_UFysqKzuX2wCuBSQ>
    <xme:TnpVZg77VHSldKyHDbvcnxV04VSvqGofoNdDpI5jYwErwHjXea2uSZfZ3OGfOtYYN
    do98ISFQdOkGDxYwg>
X-ME-Received: <xmr:TnpVZifRBW5ouPJ5Xd97hLkM6Z2Kb-Twn6Sg6u4wuA7MEcEPMRMjQasFAuZIXyKjyXz1vzIjBbX4oH_rQs6aFCsyQ-3uUrbu6H9HXnJn_KU9pzZz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:TnpVZsKDOvkHgIBSAomnIs9qSjnOi9twkM8rTgwRM_oMfV9-tYHHKg>
    <xmx:TnpVZvIpZp-n4dKdtFNW9M6xthQsfPMfXBf4FcFBb9NSsUnyFSU22Q>
    <xmx:TnpVZlzkLbDLtd1I2deiiSBeGI2qgfTgMt1AadclhGLPmJ0k4kQWWg>
    <xmx:TnpVZrJ0Iv4MVXOeUFUUAnA5E-JSpAjZNKs-dFOYQ-OBuTYxcJMndg>
    <xmx:TnpVZlhJSHvacXvSo5aLhs8kZNVxdyvzbmtGBtO0ZSKR5ThUs-Z6NJsZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 02:31:41 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 72be3910 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 06:31:29 +0000 (UTC)
Date: Tue, 28 May 2024 08:31:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 06/12] refs/files: extract function to iterate through
 root refs
Message-ID: <f7577a0ab37988476cdb83e310f96f4841c9364a.1716877224.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716877224.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+5FZez476uOFR6t7"
Content-Disposition: inline
In-Reply-To: <cover.1716877224.git.ps@pks.im>


--+5FZez476uOFR6t7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Extract a new function that can be used to iterate through all root refs
known to the "files" backend. This will be used in the next commit,
where we start to teach ref backends to remove themselves.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 49 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index b4e5437ffe..b7268b26c8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -323,17 +323,15 @@ static void loose_fill_ref_dir(struct ref_store *ref_=
store,
 	add_per_worktree_entries_to_dir(dir, dirname);
 }
=20
-/*
- * Add root refs to the ref dir by parsing the directory for any files whi=
ch
- * follow the root ref syntax.
- */
-static void add_root_refs(struct files_ref_store *refs,
-			  struct ref_dir *dir)
+static int for_each_root_ref(struct files_ref_store *refs,
+			     int (*cb)(const char *refname, void *cb_data),
+			     void *cb_data)
 {
 	struct strbuf path =3D STRBUF_INIT, refname =3D STRBUF_INIT;
 	const char *dirname =3D refs->loose->root->name;
 	struct dirent *de;
 	size_t dirnamelen;
+	int ret;
 	DIR *d;
=20
 	files_ref_path(refs, &path, dirname);
@@ -341,7 +339,7 @@ static void add_root_refs(struct files_ref_store *refs,
 	d =3D opendir(path.buf);
 	if (!d) {
 		strbuf_release(&path);
-		return;
+		return -1;
 	}
=20
 	strbuf_addstr(&refname, dirname);
@@ -357,14 +355,47 @@ static void add_root_refs(struct files_ref_store *ref=
s,
 		strbuf_addstr(&refname, de->d_name);
=20
 		dtype =3D get_dtype(de, &path, 1);
-		if (dtype =3D=3D DT_REG && is_root_ref(de->d_name))
-			loose_fill_ref_dir_regular_file(refs, refname.buf, dir);
+		if (dtype =3D=3D DT_REG && is_root_ref(de->d_name)) {
+			ret =3D cb(refname.buf, cb_data);
+			if (ret)
+				goto done;
+		}
=20
 		strbuf_setlen(&refname, dirnamelen);
 	}
+
+done:
 	strbuf_release(&refname);
 	strbuf_release(&path);
 	closedir(d);
+	return ret;
+}
+
+struct fill_root_ref_data {
+	struct files_ref_store *refs;
+	struct ref_dir *dir;
+};
+
+static int fill_root_ref(const char *refname, void *cb_data)
+{
+	struct fill_root_ref_data *data =3D cb_data;
+	loose_fill_ref_dir_regular_file(data->refs, refname, data->dir);
+	return 0;
+}
+
+/*
+ * Add root refs to the ref dir by parsing the directory for any files whi=
ch
+ * follow the root ref syntax.
+ */
+static void add_root_refs(struct files_ref_store *refs,
+			  struct ref_dir *dir)
+{
+	struct fill_root_ref_data data =3D {
+		.refs =3D refs,
+		.dir =3D dir,
+	};
+
+	for_each_root_ref(refs, fill_root_ref, &data);
 }
=20
 static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs,
--=20
2.45.1.246.gb9cfe4845c.dirty


--+5FZez476uOFR6t7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZVekoACgkQVbJhu7ck
PpTgpQ/+KDqP+JBgi6S0vybLCipEpavEdayStLckXdeUV4kc/Ms+ezZ8sk+IIyhR
6mNZm4zljdc68xE5tFChID5ofCfE0z9avY9LmqXWFqC+Jl+Elc9Fme6mKNEa+3Ry
r9fMUNQ9T4zn8T64UbHLcAzcrFYs2AlrQJMxL3S/U2BCtIaowDgBAzCUNp8LpfmU
FwW5PRWh7wU7l1eGdWtg4JIa/8Hn29ecZZ0mMJp6Ww1VVWh0qitQCO3/BflsovAP
vXax4qFDR0j0XsjiHr0w4C/j34clQFhJ6znI8i8+870HQyB07mPpdVh6DYsDuag7
nGod6tcUBRHLVmfdD8d+J+NN0b0TPOJ98Rt1rv935hdSBEMPu8BwWaJ+D2GCPGRN
NJbLkpfNWApyB7GIsbpZtgQmM8KziSXNvuPEakqg0IUrK5CuuRCccsofDcU/mJfn
owdiwBi+8WKSYknIa17iMDS/vZesZwx2RIhSi9c6bqnyoBvw3nixICb2YlPIOLx6
38COQjk5CeUVecnkLOeKWmGaBcSVIGFcl0UXTVVF+G8lqoDM1cSi/Q4XPap+weqg
vAix9z9bgLxO5TYmaFFUCze4G3M1i5nBQLXRRHx21fMeVXsigXV6fvjBlCnZXesg
LIs4k+UOmjkqLVzw1KUjQ403m/ESmYOL/qvl4cngecKLhwvZ93c=
=leiZ
-----END PGP SIGNATURE-----

--+5FZez476uOFR6t7--
