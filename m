Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B034F265CC0
	for <git@vger.kernel.org>; Fri, 22 Aug 2025 08:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755849715; cv=none; b=eS0ENVnNOt5dKiSoIo+JgjWbAyASkWZ3hswAez93uZdUay+h8q0yz8CyDLJm0q0v5a7dKD0ZR06nnZCF6ucN8plIGbEuv6Z8m9zVOnKTnBeZ/WdauOy1/htN8k/xbirJPmk+VjAHQG9OzUhH9ndUgOfExcfFp2OdUGEGieK/Fno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755849715; c=relaxed/simple;
	bh=cVFFl4J1OlcB1TrS4egZle6HR4LjtTVI98hZkoAxN4Q=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYijjZ/9r2/gc/G/9AP6Q0CLk1kTVno3g/OVi4+qlBiULD9u1xflzBBpDcpxTaXZsNfpVW5BcKHza4dTI6hECnjT4u8hjciJ+Hv6bexwbqW7i52+25U3ChIoGL9R8S2evZ2wv8YKoUrTvizEcZXDmQuj0aevovp/GFIs+LhDaOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLvWe9tP; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLvWe9tP"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-50f8bd5ea75so560942137.3
        for <git@vger.kernel.org>; Fri, 22 Aug 2025 01:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755849712; x=1756454512; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aPPMs0tWLAEDuG9jp4+3SuVMM4hqnugihijk//o6uEc=;
        b=XLvWe9tPgGhYDoumbKJ4mch9pdXDx18cCJsMCObgiPozlcLX37RDsNv3CQlGQO7EnK
         nkwAnEa6mFj8QOE3Op8WqtfSZyAijoMFsukKKIiXUI6id7zVEfCkH3t9NG8prB0qVJai
         xkQAQd0NZC7AXTrXH5Dt5yPUGtqk+oEOGVRNywN9KKihTos79LPwWKoWWBNcj0F9Mj0t
         ygmyPLoVyqvtDbKuhVr9zi9cai+tcRwML9USsRHIR+/onUObPII/rKua/RCBBXPmu2R1
         GJJS5RpwqUF5oQmbijcD2AKfgtrAcZA5NPV7o70v7KX5rfhFIcFaA0A3+JK0MOlRoOn3
         flWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755849712; x=1756454512;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aPPMs0tWLAEDuG9jp4+3SuVMM4hqnugihijk//o6uEc=;
        b=j8+d9O0UII6ZsEVX2zmqRgIeqE0rFLn5g7UBBrIbIY7rMnuEfkin00N3hJfwyeKoyb
         Jgt4+8qwTi28DEB98SFmMwNV9239K8ypo0oeLSnm19xQtvqHLdCLT1l5aaK87/omupOC
         TEcGm754Cr953QUkxyTIURIhqYt9t5CZWAXyZnKoD8PvNixS98u0oL8xQTG4MhKZ2XaP
         ZBeHHgL/wwk+LnhAABap1IIXnFuPXO75X/syjRb0hZ/gus/KMpL2li1+C/w+m0kEqdsT
         fewINHfwFrewhXCeVce6VitYdbc2va4Km/MkjFkzVZBvzUInuc+xWp7+E0Gi0qp0qlML
         TQGg==
X-Forwarded-Encrypted: i=1; AJvYcCXO5npt030Ywb1GAIJ6jI/AJXmQX3q/cs7wsXcwzBTcTZFPqh16bpxwhTdn9wj/cQnYAb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCxwFs+88pbpdOXI0lyesNs8I3T54V5mJAEYlypuB+b9tmrBCe
	+W+RPY+b38ad+MrmlOZPbxCx9ycyaRymt7XweM3Ari4+B2SqgvMRQXnuCwtD+BGFoRkZSHvP8mf
	x4dntI/WW+YQLFCHKnNQetMr25nO9tSTvF5wd
