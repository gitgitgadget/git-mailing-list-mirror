Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9B91AC444
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734693311; cv=none; b=P9WJTXwlN+cPWMfcFGBfN4DHtrAQhSD50tT+N27M6VyKL8mH6HpJalo9g9KgTLIGDVHAxMc4RZ9JEKvEcLvcr+8JlJGg8rQabe5nSro8fYCVWHagBKrwD1fTSmYhGGDXF8Jl63GBOH0ojr+sLYzKOqy9tb160MNMCebZzBKxapw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734693311; c=relaxed/simple;
	bh=kCuzcfm/CMfaH5HGhqvg8N8LqI6UhVw4DDyWmOqQcAU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTRyDeZxQrfoSjZRng5FMIv20Q7KGomWIxb3FyrFevzbNpelXCdIoqyR89+pNjLB6uvFI47qBOGh446Y5cATi6zi0Mb63mmE7zdxTEpjM9AfIAmlrklL6767mKlz15cmVd7PHE1p/Fts39zDadhhean+kZ1sWLewPZJ/VRdRm2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOOTx+KE; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOOTx+KE"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-518ae5060d4so538506e0c.0
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 03:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734693308; x=1735298108; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wBVMdsweGE3vX+ExOI7NTQPl908Q7cpspO8fJEebu4Q=;
        b=MOOTx+KEsBWa+YLMe5r4mVvTWzE6IJUOktXDZV3H26NXMW/8JsoyaOtJ+KS6IGY3F8
         ogn7Q0l63W7p37ZJR/3e1PbUuefp8OiGaupiYs2PK9/1NMQKHEoG7f9AGgE47WkJjE9T
         blfZhe/I3KbjyV3H7E/QFLVa7DVo0gTY5sayEI/ZgDGue+9+BEkHe5ydzBhoa8l9xCN9
         WBYzV+RkX5sw+vKM260p/qbarNb3PiTsM3zGvzY4NSOhJ36S6eoRpr+p3lhzcy+4IMkb
         P+GdWavBxfTmwH8uVKvnIWyoge2sEblPR/BbojlYMD0324vb8K19TVtqiwmT3devU1NQ
         nckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734693308; x=1735298108;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBVMdsweGE3vX+ExOI7NTQPl908Q7cpspO8fJEebu4Q=;
        b=RMK6teGKRYbg5IDJ/ZtfBouW3bTu9R7EkaAw4hm/AK1ILs4b6r/e02VqOQUPJioFL+
         ccu+mayb5DG9QAr12yaYnqH+gcA/Wt3TY22Dmcb4d1ogtqI9I3hgyEwIMRwesR9DcPZv
         PTVhi2/7kVAH2wQNl2Pa+givh+JhVpRTw7N2I4z0JdewVEYlmQafzidoju6DqKOnzjZh
         M06qCn71ErXs0fmLZKCDuzCJmri7awYsPTPvknPRDpsPs2QEC0KIiHymrxPVhunTlpZb
         q2g9YZmdpfEXGkurj9e0n4+my7/zjck13b04JvPM+40JMuBchdJzXjgKIZJEk289QYgP
         YjSw==
X-Forwarded-Encrypted: i=1; AJvYcCUMC/x1KIMzMB9CYSoiTBV6qxrePosPmVtI8FoyErVdDzqDHIPdL2KR9MRNEScd7uyJpgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwF9565NWbOgji4GDjlH5O3n8ah6qI3JVRWRKVmIpPUxdeirU8
	VdwAI5gQDoSg4Fj0jJYgTpW898INLzy+JB7gnJ/HORSCjSBLWRJg95GPmRJrLF9LdMlk9/eA4zq
	kdfTKgVlbCQD6zdy1KB81+OezhAQArCla
X-Gm-Gg: ASbGncurBwaNhn+ug+XBEuqykRE9EP8bAfbhPS2EZw8bMSINbEAFqhYWQ4kd9DH4Vk8
	I0WNV0ZFuvXIINrBe8XW0eoRsbmRqVnPry9cI
X-Google-Smtp-Source: AGHT+IFIz/kMWaIWLkLfMKPxU1JccfuxpbOTMU1rbtBq4Nxjf+7YLpCkvw+7rPGRgaU2ypgYvAze+MXRDI79RkJ3gJo=
X-Received: by 2002:a05:6122:3a1c:b0:518:a14e:7334 with SMTP id
 71dfb90a1353d-51b75d8c90dmr1960956e0c.12.1734693308425; Fri, 20 Dec 2024
 03:15:08 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 20 Dec 2024 06:15:07 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <871py3h3ia.fsf@iotcl.com>
References: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
 <20241216-320-git-refs-migrate-reflogs-v4-7-d7cd3f197453@gmail.com> <871py3h3ia.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 20 Dec 2024 06:15:07 -0500
