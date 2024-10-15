Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87201741EF
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 07:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979061; cv=none; b=ggF7q3HnhqnkRHn7Bebfarzn4jVYW7NGrxe1iWdYs7DT6Ne3EE5W+TSOkL4yiMEoEQvHfRsw62do4WYbYKK8RIheJpxs7OdUK3AFMNWrAkhpHtSSpIfw5SbzsfMwDzPIyB4QWfwJG4ChUIt/GmFClbjaUWsN26xWM/p5kYHZaZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979061; c=relaxed/simple;
	bh=lok9rM69LVIMgc4GONTVwfODhutzQYixmoBGSQcY8X4=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKc0EmmChIlVWMsFP1Pm1cajeNQ6YPTztvYB3N3qJtc5eHDXY0ntbExhq0oSCa9Hr9X8ZugrbtmJT7w6ecexIArKke31lK5Xz/m2wjyDh/Wo/l4IC7MzYyQds//zrvKZDge8PvpDrYPEJG9eilEItsDq5TNCd9yCMFZ4gDkXCuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTSGzYyH; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTSGzYyH"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e2eba31d3aso2711906a91.2
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 00:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728979059; x=1729583859; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=E/hrLNLbUpUUN/tq+H5Xw0ZmoXRYWVPZNEm6qVg7UGI=;
        b=FTSGzYyHVVqy+rXkbHKW/kBr5uOFW7sFPmkraNfWbZb1Cc9SGbZEXndXnKtmWrwU/t
         feWkx7pIbyw9Kn8S9ogcboXpKKjvWWEBBJlHIxQKA35feeiKUwYilqJbCZg7Jb/WcTKt
         FbZHc/GvXOgF96D97ya9fmKRIUOyF4/CTTRyL6QcergOrCiWqAGxigfvcgGDAMSS/XBv
         5fLrIDxt/fzK2fgfp9U5f+qgwP7qpGg/Fj0hXGVb+lPAIVYJqQ+GOVz3dho3uvwz+ikd
         9QtKV30MqIXxJ1Yyu9I0UrWXjmzU/kHZ2qszxi2xRVKQR6A55SFRmpoTR3akHRvgQ36T
         2pCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728979059; x=1729583859;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E/hrLNLbUpUUN/tq+H5Xw0ZmoXRYWVPZNEm6qVg7UGI=;
        b=NvCWzkDWfrTUD+onHs0PQ5toSYvW710DjXkCFCKlMK1DdcoNV0sH7o8vVsmnt3/e8E
         ayIjvp9wubI6NEIXaiXZFSQ5gTHg0v+1EIMPBoZIx9WIhUukm5XoQsRE2AeMHXhQuJUD
         NIV9QFTSXdYem2AQ3FbI2jmfLiS5OUVD78FnCqn8Y02AaeI4ghdxSkZPXQx18oOqHXVg
         UygSkKO6ocEk8FQDqZOMyDcBpEiaoQeywFG0sL9VY43HH7wdEyvHtgiBCoxjivhokF2O
         AEr4/bzm+J95fCixTvIkEUxagpETmpAG9ElChhBZTHBdRfGO8THuYoO+v4Y7P33NQod9
         n2Cw==
X-Gm-Message-State: AOJu0YxoECnZdha71jP93bz/FEDPBDbvxl2PDyMmMzdmZ23ciqOSO0VJ
	uB30WUHDszJt/NlfqdJtXaN/TUl7Kry40mEREbzrlztTbzVgS0Qy/T+vKsB0rFjKtc52al7OxDh
	numDwpzfWiE3iFkeeyQfXUNlO5cSu74Oe
