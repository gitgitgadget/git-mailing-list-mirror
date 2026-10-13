Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30EB37E5EC
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 07:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877007; cv=none; b=sRSfiLOAUuZI2ry7VP1z8UEkz+Rc4bI0s51+oY7Ah8noxqH3TmuZ3baPkE/Jxub2BE+rMAIzO9I4re+s7Qt9Kp2ddFewAFrAc2+qexs1Jfny+MXRznEArzTzLTToJezVS+qems9AQo/8jJzNIkwieqSULkZpd2Mjs0JE2mkYiAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877007; c=relaxed/simple;
	bh=ZwDFdXdQmfgZGa/yFdySOHAwgxRrj1yd9nD3yjQ/EZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uoVXL2yJFv3QfV3tu2lE7fZ+/THgqi/i3zBnqcmJVIWriCPqQdj/40D0yEtjJBC6C1kvMhVesvfbVyrj14F84xz9xHM224ZxokLURg7VmspuP77RDZ7RdHqncwfuVS5SAxa4O3uluPAWCJFqfiGEMkPpSKsaHpj6e6r3+UG2Bzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fb4d7So5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ioESLC8/; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fb4d7So5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ioESLC8/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 0B859EC039A
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 03:36:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 13 Oct 2026 03:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791877005;
	 x=1791963405; bh=821CI42Onq5IF4IEKBW3qs5z8AP+bLCB5m3pMQh5e5s=; b=
	fb4d7So5ZBhJmzDIf/8WPm4QvxgWfTWZcRihUozBuPgD440ZhmYGMTCWuHzSaCBj
	E7Yz0vUtzoo7PrZg2rh7M3K0QV4mGwWW4gMpGy+sTA/092bBN6dZotd1D4WLfSEM
	vi6riPEhgvm/62OM7evZ4g3eEEBZBquiwZxU9F/kwLTZo8DGi3NnYutbSEfJcXsZ
	nPExtC7GTfiMvhxP9KJfPyCfvTBP7U2DafHKCa7bTfrfQTR+EARjqJEJ24dSUnWw
	/bvmPB64Lf+FhF1/asSbZcR48/lx8LWmY+ENbDdqlseZNldBZRK/9ib62xTeLbbE
	SpOOSZ/w26Z6K0m3ghDJKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791877005; x=
	1791963405; bh=821CI42Onq5IF4IEKBW3qs5z8AP+bLCB5m3pMQh5e5s=; b=i
	oESLC8/Rl4b9adDIZjwQBgre68ks8R7Ey5UsNrGiR0o48McHlo+RksM8JUstC8Gy
	JV+joSLEZfPkEF1R2TNc/5sqrhCLC5symsmbENClWLZpRCmMuTrOBVhyW3WRrkT9
	AK4X4jBsT657jtkF8/e68QpfC+De25MRlTVV/OLC6FsVaQxNxsEdHd9gjkQXRmgM
	XY4cq5CmcY30erNwox8QuMZFuc8iSezUxUqqNjUvEj37sCK55HCW2/Bo7w2O5YPo
	e2kj4/rSjs1jNLdURRS9zsjpXnjwnG+MSIb7RPG7cJrGM9uCRlnW8LToE8ebwSBS
	B/rD+UqBK8t3wN1f4nyxw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791877005; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:pBHSf087/j4isLuT9UBBLtd9diJVNsUkzVFRADCvDPn3TEm
	mj04HQSJwTSi5vmCGSJvs/IJzF5H+vvY3Pzw5qfLVxgHEoRyj5oQfE3MEF+QkjrQ
	pMgrLt2+SJtgUQdrbA0bAoCPskW8VonRmEGFwnF7UF5GW/e1tjH02O7j3O7FifHN
	S5jenouoB2ti2EHkKwIhtRHf4E9CJ2dGifnoZQCgm7eXjz4d0RkBBZaG9M3lIEHT
	dZfmvjE/OBPj6p5LbEI0ZRKt/U09mHAZiM6dV1Tm7CGyKW/iUqSuS0GQP6xH/jLa
	GQdSA98tgu1fnzGmWGJKdGeAeGPsa2AxOx3ugmQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1tkk7BwTUqcHhiO8kHcgIcCEL7TeMTkDTvLARtPDPno=:ZwDFdXdQmfgZGa/yFdySOHAwgxRrj1yd9nD3yjQ/EZ4=;
X-ME-Sender: <xms:jN_Nal0PvbA-I0QsoUWkvqyl2L4RwtGdw2l-bN4CFi55gFz_xzjSKA>
    <xme:jN_NajgQ251f0msaTqkcP5o3L1V5FwX596ww0DAUVC6bvnHslKaQ5WHfTW-O9YWQe
    UtEH9192m_x13wKWuGoQUoWx5REsFsgs_ZbmdSRy8In213rYQceCho>
