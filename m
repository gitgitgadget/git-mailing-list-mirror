Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA8F1547C5
	for <git@vger.kernel.org>; Tue,  4 Feb 2025 10:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738663682; cv=none; b=Li0DhLJFawOqG1ppBz1dc/9rF1AhX1vmGJBvdue5whEwpzJXJDjHa4C1i1XdsraVYo+0WOkwMSyOX9bzJLyjqBtuYdJUTNDzJf9QyaGbq3MZUQ+o+putjlbWQBmeRdmftap241Q3nsPCTINo05f6G2+/viFnovgvgCNdnisWJyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738663682; c=relaxed/simple;
	bh=msDmXBcwTMCAo5acLfsDQHsV1KWMcsHKylA1ti42F5s=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=tNa6/7VWFP7cejETDRB5aIlNgYMrRYpGfS+kO0GMlkFxBXCPjxyrY4k8lGKspXkkLp5F8fXbHeUussrTitqWAgPcx58Bj+nc0Qif7CY7Dhvz6NX2xs4HzYWfK2Z7MCUBhU18QT6LGkDLwIHbCIcSF9M8sam334s92eMbXmSPaek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8LIx4nN; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8LIx4nN"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-85b9f2de38eso1006229241.2
        for <git@vger.kernel.org>; Tue, 04 Feb 2025 02:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738663679; x=1739268479; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=doJojJwfNYi8ZCw0t6qtrJF3G2rrrgXic907+WRWqJE=;
        b=R8LIx4nNARa2g8oq593zoi6iCiyEbJP58z4pMqQDcYrvUndzFcCBufLU8uBtBBhemZ
         6JppVgmyP2YzNA+mUE2XS43K76MII8mFtnD+LrOrEHoVbAF4Xn7RSzO6tQJ04E9RnBxJ
         4SG8s0X2jL5wGbLpu2TXxETkQchRMpR70ImIxV6UAETiFLCs8S3uxNVz0oO2nvbbzfXd
         1xz0+KHGIbVLyVCWBg5gYJPHIH7Pl9NbGyBWF43N/3T1vgNjXbTN2WrkPAwF027QBsHp
         YZ2LuiF2ZmA8pJlaxyN03sv7LAZavOg5W2zLI/ald8e26bqLENPpa2v3WxnurItZ5Es8
         yabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738663679; x=1739268479;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=doJojJwfNYi8ZCw0t6qtrJF3G2rrrgXic907+WRWqJE=;
        b=pFFbCKTUSKRuSsFTQyWixOet6gerdomFcf+FyldWWR9yPEKGm2vP6wVa/dIiGK++Fj
         93sJX05MEJZ5X39xgdgPLOXh919ySfNfz2zxOAwZPQosQ7uebh8OwgeTPDRoUXeFJVg3
         fIp4W+XhSEKg7+lRKLyJoc4bBCWu87FdYzjbxQgjsVtMLhBuY6LF2u7MuK+gQ1n3IFQ7
         Jx4jyi4TnNMXQMNDjmxWIRcfgKBG7qf3GFk9QZp7v/xg8RBXGWbp3HVFRM5NFKz/Hk55
         Zh+IHEKG3mkIYOyGwA2NIGb0/6/yrhcXAMoyiIjDRQYXpHXY006iCQU187+wZlJriIrD
         F8ug==
X-Forwarded-Encrypted: i=1; AJvYcCVCdIgC/DJoKauA40zmn/w23fBfd9SHq9Z7XGiVvKwfXqqkAkeqyMP5sa6lqRFi8SUZsog=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP6V4wRrVMaFUQeG+MQxzjkt+f8G1UVKFdL8tfIicYRscSaEiz
	S62VqGUic1G3am8otCEJz4Z6uSQljph0Q5Rf8yXCmwAliI4913sQpxvr0xu8DzMURCYHC9a+KW4
	d57PGEmLX3waD4nzsoETb2Ps59m2HZp19
X-Gm-Gg: ASbGncsVt37OukyPYFQbcCKULB2tcq/4XGdBxrO4le2sVc8YBYg47GVsa33Cx3lgbXM
	+XO0TmyANS6isq0VI4Ru5A1rGghLguu2M54LtmDx55SMhmTcNIT4d157EMbeIAPYKla3b7+ZPnB
	hpW/pnBlserpwxnB5tGXCiXz0sdKX0/P4=
