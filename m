Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7210F1BD9CA
	for <git@vger.kernel.org>; Wed, 11 Dec 2024 18:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733940551; cv=none; b=eljO3ogHMFtlsWajMIwzxK8AOABVzgXNA8ojEj1njx2V39Ba49ZctlXTKbBao1V9GzAYNw3APf8uYX7EYMZaCnf4/MGavu5Q1DoaVxGkF8SqDva/YtvdGXzONFpEYiQANT/bXJNttTvw8mQCuxIepKdZOh1hlQ6MvfMxZjSUWx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733940551; c=relaxed/simple;
	bh=u7ERv29x9xLhFRNnzqt+G0F03m0UPsYZNHXCzqZO5kg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cCBPIGss1UkadL3mew2Fo0MCWZN1wGxVHB/jd7uknIaNCdPp8OoI/bk/Oaw7qiz9NDLo+KDs4NLZK2SOAYcBaH4Fir7AlJoiYyYLqhiAKa0prbAxc0ctyWvEBluEUA1knwSAVqFsJrDmuFLAMy7jZ4sSAj9nPu9mciClUXC7sKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grMyANt9; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grMyANt9"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5187f6f7bcaso1051062e0c.3
        for <git@vger.kernel.org>; Wed, 11 Dec 2024 10:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733940548; x=1734545348; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=o0GlNtCLkys/mQi8pKj9Zmt3wTZ+3pLRcn4xyK0kFSU=;
        b=grMyANt97MgUex29tQ0mWwxmpxAkKS5t6x5dlzM8UdvbYgHZKoLXOvSrxZ8RY9fKGm
         aRfjf404emga993wsMjh6ExIC5jHnusjuJvlgaJGyvbC3scXz1nBnjd+5PqYBE5f98ge
         6bhPcdbDYt7OnKMDCTPqgA5W6lbm6mdZ9t949CRcJQhEITm/MMOfw7yK2dNfwyFDLDbA
         2HSU8R4f3gbCX1fk8Oo3Z/NT8q0W87lKaZGAAAmhhiwCthcelRfXpRCP0ckULR6i8EHA
         jPIn/UClgui2DWDg+FteTzyo0RsEYJWAhFLQYyz6D7f8lCDd2rtZ8RqtHzVAK30Q3BDm
         yOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733940548; x=1734545348;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0GlNtCLkys/mQi8pKj9Zmt3wTZ+3pLRcn4xyK0kFSU=;
        b=lvr9Z/SEr+ULAaR6JYULlRxOak2VS5B9PJbe/gwqybcuqAH/FsKpuokhgt9KiRbfqe
         PG9WXraK5H6DsvwcF0EFyiFFxFPI08MirOZBs08IEHXG50Nak/pX0mErFZRaekVNZ6sh
         md6Rs4CbFqWefN/fKHntdf7ev5DvlCNSwfxFssYJV8/L73eZe0dqwO42q3SQf7H5jbQ/
         Nij/fbuRuTIHxlgrbh36pEbdnrh9Eor8hQelng8m62reO1ub6MAXmkDS27ujgg0dkmkF
         5XdmMJ5yna21QZKcH9thxjSTE/Az5vTDpXahihfAccdvAPT9YSaR/+2zd2icYWGpTScv
         ZiFQ==
X-Gm-Message-State: AOJu0YyBC8NYPvOtSQ3WVBkWtv5qSgGt42L/1l6eUoV3qllFbIUH+9aV
	iyHAgFJ7LzmXNbMv7FIJrI7lpesGoFnnrvAyIEnq+kov0KWKTBcqRCJTE5Q2usuvnE4PxQKvw0B
	7McpmxpzClFXlGDZa1JPZx2elpc0=
X-Gm-Gg: ASbGnctqdbdkkLHL+VUXMQxxkx7G2vEM+y5NL3plZwEcQ4l6SLurdnSuZul8U5KvVnQ
	VX/ChZNeb08MPjzEi3cisnVjY8TATPL3EUTgq0iqcurUe1sdhXqFi8fToAbuzWuL+JTjGpQ==
X-Google-Smtp-Source: AGHT+IGQP7XKISYBFDywXaqFGUnQ1eHkXbTpWuurcBoNcu35fRvS200FoilWAtVyKh/6TL5FfQYMWtPCwVQnjsXfbIc=
X-Received: by 2002:a05:6122:82a8:b0:518:8bfe:d5f0 with SMTP id
 71dfb90a1353d-518b5b641efmr322826e0c.0.1733940548348; Wed, 11 Dec 2024
 10:09:08 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 11 Dec 2024 10:09:07 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Z1mhCWXowokIaFR5@pks.im>
References: <20241209-320-git-refs-migrate-reflogs-v1-0-d4bc37ee860f@gmail.com>
 <20241209-320-git-refs-migrate-reflogs-v1-5-d4bc37ee860f@gmail.com> <Z1mhCWXowokIaFR5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 11 Dec 2024 10:09:07 -0800
Message-ID: <CAOLa=ZTLK=PL7YmkxzH5cZiHA21r1pM1qqbvu=fXi_rpRmHCYQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] refs: introduce the `ref_transaction_update_reflog` function
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, toon@iotcl.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000007277570629027e6d"

