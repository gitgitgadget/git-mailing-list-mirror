Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD801CDFD5
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 13:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756389083; cv=none; b=MbCdg5jHTh1+qpznoFeTEXiGO/CzITYsqiBIhdd+UlUXdZ5FCZ19DxL91FiwT6opkib08GHJmzYx6xXUOk7NYySmgMMRCKxnMw0tUkI/ZgtAv2tvJYQFCb/JUfM/ZSLoMiED53DcvTnT4xy0XUDe/uvCjiLQHI1pUo2VL+Coraw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756389083; c=relaxed/simple;
	bh=TMKFQiIv9+dUd7LdPzcP/D1OyPYMh+cTesRYCSYCxoI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YToYtSyhYqCpneJ2ew9lSWBqhcLMZq07ozd+ppr/OGmJWk1Xzt/npMS8in3+gK15TbjER7rj8jYLVeLPiazr8UrbImm9ahs7Or337KRVx3oJjmqQHz/3vqJmBESRzGg5N1YXNdnNU0sZp91s65jJJvSsuUZ9rVjV/3rwq9eluz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbDcrTGx; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbDcrTGx"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-53b174de200so688775e0c.2
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 06:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756389080; x=1756993880; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=B2gLNBzjG50UgSq0pKnY67GKghQgvkc5FrUJll8Tzig=;
        b=QbDcrTGxm7T12toARDw5U34xGviE/SjrP/kDm+bfKj2pE8i33GKFPLoYMLaBQsatH/
         NBJjWz+23lnuNx9i0hOpZqPMSVzP0LUehfP6Gp3F+MnCQdogHPRco7oV7WQocSBhSlDm
         P3Awt7ez/p33XSSAfXXK7Wgx6XEmVFsmIQyBzmsBlI13sOkBehUOYqyHt0jC1jfUNkG3
         7QNqoVFFEdxtqNlyeB3uEIa95kyOpnOKcdin7vmIYNT8aVYzQC8WN/y/COaubxnUsIGR
         nfMDBz78z7iam7OkpbBO2CQOqsUl5HZ5KpBMHn/8yJHWyYZr9MT9Fwj20aGBZeMTcnWQ
         Vyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756389080; x=1756993880;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B2gLNBzjG50UgSq0pKnY67GKghQgvkc5FrUJll8Tzig=;
        b=thYsI8SsBXW8lO59zXA31QUrL4RmWCahs7CY3YrnNzETYUifWUDRCx/yDRkcyXEOtY
         jsa6gqw/lAXycmDfhwfs3lFwJUysXr6qIYbpCIC+9+idkJzVe6HpD1JgKZkmi0IcpM02
         RvOpAI4HzWglpsezfP2VqdyaFWw8fNQcRKN7SnzwrA1DP3dTzJIx7UMZfMvDuLKocXsF
         agGMaLBcdy1lxWseG5kAnCeoHkwkDE5CZtg2LZ8lIwd7IqqKxURZ0DN9//GR9QCFXP8w
         Nd7nDrk9jaDWAVgvBoBFGj3Rr4oIPzD2xNNwBu2cJABPLv14ARVfrkrXlEkl9g6LdRjL
         iISA==
X-Forwarded-Encrypted: i=1; AJvYcCVpIkoGRxShbXMt2E4c4pMgyYZFA9ixkG6l0nKUMU4D/Urg20GLPRni4FdTidldG+d30g8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdDHTkq67hUQ7ethxbFGTyjw+FjUpD510omLonGhlkoxWy0Mmx
	hHt+8ETocCLCXqekZTg3adlSkO+lAevkNMG41INufnIaEjV8rNilcTjUwsEWhfr9DrhYJ2hCzJx
	o3yXONW9rj/j90vWKxd6wFyxVfZDfCaw=