X-Google-Smtp-Source: AGHT+IEEh4GO2MQ3nZ2DAGGK/kH2LmY8uXMJ8VWgaPqpFWbBs9ZrQauSAQyr+a7W5jlvXrEQCE1T8zynz4OAjlK3KCM=
X-Received: by 2002:a17:90a:ce11:b0:2e2:c15f:1ffd with SMTP id
 98e67ed59e1d1-2e2f0a4938cmr16120102a91.14.1728979059088; Tue, 15 Oct 2024
 00:57:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Oct 2024 03:57:37 -0400
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <CAO_smVhS8zw_Hk1OrsTg==4spziQOiQtOt+Hg8x-rEQVR+66rw@mail.gmail.com>
References: <cover.1728697428.git.karthik.188@gmail.com> <1586d5376915a4662c92b8c0881596952c4500bb.1728697428.git.karthik.188@gmail.com>
 <CAO_smVhS8zw_Hk1OrsTg==4spziQOiQtOt+Hg8x-rEQVR+66rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Oct 2024 03:57:37 -0400
Message-ID: <CAOLa=ZR5eR_WEiBhPGMc9pKX20HsamLy6hkfBrF2Kj8FnGRuGA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] clang-format: align consecutive macro definitions
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com, toon@iotcl.com, 
	johannes.schindelin@gmx.de
Content-Type: multipart/mixed; boundary="000000000000a43d3906247f4e93"

--000000000000a43d3906247f4e93
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kyle Lippincott <spectral@google.com> writes:

> On Fri, Oct 11, 2024 at 6:50=E2=80=AFPM Karthik Nayak <karthik.188@gmail.=
com> wrote:
>>
>> We generally align consecutive macro definitions for better readability:
>>
>>   #define OUTPUT_ANNOTATE_COMPAT      (1U<<0)
>>   #define OUTPUT_LONG_OBJECT_NAME     (1U<<1)
>>   #define OUTPUT_RAW_TIMESTAMP        (1U<<2)
>>   #define OUTPUT_PORCELAIN            (1U<<3)
>
> I like this change, thanks. Is there a way of apply clang-format for
> *only* one rule/aspect? i.e. can we apply *only* this, and preserve
> every other line? At first glance, I don't see a way of doing it. If
> there was, I might recommend a whole series just to applying these
> changes, but with how out of compliance much of the codebase is today,
> that's not going to be feasible; we'd need to format it in a way that
> we might not want (the current style), and then fix it, and that seems
> counterproductive.
>

I think we can apply a single rule by specifying the rule over the CLI.

Overall I think its best to take things iteratively. Also because
'clang-format' is a bit rough around the edges and we might discover
some other changes needed.

--000000000000a43d3906247f4e93
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c046803245997c1c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jT0lHNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMzdNREFDQmN4bjFZQnlvV0pacWNTQlRPNEdxVDBwUwpxRG9RUjk4TzFR
U3Y0UzJKbGtCOVpvM3pIN01GODVvNVl3S2JXQyt2Z25IODgwaFV6OXg1dXJpV1IxZWxQcy92ClBv
UVU3aUlvT2lDaGQxM1RJTDRxeVJtVVZGZm5ITVliWWt6S2pzeDRKN2tiVzR0VncyTC9DRlJ0S2FU
Qk92Y3gKTmx6QWFDV1Q4cXljc0xZU211YkNESFk0aFlUNUdjcllRMVBVZ04ycXJxR2pwb2p6WmxL
Y1RRenp0Y3lxUFRSZgpOc09CZEZhMlhaME0zQU1rMnByOCsxRldiUnVPMmczV1YzY3YrVE5ienJN
b1NKTytxSVJ6bW40UlpLK2JZUTNxCndzTFRLY3lQaFZiaTBsTUJUY29GL2tkRjg5b2lROGtjbGpp
aXdzVFBlV3JrVnk2TlV0MnlISnRTUTNCc1pTdVkKaXVBYkQzME5ITXJiRjZmOEVGdlV3MSsvRWUy
c0ZxSmRiZXk3RFhrSEhnNkFUWGdxUVpnZHZqU2tudW1YWGp1NQo1eitHTCsvcktlMy84aWd0NnFQ
VHNZbG1tRjB2eGpWVFk4eDhjbllmL1B5eFZLbG5NR013ZGdZNkZpamlheXBwCjltd3U2ZVlTK2tz
aXhYZTFIcXdlY3l6KzU0MDhDRUFrbVJzbEVpbz0KPTBxSDMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a43d3906247f4e93--
