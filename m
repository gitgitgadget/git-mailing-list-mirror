Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F326B1DA0E9
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733484271; cv=none; b=UstsDFDEPNrAyOqlca0PuVDjggHQk/qB+fCRCjrOWOd4S7gnNfh++JjcLPPkwllv1IDXsCPN0h108YmuJ+fDYArIk7pTAcZO4V1O3xK+F4F6ZDfyfHksMCZY4K17DGputPF3eYPtF2q7xJ2h/xpz+ddwWLIiAijxgM3XSGd5neo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733484271; c=relaxed/simple;
	bh=1D6MVH/o2BXGISt3kOYPAlm947vxibdhKIjimlUOo90=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smtJ5K5AtfnzNa9c12F6UFw5DZ10PqICKEgZdmsETd2lqX5GkuwF40k0jHhHBL3f/vfiYCPoaQ9utQ9/GirS3NYIK8JZ3IQtqM4OgzLLO2SLVQAGwckn9m49ObZhsaoHGUBkrSbfR4KAh2+tl1xN51zGBoxnUtcvKti6OGjIegM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfw8TEqI; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfw8TEqI"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-515c7971553so534469e0c.1
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 03:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733484269; x=1734089069; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7PP++t/wMbY2lvbxJThk/qG6aqCOBajVRJpyzhsTmk=;
        b=mfw8TEqIcqNm8mEoP982BwDgc9XGxiF0s7fstl3+uhQ2ox+6yTXO2MGJDIsxQnzXZ5
         q0kYtZC93ed2yeR5+XbjqCf8x4qaYypTqam3b1f0ho+lv6fd0m2oDvfIUMwMDcg+fema
         JfeSjPzoPWoIUqwN/e7zowBPdLwI3ZdNgx/DxJn/gUT+Bz7pl3KnHvK2f6+IjicxuCzk
         HsdpI3mS/WQuCC7OjsyzX6neEiJmSZHt2+s5bCqwWNKplIxYm9HFZ+rhrJ7Po9a0DvTG
         15fABcT52dhEnqJ8dltV/cZXrQW9HaNyRo/ax4UAldGrTT6MBerD58vyRFxPrpUdRWkG
         cptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733484269; x=1734089069;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7PP++t/wMbY2lvbxJThk/qG6aqCOBajVRJpyzhsTmk=;
        b=Ve94Rp3fl/A3kiBOVSTghZBcCwamkxU3kA9iOvJnnUoKYjf7OontNb7/6qOpN38L3k
         PS0nTOGbGngZjTJlv8bBv/HTC+yPERpQI94sISaeMvC8TlNCy0eV7PLzJ6FXY+314iAj
         iRJoAiC8dPex9L1tXPfvyGQLpUasuLotZ2J6589Itl/LPt0JbBfkxdnYiwticAstT+ML
         Fj3iSK+daBu1P6lgj7TIwm6cjf26t1kjLbOQkJtVNQSvR/MzBS3cojGPK8Frzd1FkeqG
         /OGgX2E5QmgAIBdPYgIRcevOxEYbpCFILuXReoEeTQAkCf/FUjlmm1NTdJDzTK0Uo2dH
         0VCA==
X-Gm-Message-State: AOJu0YxjU/nNOrwmoqY09hkCRnQOvzUU9lCRV9dazJv6qAbHcYKIs509
	adyM3Zz3bMNXOEF4Tn6Fkl8zSaGZVIsadRbC2hza6144SWbzHwCUih41Ly2tNenj7PSyPewI524
	tkn9lBCt8v8gUCnN8EG6dP9tByguucOX4
X-Gm-Gg: ASbGncsMa5sMsBfKa/QRwmEhf/OTgPEeK1JgiYC86BFCq55UES7JMrbYpKfVyuBBB5o
	Wu+zrzb+64JiRfWjQR5TaaX8d3kfvkA==
X-Google-Smtp-Source: AGHT+IGmOstXSA9d4Y0FDyUMbfjAx05eF6MKWW+y4iXh3qzSplVZxuKsuxnj2nNducyHFe8aYsIrGdXKq0xEfaR2Lno=
X-Received: by 2002:a05:6122:3716:b0:515:3c4a:3c0f with SMTP id
 71dfb90a1353d-515fc9d6fbamr2931759e0c.3.1733484268884; Fri, 06 Dec 2024
 03:24:28 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Dec 2024 03:24:28 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Z1K-rXakmMQHN9If@pks.im>
References: <20241205-424-reftable-writer-add-check-for-limits-v1-1-b287b055204e@gmail.com>
 <Z1K-rXakmMQHN9If@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 6 Dec 2024 03:24:28 -0800
Message-ID: <CAOLa=ZRVy46gZP3JK5sUHaJVCCXacqbT+aW_Yr0WdboRVks9dw@mail.gmail.com>
Subject: Re: [PATCH] reftable/writer: ensure valid range for log's update_index
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000123a000628984220"

--000000000000123a000628984220
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Dec 05, 2024 at 04:49:57PM +0100, Karthik Nayak wrote:
>> Each reftable addition has an associated update_index. While writing
>> refs, the update_index is verified to be within the range of the
>> reftable writer, i.e. `writer.min_update_index < ref.update_index` and
>> `writer.max_update_index > ref.update_index`.
>
> These should probably be `<=` and `>=`, respectively.
>

