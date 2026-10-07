Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A9949B5AD
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363990; cv=none; b=qydFfWkXhkVn8VJjV/iciLkW/4S/cKUUsG54ZSIP0G9jOPV7fVm33mhJr03Bj7V1cjCuIxfrutNa6twXNp6tr6IDvMWNAM1rhSJykeS5k030lXneUlfbrVhAF5BAr2/1f7Je+GfOY0Ac7f1yIUfwnt065X2PlMzT2jRFT8eU7G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363990; c=relaxed/simple;
	bh=c7bTY+CqgLR35WduFs97BMNnQyjt9jjEEYZx4ThMO8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4KtZ+aoQDCoQ6xoVLWQiQ6rDuSlehO2P4UUfcGaY/1c68jvKFVqUcM8h9SezBzZ9T2/WdKhHUs4lQM5IW8oCIXq+ZCd+NzPyclPBd9Ve5I+k77ygSPjsXBekGvqy3Q82w8GZQgsmqti+Q2Bql4WeZpazpWkICAYiFVxlTh2/Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SWM6e25t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HexoE6GX; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SWM6e25t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HexoE6GX"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 687C8140012F
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 05:03:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 07 Oct 2026 05:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791363824;
	 x=1791450224; bh=sGhr8jfV7IRdfAq+eaMKNKjl7CGEHp0bDDO1g0EROPg=; b=
	SWM6e25t0upkJYwJht6DETwH2WFmOBAnxYd5t6QfBmg3RCUKKwC32lCdz5dh2ITa
	N+4qgSHLcbOhkI4htML78AQHr1VAupUtE3Ww3qRUaTEpZ0lFp71F2GcdyTxnZg7J
	s62Pv56b8Z7SgMcuDcezpU5VUWU65kyREIBeEWzuQM9exmLaZMOpFczTTX4jA50/
	N1Evih12fnQrusmrTf2G+nEO81G0fIx6CHbOTioqvS5tDkZ6brdQpBCLi3iAw3hI
	CW3Yc99Jk38hSKyGUtIjjOoJrHpKa97D1V0ur5dXTyQ6E3HaWs3X942LUsjEpmLo
	ToJhIyuqwPxvpsWdhk8C6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791363824; x=
	1791450224; bh=sGhr8jfV7IRdfAq+eaMKNKjl7CGEHp0bDDO1g0EROPg=; b=H
	exoE6GXDVYS6dySCdD1AvrU0Avvb24gGOZhjDTeJqvZED3sabZJj2/Y1mLE6rD2l
	j2gUuYme8+wg8doZcgWexd2+IaEA0bCTqPhWD6aEaVC2Py987NcaVG52GupM/70Q
	aHWw7Nm3DZZqFL5OMzMnJLM1ZzOtw+C8WIjbp9mY9GuurMiyMhpb/dOtDm+WcXmV
	M/fsCtQS48t9HqhHVih0nWKynLbY6ekXuejKxdNKsfeQex3ggfRcqyeaIQdyIMC8
	aonURq9moI5AtlynP4ahJEInpF/bX9cspoCtXjOd4/AKUVz8ffxV16xxEA1GAoEv
	AyJwT99h5HluOK9k6ccxw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791363824; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NBfkaobP++8UPK0/JttWKFycTVowhRdIxEafEvlJxNJT+fU
	AWhmywyx96318a38lv3o9uWLzcHwa4tV6gPvkxPQKW5hiE1yg9jjBMsHBK7KDzfB
	tKjx3RVsgtJqCqdDDKxLqRrJRKeiNkQXDxLWlCQMHF7lLmlXsBfswvePeZi78rVA
	sMf2D8h0tPW2YTrB0DAZQ/et3S1ndngq6GebMFHjpX7ocVEHqbH1zISNKMhva5ye
	07lNXDW4vkhYCKKOlOp5JxviomK4q5NRXlZ/6wMkmd1xataGbJeK4KFVRhWaXXwI
	L+SNmXkf6STNv2d2bhjNfStmsQJo8oyC7NrzmUA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-disposition,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Wi7Akl0prsahEcR0hVsKIkQocBaSHS8FP3j+4WnwXRE=:c7bTY+CqgLR35WduFs97BMNnQyjt9jjEEYZx4ThMO8U=;
X-ME-Sender: <xms:8ArGanEBXuJ8ukkYOVngDb5Tj3RjYPDorNTVS25izy-fr8rZGV9QZg>
    <xme:8ArGaqXCEQI74MU4jkP9E90VaD9FJ_fy69VpuZg-rT9BDeWlvvEai8BeUPQRDOlcX
    5zx1e4jIFgieE7cDA0az842IFeRExdJMZDc_mWMsuwpT6ryoH_afQhV>
