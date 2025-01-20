Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E501BA89C
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 11:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737371855; cv=none; b=MAelxxzH8rjdq36hXu7xyiY20wn8fmqDT0a1kwU4x5hqR0HQw919PWkv7BIXUEpS72tZ4CZRUIFLYo0IRDV76IItQy5rfhWzmpRkveYks209irEkf1y4xfi7bJxmzsiCsOm9XG9JQhu8tEjtm8YBX/8xizKDiIbjG5wbAp39I0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737371855; c=relaxed/simple;
	bh=FSE4b/Q7B1oa7IU6AWxAVTqtiqXxixdF3XzToUVKqs4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJlvTDelGoBbLiOK9nU2sDvRE3b0btsYR6H+HZirFnjUty28oaPBrYSzUh+oM7VhXdEUZJgcmIn9yTKh6IudWiE7cBOwCAhxjQcEnV3begZ44e5pVK8Fuys+/rfJ7Ng54jZQ1ZqpuoT9hIHXvK9mcf32TGZF5m61pzhV/ftpuXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGRfv8p4; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGRfv8p4"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-51cccb020a9so2661076e0c.0
        for <git@vger.kernel.org>; Mon, 20 Jan 2025 03:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737371852; x=1737976652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xe+oS/eojzbBKATnjKuv/QXIwzRra0KYOjAt1gxrBOo=;
        b=eGRfv8p4m8kn6lNp3XzYS253T6X5ESTIId5YtXvF/IqNNOx/JCK6qScLdLE2/tgHHT
         qGiV4iXlFfAORwoInX+mIlcmbv4ZZ34G18JSmB+gyjQfS1Bec97yCV3EocyEC45gusnb
         wCgCtshI0PNe9I7X2FnUj2I1G4HVKYnLoDP9wN1yVuX8wgJO1RMvhJjQR6S571hqx9F2
         5JgPzXt1HU5EkE1e55gvRn6TfLF6XCquPjNx1EHg4idsqyLW31zAg9QSU1XY6rXLgOgu
         /e2g0EOA7gz/WB9d7LBN19ugZqcesBnChaAP5f5jti2DlQ4wfmLYJxP5BGpMDMZ/qfHB
         K0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737371852; x=1737976652;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xe+oS/eojzbBKATnjKuv/QXIwzRra0KYOjAt1gxrBOo=;
        b=wklXa79WZZd4SfUqPiHEQB63XaKs4qupoVhRgO5ncaj2JsE3IykGph2+MTX+tmqAK+
         g8gsxDgasTEKfB5hHuj2+08qmETkX7N9p4CWZtPDoo4lwFNahxm4oYzXGlhnrtnqFzch
         h5OlJCvDGBcDrzkJVM2FadEsM3PTsZIje5kb+ljs/L8hu85AQz9G+mQFYxB9TeUoHajP
         1diUqxy4tLMRjZq9Y3+ussl02kHzY7nFTYQ8tOOPMI2cC+B0mYuPf1c4AlKzmpMRy+/N
         VZLwrN2MCfLS9B281vK/DQMtxRoj/D/WL6DoKKO4HtBrqowlEuZxGtQuHNeTS+mm9TQL
         qXnw==
X-Gm-Message-State: AOJu0YxuC+Ojgt62m1k4CScd+btNMw8rg/WAKfBxQ2rq71pOsdRViJVW
	07aFOZS9XqS90M2JprUi9iCfk6kaBYgnccaai/BZ8a+4eYiK46RC1+3gQK9s5VvSyXw7gEIfEtC
	SlXOL1FVV65p9tFS7Gm9dr9DTQZnOkm3L
X-Gm-Gg: ASbGncskd1l/tdjBvTsVvsZVXQZyW/T7jDRkbZ07iQdBpJngSkjqTF4tnLpXnLsb/Dz
	YKm5pyyBAONCiZhAwSnk9hXHMuiB3ecOZdJt9KHGknuUmRpbeS4gN
X-Google-Smtp-Source: AGHT+IF7TOiaUyR6awF6yQ1q6a5bsUYmC72aZinytwhvyxCgxJwW+TEGVdMDKI7ohgDvMAqL4KytwvH8U21LQXnX2Ck=
X-Received: by 2002:a05:6122:1998:b0:50d:6a43:d525 with SMTP id
 71dfb90a1353d-51d592b74e8mr7755992e0c.1.1737371852235; Mon, 20 Jan 2025
 03:17:32 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jan 2025 06:17:31 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <Z4oi9i_EHLaPjk0g@pks.im>