X-Gm-Gg: ASbGnct87gut1cpuLWUK5HZCYT/AINsab/YNz2P82TEpjRk8DDaczaXD4XRimRrfT7Z
	tzueFaPT5FsdBiDjHj+TpGTp3eMTWDpPYxecjOtz6v+3rD65xndJdWzdR90F9rcIqG8R1gwmjxb
	158iZ2SwoatWaMBKxnAdRM92V+NSdqQ0l50N3WdnejJKsr4DTRKlhyy+JPbpAV3s27FNNy/pZcL
	PmiX0QE8UhX/5K1O8w=
X-Google-Smtp-Source: AGHT+IEkb+ALEdHD6drMTM01AddBIhBRXbs5EbRYsaaV0jfIaKJ18WlNpihBvPPCqStSaZrBkNQC9slwfscXMw8Z8iA=
X-Received: by 2002:a05:6122:3105:b0:529:2644:8c with SMTP id
 71dfb90a1353d-53c8a2fc1fcmr7737968e0c.8.1756389080186; Thu, 28 Aug 2025
 06:51:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 Aug 2025 06:51:18 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 Aug 2025 06:51:18 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq8qjbxn8n.fsf@gitster.g>
References: <YQXPR01MB3046197EF39296549EE6DD669A33A@YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM>
 <20250820213323.GA1667633@coredump.intra.peff.net> <aKbHozlmDIqfgkg4@pks.im>
 <20250821072706.GA2390046@coredump.intra.peff.net> <aKbwabLZiWasYoBC@pks.im>
 <xmqqwm6w3bjp.fsf@gitster.g> <aKgKmLvaHAuueJeb@pks.im> <CAOLa=ZS43w74tWjD47h2mnGiyaQWrGEY-UpL8kdXJi_zD0ASmw@mail.gmail.com>
 <xmqq8qjbxn8n.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 28 Aug 2025 06:51:18 -0700
X-Gm-Features: Ac12FXyUmi0pmEREVVHrEIbOeiDrPjthxjmCDKeVQuxyFoeiK-v4WkE9pyiMI8I
Message-ID: <CAOLa=ZRizMKRsP2wo-RJUksXAv1Hgx3XDGCO_ZGOwKpf6kAbQQ@mail.gmail.com>
Subject: Re: "lock file exists" when fetching in bare clone of repository
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>, Joe Drew <joe.drew@indexexchange.com>, 
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000366521063d6d33da"

--000000000000366521063d6d33da
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> The fix itself isn't too involved:
>>
>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>> index 088b52c740..5c31b02e6b 100644
>> --- a/refs/files-backend.c
>> +++ b/refs/files-backend.c
>> @@ -776,6 +776,8 @@ static enum ref_transaction_error
>> lock_raw_ref(struct files_ref_store *refs,
>>             goto retry;
>>         } else {
>>             unable_to_lock_message(ref_file.buf, myerr, err);
>> +			if (myerr == EEXIST)
>> +				ret = REF_TRANSACTION_ERROR_NAME_CONFLICT;
>>             goto error_return;
>>         }
>>     }
>

Let me preface my response by saying that in my quick to respond bug
fix, I think the actual assigned error should be
'REF_TRANSACTION_ERROR_CREATE_EXISTS'.

> We assume that the existing lock is what _we_ created to lock the
> ref in the other case, not somebody else locked-and-died some time
> ago, or somebody else locked-and-about-to-update-competing-with-us?
>

We don't really change the path of exit, but rather just categorize the
error. So by marking it as 'REF_TRANSACTION_ERROR_CREATE_EXISTS', we
don't really say what kind of error it is.

In batched updates, the transaction allows failures unless a GENERIC
error is observed, wherein the transaction would fail. By marking the
error as 'REF_TRANSACTION_ERROR_CREATE_EXISTS', we allow batched updates
to allow this failure and carry on. Which I think it makes sense for all
the scenarios:

  - existing lock created by us due to being on a case insensitive FS
  - somebody else locked-and-died some time ago
  - somebody else locked-and-about-to-update-competing-with-us