X-Gm-Gg: ASbGnctUVnmDiFQvYEnc1AHdYnW1D1Ryi/MtatmYNp1BsMrLlSVNRSyXLfuW13HKJxQ
	VbUzWB8HRH0yFHaHqveL0tuJpWWl0VZdmgqLbviQFcCK+qdjfTKZIC2FSzoRJ0XX4hq+S3vdvdI
	KrgDIU81eVtVJaTlQ6GR8f4TOgc3J9dPg2+V4BbmuNRw+Ho6xrThLTwMrE/W2tG0GdDGVrnr9K1
	aFu5IIf/R8QCHD7TGB1rTUq4hRCQKnJadXOdqOUDviWiFqSjzrc
X-Google-Smtp-Source: AGHT+IGgmigt9+SJciwRJnWGKB3+rCCUvUeVhurHAKdnQWe/l/9iAy8GpBHoTEjbMXxiraDIG7bfthWNWH4nXsoKmvU=
X-Received: by 2002:a05:6102:5802:b0:4e7:bf03:cd79 with SMTP id
 ada2fe7eead31-51d0cbecf04mr474711137.5.1755849712355; Fri, 22 Aug 2025
 01:01:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 Aug 2025 01:01:51 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 Aug 2025 01:01:51 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aKgKmLvaHAuueJeb@pks.im>
References: <YQXPR01MB3046197EF39296549EE6DD669A33A@YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM>
 <20250820213323.GA1667633@coredump.intra.peff.net> <aKbHozlmDIqfgkg4@pks.im>
 <20250821072706.GA2390046@coredump.intra.peff.net> <aKbwabLZiWasYoBC@pks.im>
 <xmqqwm6w3bjp.fsf@gitster.g> <aKgKmLvaHAuueJeb@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 22 Aug 2025 01:01:51 -0700
X-Gm-Features: Ac12FXxKpw3w3YDJqpRMBWsOTrrLzbYqXXlC65U4r36mUom7l2Ej80IlsFCJKvU
Message-ID: <CAOLa=ZS43w74tWjD47h2mnGiyaQWrGEY-UpL8kdXJi_zD0ASmw@mail.gmail.com>
Subject: Re: "lock file exists" when fetching in bare clone of repository
To: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Joe Drew <joe.drew@indexexchange.com>, 
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000629aad063cef9e30"

--000000000000629aad063cef9e30
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Aug 21, 2025 at 09:05:30AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> >     You're on a case-insensitive filesystem, and the remote you are
>> >     trying to fetch from has references that only differ in casing. It
>> >     is impossible to store such references with the "files" backend. You
>>
>> "backend." -> "backend on your system."
>>
>> >     can either accept this as-is, in which case you won't be able to
>> >     store all remote references on disk. Or you can alternatively
>>
>> I do not see the former as a viable choice, though.  When this
>> happens, the clone or fetch fails and the user cannot catch up to
>> the upstream development, no?  You have to futz with the fetch
>> refspec to cause refs your filesystem cannot store ignored in order
>> to make progress on other refs, but that is making the user do more
>> than accepting this as-is.
>
> Oh, yes, right now it's too involved. What I'm proposing is to mark the
> transaction as allowed-to-fail, and in that case we'd be able to fetch
> and store refs in this case again. The result would still be broken, but
> it would be broken in a similar way as before. There's one difference
> though: we'd accept the _first_ conflicting ref now, whereas before we
> accepted the _last_ conflicting ref.

I replied to one of the earlier emails, but ended up only sending it to
Peff by mistake. Re-sending parts of it now.

The fix itself isn't too involved:

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 088b52c740..5c31b02e6b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -776,6 +776,8 @@ static enum ref_transaction_error
lock_raw_ref(struct files_ref_store *refs,
            goto retry;
        } else {
            unable_to_lock_message(ref_file.buf, myerr, err);
+			if (myerr == EEXIST)
+				ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
            goto error_return;
        }
    }


