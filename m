Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60C686320
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853828; cv=none; b=WgJqP9Uc9STMfwg4OsKrVKPJuTtLLvgiWtNpKQsrVoA0IEtRx3Aj7HWT+RiMg/GxtNNg+sPnn0Rp69n48g0DU7nLngr/8TzLiBe13AxZU9JrVK/05w1bkQDaWJeqsqPnkG9hjemgOFRiFHII2FJtNGchGeqRkSqTzInXJA3qO9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853828; c=relaxed/simple;
	bh=njy5FThmsKYQC/N2wxZzhzPqFy6ajAAq0e2zt59l4u8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDyhW6515/amPjmE0/XS1kag5GfE9FmjRUiSGEgTFe6DnJzVoM6yAleLdtWLEjXPFfvLumVc+ALsm0Xh1lgOnomVwZ41AXAFz94Bdy9j1BdnMHUbyQe7BlP6HfcvoP6JS44bApc/7QbMW+Eu1O6eqjvc6AfX19yzh4kx/l5FFl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RECejP3e; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RECejP3e"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-46750537450so26393871cf.2
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 10:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733853826; x=1734458626; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=viqgtPd7vAinlG1SRo1vxD0W8atewVSI23xupKF+isU=;
        b=RECejP3eNxu3VPxJzMNjwHEx2A/tE0ztNyhb16iayTbwc6mE9gLJxgpcDSvzaUusBY
         Yzy0cINm1w3Kqnn6SAwWBt9uiyWF/62UXYHJ5d5kMULvB0jcqqY+b5v2QsWTsUr7GHnG
         A6xXQfn7hNQ/OKrxzCG3RuVkcW6qG28ZYuHaMdktay5HNHKN0apnnCzR8DPuo/ej2j5z
         3Nc6J6DuhgwbBHpwQ0USDldynPOAIQMiu6j9dIfj9NacV4BidMLIcGpTBUEwcY6ujGnN
         M+eJMXzLQBAWse3YWE9oxx6m2yJ6FJy8GsGm5xphUulyb1wIxvuI7OP+kKFndAu5ZfJX
         D5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853826; x=1734458626;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=viqgtPd7vAinlG1SRo1vxD0W8atewVSI23xupKF+isU=;
        b=qaAZ3Yd6xDKeqYOFxE3S6EM8KC+FbmQ1qOvPbGccqp53WoV8yC+F3kYcRoDUYoePnm
         xOekL5d8TXhShMVHKuet7hjOPMH/xYz9Mxw11VcOU+PpmGXiwPhy6OPYxtpbbfrUt+Sq
         F2V16YHLv7zisaIqh4q6yHmZxsNcuBzc3lonTO9MepithMZShff0U/ZxadvtLOxq3Oup
         uM63cY5zxIxuSeFMWeQ5Q4WCxrhfDzt3aA4UBdXcs9z0WMDfuobOkSRIfww34lrJIUJP
         XIOuWIdfc2kOa/BXnNxqZ7XeNDdz8+BBcgpSvhw1cdb0VUZkLxwet8JoZLo29nUuNLhH
         2QTA==
X-Gm-Message-State: AOJu0YyBWoaOQbrYpOVWtYpHk4H6J5Kzls0CpCzsXw3BzNGdy035jvcm
	RjYpNSqo1b4h7/JT/dvyiSXR9uIg+aRQdbVLY7QP2pgVlsatWyYjqE7mEp8YlOtHFqlB6eIsRQE
	rxGHa6qKQBMgznGljjIlVw10F79s=
X-Gm-Gg: ASbGnct3JNdow9gCwtZVcnh8IxDcRbaiA97Qygdn0IiAbiefJThNLP+n9PzLJs8LWNC
	FXQl5wBYdBB/H1DE3Js0hX+Sh/EahbOyMAW1vKHmZdOYrdAKBEnrS78Vhv5i40K/vhqDfHA==
X-Google-Smtp-Source: AGHT+IF2XmCVpOIiaD+1n/V7Tqm+LMiH0PrQeqUimLczmLu50pevJnpPbdAZV6iM1lOuezmcXRyx2629Ih2ays6VCJU=
X-Received: by 2002:a05:622a:8e07:b0:467:83f1:71d9 with SMTP id
 d75a77b69052e-46783f17fb6mr28822521cf.0.1733853825530; Tue, 10 Dec 2024
 10:03:45 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Dec 2024 10:03:44 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <CAOLa=ZRsAwM8oUnyYCaRKkkudN+QW+hRSKZEvPJLThSr14M7rA@mail.gmail.com>
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
 <xmqq34ivlora.fsf@gitster.g> <CAOLa=ZRsAwM8oUnyYCaRKkkudN+QW+hRSKZEvPJLThSr14M7rA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Dec 2024 10:03:44 -0800
