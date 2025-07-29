Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BC11C861E
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753821053; cv=none; b=eSb/H5/uMd8KnrrLcYeTNrLqEXeVYJ+ovvSZV2OmScHy4JVPTtIYpfj5dgdphavyBRO1PUjxBa6Pqrj56iRCrHMEJeYdV/uW8EcA3pIFggFaUzhdPufHjPhsQfPdAXXQ0TbwHlORbDaA2rBApfPqRTuwBClX8M1xCmPhXQc1Vjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753821053; c=relaxed/simple;
	bh=RKKPbHUTUk1ScbB3Gqbmeza2y4kqTFmcErBXWOYnf/E=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UcrnHnLY13TEmJwU+BKYmxMDOq5Z0TsWRpqtJenxEdV2WuWfUCOAJiVpOZ1mKhpx0PQ0UxNOsLmxqbcaiSAgiiJU3tuCdFShjFePfUK2SQBfIdRRUlG7sGrxnHZxahCwdzhphxnaftUQhtcoGTq7I9Rx13dVPRNl/JpV9kO6Z0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNNzdSCZ; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNNzdSCZ"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-880f92a63c7so1232767241.1
        for <git@vger.kernel.org>; Tue, 29 Jul 2025 13:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753821051; x=1754425851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LdJReYnktbE7M3+xIjNsu0H0IN9KFhs9t1nS2Se9LcY=;
        b=lNNzdSCZIIdp9vnPyULo59dBk4mB4TIOI8iPiOEZVCu+vjFhS9avuGboMc/Qk1o4gd
         V9YW7ePmhnbj3BOBUMeRLa9DYAJ6i4osHPUy/VqgIgNpfAXXQhdw5fynk2T7RsjWdP6H
         V4k8Qoa0RADAmdJ14IbXMBumR21h9uhDVZ668GsvE2VYZ4VfppisHs1tmSrM3dQo0cSh
         ZfkzUE7wHKZmLquzI7yBJtpsAAGOjvgtCa8F3O8HLGJPkR87Ahrc5s5t29grslr0H8YJ
         hyDgNoC4KYANwSrNCHa4YZpcIryb/k5Co2KIxqGwrL0GSvaf2iSHjxx7ZgoV4u/66kUy
         qRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753821051; x=1754425851;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LdJReYnktbE7M3+xIjNsu0H0IN9KFhs9t1nS2Se9LcY=;
        b=DMcof42gbWOVHpoEnW8jaGYODcHQc828oOAxJ6E81MnHz16YOV8p7RozM6zfKn2dla
         QPYwtWgOulS7sNjBRPPyBBouREh+m8881BflB3x98td5qtj6HIjZnn3fQVvZFiBy0Y9Z
         Ou3YKc5rWCWdup0n/Ggq+yP9i5OMiA4/BXd0rrnI6Aa3wcFg2IzhpkXkK5Zs7ky9mVuB
         aiIGbcjYi3782qKep+QULUDmVYhvGo8kbbeSJTQ2SzXyb4vGNMR3vwjWJzb/J/+AxEHp
         daMYYhrBmJC/tNAbzWQfin7EN1a6q9KyqTWG9R+MG/zYNQvul9pLXd9AIIonvlBjICoR
         a2kw==
X-Forwarded-Encrypted: i=1; AJvYcCUP/cBc6jhYlVKh8xUNXLEEgzvUYA3vA0WH2cra9CAApemg5WF3cjm5A7mu7GX89GH3oUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf44wj30xknUi2hb3Gattf77IaEIJ0SW70VbTSZsenjBvYK+1c
	7w1pWvFv1n3Ux4JD8fq/EAOPeRA4LzBw3B46JP8sbCVgwDuAEXWTuhxesgsZLCz/Tkk+6Tsnph7
	4pmNIKLvvTNaO1eWXnpzegZGyhPIkU7Y=
X-Gm-Gg: ASbGncvi50h+HJgo8j/3I6ThfKHTBXkCwdE+QclDRwoaTOi8FJ2SfUASA5tnz36CRBE
	u1zme20sN56xh+/z/X9tyhQEuU4Axsy54jcKNaSV6JilA+LkFZqfL6MIpWcGSjetYsmEjRIBFSl
	taE0q+hQomCz605XSAybTbJjSMxAzJcT+UpquvahbAw8iD6ZD3Vv5aDCtEE95R18ZWsdjXjmEZV
	36+SC2muy6SDQT/mC7HPndmOBAoFdjCKbg8CKLc