and this would fix the issue, when tested on a case-insensitive filesystem:

  $ ~/code/git/build/bin-wrappers/git fetch -f origin
'refs/heads/*:refs/heads/*'
  remote: Enumerating objects: 15, done.
  remote: Counting objects: 100% (15/15), done.
  remote: Compressing objects: 100% (9/9), done.
  remote: Total 15 (delta 3), reused 0 (delta 0), pack-reused 0 (from 0)
  Unpacking objects: 100% (15/15), 3.54 KiB | 3.54 MiB/s, done.
  From https://gitlab.com/knayakgl/case-insensitive-refs
   * [new branch]      SampLe     -> SampLe
   * [new branch]      Sample     -> Sample
   * [new branch]      main       -> main
   * [new branch]      sample     -> sample
   * [new branch]      SampLe     -> origin/SampLe
   * [new branch]      Sample     -> origin/Sample
   * [new branch]      main       -> origin/main
   * [new branch]      sample     -> origin/sample
  error: some local refs could not be updated; try running
   'git remote prune origin' to remove any old, conflicting branches
  error: fetching ref refs/heads/sample failed: refname conflict
  error: fetching ref refs/remotes/origin/Sample failed: refname conflict
  error: fetching ref refs/remotes/origin/sample failed: refname conflict

  $ git for-each-ref
  24abc5ed19b517692bb4245eb4185dd5a86d7376 commit	refs/heads/SampLe
  24abc5ed19b517692bb4245eb4185dd5a86d7376 commit	refs/heads/main
  24abc5ed19b517692bb4245eb4185dd5a86d7376 commit	refs/remotes/origin/SampLe
  24abc5ed19b517692bb4245eb4185dd5a86d7376 commit	refs/remotes/origin/main

But like you noted, we end up saving the first reference rather than the
last. Either isn't ideal, so while there is a change in behavior, this
is better than the complete failure of the command.

> In any case, I very much feel like we should know to warn about this
> case and guide readers towards a proper solution.
>
> Patrick

--000000000000629aad063cef9e30
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: edc30f0c23408986_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pb0krNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN05mQy8wZUpubWdUVGRxZnZ1eWNTeDVlQzl2TW0rTwpZeTlXRjQ4bGl4
c2R4UVZoK0NzYUtpcWYxUk5mWVdabW1JcVlZbUFubCtvVTlqcDJjemsxSHRVN0l1V1RVRjVrCmlK
bGZVeDBhVkp0M0Z6TVNqZVMxZjhBS2RDbEFtblp6M1U1RkdkcktXeXk3Y2wvekwzSnFjWG5mQXdL
ak9TR28KVTB3T3dSdGx5R2FqNjhCcVYxdlJCQ3V3eW1FUW5kdXRBR0E1aCtJOVB5M1BoSXErUkpM
aFFhLzVjNHhyQXZqOQpkejlHTDRycjB4U2pPOXNMYitFa3RqMmE1V29aeTdwQW9CdHI5azFFNm9T
SEhGVE5uTjVSaFN4VFBvOGtrZEtPCk5pS2laOFQ5elpUSG0zZ0J3a0Z4aTBjNXFuekthdjFEUFpU
ckRFM3lSRW8vTm05Vkt2RFJENXpxOXVldHFIam0KQkxIVDR3Ly9XODZjakNKNlNFVVljWllEQTJp
OGk3WVhFR1Vqd1prMFFCcmxHeVlwb056eVEvcXB6MjNwOVh4WgpDbkFxUFU5RmlFRlFmT3FPdUtT
VW96TWNuWWhNYllhb3AwWWo1VW42WVFLWm9jVUJQQlhFbVFrZ3FJMXFHRy80CnJIcjFpQjNFS0c0
NEY1MFk2MFdkL2RxbW5wUVlYWFpsaXZpeWc0dz0KPW5iRHQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000629aad063cef9e30--