X-ME-Received: <xmr:8ArGamwU1ZB5EP1h9ZABFtk_5igiXDf0EQlyUF9zRr2t16M4hwsOjg>
X-ME-Proxy-Cause: dmFkZTEJdiSh/Ibb8fhHkTzk9UV6+egzxnC7UK8eY83MeFSHI7EJXHzaeYLxG/DzngYJvg
    rOAEo0pAwcnZUZoX7xQtGtM8uM8UHngG1tm2rrojYyWTNxFm/F+ksZuGQ25aY/MXlCU0+4
    shwCnBjTK9pn3St4OtYNgbjBWAbM5Au8w2YHDI8iMKySgslsq8t0xfE5BtkOw4TlK70zkF
    u4mwZcZHnpt1C3rRGcXci8untuHXwyP2kwwdNnR51mFqk4dh+Ye9/K5iS19aiqIVCRrgj1
    VjMupvPmEkN+SrJSlL6jrwqiutOR3jRPhbwD/otm040nSSeGvIat/ynyi/RJJqjtyeY3po
    EHMVPX7ePQFffMdIuMW0TwDD3IyGwoDwX4KncWqd97tul00TNc4ngN9qvUwslPJZk21KHh
    p+lQRhZ5jhyIYJaFRNyFqycyj8El2zMKJXNHtY8rXjZ8qp1din5EWsqk6KocA9EdYkbfBh
    /iAwjHL7NdyWxacNajZaLKLa+h6HAnp3MqPEgEECde1/VPyozQuNUlSE3cdRHElgyVKehT
    JZ00NRvEt12fGO6NcBS6euGWH+S0fZADf3xjM6PDqTnQHSKuQKeQvpW+Vcu5F46nTnv5q6
    xV+dPQzcMT3vjHLkz07rJzclpKPUZgy72B8FfGv25HIfRXwKxY15OjnlDq3w
X-ME-Proxy: <xmx:8ArGagMDfb5frYahpbc_0cQOGZG5-SC9nPZenmpd3S3zXlZjTVspmw>
    <xmx:8ArGav53ebYlNVQ4EwpjSRsAyufXHMNdrwS7Bmotete796H48v_6zA>
    <xmx:8ArGapM2RlNLo7tEVZGSLYqv1nyTIYu-tyhwsFdL8JZ2EAjz6jv5FA>
    <xmx:8ArGalkBBi_sOw3cJTZ8Z_ndqp6AH82HC6NulEuLhTCtcyiaKDhZSQ>
    <xmx:8ArGan3r2-dO6xuqJzCyovr_CA1hhhr9Iaun3XvNzXc4mfYyvj5CVQz6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Oct 2026 05:03:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0bc474f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Oct 2026 09:03:41 +0000 (UTC)
Date: Wed, 7 Oct 2026 11:03:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jens =?utf-8?Q?R=C3=B6cker?= <jens.roecker@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [BUG] push resends common history after repack during pre-push
 (2.54.0, 2.56.0)
Message-ID: <asYK6ld53e8lJ4Ir@pks.im>
References: <CA+tGzvYYKm=Yo88knZb4oavG9dH5smUCXnoqa-RR9-7YEBycVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+tGzvYYKm=Yo88knZb4oavG9dH5smUCXnoqa-RR9-7YEBycVA@mail.gmail.com>

On Tue, Oct 06, 2026 at 07:37:47PM +0200, Jens Röcker wrote:
[snip]
> Possible mechanism, based on source inspection:
> 
> In 2.54.0, send-pack.c:feed_object() drops negative OIDs when
> odb_has_object(..., 0) returns false. In 2.56.0, the same quick check is in
> append_negative_object(). In both versions, odb_has_object() uses
> OBJECT_INFO_QUICK unless ODB_HAS_OBJECT_RECHECK_PACKED is set. A parent
> process with a stale pack catalogue may therefore miss the base after the
> hook removes the loose copy; the fresh pack generator then sees the new
> pack and walks history without that excluded base. This is a proposed
> explanation of the measured effect, not an instrumented proof of the
> parent process's in-memory state.

Right, that makes sense, `odb_has_object()` can have false negatives by
default. So in case the object database has been concurrently repacked
we'll potentially end up thinking that the object does not exist at all.
And in `append_negative_object()` (which is the modern equivalent to
`feed_object()`) we'll then silently skip such objects:

	static void append_negative_object(struct repository *r,
					   struct oid_array *haves,
					   const struct object_id *oid)
	{
		/*
		 * The remote end may have advertised objects that we do not have in
		 * our object database. Skip those, as we cannot use them as boundary.
		 */
		if (!odb_has_object(r->objects, oid, 0))
			return;
		oid_array_append(haves, oid);
	}

