Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194463112DD
	for <git@vger.kernel.org>; Mon, 10 Nov 2025 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762780991; cv=none; b=FMqKKFDUTW2XkSVUXUypN5PbUGra+DEQNVR+SIB3mpMH7doDO4WklKunvaEV+zhTXd80gW5HZ+/+hSNPMaobJvFQmZca0CSAsLAzS1GZGjVNqRSTi3E4ne3To/t4zw5hfzx5lDsqMRAZFeRlSa4FSV6K/d7AbN/3K7955gszgxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762780991; c=relaxed/simple;
	bh=PFsNSzDrwEbAzPAV4v0VXvi50A+d5COqKDrJn0ed6/4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M99d/isAKMsox3dWYIHfvWds+hIvheoVqlO12gNLOCuN31BiVhPwQCnaGmpKdPSSucvxqKh30r+a2f4pjKn7ntUoUh8iKmgHwXXegZxpiHQaVHZe6fr7aS0YzC5XE6LvG+9oOAKBCkWqunY/DIFThsYsnze6uk9E+sWEb6TLbYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/qBOdKH; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/qBOdKH"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-89018e9f902so1467817241.0
        for <git@vger.kernel.org>; Mon, 10 Nov 2025 05:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762780989; x=1763385789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CpGOvSNQu0vLN4tJCTvEpNN9u2cS+DMwVe5Bky7/MNg=;
        b=D/qBOdKHOh2ifjEA0RwDkYhzGEB/NPlIm3B4vdg1ydCsmxwBpdYDjgppOp78QJZpBO
         N1qsS28vW0SefXXVP/Wwi5/9V0IKgMyVG0V620iiFOKYQsg4oSX9m75NUDSXHy/1P3L3
         iyNdG3oaIScpGCQHAZrrPgFgck4hj98vokNpouYUPoQ22r0N8yrbOqS4exqc/D+mJ1bB
         j95j/H8KMTZTvRB0NWepA6Y73c17jiBz1FaPBuE8Y1EcUeZFjQVORoDqhn87GeHG5p5O
         /HBWBnoUrlKyD8UH8W8FU35vUhNjRo+JKTiiL1FEMwdrrLv9Q3xTf2IuLknyvGMLF2/J
         daCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762780989; x=1763385789;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CpGOvSNQu0vLN4tJCTvEpNN9u2cS+DMwVe5Bky7/MNg=;
        b=fnMVzy+6Wq6nBDj5FqX83G6iIsYsOn/0OrGoLyrmzNzMinOKDUx76wKmTwVI7sMLzV
         ZZlJAfX4VkdITWpSAty0/jZX+2qdcej3lqwILwW63WiLFT22f+UA0eO2kKtls8iCVc44
         PaASi+p0xh3vEKb2xBTLHKFGWDYTP9WmswwTW0GT4v4050K++t4vkcfrxLEMHo3eGlhH
         /cC+HUAkrdtv76v6qFCkW66u8C+jJVHSKDKobXwnX4e4GsBOT0DjwKR1w/nYB/EBoqbf
         D3jZZFpDiXVb9nbJCRmfjvvyq5xPVMonDaKUu8mdXs3qCAx+zqViJwnJCLTsQr0RGPur
         +qPw==
X-Gm-Message-State: AOJu0Yx60kasTP0osvzbtTe+7dxSsPIYtY6NqObn9vhR011zo9p0MT8K
	C32iNckXnmw2CIBYS4ZqEq02smPZgGzYuyRj3WcYE/aFhjgSUj63/BxHt0ww7ZE+wU8OdtQZikj
	H75ejD/yS9twVaTlOFuWrxv4ZoFE8O+I=
X-Gm-Gg: ASbGncucmKQA0tI3ilskmv9Bzr4FYHPpbPhMh5g3stXpCbdykvIW3h8yKXcqUSr+ZV1
	oQlmsB0iBBo1QB/s8L3RRJei3vCwHyaZonGDC43T3pE1mHFYeb5sde2Z0K98eTZev9PgV8+3Yab
	lXrRWkat7/HqkIXD0K2nZ0+gos4uhWXqCky0Uz13Xm7bXx5Kchqr4jJzLrPIgVAr7W+clw+9R6r
	Q/NR2HMsOmcTWkcmG9ZWOweK0FfTxgcBxG3blz0vKLPd/rPJvURSPWq94gc28QxVBGJmg==
X-Google-Smtp-Source: AGHT+IEJcQhGFhPH+kDAOhkk1JoK/YwyjhXrRd1p0iUSAsumWMM4ryIBhbpRpi6YjGQ3Vs449ck7kkZYicZGRkM3s8Y=
X-Received: by 2002:a05:6102:b11:b0:5db:28ef:3dfb with SMTP id
 ada2fe7eead31-5ddc478c3dcmr2892373137.34.1762780988841; Mon, 10 Nov 2025
 05:23:08 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Nov 2025 08:23:07 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Nov 2025 08:23:07 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aRGVd7L2DV4DNM-h@pks.im>