Message-ID: <CAOLa=ZRwH8mGDF=afGnci6BXD8r+tA5gKgrQRb0BZFBWYDG7qA@mail.gmail.com>
Subject: Re: [PATCH 0/7] refs: add reflog support to `git refs migrate`
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, toon@iotcl.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000005d83780628ee4d9c"

--0000000000005d83780628ee4d9c
Content-Type: text/plain; charset="UTF-8"

karthik nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> The `git refs migrate` command was introduced in
>>> 25a0023f28 (builtin/refs: new command to migrate ref storage formats,
>>> 2024-06-06) to support migrating from one reference backend to another.
>>
>> This topic pass the tests standalone for me locally, but seems to
>> fail 1460.17 and 1460.31 when merged to 'seen'.  I'll push out the
>> integration result tonight; it would be very much appreciated if you
>> can help find if there are semantic (or otherwise) mismerges that
>> are causing this breakage.
>>
>
> I see. I can reproduce it on 'seen' as you mentioned. Will debug and get
> back to you on this. Thanks for letting me know.

Seems like this is due to 'kn/reftable-writer-log-write-verify', which I
should have totally seen coming. A quick fix like the one below fixes
the issue. I'll merge in 'kn/reftable-writer-log-write-verify' when I
re-roll.

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 1badf88df0..5c51a6a226 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1428,6 +1428,7 @@ static int write_transaction_table(struct
reftable_writer *writer, void *cb_data
 	struct reftable_log_record *logs = NULL;
 	struct ident_split committer_ident = {0};
 	size_t logs_nr = 0, logs_alloc = 0, i;
+	uint64_t max_update_index = ts;
 	const char *committer_info;
 	struct strintmap logs_ts;
 	int ret = 0;
@@ -1541,6 +1542,13 @@ static int write_transaction_table(struct
reftable_writer *writer, void *cb_data
 				log->update_index = update_index;
 				strintmap_set(&logs_ts, u->refname, update_index+1);

+				/*
+				 * Note the max_update_index, so we can reset the limit
+				 * before actually writing the logs.
+				 */
+				if (update_index > max_update_index)
+					max_update_index = update_index;
+
 				log->refname = xstrdup(u->refname);
 				memcpy(log->value.update.new_hash,
 				       u->new_oid.hash, GIT_MAX_RAWSZ);
@@ -1604,6 +1612,8 @@ static int write_transaction_table(struct
reftable_writer *writer, void *cb_data
 	 * and log blocks.
 	 */
 	if (logs) {
+		reftable_writer_set_limits(writer, ts, max_update_index);
+
 		ret = reftable_writer_add_logs(writer, logs, logs_nr);
 		if (ret < 0)
 			goto done;

--0000000000005d83780628ee4d9c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 503c956ae3c9c94d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kWWduOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNzdXQy85RDVwSFpWZTlHR2xWZ2ZJSWhaTWFOa1pPNgpZRHBKK2ZYVzc0
NHQyTEFZWCtKUWxObEdjOWd6T29NMDBlL0tGME1vdnBEY1c0NWNWbG1hRm5LMzFBQkNwS1krCnph
S1BFOUJ6bVVhVXA3UWIyUjNPTEVHTk44U0MrWG1LNGtmbFFlUEcvMnZSYUwvTlY4Rm8xYzlVMUlt
ZlV0c1gKTUJJSW1WUnRVSmt6REpjb0FPYkJ3aXVyNVo4UGRsbjNXZHU0Ulh3K1k0OC82NGNydFlJ
RmtMVG5zVWgzWmFRZApvWHgrVjV1UU5KVDdUWkplOEhKdENXeVVVNXpuam5sZTYzSEJuRmlSNHdi
M1dzOVJYdmp1UjhNaW9LVmp5RHZ0CkZQNTZtR1dBb2QrTHVKTUUwaFZaeEtkcVNMY05GbXdqa2t4
VXQvSGFtVGxhdTBERklXOXd0RmloaldZZmlxYisKVHZ6TU10bHBwb0xtUXY4WTAyamFqMXZudGlG
OEVWVFg0Rk5TQ2lOZkpHUDBHaFBjM29aN0dMWGg2aytrNDRQZAp0MnlRK1ZRUlpmYmtiK3BoczdV
YUppbFl1aWRhdXhVVkp1ci83c2krRjlYUWpwY24wbDFrbjVKekpFOXRyb0lkCmNGa1oyQlVSRnVR
aDcvelF1Y3pzaE5NblFOTWRFRnlmT1hkMDYzYz0KPTJHZHQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000005d83780628ee4d9c--