X-Google-Smtp-Source: AGHT+IEbVoyF6M5Qakmz8I/yUg7/qzW9xNKE6nG3iqPBTD85RnPGl9DjYYeU3BZkbS6AzL9vggtSys6Dk9f9F2AAZ8o=
X-Received: by 2002:a05:6102:8013:b0:4b2:cc94:187e with SMTP id
 ada2fe7eead31-4b9a52371bamr18093504137.18.1738663679419; Tue, 04 Feb 2025
 02:07:59 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 4 Feb 2025 02:07:58 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq5xlu4bt6.fsf@gitster.g>
References: <xmqq5xlu4bt6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 4 Feb 2025 02:07:58 -0800
X-Gm-Features: AWEUYZkHVSlIeG_4DKH8D7bEJJYRuBCLeXZKBOFqi1tkTOdd5KxT-64P9s7g7zM
Message-ID: <CAOLa=ZSoiEeJqP8GDdyStOjNaw6itAHjJH=t28jp1tssjAun5Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2025, #09; Fri, 31)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ff0445062d4e2ed6"

--000000000000ff0445062d4e2ed6
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

[snip]

> * kn/reflog-migration-fix (2025-01-15) 1 commit
>   (merged to 'next' on 2025-01-16 at ae8f9ce9a0)
>  + reftable: write correct max_update_index to header
>  (this branch is used by kn/reflog-migration-fix-fix and kn/reflog-migration-fix-followup.)
>
>  "git refs migrate" for migrating reflog data was broken.
>
>  On hold.
>  cf. <Z4mUizLNUdq_1BgY@tapette.crustytoothpaste.net>
>  cf. <CAOLa=ZT4nws0irdZKUuWc70Rv9RUNQuSXnGAt1SnE1O+umSReg@mail.gmail.com>
>  source: <CAOLa=ZTL9n_DPhNr49XAd6bT838kc09oVx_AH7Pb4o8VK_xQ9w@mail.gmail.com>
>

There was some discussion around Coverity [1] on this series. But the
conclusion was that this (all instances of not checking the return code
of `check()` in our unit tests) would be fixed when the unit tests are
migrated to the clar framework.

Apart from that, there was a Nit suggested by Patrick [2]. Which also is
a broader cleanup and can be done as a part of a later patch as
#leftoverbits.

So all in all, this can be moved from 'on hold'.

As for a brief about the topic, perhaps:

    Additional safeguards to prevent 'update_index' changes post record
    additions in the reftable backend and small cleanups alongside.

[1]: https://lore.kernel.org/git/20250201022409.GA4082344@coredump.intra.peff.net/
[2]: https://lore.kernel.org/git/Z5DgxQuc2j_-5GHg@pks.im/

--000000000000ff0445062d4e2ed6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d2baf7db42bb18d1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1laDV2d1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNHMxQy85Q0NVUTZ0YkwxVVNxbTQ5MXhXMWk2VnpzWQpNYmdna2ZWa0JR
MDNiaTdwUHVHSHYzVUZIMlZSQ2UvbWtxMkw0TmI0Rys1Q3duWGwzREV3Q2owVVJycXgvK05HCm9M
cDd3aVhVa214NjVxU0FGRHRGdmV1b0hyOE4wSS9VbFozbWVqOEFMalFGN1ZQdGlrbmxnODZNRDRW
UkRYWEwKSmhDNmtHWmYyUTI2THFSWEZqTllyYTNJbzFTanRRZDhtQ0Zia2E4bWVPMjZNdUNMWmtW
T2puQ0VVcEwyZFRCdApCekZkRUdIWCsxQU9sMnZNbmRDT21aVmdWWHBEdlN2a1RSalNLWTlldXBM
RS8rM1d2eTdleG5RT29jT0d3RWtqCnB1eGtqNFp1dkVtaXRCMnZ1NFBzTFFCcmIwQ1NiOWRIclVI
enF3SU1WSnBBVW4xNVdCYnJUSXQ1aG5NTkxRMHYKejZrTENJWnVWcHYwaDZjekFZNHNxUC9reSty
ZFNIOXkvajlHZG43bjVIOUNPL29aemFyNzFIVDhrUHFYNXlobwpKL2N3SUVMYTFTOUFpQWpwdHor
enVvbUxzTFN3WmhMV0tGbUNoSEV0NjRnRXBZRkhVWWYrbXZsWEk1VFJDbXQyCmpNcnVYUnJpRkpa
MVQvbmlUbHZ6N2ZqaEtLYWdoYjA5NzlCNXhZcz0KPS8zMjIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ff0445062d4e2ed6--