References: <20251108-fix-tags-not-fetching-v3-0-a12ab6c4daef@gmail.com>
 <20251108-fix-tags-not-fetching-v3-2-a12ab6c4daef@gmail.com> <aRGVd7L2DV4DNM-h@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Nov 2025 08:23:07 -0500
X-Gm-Features: AWmQ_bmW0jWKyY42GOX52I-RaZ4Tr-dEanRqF24CiqiaUNwuWXpFC8KHBYRW-Ww
Message-ID: <CAOLa=ZS4wJnsCffg6EcECFEzqBo_xV+dyNi5L=4iaLqcMwPphA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] fetch: fix non-conflicting tags not being committed
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, jltobler@gmail.com, sunshine@sunshineco.com, 
	gitster@pobox.com, David Bohman <debohman@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000a867e206433d6eb8"

--000000000000a867e206433d6eb8
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Sat, Nov 08, 2025 at 10:34:44PM +0100, Karthik Nayak wrote:
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index 49e195199e..337ca2b0af 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -1963,6 +1963,14 @@ static int do_fetch(struct transport *transport,
>>  	}
>>
>>  cleanup:
>> +	/*
>> +	 * When using batched updates, we want to commit the non-rejected
>> +	 * updates and also handle the rejections.
>> +	 */
>> +	if (retcode > 0 && !atomic_fetch && transaction)
>> +		commit_ref_transaction(&transaction, false,
>> +				       transport->remote->name, &err);
>
> I think this needs some explanation why this condition is safe. There's
> quite a bunch of function calls and conditions that assign to it:
>
>   - `truncate_fetch_head()` only ever assigns negative. This will be
>     ignored as expected.
>
>   - `open_fetch_head()` behaves likewise.
>

Also the transaction isn't even defined until this stage.

>   - `prune_refs()` returns negative, but we then turn the return code
>     into `1`. So we'd end up calling `commit_ref_transaction()` in this
>     case, but we didn't in the previous iteration of this patch series.
>     Was this intentional?

Its basically the same, before batched updates, we would return the
return code of `refs_delete_refs()` from within `prune_refs()`.

The fn `refs_delete_refs()` creates a transaction within to delete all
refs, this is done because we delete refs without old OID and hence they
wouldn't ever fail.

So now, when we pass our transaction to `prune_refs()`, it is also safe
to commit it.

One scenario I didn't think of earlier was that we would now enable
partial pruning with this change. But I would argue that this is
desirable since that is how we deal with other ref updates during fetch.

>
>   - `fetch_and_consume_refs()` is one of the intended cases, and it sets
>     up a positive retcode indeed.
>
>   - `backfill_tags()` behaves likewise, and was intended.
>
> So this looks good to me, with the only questionable one being
> `prune_refs()`.
>
> Patrick

Either ways, I would think that we should elaborate a little here.

Thanks,
Karthik

--000000000000a867e206433d6eb8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f61fc8722a42524d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1rUjV6b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL0VuQy80NS9rTzVxN1RQTEFGeFBsb0hGcFJidEZCSQpxOU5yTDcxcVU0
M3FqcUFmWS8rYlJlNHBrTyt4a1I2dy9jVWV4S2FTZnNRNHl2aVBsNlhmbGkrU3hhdVhZUmNNCmNx
eFBsNmxLWS82MktxVis2U25IdUpuTlNuOWxQcEpId2t2RlZsV01JYmhzaDlmMjg0cHgzeG1vcGI5
UHJGVlYKWkk5VXRlVy9qWldSYTBPNnEzVVl4eUt0OGFlR0c5VlhmdXRjNWtoT2lzMllDemQyVTZu
ZU51WmxGUXNWS1MyZAo5ditSYkFzcEVKcENVTXdFQi9kbmtnelBVQVlDWmlxSTBXZE5TWlN1MnF0
R2dOMnhxRndwZWRQSUZxUmszNWMvCkUzM3N6bXp6Q3VLWE4ycWMya1FtK3FRTVAweDYzeHI4a3lC
aFExSm5UWnl4Vk9FUUpTcEZYYWNCL0hYdCtkeXQKQ1lsL3BBTGdzV2dGQk1JV3dVdkFBUTVwMVk5
KzE1aEZQK0NkWmlLUjNKaithMk52WnF1Q2pJQlBBUE91bEhxbApUNHozeWx5S2Jpc3pGZEsrNjQ5
RzFwV3ExMFdMR3NZUllEQWt2Mjhoc3NGS2Jmak40N3VQV2RsUURPWVp4ZFJ4ClhzYzY3Y1JEOFJr
Z3FZK1NSQU1RS2xtRERqam5aU050bENuY3Jodz0KPVg0NVcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a867e206433d6eb8--
