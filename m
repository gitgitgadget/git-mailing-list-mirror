Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563B843E092
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 08:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769556; cv=none; b=Ha2ADQC/WqpPTk6SIpK0Rfz0uFInNkBUcOUPJf5Gtx5ZjllNlPfrXv5oG/bCJ46FRZSAT1ncHD05OCMsgQ+IwgBjyqDlGHDmvqIAH3wlHuPwRbioqTS7YGaiH9msza0GiBeqgItQfHkeuIfO7Ax4BXOA6hP+VWyIJn9jA9cAZgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769556; c=relaxed/simple;
	bh=6cjVqZaweOo/p1gQhW+Il9apL/zj5Odw5NFcnyjtB20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jyncbvXY/Bbvm4O3z29T3Mh6u2di6+lSofUb9JJamGK0t9nCX8SGHR6/LYyDxJtxmAWH7zzZkRjcn1Xtyc1uZ6oIRqHHt4BTNYkp2XhWfJ73/9qi+0LkCqSD8NWxA70hb6hGtPkRTKpqN1B8IOgWNKmjr2MTaRWC9xfm6s7abHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nBWbNucC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GnTvY8Lj; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nBWbNucC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GnTvY8Lj"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 40F5DEC01C2;
	Mon,  7 Sep 2026 04:25:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 07 Sep 2026 04:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788769553;
	 x=1788855953; bh=bslHxKImcUG3O+LCmhIRK0c/sq/JbXC9crkGRVYuhB0=; b=
	nBWbNucCSZbukWv3fTUcGCzsXgM94WxMdPDQRm3c65ak96HoZ/MHkOmWjZEza8CC
	X1wLz0kHB6NtG+o4PWWjCoXuLPr146rbf6mXC5M17v/EFEArdFtZbIFdNr/pXJEj
	qM2xeZeI4Hz6lbDeIKz52NkjY3xXbbuEAxhzPz/VKI3udFMDGz0MRPUMsZALHmMG
	n3wUfavGZYi3hl/f24o6A4i0RvZ99lFhQDA0SuZB7dl1c6IUXEfIFwIfMWrpxpPx
	M/PR5AVGYrQKcM+l7DAfl4Uhic29+Kd57TBc1EyJaGh02lCaIWErrJmijDY7GxyA
	oGnVO9o4bUconNtYLWrrHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788769553; x=
	1788855953; bh=bslHxKImcUG3O+LCmhIRK0c/sq/JbXC9crkGRVYuhB0=; b=G
	nTvY8LjtL8FY6Nm/CooDN3TqSHNyKPIofqoGy0Is7BQaPkkjEBivjfoGUnEi0nvO
	YKrzZ27EfaT2e+GrdputbrQ28FdbMNjTAk8MXYFEcAHyxvQbn9scdITCk4yN31df
	UPdPeeRfqjSZv5NwBPt09rf7zG40SPasLkeRHKBjivE09/ZUskuxjomyL2mlYcEq
	cpgQUL3wHIcAfeItbxbq+mKDTZY+v4f/2fG7FSVBaG34DsEkdbWuYGUvXfSDq/kl
	h3w0wJYbF9ouQ8IWMKRY/HwD21mlVbX71aqFhcbH8G2Gb5xLkzxCMfXiJXFXc48X
	EkFNCCAuIBil8Sy46Sflg==
X-ME-Sender: <xms:EXWeas7_zy4GGtNcWmrSlWp0nNe4N6TosCN7Xk6u4vIvyOOv7FCgLQ>
    <xme:EXWeak6_eaehl-jIfsYnQFiLS6EEUOpq9_CdHffpjK0wi8LFo-Lr3fOunSBaiVIsN
    PnRbM-PAYiKLWYd5FWPpUUSMYoAMhBa4VNZjLwKBGRwnPwXIXPLsbs>
X-ME-Received: <xmr:EXWeageWiB4xhKOFbMXMeIJoOAlx00jDOES8SI7pechsfmNXyyrkMg>
X-ME-Proxy-Cause: dmFkZTFyLnsnXJs777FxsqcHvlzsV4urKyexW3K0A8vOJAOpgvOc5x5wNV4lt+eIqFqGzl
    8eYKtuoNlkVgnNv7hhczE9YTTY8alxBLhhMhaOVxF56CvA8MajbHzByNeaNbgZhKoQ83X+
    kjdUZ26eZD7TYJAMfdiA7fOK/MJXPy6/tKVB7bc10vvxuQEX/JY07OcGV4T4akvwWw02v6
    0h7HUid6hlebYTHq8zGUk91cgHbiDyLqAYAn5s7gtO6upjjSgB28oiJEbkELaS3X3XYC3q
    FXDNx12rxyDpcBPASmj4RYqLexG5z2LibBtD7BQ7+XIABMrkBSfZP1jUp0D7ex5HjpgPGT
    p2YUqjnb0OZPvfnsEL00yDDtQduzTmoZx/6vmeWQAguum4QgOAp0AE09m2V+qgYZzIuzmE
    l6eV/A3XeLedtlcmHqGSSjgaWh5dJislkvtGjjT/Wu8mK7T1vX4mTXWm/6Mrk4Ui/jgER9
    Du1IApLo7vUmIbNlM6R2sX/wgKJs6ky8KZLjy3mKZwfwAQLX+5H6MNksxf1iEXgXDa88YJ
    oiHE8bVQD9yZihhyaIHJMI7JB2GNNcVMGCEWiaDKQoXpzmPS/zey6dt2n002v4dXC6KJ4q
    VpIoS7OwmBbXr5GdGTHZVMugsG1zuiB3/HJu9ItmV5P2T7Yvr/yptCzf763Q