Consequently, we won't mark the object as negative boundary for the graph
walk and thus end up pushing too many objects.

The question is how to fix this. The obvious fix is of course to just
pass `ODB_HAS_OBJECT_RECHECK_PACKED`. But as the comment above explains,
it is expected that we will receive potentially-many object IDs that we
don't even have. And we certainly don't want to reload the object
database every single time we see an object that we truly don't have at
all, as that may be somewhat expensive.

I wonder whether we could maybe batch this check: instead of checking
each negative object separately, we could gather all of them and then
check them for existence. And if any of them are missing, we reload the
object database once and then re-check only those.

That'd be more efficient for sure compared to potentially reloading on
every single missing object. We still have the chance of racing with a
concurrent repack in that case. But maybe that's good enough?

Something like the below (untested) patch.

Thanks!

Patrick

diff --git a/send-pack.c b/send-pack.c
index f20460fbf4..aecc73209e 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -42,17 +42,46 @@ int option_parse_push_signed(const struct option *opt,
 	die("bad %s argument: %s", opt->long_name, arg);
 }
 
-static void append_negative_object(struct repository *r,
-				   struct oid_array *haves,
-				   const struct object_id *oid)
+static void append_negative_objects(struct repository *r,
+				    struct oid_array *haves,
+				    const struct oidset *oids)
 {
+	struct oidset missing = OIDSET_INIT;
+	const struct object_id *oid;
+	struct oidset_iter it;
+
+	oidset_iter_init(oids, &it);
+	while ((oid = oidset_iter_next(&it))) {
+		/*
+		 * The remote end may have advertised objects that we do not have in
+		 * our object database. Skip those, as we cannot use them as boundary.
+		 */
+		if (!odb_has_object(r->objects, oid, 0)) {
+			oidset_insert(&missing, oid);
+			continue;
+		}
+
+		oid_array_append(haves, oid);
+	}
+
+	if (!oidset_size(&missing))
+		return;
+
 	/*
-	 * The remote end may have advertised objects that we do not have in
-	 * our object database. Skip those, as we cannot use them as boundary.
+	 * A concurrent process may have repacked objects. Reprepare the object
+	 * database once and re-try. Note that we explicitly batch this check
+	 * so that we don't reload the object database for every truly-missing
+	 * object.
 	 */
-	if (!odb_has_object(r->objects, oid, 0))
-		return;
-	oid_array_append(haves, oid);
+	odb_reprepare(r->objects);
+
+	oidset_iter_init(&missing, &it);
+	while ((oid = oidset_iter_next(&it))) {
+		if (odb_has_object(r->objects, oid, 0))
+			oid_array_append(haves, oid);
+	}
+
+	oidset_clear(&missing);
 }
 
 /*
@@ -64,6 +93,7 @@ static int pack_objects(struct repository *r,
 			struct send_pack_args *args)
 {
 	struct odb_generate_pack_options opts = ODB_GENERATE_PACK_OPTIONS_INIT;
+	struct oidset negative_oids = OIDSET_INIT;
 	struct odb_pack_generator *generator;
 	int rc;
 
@@ -84,18 +114,20 @@ static int pack_objects(struct repository *r,
 	opts.pack_fd = args->stateless_rpc ? -1 : fd;
 
 	for (size_t i = 0; i < advertised->nr; i++)
-		append_negative_object(r, &opts.haves, &advertised->oid[i]);
+		oidset_insert(&negative_oids, &advertised->oid[i]);
 	for (size_t i = 0; i < negotiated->nr; i++)
-		append_negative_object(r, &opts.haves, &negotiated->oid[i]);
+		oidset_insert(&negative_oids, &negotiated->oid[i]);
 
 	while (refs) {
 		if (!is_null_oid(&refs->old_oid))
-			append_negative_object(r, &opts.haves, &refs->old_oid);
+			oidset_insert(&negative_oids, &refs->old_oid);
 		if (!is_null_oid(&refs->new_oid))
 			oid_array_append(&opts.wants, &refs->new_oid);
 		refs = refs->next;
 	}
 
+	append_negative_objects(r, &opts.haves, &negative_oids);
+
 	if (odb_generate_pack(r->objects, &generator, &opts))
 		die("git pack-objects failed");
 	odb_generate_pack_options_release(&opts);
@@ -114,6 +146,7 @@ static int pack_objects(struct repository *r,
 
 	rc = odb_pack_generator_finish(generator);
 	trace2_region_leave("send_pack", "pack_objects", r);
+	oidset_clear(&negative_oids);
 	return rc;
 }
 
