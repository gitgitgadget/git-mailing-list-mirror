Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FC11A269
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587067; cv=none; b=kUaBUdpye6+G1zMiBOd3nNsXlX9WTMnHIuq/zd7dUAXe0LaTpw5miUX3wSpVJu8wdSQ0WyHWb1Q35gBX4Is5vTDSVKk2dHDvonNHRZ4w6SFzYdzLsCCINbLzXhd/MSgYSjhsPI42XL7Ve1biETztFCPvw3JE76HaqHCzlwLhzZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587067; c=relaxed/simple;
	bh=FCPNt+YLeOsM0O88Yi0zpC2CcGb9U0ytdI1BpMmfGRI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcDQ24cEtOKBGtUUBl/GUZcj2yInWrwhNqKoXSorQgcix9yucyvJ4A6NCBcMIx/c9dPbRKSGVpbe6zjJF3pnRRePivOe+SYuuWBXHVn6i10aLKBEVVPaPW7Kq08lV1bBK8v7G7GrvqNxpw/UyMUAdfMaOMjT22y+087n6xfGpNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVJ5OqUp; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVJ5OqUp"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4a5ad828a0fso1455607137.2
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 01:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729587065; x=1730191865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=3h5mhWhfyF7FdxB74EzNnKCwRKESJvM1v+amGuE3yK8=;
        b=PVJ5OqUpTzPNVeId2ZbS6tVgf/TkKIz0SOY1r9hPw6JChA1QD3ug7I9C2ZeTrQnzn6
         wcc5HYwQXHoxE0cvmIBBNx67aswOi9WQJxhLLMb/miNvFQSZjMzr8xeuTzoNvEqraOB8
         Qc/cDEsZRubhs7b2RIPXpaKUsf/KBnqVWzU8IyiVK7OqwIDXz8gLbD6asOr2pisuDnMw
         Oedrt1Lxo2dJcq003FfVGeaApvaEIGbtAxA2pJTZkpXR6tZ0/OfxyPEtxKcxsktstRWp
         3vG58pAzqSx94lxzcPHF3tQGonHWVF0TiypYY8WhoK+8pqilv5zxipqoflMtYN+GHnlz
         yTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729587065; x=1730191865;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3h5mhWhfyF7FdxB74EzNnKCwRKESJvM1v+amGuE3yK8=;
        b=BRmkaQxeft4EE3jvt2hZa4qwTOdazHra/cAx+wEj62/LI1B/hwZlxWm3jGq6DaG18b
         sckYPSk5BLeAwYfNrR3iS5j29Qh3keovXQMSKfdvHXzgXtQ0a7283gEvyxVeDZLzheJq
         Mpzi6LtgOVikaq8IiSXKpw/w1Hz6pkwX+jQYPTTty1wmgrrT33QyvTriwNwz0ZiK/um3
         2VM9/I4SgW/nwDSQjpt6RqxNSG3zNTVH37srASUNdcqVFBRDBTo68hojBehx3AsRrMzs
         6DZyTW8AbcaN3uAeGXHvl4lTMsJ0zqIE6o99K/yRwy1fWXHI6gK+4ohmQUnPVdcCjpLt
         CMoA==
X-Gm-Message-State: AOJu0Yyj0t2q0Z9dY0rdjhe6Yy7gBiLy9iEDGyHHHUEU8YUwSHCORjgS
	CKQAwMON8ZP+t34lS2ZXkB8f1jT0lKKQRpW4cpy8lBRRz2zDgKCVVVOwiubeZsuayAcDgzkGjph
	qxJRK3Hl7WCl37aoh0ennqQjBe/ET/UwY
X-Google-Smtp-Source: AGHT+IG212LazcnEGuLBIbVcG5D/xBk6PmsmH+oAVq14lbDDmzsCGc9b9r4a/CPEukvwnDT3IuSXhTvsnht8llnr828=
X-Received: by 2002:a05:6102:e0d:b0:493:bcbd:4633 with SMTP id
 ada2fe7eead31-4a5d6a8c469mr13039794137.3.1729587065094; Tue, 22 Oct 2024
 01:51:05 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Oct 2024 04:51:04 -0400
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <ZxbCWvFo8ZdwPgJd@nand.local>
References: <cover.1729504640.git.karthik.188@gmail.com> <c8cc21c2eeb9d1e0bc261143e642eff38fe33888.1729504641.git.karthik.188@gmail.com>
 <ZxbCWvFo8ZdwPgJd@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 22 Oct 2024 04:51:04 -0400