Message-ID: <CAOLa=ZRQsVMBahopKZLwFX1qZuJ35EZPBNmoxbidzGkheqSpEw@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] refs: allow multiple reflog entries for the same refname
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: ps@pks.im, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000718c6c0629b1c2d0"

--000000000000718c6c0629b1c2d0
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The reference transaction only allows a single update for a given
>> reference to avoid conflicts. This, however, isn't an issue for reflogs.
>> There are no conflicts to be resolved in reflogs and when migrating
>> reflogs between backends we'd have multiple reflog entries for the same
>> refname.
>>
>> So allow multiple reflog updates within a single transaction. Also the
>> reflog creation logic isn't exposed to the end user. While this might
>> change in the future, currently, this reduces the scope of issues to
>> think about.
>>
>> In the reftable backend, the writer sorts all updates based on the
>> update_index before writing to the block. When there are multiple
>> reflogs for a given refname, it is essential that the order of the
>> reflogs is maintained. So add the `index` value to the `update_index`.
>> The `index` field is only set when multiple reflog entries for a given
>> refname are added and as such in most scenarios the old behavior
>> remains.
>>
>> This is required to add reflog migration support to `git refs migrate`.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  refs/files-backend.c    | 15 +++++++++++----
>>  refs/reftable-backend.c | 22 +++++++++++++++++++---
>>  2 files changed, 30 insertions(+), 7 deletions(-)
>>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index c11213f52065bcf2fa7612df8f9500692ee2d02c..8953d1c6d37b13b0db701888b3db92fd87a68aaa 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -2611,6 +2611,9 @@ static int lock_ref_for_update(struct files_ref_store *refs,
>>
>>  	update->backend_data = lock;
>>
>> +	if (update->flags & REF_LOG_ONLY)
>> +		goto out;
>> +
>>  	if (update->type & REF_ISSYMREF) {
>>  		if (update->flags & REF_NO_DEREF) {
>>  			/*
>> @@ -2829,13 +2832,16 @@ static int files_transaction_prepare(struct ref_store *ref_store,
>>  	 */
>>  	for (i = 0; i < transaction->nr; i++) {
>>  		struct ref_update *update = transaction->updates[i];
>> -		struct string_list_item *item =
>> -			string_list_append(&affected_refnames, update->refname);
>> +		struct string_list_item *item;
>>
>>  		if ((update->flags & REF_IS_PRUNING) &&
>>  		    !(update->flags & REF_NO_DEREF))
>>  			BUG("REF_IS_PRUNING set without REF_NO_DEREF");
>>
>> +		if (update->flags & REF_LOG_ONLY)
>> +			continue;
>> +
>> +		item = string_list_append(&affected_refnames, update->refname);
>>  		/*
>>  		 * We store a pointer to update in item->util, but at
>>  		 * the moment we never use the value of this field
>> @@ -3035,8 +3041,9 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
>>
>>  	/* Fail if a refname appears more than once in the transaction: */
>>  	for (i = 0; i < transaction->nr; i++)
>> -		string_list_append(&affected_refnames,
>> -				   transaction->updates[i]->refname);
>> +		if (!(transaction->updates[i]->flags & REF_LOG_ONLY))
>> +			string_list_append(&affected_refnames,
>> +					   transaction->updates[i]->refname);
>>  	string_list_sort(&affected_refnames);
>>  	if (ref_update_reject_duplicates(&affected_refnames, err)) {
>>  		ret = TRANSACTION_GENERIC_ERROR;
>> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
>> index b2e3ba877de9e59fea5a4d066eb13e60ef22a32b..bec5962debea7b62572d08f6fa8fd38ab4cd8af6 100644
>> --- a/refs/reftable-backend.c
>> +++ b/refs/reftable-backend.c
>> @@ -990,8 +990,9 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>>  		if (ret)
>>  			goto done;
>>
>> -		string_list_append(&affected_refnames,
>> -				   transaction->updates[i]->refname);
>> +		if (!(transaction->updates[i]->flags & REF_LOG_ONLY))
>> +			string_list_append(&affected_refnames,
>> +					   transaction->updates[i]->refname);
>>  	}
>>
>>  	/*
>> @@ -1301,6 +1302,7 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
>>  	struct reftable_log_record *logs = NULL;
>>  	struct ident_split committer_ident = {0};
>>  	size_t logs_nr = 0, logs_alloc = 0, i;
>> +	uint64_t max_update_index = ts;
>>  	const char *committer_info;
>>  	int ret = 0;
>>
>> @@ -1405,7 +1407,19 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
>>  				}
>>
>>  				fill_reftable_log_record(log, &c);
>> -				log->update_index = ts;
>> +
>> +				/*
>> +				 * Updates are sorted by the writer. So updates for the same
>> +				 * refname need to contain different update indices.
>> +				 */
>> +				log->update_index = ts + u->index;
>
> During my review I was having a hard time figuring out when `u->index`
> was not 0 and where it is being set. Can you maybe explain a bit?
>

As of this patch, there is no users of the index. This patch adds in the
infrastructure. The next patch is where we actually set the index.

In short, the index is only needed for the reftable backend. This is
because reflogs contain a specific order and we need to retain that
order. In the reftable backend. For optimization, all writes are sorted
by refnames. The index provided a parallel system to retain the order of
the updates. There are no real usecases apart from migration of reflogs
from one backend to another, which is added in the next patch.

>> +
>> +				/*
>> +				 * Note the max update_index so the limit can be set later on.
>> +				 */
>> +				if (log->update_index > max_update_index)
>
> Is there a lot of value in having this if clause? I was a bit confused
> why it is here, because I think we can do the assignment to
> max_update_index unconditionally.
>

It is necessary. For reflogs whose index isn't set, their `update_index`
would simply be the `ts` value. So if there are a mix of reflog updates
with and without index, we could end up with a scenario where we don't
set the max to the actual max.

>> +					max_update_index = log->update_index;
>> +
>>  				log->refname = xstrdup(u->refname);
>>  				memcpy(log->value.update.new_hash,
>>  				       u->new_oid.hash, GIT_MAX_RAWSZ);
>> @@ -1469,6 +1483,8 @@ static int write_transaction_table(struct reftable_writer *writer, void *cb_data
>>  	 * and log blocks.
>>  	 */
>>  	if (logs) {
>> +		reftable_writer_set_limits(writer, ts, max_update_index);
>
> So max_update_index is used to set the limits on the current writer, but
> using reftable_stack_next_update_index() it's also used to give the next
> stack it's starting point for their range.

Using `reftable_stack_next_update_index()` would return `ts + 1` as that
is the next sequential update. This could be lesser than the
max_update_index. So we can't use that. Once all the reflogs are
written, the next call to `reftable_stack_next_update_index()` would
return `max_update_index + 1`.

> Now I'm not familiar enough with the code, but are all stacks handled
> in sequential order?

Not sure I understand your question correctly. Updates are handled as
per a given index. Each update is also sequentially stored. Tables are
named after the min and max index that they store.

> And how does a stack relate to a reftable file?

The stack is used to refer to a collection of reftable tables. So for a
given worktree, the tables under '$GIT_DIR/reftable' would constitute a
stack, where the 'tables.list' would state the tables which are part of
the stack

>> +
>>  		ret = reftable_writer_add_logs(writer, logs, logs_nr);
>>  		if (ret < 0)
>>  			goto done;
>>
>> --
>> 2.47.1

--000000000000718c6c0629b1c2d0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1e19ef47c2c51629_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kbFViVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN3hHREFDRko4dWJqSE9lVzhsRTQrOE90WjhlVzU3NwpIQjNla0o1ajZP
V0JyeXdaTTRMWGFsNlpwR2Q1WlVINDFmNDBiQTM2aTF5UzF2ZEdMQXdtSUFPV1dwd21VVWI4CkIw
MjZCSWNjLzNIT0xGUlVyQWdrWkI0dmhEeFNNOXJrRDY0empscFdtcGpleVlHdm41RHFYRHhhQzNz
eENBUVEKTi9xbjJpeGwvSXpKTkFqTlNvY3c2bDBFWjc2ZnhiU1M0VzNCeTVldmpJRFhjeDFvbHpy
MUwzZ2RKZnVKUDRLYQpRQjdBd3Nvb0ZscjJkM040ODZzd3BxZ1JaaWt3enBzbFhGSld3ZHNXaWFn
RDB1QXhQeno4eW1nMFMyZllQdTI1ClRuNXRlRU56VzRvazJXa3Y4VWVzVWUrK0NQTnRXRExSWkQy
dmFoM2sxeW9ndnhpZGo2a0hXVDNIZVRKbU1RVGYKUG96OFNFai9TVmtFcitNODRLMk9VdTVEMHZq
UnB4R2FMQkZPcUhFVnlUb3dEcjEzNEdLaFBmeDRGdk1PdXZ6awo3eFJzbU42bFlYYWdsTUhoOUNv
QW1IbEF6K24weFB4azc3WllVbERkYWtJcjNSSi9Dd2ZtQURueUlRcldNRXBtCnBjdUhVcisxQUwr
RXFLUUpmWkR1d25sSUJubXJWaTRtMDhYdG4xUT0KPXpJeHMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000718c6c0629b1c2d0--