Indeed, good catch, will fix.

>> diff --git a/reftable/writer.c b/reftable/writer.c
>> index fd136794d5a27b33b5017f36fbd6b095ab8dac5b..f87086777cd20a9890a63f10c5d6932310dd5610 100644
>> --- a/reftable/writer.c
>> +++ b/reftable/writer.c
>> @@ -412,6 +412,18 @@ int reftable_writer_add_log(struct reftable_writer *w,
>>  	if (log->value_type == REFTABLE_LOG_DELETION)
>>  		return reftable_writer_add_log_verbatim(w, log);
>>
>> +	/*
>> +	 * Verify only the upper limit of the update_index. Each reflog entry
>> +	 * is tied to a specific update_index. Entries in the reflog can be
>> +	 * replaced by adding a new entry with the same update_index,
>> +	 * effectively canceling the old one.
>> +	 *
>> +	 * Consequently, reflog updates may include update_index values lower
>> +	 * than the writer's min_update_index.
>> +	 */
>> +	if (log->update_index > w->max_update_index)
>> +		return REFTABLE_API_ERROR;
>
> Yup, looks sensible.
>
>>  	if (!log->refname)
>>  		return REFTABLE_API_ERROR;
>>
>> diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
>> index d279b86df0aeda11b3fb4d2c15803760ae394941..5ad1c72f6901abcfe7fdc6c3e69e26b58d0013a6 100644
>> --- a/t/unit-tests/t-reftable-readwrite.c
>> +++ b/t/unit-tests/t-reftable-readwrite.c
>> @@ -151,6 +151,45 @@ static void t_log_overflow(void)
>>  	reftable_buf_release(&buf);
>>  }
>>
>> +static void t_log_write_limits(void)
>> +{
>> +	struct reftable_write_options opts = { 0 };
>> +	struct reftable_buf buf = REFTABLE_BUF_INIT;
>> +	struct reftable_writer *w = t_reftable_strbuf_writer(&buf, &opts);
>> +	struct reftable_log_record log = {
>> +		.refname = (char *)"refs/head/master",
>> +		.update_index = 1,
>> +		.value_type = REFTABLE_LOG_UPDATE,
>> +		.value = {
>> +			.update = {
>> +				.old_hash = { 1 },
>> +				.new_hash = { 2 },
>> +				.name = (char *)"Han-Wen Nienhuys",
>> +				.email = (char *)"hanwen@google.com",
>> +				.tz_offset = 100,
>> +				.time = 0x5e430672,
>> +			},
>> +		},
>> +	};
>> +	int err;
>> +
>> +	reftable_writer_set_limits(w, 1, 2);
>> +
>> +	err = reftable_writer_add_log(w, &log);
>> +	check_int(err, ==, 0);
>> +
>> +	log.update_index = 2;
>> +	err = reftable_writer_add_log(w, &log);
>> +	check_int(err, ==, 0);
>> +
>> +	log.update_index = 3;
>> +	err = reftable_writer_add_log(w, &log);
>> +	check_int(err, ==, REFTABLE_API_ERROR);
>> +
>> +	reftable_writer_free(w);
>> +	reftable_buf_release(&buf);
>> +}
>
> Makes sense, as well. We could trivially extend this test to also assert
> that we can successfully write a log record with update index 0, which
> would be smaller than the lower bound.
>
> Patrick

Yeah, that does make sense, will add and send in a new version. Thanks
for the quick review!

Karthik

--000000000000123a000628984220
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b511513f6f229a70_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kUzN1c1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md0VGQy8wYitITnFla2lDQXluZUdXczJvS1NOTXFBUAplMjBUVDFJbHVs
a0JIclhoUTdQT1JyamxVWWVLUDliV0FNN0VHckxKdlZDb0d5ZmRBMUk1c0RBQkFONTQyU1N1CnBT
aEVibi9YQ2Q4YksyOW5KM0hRMHVSdU5wUUptTXZDQU4ybnoyZkl4YXZDUSttUXZGa2NhV1ZqaDhU
Wm4zbW4KcDMwRnZJQWoxKzZOaE5qWG0xRW5FY2xNVE8wM2drdHoyOUV0RldBUVoxcjcyYjBXSzNq
UXRma1lGeUxocU1Rbwpvbml0aTJMay84WkxVcTR3a3FET0dsNzBjY1VadnFVOUYweDFvMUNKK0gw
ektlSHg3cU5GekVTeENYWGVLMGlmClR0NHl6Z1lRUTVoVWlLQ3YwUkhjOFZBeEFZYnNUanhrenZZ
UHN1NW1NVytvdnBvSXdFOWpZY29NVStCOU1SdDcKQ00yRUZZendBY3B1NkNHSzBNUFNRMXdiOHdQ
SVBhMXJXWlNZNS80bFV1N21vZU5ZbzkvS0t0eVJ5Y0xJcDdIOApIT0VGeUJrMU4vZHVhWFFsUklk
UVR6dS9uZEd6Ykd2ZnBwc1BUeTZ3cHpZR1E0dE53SGhDRi95UVM2d29kMldtClRvcUF6MGlTS0Nm
cFc2OTVVYVpWNE1FVjFPK0dXZlZyRjNGcWZtZz0KPWFWbkYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000123a000628984220--
