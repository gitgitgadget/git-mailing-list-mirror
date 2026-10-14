Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94B94AA599
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968042; cv=none; b=Lleb4n5drutawl/wVwO08NIbX6nKOi6NKadb0bF2WOW/nxabujrkl4t/AM423SEINavMDvDiNFap2vOiTL3vObJljZFIDdmw30ievsJm3JL9cV2JgLdpLmLQeSnWkvnI4J7e+CRX2Bm2pAaisVfSb+R/s7QC3++zSw5y1Y9XrHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968042; c=relaxed/simple;
	bh=ZwDFdXdQmfgZGa/yFdySOHAwgxRrj1yd9nD3yjQ/EZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YPFSVW/iaPTsNbdf5RMqPj4KpZclsa3JsFJukytMzFWbrInGk9zrwV1SBr1dUz3DKsTzGJ1V7iyuRn/wjRxLEbF2BWfs2O9VJG49Bo35bwumxrrnUYMcwtW+RvxToOsGxQDyr0hmc8ER6aYBDn6lUvI8VisZCpffrjE+adgj/1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eZ0VjSlG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O8/Mc1WL; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eZ0VjSlG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O8/Mc1WL"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1618BEC01E8
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 04:54:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 14 Oct 2026 04:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791968040;
	 x=1792054440; bh=821CI42Onq5IF4IEKBW3qs5z8AP+bLCB5m3pMQh5e5s=; b=
	eZ0VjSlGIXnS7RdcEVKJBg/QWuKHAi0S/13P8vLk78q+zNnKhgcQys+mPOH0ZsnM
	PsGpfGv6XQFJ+eS3mauSq17MPufyIrKCiNSc356NVumjAdNhcLOChrFRkIBPBn2c
	x1zGff8ZAA5udg2HQjFx6ShauGFahtgKYce1/EiFPlI5yOsDnG4ImZp2ZoK5SvPX
	oskxrI2kmi/j0nNor4lvlsy0OnLspOOF5yFukxp6WGl5n80zNNlQE0SaLGTGzP60
	Kfo+5cR6fXVgOkYx5UK+KO1Ib37Eeq985W9xkuKPBAttkal766YGGq4JhHPIL/1T
	CdeIzZ4ds70/HYJgKhe69A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791968040; x=
	1792054440; bh=821CI42Onq5IF4IEKBW3qs5z8AP+bLCB5m3pMQh5e5s=; b=O
	8/Mc1WLlRTZoRWQqM1H70WoCkG+R8Km3U0quRiuxLVgYXD8JE7sII1KMxf2QTSP6
	1GdIwoV6/iWH7BQXz1X6E5feXhcf2oHJReXfZ8jRha5RnFIquiDi7MAjPjicvAKa
	rnxnBSmlh4Wxhn6GDYJM4L8H5wPXR+YthjSLfYCpWaKAHM2HmoMkMd0YuClCI+Hw
	A+QjQ9fSSwxbKoyS8/JOZtTdqECLQNqJyu60Y1le/b9RK5TzQR0x6LeiqCcSicVw
	R6HqbqRFlKrRka7griF9wtqHrR8zBOXJJkVTMSWA7misK9J7InLc6qRt6XA601na
	R5GlCVlDjreZyTiQ1SiNQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791968040; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ANx8JpMn140JhOf0pR8I0f4dyNvK0SLS9hPusj69YWjJBh6
	C1fba/JN3eApPf6orUiO32A9AKukTGGkUD/UpJM7hxjIVeFH4dPPzKITnqYQ7+O9
	5IBRzeMGfIMliCExu8emfmx+8gEP9LsBa8G8ar+Ffvs7VKKN/FvDcywmtNzririL
	kzib+oAtXqCWeuAngoh6G2qwkPeika61UluaV1g44VFWqk525z0SWcPSQ5TlRX9P
	h/qfAgRon5emtGSVPnZn5TbgMPw6wXwaQY0WTlMxGZjKaii6L7atnpW1LpUmzf7H
	qDD9pq6J+lNZpX2bpahydNJ1aOVlfuRH21Gyj2Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:0vBNUpXafQ38E8uHhXphn6p7of17CrOSHUH6JEh2AFM=:ZwDFdXdQmfgZGa/yFdySOHAwgxRrj1yd9nD3yjQ/EZ4=;