X-ME-Received: <xmr:jN_NajRA9r6gZbDoB4V2FOc67uN450h0pZrgQAYPo3ugrUMxJRBr6Q>
X-ME-Proxy-Cause: dmFkZTFDms0BEkwqV8YnJjItkFU5eW9NUMXdBS8FDjClRKaZIYclXd9jbIoB3wdqQswS2o
    xHLri9Tr7lz033x9IJHKySJWTlznhhUDvn3kxiZGgiPFbzTN//o31jZ0Tv5nLdizIcWqaC
    eKUKKg/7BEAlvp50wbXVFoxbRl5s0Aj1xh6A/LxDpRdaBeleoCENeeVNL6FTdxu5k0w0Pn
    isuDCoDhCyKWGfm163e+sUbe85fDiRifH1mOG12Ke1ngUpR05Tqh5ixzHbyixEBthzmn9x
    OhcTxa+XGs0VE60bEz5aGvVMlHvAgA1jlEeZnoRdZAcKHWQhoOO96IlCznLFoSUZXOVYsj
    Hs7wAafYP3Rox9aids4ADaLGmEO1yQeppcFqo5/YMhRkqPq5IDe+XqEBTIzSKqT/tUsIK7
    MTAmdz0Il7VEdq0ZdpYtCEtpYM1B5Of+iIQnpHhaiIMXH18tn80rxfZtaHPGi48S2vsOsX
    v8nt4lnBEhIafebxzCnHYyobZpBL+JCBiOEu37iWjWDbDgPK267nIzi8YcCkuwJeDPANnF
    O8TUatRVzTP0k4Y7pmNwlySpq32sEdhsuRgm54T2mdE5kFV/i3XwYaw26dyYr2CJDz422n
    qXOkg7ez4PQRMxWUH7xS2noZGxJRDeVZZis9TFC7//VMQBh9jhk9nqnuRheQ
X-ME-Proxy: <xmx:jN_NasiRQr2xi2gvVcdF4U_-G1_m-mbVweU23Yf6AHeWG1wBA5FKYg>
    <xmx:jN_Nar49E6P6oiFrmUqZ3dlu8NKj17P-E0JTbX0keFSr40DqTzKXGw>
    <xmx:jN_NahB_Y3IThgWxl6VzVLexo-ZHW8TNIt_7En8OYBeEEB74JTIlTw>
    <xmx:jN_NaqaDGInEliCtdFKDztoukv9ln5ud9iWz9pme83AhB9ZfF1ma_g>
    <xmx:jd_NakziOrYvxgdIjapdu2e1-HP-_bkBM-6GZt0c_LXzAzB59vRXKNzE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 03:36:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8749a763 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Oct 2026 07:36:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 13 Oct 2026 09:36:25 +0200
Subject: [PATCH 1/5] odb/source-files: fix performance when reading objects
 with alternates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-pks-odb-files-alternates-cleanups-v1-1-b7030ff2b26f@pks.im>
References: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
In-Reply-To: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Wolfgang Kritzinger <wkritzinger@atlassian.com>
X-Mailer: b4 0.15.2

With the move towards pluggable object databases we reorganized how we
access alternates. Before the introduction of pluggability, we were
reading objects by first scanning through packfiles from all alternates
before scanning through all loose object directories. With the change
though, we are now iterating through the sources one by one, checking
each of them for whether they contain the object either as a packed or
loose object.

Checking whether an object exists in packfiles is comparatively cheap
because the list of packs is cached, and the pack indices are likely to
be in the page cache. In contrast to that, checking whether an object
exists in loose format always incurs one stat(3p) syscall. So scanning
for objects one alternate at a time led to a performance regression in
in the case where most of the objects are contained in a packfile of an
alternate, as reported in [1].

We could fix that issue by introducing another flag that tells the
backends to only search the optimized storage backend. But that is
adding more complexity to the object database layers that is ultimately
only really required because of the way the "files" backend stores its
data. So for an alternate backend, such new infrastructure would not
really be a good fit.

But since then we have moved handling of alternates into the "files"
backend itself. One of the consequences of this is that this backend is
now having full control over all of its sub-sources, and that also makes
it way easier for us to optimize for this access pattern again.

Do so by first trying to read objects from packfiles located in any of
its object directories before trying to read loose objects.

The following benchmark demonstrates that this significantly improves
performance in some cases. The benchmark uses the Git repository itself
and sets up its object directory as an alternate, while the primary
object directory is simply an empty object directory. It then reads all
commits enumerated via `git rev-list HEAD` with git-cat-file(1):

  Benchmark 1: git cat-file --batch-check --unordered (rev = HEAD~)
    Time (mean ± σ):     179.4 ms ±   2.6 ms    [User: 114.6 ms, System: 61.4 ms]
    Range (min … max):   177.1 ms … 187.7 ms    16 runs

  Benchmark 2: git cat-file --batch-check --unordered (rev = HEAD)
    Time (mean ± σ):      95.0 ms ±   1.5 ms    [User: 79.8 ms, System: 15.0 ms]
    Range (min … max):    93.0 ms …  97.9 ms    30 runs

  Summary
    git cat-file --batch-check --unordered (rev = HEAD) ran
      1.89 ± 0.04 times faster than git cat-file --batch-check --unordered (rev = HEAD~)

[1]: <CAFXJcxvpKHoVDwE5mBOd=w-A5vPdUmehqr8SHLUD7qv1qB00rA@mail.gmail.com>

Reported-by: Wolfgang Kritzinger <wkritzinger@atlassian.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 455f409db0..9268f5aa9a 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -426,6 +426,7 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	enum odb_read_status status = ODB_READ_NOT_FOUND;
+	enum odb_read_status ret;
 
 	/*
 	 * Reading an object may fail even though the object exists, for
@@ -434,15 +435,15 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
 	 * prefer the first such error in case multiple reads have failed.
 	 */
 	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
-		enum odb_read_status ret;
-
 		ret = odb_source_read_object_info(&dir->packed->base, oid, oi, flags,
 						  status == ODB_READ_NOT_FOUND ? errmsg : NULL);
 		if (!ret)
 			return 0;
 		if (ret != ODB_READ_NOT_FOUND && status == ODB_READ_NOT_FOUND)
 			status = ret;
+	}
 
+	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
 		ret = odb_source_read_object_info(&dir->loose->base, oid, oi, flags,
 						  status == ODB_READ_NOT_FOUND ? errmsg : NULL);
 		if (!ret)

-- 
2.56.0.212.g129ede20d9.dirty