References: <20250117-461-corrupted-reftable-followup-v1-0-70ee605ae3fe@gmail.com>
 <20250117-461-corrupted-reftable-followup-v1-1-70ee605ae3fe@gmail.com> <Z4oi9i_EHLaPjk0g@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 20 Jan 2025 06:17:31 -0500
X-Gm-Features: AbW1kvZkVrkuAxbi-CKk3qjGL2PgPibZ8bLJkGzToTuyd8vyrAabpenmx5__EpQ
Message-ID: <CAOLa=ZTWxy65o4+=nF8r3+Z44DjcpEvwHhocAcM8L2VqZucR1g@mail.gmail.com>
Subject: Re: [PATCH 1/3] refs: mark `ref_transaction_update_reflog()` as static
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, gitster@pobox.com
Content-Type: multipart/mixed; boundary="00000000000018936d062c216821"

--00000000000018936d062c216821
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Jan 17, 2025 at 08:59:12AM +0100, Karthik Nayak wrote:
>> diff --git a/refs.h b/refs.h
>> index a0cdd99250e8286b55808b697b0a94afac5d8319..09be47afbee51e99f4ae49588cd65596ccfcb07e 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -771,20 +771,6 @@ int ref_transaction_update(struct ref_transaction *transaction,
>>  			   unsigned int flags, const char *msg,
>>  			   struct strbuf *err);
>>
>> -/*
>> - * Similar to`ref_transaction_update`, but this function is only for adding
>> - * a reflog update. Supports providing custom committer information. The index
>> - * field can be utiltized to order updates as desired. When not used, the
>> - * updates default to being ordered by refname.
>> - */
>
> Do we maybe want to move the comment over? The explanation of the index
> field seems useful to me.
>

Yeah, that'd be useful indeed, let me move it.

> Patrick
>
>> -int ref_transaction_update_reflog(struct ref_transaction *transaction,
>> -				  const char *refname,
>> -				  const struct object_id *new_oid,
>> -				  const struct object_id *old_oid,
>> -				  const char *committer_info, unsigned int flags,
>> -				  const char *msg, unsigned int index,
>> -				  struct strbuf *err);
>> -
>>  /*
>>   * Add a reference creation to transaction. new_oid is the value that
>>   * the reference should have after the update; it must not be

--00000000000018936d062c216821
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 48b85ec1051d171a_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lT01Na1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN2RwQy80emJNUjVVTTRZM05SR0VldEVkTEYrU0VuQgpJd3dISi9FUHNQ
cGRXOEs3RmVxTTFtMUlGamFaeTVEQy9zYlYxZlpabU1SSjY1RjQ1SityWHRSaXUwdFJyUG95ClBp
b1oxZWpjdjBTcWpsWGk0UFBzNVJmQWsvS25pdXkzOURtRmhTMmpPQ0l5UytwY3Y1ZUc2VCtlaFNC
MTB4RXEKU2lZY0MrN1pyL1NKbzJldUczUzZ1bnZJWkZNQlB2Mk82ZFZMSk9ieHloZytITDgvNlZZ
R09DVkdZd3UvbkhldApNREFTUmV1QVRqdFlXT0lJeGt0TDY5TTRiQ0ZhU244MDdxVjdiRDl6b1Rn
R2ttZ1VPY3FXOTAzT3VaN0h1UjA0CmVFMlR0aU1mZ0ZaUEhFWjh6dm1wcWFpMktkekZvUXNXWFBR
Vm1QZndNL0hZUlRUekl3aGZucEZ0Rk9IeEEwbVUKYWJoZ2RxWjZDaGpqWjJZZmMvajBUbUxUcWtL
ckxSR2hmTE1iV2ZEdTRjcklKN1VSbjFUdXYrVWVXZit6bHoyVQpJTWNyeUVldkhwMnQ3SWlMNmVZ
eVVXekV6KzNmR3FWZHZPU0srMThYWWhyd3c1SHlQaXY3MUMvcDlNYXlKTExXCngvc0l0SnM0QUI4
WGJuSVVRbTRoR2RETzNOSGtEMTFkaHo1dU1EST0KPUFrSHQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000018936d062c216821--