X-ME-Sender: <xms:KEPPaiucISiLPb4hyqITkNa1jyX3iGhQ-98ASRJR6nvUUsQMbCvPSQ>
    <xme:KEPPaufgcO0aaDc41q_gVduJBhrv2CtLVyapFD0Gahwjd1wjhe0s000lzWKRe2BwG
    HantxXMKw1sgzju3uIk-jmA8AJoETBULuJpqpIB4C35vdc9s6xbTg>
X-ME-Received: <xmr:KEPPaixa_ZelZNQSPmSbGfa4gs_5VqcHfW3DV8S_s1_5zoPWM1TwPw>
X-ME-Proxy-Cause: dmFkZTGberXrCizqextxcbDt5sHh6BxVwcDdcRbPAEJ1/Aqn94NmQdM2kQMTj5L0Gwer/w
    WI3c+kkTcHL1y05i5u3sR9tzhirdV19GM73Yxk3ixFax5wpBnQW7DEYyLR482oyl3Y8W2m
    NlU9N19taCeeEdWVh48KL9jgGhlsNwbAE1+uDJBOHMBS7WfGixH5g7/zd8GBrSa3nGpTS9
    a0Hmjru3Uf4Di2F2XvDIKq5FnRIRIBSj5cOaxGvLiAC4JIVKzBhWsqkoGSX5azj2uP1dLM
    tKVburdL+yGwDIme09nthcDc+q4tSQZK2imU81v4qstnm4X14zYowXhGUUvtTBqAvTHwEM
    mjLV7+QKkadQkUHBJAY3wOMzw+0vTrvEv9diWZWBbTx8U7k0M27Nl/1yFt2fBW4LH231fF
    /ZY/uUxQtOxAymd7QYS6O3wy1yBPAI5mMHXXRWa/fzb8+dasNBZwp1QDBl0qZX47fqxsx8
    2Rho+Jcgi3Mx5FErexYrI9GpnktaAvdWWB9s4HcYMGb6003MFj0u+Ka/ZBhfzpWfRQmnZO
    EDL97T7wqL4P2ix9L6ID1B6p516397dr1UofSBgeiVndYEujO5Y+K+lV7wu/cwrvzRUTTK
    BL1bA842brsxeYaY5CIgve2pwUHgXxB5ZJPJhDS9y4osyaCnvkRfIWSi27VQ
X-ME-Proxy: <xmx:KEPPasH6knfVXhtYi9uvQhywgJEzxseTwrT_RwVttCWPbTrKe45KIQ>
    <xmx:KEPPauxfCyzGbDWIhqS_FGbV3x3ecmO5vThG3QpaGHadud8w-n9rgg>
    <xmx:KEPPalstLF0Tu_U4JGVrBDA9-J556cGhfbAz3tM7qVcmBoQOS8ZDmw>
    <xmx:KEPPaj0lXp5wmewZKnk4T2rVU6vbSLy0ND10IYBJQJXY2JJGqZSohw>
    <xmx:KEPPahhitmwnWHbVxpdKVcRgZ998vwJDbdpCZfsRYhSZoKHVbjyQBttB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 04:53:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a2740a2f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 08:53:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 Oct 2026 10:53:45 +0200
Subject: [PATCH v2 1/6] odb/source-files: fix performance when reading
 objects with alternates
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261014-pks-odb-files-alternates-cleanups-v2-1-fed9b2caa3be@pks.im>
References: <20261014-pks-odb-files-alternates-cleanups-v2-0-fed9b2caa3be@pks.im>
In-Reply-To: <20261014-pks-odb-files-alternates-cleanups-v2-0-fed9b2caa3be@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Wolfgang Kritzinger <wkritzinger@atlassian.com>, 
 Justin Tobler <jltobler@gmail.com>
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