X-Google-Smtp-Source: AGHT+IG4tX+h48n56O2Tv9/Z8RGoWe7TsG1avS0JVliHnr2Y95vtKbneWaqVeD3XcoBsmQe/AfJnmiCwNLcnlPtJuGQ=
X-Received: by 2002:a05:6102:330b:b0:4f7:d553:3cfa with SMTP id
 ada2fe7eead31-4fbe7f6decfmr902533137.12.1753821050940; Tue, 29 Jul 2025
 13:30:50 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 29 Jul 2025 13:30:49 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 29 Jul 2025 13:30:49 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250728-pks-remote-rename-improvements-v1-1-f654f2b5c5ae@pks.im>
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im> <20250728-pks-remote-rename-improvements-v1-1-f654f2b5c5ae@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 29 Jul 2025 13:30:49 -0700
X-Gm-Features: Ac12FXxasCok7p0LFfNgdSPNXDyCXU064EtVS9rAvd9RnDDq-hd6LKYyJEYOjzo
Message-ID: <CAOLa=ZR10eOikwFyDwMDSyX2qQM-knCKhCKB4YtLD=Pdoz=vTA@mail.gmail.com>
Subject: Re: [PATCH 1/4] refs: pass refname when invoking reflog entry callback
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, Han Jiang <jhcarl0814@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000bdd05d063b174851"

--000000000000bdd05d063b174851
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> With `refs_for_each_reflog_ent()` callers can iterate through all the
> reflog entries for a given reference. The callback that is being invoked
> for each such entry does not receive the name of the reference that we
> are currently iterating through. This isn't really a limiting factor, as
> callers can simply pass the name via the callback data.
>
> But this layout sometimes does make for a bit of an awkward calling
> pattern. One example: when iterating through all reflogs, and for each
> reflog we iterate through all refnames, we have to do some extra book
> keeping to track which reference name we are currently yielding reflog
> entries for.
>
> Change the signature of the callback function so that the reference name
> of the reflog gets passed through to it. Adapt callers accordingly and
> start using the new parameter in trivial cases. The next commit will
> refactor the reference migration logic to make use of this parameter so
> that we can simplify its logic a bit.
>

I remember hitting this issue with the migration code in 'refs.c', so I
think this is a good improvement. The changes themselves look good.

Nit: Changes suggested by clang-format in case you re-roll:

diff --git a/refs.c b/refs.c
index fd9a5f36b2..6ed0cd6ddc 100644
--- a/refs.c
+++ b/refs.c
@@ -1078,8 +1078,7 @@ static int read_ref_at_ent(const char *refname,
 			oidcpy(cb->oid, noid);
 		else if (!oideq(noid, cb->oid))
 			warning(_("log for ref %s unexpectedly ended on %s"),
-				refname, show_date(cb->date, cb->tz,
-						       DATE_MODE(RFC2822)));
+				refname, show_date(cb->date, cb->tz, DATE_MODE(RFC2822)));
 		cb->reccnt++;
 		oidcpy(&cb->ooid, ooid);
 		oidcpy(&cb->noid, noid);
diff --git a/refs.h b/refs.h
index a39f873b1f..5b0efaf752 100644
--- a/refs.h
+++ b/refs.h
@@ -559,10 +559,10 @@ int refs_delete_reflog(struct ref_store *refs,
const char *refname);
  * functions.
  */
 typedef int each_reflog_ent_fn(
-		const char *refname,
-		struct object_id *old_oid, struct object_id *new_oid,
-		const char *committer, timestamp_t timestamp,
-		int tz, const char *msg, void *cb_data);
+	const char *refname,
+	struct object_id *old_oid, struct object_id *new_oid,
+	const char *committer, timestamp_t timestamp,
+	int tz, const char *msg, void *cb_data);

 /* Iterate over reflog entries in the log for `refname`. */

--000000000000bdd05d063b174851
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 59945511d1b57d9b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pSkwzY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNDlLQy80eGdGSXZMSG4rY1FOWjM2cll1VVA5VThkVgpPeG5RU0JSdTEr
cXlNKy96OHA5QWVxRHBycG9qRFU4K3VMc0svcEFsVWNNQUtDWk9aT201VjhTT3pWc0s3bTBrCk52
VGRvMTNSUUlpemRUYjZZa3hjbTlCTllWalNWZnVjODFmMGpYcGprTjhQRmtTeHJDRCtWblErdU5p
QW9oSWIKUXhUV1VqaXArZjd0dlBrRC8xaGZTbDR5WWlaV01nOTZqaFZicmZJSXBmdkVPbEx5Mjlw
RHMwN3QxVEo1b1F4dApVbDkxbExyVnd2SkJiZVludG9DVWtaTmU3MTdiNURlTFJlNlk5Q1QvK3Rh
WVN2b1JWcTZqN3pMUTR3SW40MElYCnpVbGZUMGYvRHBoMUpvU3h0ZlRHL3AyVTN6clZYbXdPcGhV
WjJaZXY2dk95clVyWUxsTXhxNVBJVGM3by9YdzcKNm9yQWlVUzRJU2pldnVTS2orZEdianlpeGUx
WXQyS1BWaXV6QjExWlYzZHZYajMxQ1A0Vy9TUUFFZ1pVbk05NwpzZlpESEh4aHNwYTZJSDNWYi9C
djdxU3lhbHpWVVdoaGs0RzhuV0orR3VEYUErekRQaXRLSnhvM0pHQ1RlRk8xCkpjSERSQkIwdXBN
NmNvSzJnWWhWbGNKdmIwUTE1TGwrS1ZTYkdiMD0KPUlkZGcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000bdd05d063b174851--