> Without this change we'd return REF_TRANSACTION_ERROR_GENERIC; does
> the caller treat NAME_CONFLICT any specially?  Or is the "fix" you
> talk about just about giving a different message and no other
> behaviour changes involved?  I guess a more specific message that is
> 99% of the time more correct is an improvement over an overly
> generic "some error happened" message.  But I thought the original
> issue was that the user cannot make any progress when the ref
> updates are transactional.  Does returning NAME_CONFLICT from here
> tell the machinery that we are allowed to break transactional
> semantics somehow?
>

Yes, without this, we'd return REF_TRANSACTION_ERROR_GENERIC. With this
change, we'd return REF_TRANSACTION_ERROR_CREATE_EXISTS.

This error type is bubbled up to `files_transaction_prepare()` which
tries to lock each reference update by calling `lock_ref_for_update()`.
So if the locking fails, we check if the rejection type can be ignored,
which is done by calling `ref_transaction_maybe_set_rejected()`.

Only during batched updates would errors be ignore and only for
non-generic errors. So this change would specifically only apply for
batched updates. Currently that is used by:

    1. git fetch
    2. git receive-pack
    3. git update-ref --batch-updates

And for all three scenarios I think it makes sense to add this in.

> In any case, I wonder if refs_verify_refnames_available() should
> notice that we are using files backend on a case challenged
> filesystem, and change the behaviour a bit.  This additional check
> needs to be implemented as a backend call via refs->be->something()
> to tighten the outcome.  It appears to me that the function in the
> current form does not even notice a D/F conflict when there is a
> branch 'd' and the transaction requests to create a new branch 'D/f'
> on a case challenged system if files backend is in use, since the
> function is in the generic layer and behaves case sensitively (which
> is the right thing to do---we are talking about detecting backend
> specific glitches here).
>
> Thanks.
>

Absolutely, this whole thing with the files backend and case-insensitive
file-systems is a mess. Yes we'd need to go around and fix that too.

--000000000000366521063d6d33da
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 973c794b26ead0fd_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1pd1h0VVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMEVOQy85cVBBWnIranp2WlBtTEtoVHpoVGNvUDV3Ugo0VUNlQ29XRHBP
SnlNeHBWeTZiQ3UvSjZVTVA2M2VORDNQR3RUTEFXNEdYVkgxZDQ5ZTFXdnhsaHpyT2QwQTVLCndl
djFhSWtlR21VTHJQNVQ5VzFjNXhtTmRCTHJJdy9NS1VTT3YxRE5LZjhvMHU3UzNxNDhoRHF2WXZO
V2VQd3EKSlNsZ2tRQjZSRlB5VHVhUDZLKzE2NnEwYWl5OEN4dFJyQkFQR2w0N01XdWFQRG5mQnh1
N25rOEpueU00WlRxQgo3VEY1RDVuNklGcjZRSzdyMFdHZjBpVUNXZUZaOWxhbW9VVWF5UmJoaEFK
blF5VURRMkRZSmdNMVFpOWNKbkxQCjVDOWFMY0ZpcC94TXdXaHRFSkN5N0xOVXo3eHhSeWhnQk9r
RHRudy8rc0NWL3gyQnVVWUxiWUpJOS9Id0pIbWoKeEFLdkpTNUF5ODhPNzhESElYVDdqZ1pOY0I3
UGwyQVBRRzY5Y0N0a2FKU1YzUFVwdlpOaTVwSDN3VVhlV3pOeApzR0lWdjZEaWl4Yit3VTI1ZzFm
bWI1YldEMCt4Unl3RHNzZ1p0c3NVNnBrQWJ3UzBZY3BST0J4a3I5SmpDazRxCjhkelpFQVFYdFk0
NmM3VnpWbVJSOE9uZ3BRa2Fvelk0bk55T1FEMD0KPSs4K04KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000366521063d6d33da--