X-ME-Proxy: <xmx:EXWeagA5hvATlMiXQNqi2REtvcRHLVUk6Gnimzq92jii4VXyYAnniw>
    <xmx:EXWear96nTkG4ytu6MEHI-e_EPtt2jRzeBh1fP-2gLPISJ1cn5N2sA>
    <xmx:EXWeajIr_xySf03k9QPWctRGJhJoK4WZBQtTrW3ubQw6J6mAjp2oWQ>
    <xmx:EXWeashjd09RS_4DyIgzjWSqiMHo5xTEJFFsRq6rN9rSwGx1L2-tCw>
    <xmx:EXWeajI8pdqV48Y3Mg-fmWfUyc0y7sp6ddu3yjt_o8Am6t9gonGIjDLI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 04:25:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a17c3986 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 08:25:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Sep 2026 10:25:39 +0200
Subject: [PATCH v3 2/9] builtin/clone: defer setup of the object database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-pks-odb-write-alternates-at-creation-time-v3-2-735d0b5b3e00@pks.im>
References: <20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im>
In-Reply-To: <20260907-pks-odb-write-alternates-at-creation-time-v3-0-735d0b5b3e00@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

When cloning a repository we defer initialization of the reference
database. This is because we don't yet know all details required for us
to initialize the refdb in the first place. Most importantly, what we
are missing is information about the object hash.

We don't do the same thing for the object database yet, but here we
essentially have the same problem. While the "files" database does not
need any information about the object format at creation time, alternate
backends are likely to require that information so that they can
properly set up their data structures.

Besides this forward-looking future proofing though, we also have a
second use case for deferring initialization of the object database,
namely alternates. When initializing the object database we do not yet
know whether we'll need alternates or not because this depends on the
repository we're about to clone from. If it is a local repository and
the user has passed "--refernce{,-if-able}", then we will end up writing
alternates into the object database.

The ugly part though is that we cannot determine where the repository is
getting cloned from before it has been initialized. While we of course
already have access to the user-provided URI, that URI can be very well
rewritten via "url.<base>.insteadOf". We can of course read the global-
and system-level configuration to resolve it. But we explicitly resolve
the URI a second time after we have initialized the repository because
it can happen that we copy a ".git/config" over from our templates, and
that file may cause us to rewrite the path.

In a subsequent commit though we'll start to write alternates as part of
the repository initialization, so we'll need to have the URI properly
resolved before we can initialize the object database. This is ugly, but
as mentioned above it makes sense for us to defer its initialization
anyway so that we also know about the object hash already.

Defer creation of the object database until after we have resolved the
URI.

Note that this also requires us to defer the call to `setup_reference()`
until after we have created the object database. While you might think
that this function has something to do with references ("refs/*"), it is
in fact responsible for setting up alternates. Consequently, we can only
call it after we have created the object database already.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 904d2d859f..bdcbd7aa1b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1188,7 +1188,6 @@ int cmd_clone(int argc,
 	create_repository(the_repository, git_dir, real_git_dir, work_tree,
 			  option_template, GIT_HASH_UNKNOWN, ref_storage_format,
 			  do_not_override_repo_unix_permissions, NULL);
-	create_object_database(the_repository);
 
 	if (real_git_dir) {
 		free((char *)git_dir);
@@ -1311,9 +1310,6 @@ int cmd_clone(int argc,
 		strbuf_reset(&key);
 	}
 
-	if (option_required_reference.nr || option_optional_reference.nr)
-		setup_reference();
-
 	remote = remote_get_early(remote_name);
 
 	if (!option_rev)
@@ -1342,6 +1338,10 @@ int cmd_clone(int argc,
 	if (option_local > 0 && !is_local)
 		warning(_("--local is ignored"));
 
+	create_object_database(the_repository);
+	if (option_required_reference.nr || option_optional_reference.nr)
+		setup_reference();
+
 	transport = transport_get(remote, path ? path : remote->url.v[0]);
 	transport_set_verbosity(transport, option_verbosity, option_progress);
 	transport->family = family;

-- 
2.55.0.1007.g17ff1f9808.dirty

