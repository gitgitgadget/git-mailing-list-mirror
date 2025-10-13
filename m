Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F9A2264CB
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760346079; cv=none; b=KCBN2Mb7W3HZSiYf6mOXkcfdVfN30hd4WfSWMCBs21UkNtuZa1REGiGRAeZuFlvJlqaqlE0u5lPy2pbl4/DfqUROPFzRvt+LG01HM3SrdGrReK1y1cPxy79EWAD/NQnjvR3msfIryaRk9onOB9/zwrZ1JVEMB0F0vdtu3gxrL+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760346079; c=relaxed/simple;
	bh=rBFh6OA/+pGjYyQsl21lH5wZBL2MiEKEGyG8bzP1+PM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWMV3WGgDs/ytQC2jBsNLSCif24++B10Q7DCwafPFVkiAeHjYsdy//Bp8e+qWwMNw74St/4FWLD86Goa6nVbq4DGGpzwao3DpPBLOi1n6I1xtVYGp+NtxW6LBqjDvXgnSG82A0xqeKDmacJiErBP2IVc69ynH7P2+/1/ZsuKKTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EaXDfkyY; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EaXDfkyY"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-54bbe260539so1472125e0c.0
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 02:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760346076; x=1760950876; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JwT5d+PBh3UIKbvUWlZJ9Cedw+ioSyHbLW11+8K6IR8=;
        b=EaXDfkyYceIrNuhK7NhF6QsTcK9BPNBN4HjbzQHzySBJkEY3OddqtZqjI3Cwd12G4x
         McMimLFzIIH3lCRIAzC1/f+9OLbWjre0gkYISz5kBkBPPetir93o7Mf3FNnfx5kZ8bC1
         D+UbfKGIbtrFJWBO/uMSAhJiNW07ZmSHcLbk9UAL2cfc5qY67OLUK3eHpn54QhqUztl1
         Lb5+MUTOrgSxGBNrVaxqN4VmtiEL70c/iltD8B0SyQprjJYZn8lkEs+Abn9xtnQe8TcV
         yA0igq/V3Y+SITEDi9XXabGDzsGEcwgSnFg5an3K2K4ZolJzBLLuNI/WIuzpCRiA9nZg
         TW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760346076; x=1760950876;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JwT5d+PBh3UIKbvUWlZJ9Cedw+ioSyHbLW11+8K6IR8=;
        b=lZ0d8ZEvsaTIxnLWuoAC6h/fkyP20ZQrd0To/0OYdOHQ3dasTj8iHgSe2h5Qo9/2mR
         JhZ7PP5OS51hfsZ2bavZbm0wDbcy2COtBPx1RboaAA4BLnpK4G8fwB6s/pqFuZGjTy2i
         s7dt9alRr8OgITxJzrakbZ2WNgCw1lt4BGgALVu5e6acAtD7nlCGqx8H1VlowqeyyS3x
         iqcuvqfK84qXlud7f7xqUnkWqWAq1eZxVCeh2KWePsIpbZA6NoP23hp5caYdZmDlvdFy
         xjERWKvh2LmZhGfXNoVZ88b56YpEsF1NWdbvzN9QuyhG+ZDIWwSC/0oQFfLhGfCNwKhJ
         H06Q==
X-Gm-Message-State: AOJu0Yww386qcp/s5eff0z8d/N91q+QIlm7uLEmqaXhbRFUM52ezFAVi
	puEGdevgzGuEGU1GrypjQNJ768WBVItlfbWzlOePOjt8rhEpxN0VstqqsWC+CLgeTVPSm1zHMaO
	b/A3EAn5FycbIejFutpVHhTlJKZBT9F36DD3p
X-Gm-Gg: ASbGncuLxa/AWSMbeClC33sKswGyceWvIr/eG7Y2a1JtNTzCbSIKh3eow6YXsnZlQT1
	dmyjPJOuD4SAJ4mIjceV651HfEyqXAiFzRdv19UmNnYCFmVoBcRXyO8qCtowMGoo5ILOOei2qUZ
	3+nPe3rdWDOstRfPIbLFdQyp4n/Yv+/QKsG4sElqMzNPRpnL2gUg9EGAPFoTotscwO1hSKChJxU
	QuB/uY1fCCcq1Qu3O02aZaLwm/ywS3gkqkSjgf26cob5LrUEkQmKS+wGYLc6erYKUHxDA==
X-Google-Smtp-Source: AGHT+IH+gqjcpBqYSkrlVwCqJ5/4zBReFBJtjJRUOraoO7QRWUVUVf3WHipxLi0x6wfbsHRO8oHu1JXjbtE2IFw0+do=
X-Received: by 2002:a05:6122:3104:b0:54b:be27:b541 with SMTP id
 71dfb90a1353d-554b8b38809mr6457764e0c.8.1760346076343; Mon, 13 Oct 2025
 02:01:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Oct 2025 02:01:15 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Oct 2025 02:01:15 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aOjse9udPEoWqUaO@pks.im>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
 <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-6-c7962be584fa@gmail.com>
 <aOjse9udPEoWqUaO@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 Oct 2025 02:01:15 -0700
