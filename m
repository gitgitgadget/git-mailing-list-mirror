Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AE8522F
	for <git@vger.kernel.org>; Fri, 25 Jul 2025 05:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753421791; cv=none; b=Hl0nwfeG7X72fam6YRh7VXQ0aVa2cdCy19iYYFIS4MLZkYvvwxx9NQHGI75WX0vWG6ustdS2I82Eg/fqPI5h0Tjzd08SCcct8OIFR0jSUuJa0G9l08TgXbx+dqz7opl3UbrCCXI1kcy4UkWO0l4zauCWANG1EObpl5nV6dAABkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753421791; c=relaxed/simple;
	bh=/pp6rPVOO+ragq39qDh4YOs0zMSCVWn1z4a+K7QzRtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRHCtn6JoqB2x5+pqilm30j35YKDhKcY4cXI6wufo8wjor6jsh0C8OMr7axWmli91HG4hCuRJp4fjLrHFuR+UWUvEcwRSucJ06L3QZFDLGn9wUsOjAcq136S8DqhrdWkxcVowm2I5H14QCtXC5A34nHZC8asthToIsrpCfChKWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e44n9hrt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CrFfTs80; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e44n9hrt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CrFfTs80"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 60D4C1400259;
	Fri, 25 Jul 2025 01:36:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 25 Jul 2025 01:36:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753421787;
	 x=1753508187; bh=uW6OYRtV8sEN53wCObhokHEh3xEkgT0EPEiiAH61HQ4=; b=
	e44n9hrtbAQjdffdTJuMfil2mY0RY2ADCLj6x9GOuIt+XzUPz+PfEuSAI0AmfgZP
	dj/UbAZP1b4kp4KHc8e0ToYrjjmv4gYHJQRYdZGQoulCx3yRRTO6ywOBrkQSUh/y
	mixs8UaTLLaXhFK1CPKf/Z2l0C5mWdwmTiaVnWMdpxwE5J+ar2C0lArmsifDseml
	+FGbiIK/TN4zs/72UW5Ng+3pRmxgm+b/PooNZI27uqjfCfMR94b2XMyQuES+N8vt
	MFizLohXOHRjezhZRynZhLY+97aD2bfIJx/CyanorRBucnR1xJQz7DsZcm0d28l7
	muUTk5fizyXpIfGjIYMsSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753421787; x=
	1753508187; bh=uW6OYRtV8sEN53wCObhokHEh3xEkgT0EPEiiAH61HQ4=; b=C
	rFfTs808SwVTBrHqNYYmKHArJmS5ya3lL7P5Q9XtA3aZNCqB2DJFsYOG2R50acuW
	S+eiVsFYTerG154bHUSQ/0NAIfVYWQ+gZTRzleFs4IKqnVs73I2fkMtQ2a5vUA8M
	1ZkWQ/He0t9xV9AncftTDtXrygKjqpO6Ux9X2SJ7+K7hePagdLvFCOvYtOjCenc3
	Ly2lfZ513mGt8Lf/R3VPWfDurl61j530AjGfKswggUUAs9oJ5z3i92LiZOgyGjpL
	2J52J4zf3jAaGFuEhhsLZ5+W/lxHzrAc2W+IgvQVtyLL0biUQjKip3wXuBnkKqTl
	+0KPe/XDrtH6xb+PaAPkw==
X-ME-Sender: <xms:2xeDaB6sLmSit71LM2WESURPUd7xCIHbZLr2JS4P2T9u1kgxhtGI6A>
    <xme:2xeDaJdKFLS_gcL5asaopwNEC8ZT81iKc3WTxZBVBnqxdfYSlPCLmOaTXfomsvLJn
    Iihm5JBKiIgTS9IzQ>
