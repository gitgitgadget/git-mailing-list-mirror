Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E4B2080CD
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251979; cv=none; b=c78jKHbOIXn/M612WyzBeCfZKn3NfTxxBmetX/s/aLHvBy4nYB9ARfqTXCNjM+Yk/tcjC1f6nc34lmVJ54/dijZHXq9RNHYS9qxfynuszWidG5r9nx5/vsi5fLfaFszIxC+DNcfZwTHq9aWZYbrYMjnklnXbKNZnEKvD0o21L/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251979; c=relaxed/simple;
	bh=l2W1o1AbSDvyk48O4WyEQB17Zh4Euf8tYVfNr2wOGBc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4sU1qycaub7CkPbflL2FZW6IH5JSVQBNS+63jfytgkg8aKTiARLowvT/uCRQCUaDiY5AXUwZdiImHla5dl9CWvbIdkEGnXwwnzLxVpnIOuIraaZEKqj4/QlVdV+imNGZJfuL4jt/HDrdGjt7yWZDAMIwAOPvYW9Y7rFURF1vec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtXKvUMr; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtXKvUMr"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-86ba07fe7a4so345345241.2
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 01:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741251975; x=1741856775; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ttZRlNzHewwpgNAqnpf42gxkF9mGz4QNX5ocsE/qneU=;
        b=dtXKvUMrZQ9nh/hbImrcAQ/FHqgRcHj8qXYYeneO7bNdX4OCmTHHbrx0dCNWrYlSY4
         3oB1N3rnCEkVmVS2rHj7lF6XGfwO+8gqXhzVpRpkjIJbwpuTmeAVc5Ce0RZqc6kZTDG5
         nGL4Vwxnj2rupbeulc0FUNfLmRJej18G1yQC4I3ECKEDNmeptI/8Wv/RoMRdTNaHpnPy
         9fIv6K75nLwtD2RLaJA/rUcF0Tm8NiLKSmyC7iToDq4SWhhDsoRtDr/DZl99/6rfhZm/
         d39QgZzPS/7v/wWcg0RquWM4hehLNiK6fZtA7J06SBuVPE1bEv/LTg2a+H+Rxu8UO4/E
         ZWww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741251975; x=1741856775;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ttZRlNzHewwpgNAqnpf42gxkF9mGz4QNX5ocsE/qneU=;
        b=OjeFyvVTaOidC/luFtauSzCrXxtfz3aCoqWp/Su3I9XTxEovgiv+uANiu6oPGHgDK2
         pt/g0jJpQeyDFAmuZmYNwL1K9tw0osovl1uWu2rsYIVZbLQWEJNVmwniPkqUEIXojE4R
         xtUGE6zhjTrVjvT4HHk0AtswuP6rSt+VhWdYGsT7g4Xb09IVJm53bUFvMMoNZP8c7gmd
         e+xMI62fkIMe1dqMyg0dFhJYPpXD8CRcwTF8n+a/6ZAl6DNdKvyHh2oW6NcIVaQg1UgM
         5e0c2+Mh51L/0z7wM37B6Ug/UK9Qs83JbWwzFruMhHLO74FccskHbwc64XQoaUgWVGls
         mGlA==
X-Gm-Message-State: AOJu0Yyv2rH4MhPg+nDBozqiGq/anwd/MsdBzLkdIZgkxMG/WtGF+hST
	BaPf3S9zawLEY6n0FnEZETqDYTKoSOPHkEi9jM/Yq1Ub/RoHXo204u8B8l1EbCHXtiRW4IzsfgU
	Wh4yBIkMCGOnNJl4Th57cT79olsE=
X-Gm-Gg: ASbGnctO+yNbp9NWz8RbV5C/RjJP4ofcI3Hc7RVa993XMv8YwsMurDjRpuVxxV3go5N
	2jeRBZESJaenFTSVm9jx3CO8CCiQzcgXoJHbOKmeldWVXvQXtW+HZ0ozMfFN7j6IKHvezcRHy5+
	fqkrNxJcl+ohbcNkUrnxulBLY/zHA=