--0000000000007277570629027e6d
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Dec 09, 2024 at 12:07:19PM +0100, Karthik Nayak wrote:
>> diff --git a/refs.c b/refs.c
>> index 732c236a3fd0cf324cc172b48d3d54f6dbadf4a4..602a65873181a90751def525608a7fa7bea59562 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1160,13 +1160,15 @@ void ref_transaction_free(struct ref_transaction *transaction)
>>  	free(transaction);
>>  }
>>
>> -struct ref_update *ref_transaction_add_update(
>> -		struct ref_transaction *transaction,
>> -		const char *refname, unsigned int flags,
>> -		const struct object_id *new_oid,
>> -		const struct object_id *old_oid,
>> -		const char *new_target, const char *old_target,
>> -		const char *msg)
>> +struct ref_update *ref_transaction_add_update(struct ref_transaction *transaction,
>> +					      const char *refname,
>> +					      unsigned int flags,
>> +					      const struct object_id *new_oid,
>> +					      const struct object_id *old_oid,
>> +					      const char *new_target,
>> +					      const char *old_target,
>> +					      const char *committer_info,
>> +					      const char *msg)
>>  {
>>  	struct ref_update *update;
>>
>
> I'd personally avoid reindenting this block. It's somewhat-common
> practice to not align all arguments with the opening brace when the line
> would become too long. The reindents also distract a bit from the actual
> changes done in other places further down.
>

Makes sense, I'll undo that.

>> @@ -1190,8 +1192,15 @@ struct ref_update *ref_transaction_add_update(
>>  		oidcpy(&update->new_oid, new_oid);
>>  	if ((flags & REF_HAVE_OLD) && old_oid)
>>  		oidcpy(&update->old_oid, old_oid);
>> -	if (!(flags & REF_SKIP_CREATE_REFLOG))
>> +	if (!(flags & REF_SKIP_CREATE_REFLOG)) {
>> +		if (committer_info) {
>> +			struct strbuf sb = STRBUF_INIT;
>> +			strbuf_addstr(&sb, committer_info);
>> +			update->committer_info = strbuf_detach(&sb, NULL);
>
> Can't we simplify this via `xstrdup()`?
>

Yup, Christian suggested the same too, will fix it up.

>> @@ -3080,10 +3081,12 @@ static int files_transaction_finish_initial(struct files_ref_store *refs,
>>  		}
>>
>>  		/*
>> -		 * packed-refs don't support symbolic refs and root refs, so we
>> -		 * have to queue these references via the loose transaction.
>> +		 * packed-refs don't support symbolic refs, root refs and reflogs,
>> +		 * so we have to queue these references via the loose transaction.
>>  		 */
>> -		if (update->new_target || is_root_ref(update->refname)) {
>> +		if (update->new_target ||
>> +		    is_root_ref(update->refname) ||
>> +		    (update->flags & REF_LOG_ONLY)) {
>>  			if (!loose_transaction) {
>>  				loose_transaction = ref_store_transaction_begin(&refs->base, 0, err);
>>  				if (!loose_transaction) {
>
> Makes sense. While we already had REF_LOG_ONLY beforehand, it was only
> used in very specific cases and thus the support implemented by the
> backends is lacking. And given that the packed-ref backend does not
> support reflogs we have to queue these up via the loose backend.
>
> Patrick

--0000000000007277570629027e6d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d2fd293292aef1bb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kWjFVQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOHFiQy80N29WWUs2a0pEY3hqQ0M3Rk5ZazJIZzVPQQpXYzRlZ0VHcE15
dWJDWUJSV28vaFRKRStpMzg0eTBaVmRQaGhVcEJ0Y0k5Nk1kRWpneE5HK3p6VGJVOHB4K2hUCllo
Ly9ONWhZcG9JVUlZZXZQeHY1RkZJVnNzSE16bm1RU2tyVEJXMTltWEw1U0wycnZ6QUZPYlZFRjky
aDhTaXEKUjF2bmM1U3lPT21GQVRBZVBNT3Y4REphMVZnR1U1bkk0RXdVQzlYY3F5L0hJQ3hLNEJm
c2oxamZMYUxtdjFPaQo0NzlySURMU2VHdkMzME1ma0YzL1hPcnFTdUlJZmM1YlNPbHd3TWZydjFJ
Q0kvWjdJRUlTYlhDNFRBS2xucTI2ClhYZWlrM05LNjkxeXpERkdXZU5lUlN6SG1kcHhTTVNCdVc3
djZ5VVU1cWtNZGVIZitWMHB6bmhSWTQ0OUR2UkQKUVdwQVJiWFlQN2wwTUpVWkY4MUpDT3BxRnFP
aG9zSUhTT09RckZZZ1NjK3hRazZFa0Ryb1hhNmpVRGIxazFXQgpOUVNSMTVaQVRQRjBUMVZqeHBk
U1Z6VDgxLzY2ZG5vVUV5Q2VudStWbS9NOUhwQ1E0ZWZTUVR5L21QZGpTS0JPClMvZnBWcmJyV2kx
NVpKQ091M2pPaXJ0RUROdVdNL05HVVRKODVocz0KPVk3MzkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000007277570629027e6d--