X-ME-Received: <xmr:2xeDaFB6-3XUT-5HFGuu1NVvite8H00oybsaxDKtiGkWsRKFDtBuQ84EplIalJWKC1MLUqrBLbd9KzVPgtZ-_EiGJVs4ncdBj20kG997qKaC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdekvdejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:2xeDaM8p-PpqIUU6pR0YIzK0g7aG2nIvbqsNbuCydOaOdbn81B4Sqw>
    <xmx:2xeDaAIVpCyY0Mgrz1Rzk1ElZhAtQ0UEbXuftru3F1UytVkrs8XTGQ>
    <xmx:2xeDaFjRfw7uJuQJVd5JObsdaX2Ar1LF2CIcaMNc0RhYx_3iFXvqXw>
    <xmx:2xeDaA4Zzmpcvy5BX4S6piGZ-5CUoLTs3P-DhFoCdpBcmw3bmcQnHA>
    <xmx:2xeDaBqsPFvjz186pAFlb4Y10bMD4JzGR-LiITxHXQJE07egJcbv4Alf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Jul 2025 01:36:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b2cf0d08 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Jul 2025 05:36:25 +0000 (UTC)
Date: Fri, 25 Jul 2025 07:36:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 4/8] builtin/reflog: implement subcommand to write new
 entries
Message-ID: <aIMX1nHa5E5Hn95g@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
 <20250722-pks-reflog-append-v1-4-183e5949de16@pks.im>
 <aIJdSCPEHoiWWxrP@szeder.dev>
 <xmqqa54tz454.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqa54tz454.fsf@gitster.g>

On Thu, Jul 24, 2025 at 02:10:31PM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > On Tue, Jul 22, 2025 at 01:20:53PM +0200, Patrick Steinhardt wrote:
> >> diff --git a/builtin/reflog.c b/builtin/reflog.c
> >> index b00b3f9edc9..d0374295620 100644
> >> --- a/builtin/reflog.c
> >> +++ b/builtin/reflog.c
> >> @@ -3,6 +3,8 @@
> >>  #include "builtin.h"
> >>  #include "config.h"
> >>  #include "gettext.h"
> >> +#include "hex.h"
> >> +#include "odb.h"
> >
> > This series is queued on top of v2.50.0, which doesn't have 'odb.h'
> > yet.
> 
> Thanks for checking.
> 
> Yet this is a topic to fix breakages that happened even before 2.50;
> "git refs migrate" started migrating reflogs in 2.48, which had one
> fix on top in 2.49.  For a non-security bugfix we typically do not
> address anything older than the latest release's maintenance track,
> so a series that would fix on top of 2.50 would have been more
> appropriate.

Sure, I can rebase this on top of v2.50.1. It would then of course
require some smallish fixes when merged to `seen`. The below patch is
what is required to make it work with the v2.50 track.

Patrick

diff --git a/builtin/reflog.c b/builtin/reflog.c
index bc7e7f5e442..d3f0009cb0e 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -4,7 +4,7 @@
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
-#include "odb.h"
+#include "object-store.h"
 #include "revision.h"
 #include "reachable.h"
 #include "wildmatch.h"
@@ -426,13 +426,13 @@ static int cmd_reflog_write(int argc, const char **argv, const char *prefix,
 	ret = get_oid_hex_algop(argv[1], &old_oid, repo->hash_algo);
 	if (ret)
 		die(_("invalid old object ID: '%s'"), argv[1]);
-	if (!is_null_oid(&old_oid) && !odb_has_object(repo->objects, &old_oid, 0))
+	if (!is_null_oid(&old_oid) && !has_object(the_repository, &old_oid, 0))
 		die(_("old object '%s' does not exist"), argv[1]);
 
 	ret = get_oid_hex_algop(argv[2], &new_oid, repo->hash_algo);
 	if (ret)
 		die(_("invalid new object ID: '%s'"), argv[2]);
-	if (!is_null_oid(&new_oid) && !odb_has_object(repo->objects, &new_oid, 0))
+	if (!is_null_oid(&new_oid) && !has_object(the_repository, &new_oid, 0))
 		die(_("new object '%s' does not exist"), argv[2]);
 
 	message = argv[3];