X-Google-Smtp-Source: AGHT+IF/ngr+dRRMt6drsM2mAycI/zk0ataUYQNsbG5hVC5pgZThNr1N9mZ/B4MJvkQIBm9Cr22kzx31FS0KYP/sPKQ=
X-Received: by 2002:a05:6102:e0e:b0:4c0:3349:cc4 with SMTP id
 ada2fe7eead31-4c2e273e7f6mr4179624137.3.1741251975450; Thu, 06 Mar 2025
 01:06:15 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 6 Mar 2025 01:06:14 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqo6yfl1js.fsf@gitster.g>
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
 <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com> <xmqqo6yfl1js.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 6 Mar 2025 01:06:14 -0800
X-Gm-Features: AQ5f1JrEy6p0JZ5XjZdmFQdKk8ZNeUaY-4XGOu-p1JO-5rpcz4JjXcUhysUdBFc
Message-ID: <CAOLa=ZRT-VLtionwgSk2VON9Zps8KRL+XcO0ORF-ivzWZNOxUg@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] refs: introduce support for partial reference transactions
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, jltobler@gmail.com, 
	phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="000000000000763dd3062fa8d16e"

--000000000000763dd3062fa8d16e
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Git's reference updates are traditionally all or nothing - when
>> updating multiple references in a transaction, either all updates
>> succeed or none do.
>
> I am quite confused.  In the beginning (traditionally), there was no
> transaction to speak of.  You try to update two refs at the same
> time, we did best effort but that was never atomic.  Later we
> introduced transactions to optionally make the changes all-or-none.
>
> So, if you want "I have these N updates, but I do not care if some
> of them have to fail---just make your best effort to update as many
> of them as you can", why are you still doing a transaction?
>
> Perhaps it is merely the phrasing that makes this proposal
> confusing.  If presented as "non-transactional batched updates",
> perhaps it may have been more palatable.  I dunno, but "partial
> transaction" does not quite sound like a transaction, at least to
> me.

That's fair. There was also some discussion earlier around this [1]. It
is in indeed batched updates which can allow failures, but it is built
on top of the transaction infrastructure in the refs subsystem.

Perhaps the best way would be to use the transaction interface under the
hood, but present this feature as 'batched updates' to users, so there
is no confusion between the two.

[1]: 4beb0359-763d-425d-b416-ac40bda59e2e@gmail.com

--000000000000763dd3062fa8d16e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 31237316965cf8be_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mSlpZUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMmJBREFDUFVLK01mcSt4QkpWb3lJTGVGT1RsQzZKZwpMeUJwZnh2WDVa
cjkwYTNSblRWZzJEM3BwTVNNTUtCbFkzM05uWkttejA2a0tHMU1XVUN0eXVoMllKWVdxaVE1ClRF
YXJYMy9lRmZ1UkQ5YktZTUF2MFdlY1d5WEYrRG5ta29rdEFwZ2ZHaEU2R3BaZ3pieU1PTStoNm1F
SUlQZzEKbEUrYjBkZzRiaUpjWFVrQVNGTGx6SFpyMnA4WDZzTEhIdnY0cjF0TmFFM2ZnMXJEaUtP
ZnJ0dU95MG1FZmVKagphNXBRcDB1UGUzM0kwMFJBZlY4T05DQllGSXF2SXlqUXJyZDlwRy9vUERv
YjllNDlMbGRlamtESm9zSUR3Vi9JCm5rZXEzVk80MXJHSkROdjFPaEpiL3owM0dFSWZsaVhqamdo
bUh1UHJlY1BZN3RucjE0YmxNaTZvV01WYzV6dHAKRkNDbzJoNGdEOUpXbTY2NHdPcjdoSVc2emMz
Rzk4U2RSZi9JUWZaZXRxZGczZlZWZUtSQ3dKV0tpQk1PQTVQdwp4dTlsbEUxelRJODlDd0I5dlV6
MlJNYzloUmV3dmsxM21aZDdML2g2UGpCeXpmQmY2WnE0UXBrd0JZWlFiSGRTCkVxS0pCUW1hVWsx
UDcrS0hHUksxSnZJZG1Jc0dVUDZBMGVaN0xnOD0KPWlVMmIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000763dd3062fa8d16e--