Message-ID: <CAOLa=ZQPH_rd65-zW6dRJAiAA747htXR---icS5aV9zupH2aGw@mail.gmail.com>
Subject: Re: [PATCH 01/20] packfile: pass down repository to `odb_pack_name`
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000009faf9206250cdec8"

--0000000000009faf9206250cdec8
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Oct 21, 2024 at 11:57:44AM +0200, Karthik Nayak wrote:
>> diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
>> index 5809613002..60f806e672 100644
>> --- a/builtin/pack-redundant.c
>> +++ b/builtin/pack-redundant.c
>> @@ -688,7 +688,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
>>  	pl = red = pack_list_difference(local_packs, min);
>>  	while (pl) {
>>  		printf("%s\n%s\n",
>> -		       sha1_pack_index_name(pl->pack->hash),
>> +		       sha1_pack_index_name(the_repository, pl->pack->hash),
>>  		       pl->pack->pack_name);
>>  		pl = pl->next;
>>  	}
>
> I am a little surprised to see sha1_pack_index_name() converted
> similarly here, as this patch promises only to touch the
> 'odb_pack_name()' function.
>
>> diff --git a/packfile.h b/packfile.h
>> index 0f78658229..507ac602b5 100644
>> --- a/packfile.h
>> +++ b/packfile.h
>
> Indeed, it looks like odb_pack_name(), sha1_pack_name(),
> sha1_pack_index_name(), parse_pack_index(), and has_pack_index() are all
> modified. Were these meant to go in separate patches?
>

Nope this is intentional, each commit tries to pick a base function and
modifies all layers above it (I should have explicitly specified my
approach in the cover).

In this commit, we try to modify `odb_pack_name()` and therefore
sha1_pack_name(), sha1_pack_index_name(), parse_pack_index(), and
has_pack_index() too. Otherwise, we'd have a lot lot more commits.

This simplies the review too, but yes, will add more instructions to the
next version.

> Thanks,
> Taylor

Karthik

--0000000000009faf9206250cdec8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b89a64ae39234d76_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jWFozWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNXFGQy80enlkTlQyT1d0RUNsSWpzdnlxeExUNVl5SQpCcVY2aW41bmxW
enVSVzc3N1FDTXlNZGpJTERkV1NRRjVSVmdjOHpxQjI3cnFvSzJOVEtxZGJacWJRMUpUb3RVCjRL
cG5pVytNUTlhL3VRVVpKbDJ4QkFVQy9valF1OVh5RHN1TG45SjhkWjF2eHQ4R25KalZTa2ZwcHJn
aU1WWDAKU2hOOG9wSW1PdGhQcVd3bFVUUE9YNEFrYUNZb1pGM0g2NjYvQlNBVkZ6VUVWNmpxcE1O
VHNnd3BDOFpGTldmego5S2c3b1ZNNStKTnlDNFl5V0FocUZZd1FkalJOUEpTR0dLU2pNeWQ2WnNa
S1Vrb0VDWExjOHZYd0NSanNieTVRCnNQUTByd0NRdmJwcm1TbXZyQUV2MXNIbXk3ZTNoSW9xQWFS
VkExeHF5dytWWWlyVDdQd3RTaVAwMDVkNkk5M3MKZGVHNklnSkw2aU9XSXVtWFp2YnNudVM1MGd6
UUFqTmZLRTRObkF6aGRPQldNR2NETlZLSkcxZU1BZXNHaDBKRwo3UXN3T3RhNEJOSVljc3FIS2pv
THpPdU4zYjc1YXluQ0hJUW5oMFVpYUIxaDNQaEhUSWFxR0JKREQrSWh1czg5CkhubW5BU1BVdUth
dERGMko3TC9RNFY5V0pPSktYVFN3U2xZQkwxcz0KPW1aMFcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009faf9206250cdec8--