X-Gm-Features: AS18NWBnUkiileut63MtQ0jo49M_rYoQ44wI-7sPaatZddF1hKmEAnTjX4YQZSk
Message-ID: <CAOLa=ZSfiD4KTSMyc2WW4oC2zyDO9CHmUWwnws3GhCdbtL4rAA@mail.gmail.com>
Subject: Re: [PATCH 6/9] reftable/stack: return stack segments directly
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000090126f0641068285"

--00000000000090126f0641068285
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Oct 10, 2025 at 12:27:10PM +0200, Karthik Nayak wrote:
>> The `stack_table_sizes_for_compaction()` function returns individual
>> sizes of each reftable table. This function is only called by
>> `reftable_stack_auto_compact()` to process the table sizes.
>
> Maybe: "to decide which tables need to be compacted, if any."
>

Reads better, will update.

>> Modify the function to directly return the segments, this avoids the
>
> s/this/which/
>

will do.

>> extra step of receiving the sizes only to pass it to
>> `suggest_compaction_segment()`.
>>
>> A future commit will also add functionality for checking if
>
> s/if/whether/
>

This should be okay either ways I believe, but shouldn't matter much,
will change.

>
>> auto-compaction is necessary without performing it. This change allows
>> code re-usability in that context.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  reftable/stack.c | 23 ++++++++++++-----------
>>  1 file changed, 12 insertions(+), 11 deletions(-)
>>
>> diff --git a/reftable/stack.c b/reftable/stack.c
>> index f91ce50bcd..9d9326ce0e 100644
>> --- a/reftable/stack.c
>> +++ b/reftable/stack.c
>> @@ -1639,29 +1640,29 @@ static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
>>
>>  	REFTABLE_CALLOC_ARRAY(sizes, st->merged->tables_len);
>>  	if (!sizes)
>> -		return NULL;
>> +		return REFTABLE_OUT_OF_MEMORY_ERROR;
>>
>>  	for (size_t i = 0; i < st->merged->tables_len; i++)
>>  		sizes[i] = st->tables[i]->size - overhead;
>>
>> -	return sizes;
>> +	*seg = suggest_compaction_segment(sizes, st->merged->tables_len,
>> +					  st->opts.auto_compaction_factor);
>> +	reftable_free(sizes);
>> +
>> +	return 0;
>>  }
>>
>>  int reftable_stack_auto_compact(struct reftable_stack *st)
>>  {
>>  	struct segment seg;
>> -	uint64_t *sizes;
>> +	int err = 0;
>
> The initialization is unnecessary.
>

True, but I always think its nicer to define the base state like this.
This makes it less error prone when/if the code is modified in the
future. But doesn't really matter, so let me remove it.

> Other than that this patch looks good to me.
>
> Patrick

Thanks for the review.

--00000000000090126f0641068285
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 2b604524f25824a5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qc3Y5a1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMitBQy85am5pWktpQmlOalh2MkFwNDFzMHhHczlFbwpLaGJOZlBVZzVp
d2VZRnZWMzlLaHBaK2d1Nmh2aklVa2dZOXpBNk1URFlvMjZQR3BtSnpxd3FBa1FLL0l1TE5SCkQ3
RmkrelA0MzVRVXBIK01kNHd2TTBkd1ZGZEs2RTRwbEhTc0JyMngxV0NZbGV4bEpPV0V6TW43ZzEx
NXZyazYKcmRmMHpFMWhmd1FTTzF2N3Uzc2RVaGRITHhtTjBiNnVWaXRaZWZDalBzbU1CampmQVBa
cmYyQjFrcVBaTng2WQo1OUlMRG9jU29OUWVDeEU0MlhOaU12bmQ5MW81UjU0QTlwTnViS3o0ejJk
L2JTNy80MGxUMjZUWU5qTHR2cWszCkVNcmZmN1ZBdjYxMURGRWhOdUszdmVldTN1Ky82Q2pFQTR6
M2pjcnBGVVU1MlhSK0JEVHdzbUpXT3EzOVNSTVAKeXh2aG52dDVFVjA0dEs2bEJQRHNVcnVLcFZk
MkYxSzF4WTAzMXo4dlhURktabGdhU1oyUEVtSnNKQ29vaTBtbAorZko1ZUNuakVvK3JpbU1kT24v
anpydHYrcHVFUkZybjBOUWdadlB1Y3JMOVNCdHZzcWZlQVB0eUZkUXpTYzZmCkMzNElleHZxbGVv
azVZd0dHUERsZ0J2OWFLaENrdHBVbHp0alRZbz0KPWNyV04KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000090126f0641068285--
