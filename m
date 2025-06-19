Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC972253A5
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750334006; cv=none; b=CnD/Ij0uXu9WpV8y2oTwEHn1vGTU2Orfmh+GByYj4MgJvFjmj1TtLLgaesDj9uBVgokatVxmcECLXkcNUWQvHUJxIwN727RKt8v0BHPEU4AebvZcn/orX49oAs+KlUxG1bBhKhd3fMhRrYraWv27bKcT0a1+wR7qi06ObgyjlLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750334006; c=relaxed/simple;
	bh=RiE6BI9k8++XCC32SlVoCcasIXkzf+2KUnktKygM2Bk=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDwKdY1tvAmbyF/p94NoZMiJPfmb5PY8fVgpmYu5cuwpMiVRHaXDdhQ9hDb4LRKfCGFi2YGJ47TaW9XdSLrdp7fBr4+QKEo/2z3JPtz3YMG9tfWg3fkFRn4fPuJkVVUx+zXH4vQ08zlG6iHQGtCx0JQDDN+Ls4PNHwIBG1T1CuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5MyIVsh; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5MyIVsh"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5240764f7c1so195916e0c.2
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 04:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750334004; x=1750938804; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RiE6BI9k8++XCC32SlVoCcasIXkzf+2KUnktKygM2Bk=;
        b=O5MyIVshimuPtjH40e8NaRC8Q5zu+cwhwUuoNqlIqaD+0fpiIM39DMw/RdsC2dWxg/
         QF0yaeHN/HdfdR6LyAel8mUKDK7YvSmSwbnZWOPpF1x20XqEYrnIK55HKWrTEfNzCoWE
         YaEvsAQOuKqIeTtUoTLZlHLUEGGn2JhGARXPDGTJWqjMLq32ii9Mt044Yxd2JeoFkLK0
         JaXRPkmHb20etBTbEdJ0e0D9wM595NRixADDxkV13AX9vmhoOgNkC719SF8C4ITaBp4K
         3SjYz3gT3TZSSAVTguANd1Gea2xV9xkpcijTlceZFZ9SFqF5DIJ9norE1PQuNJ3R0ocX
         Wguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750334004; x=1750938804;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RiE6BI9k8++XCC32SlVoCcasIXkzf+2KUnktKygM2Bk=;
        b=ihlCc6D0NrIc3x2lUPgK80oeSzBvcyewbpV3gISkvZw9/c4OCDxbz4Vz4hUp0h88pR
         m+3I4VvO81/Pcpm0JIDqaX5Pc3mKpCb7AU9N1uak6VFe6+kpTszC9Qc1LoKdnMri2VRN
         ELfZKnNzHOqa034rQcD8S8ugiwGUcmsfz0GpLLmP5IyaqMb7IpiI0fZdF5azShuiENPJ
         8ibQukQcnPJkig3e/VQXyDebnZqd4QpgaPv2JiEehlr4n/qtDGU7pz0+CL/VR4mxWwuH
         Coi+rVX3kuXxqcw8pk3YXYv6Z2xYF54949YR5qfesfYq+Rvd9A4pSY/Djc9lVUh8skRt
         TOGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUogdSLChz6GNchsH3/J0cRUdIsKv+DpBizj6mhIaC0H/VAt+9Mbfls/OMV/bY16gLzstU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGcpxYoolXz6jxTkEXNCmYFlhMRqNNMxhiPbeD/j2lCVXBij2m
	9sAZnkpTpR1wqSCrIBbIBbADe35apv8Pvijw9jV450rObRRLOUd0lx2fDtLzBzGL42Rte7na4yN
	XEphqDzFI/3h7O/i877q7Mij9/avYMdo=
X-Gm-Gg: ASbGnct+1b3B8jtBEfkiFGU7Csu5OGrzcNaAbQS1glpGXvydnC05msKA9k6mh7t8krg
	8bYF3G7E8omqWN1jF/Cm/01e4NxfgEq12hurY7l2YVaMxnUD/jCqLFr/nmkaggDtSwgMCKJmcor
	y5uWUNkhFQrDQpVxvaHthreuMGEazPm8z2P9eRKGYt
X-Google-Smtp-Source: AGHT+IFjaE88k57IwdKVizAhQ3wn9LLCxKBifbSGvJm4qYmBdAhiqVaF1w5GFAL/tSqKq9PDvPhhcUi0so/jkFEREwM=
X-Received: by 2002:a05:6122:288f:b0:52f:2a3:4bd6 with SMTP id
 71dfb90a1353d-5314956ff81mr14474039e0c.3.1750334003632; Thu, 19 Jun 2025
 04:53:23 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Jun 2025 06:53:22 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250611134506.2975856-2-christian.couder@gmail.com>
References: <20250519141259.3061550-1-christian.couder@gmail.com>
 <20250611134506.2975856-1-christian.couder@gmail.com> <20250611134506.2975856-2-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 19 Jun 2025 06:53:22 -0500
X-Gm-Features: Ac12FXy34djEyA3SkRKUalS5mNs6aLk0GrHrh5PI4EGNUt9IpqYUxC-oQzep6cY
Message-ID: <CAOLa=ZQm+Hm_rMNJY7B4dGAuV=nFecsiPZ9N8uChhEwzb8n+Hw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] promisor-remote: refactor to get rid of 'struct strvec'
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Justin Tobler <jltobler@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="0000000000008686c60637eb646a"

--0000000000008686c60637eb646a
Content-Type: text/plain; charset="UTF-8"

Christian Couder <christian.couder@gmail.com> writes:

> In a following commit, we will use the new 'promisor-remote' protocol
> capability introduced by d460267613 (Add 'promisor-remote' capability
> to protocol v2, 2025-02-18) to pass and process more information
> about promisor remotes than just their name and url.
>
> For that purpose, we will need to store information about other
> fields, especially information that might or might not be available
> for different promisor remotes. Unfortunately using 'struct strvec',
> as we currently do, to store information about the promisor remotes
> with one 'struct strvec' for each field like "name" or "url" does not
> scale easily in that case.
>

Nit: It would be nice to mention _why_ it doesn't scale easily here.

> Let's refactor this and introduce a new 'struct promisor_info'.
>
> It will only store promisor remote information in its members. For now
> it has only a 'name' member for the promisor remote name and an 'url'
> member for its URL. We will use use a 'struct string_list' to store
> the instances of 'struct promisor_info'. For each 'item' in the
> string_list, 'item->string' will point to the promisor remote name and
> 'item->util' will point to the corresponding 'struct promisor_info'
> instance.
>
> Explicit members are used within 'struct promisor_info' for type
> safety and clarity regarding the specific information being handled,
> rather than a generic key-value store. We want to specify and document
> each field and its content, so adding new members to the struct as
> more fields are supported is fine.
>

The rest of the patch looks good to me.

[snip]

--0000000000008686c60637eb646a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: dc49e8efc0ead8db_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oVCtqRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meFo1Qy9zRjIxY2J1S09BMUZrakVoUlV4SkVsZDIrVwo1VThQNGpVR1FM
T1RTVisrUllMSFV2SGY1NENrNWtCR2hFckdoRUdCMFFYWGY4QU5JbUlQd25pM2pSVk5Hb3phCjlP
Zk1LY1oxbWZtQ1kzLzd3cmc3RTJ2bEEzMVN0d2g2dzZWSHZTR3AwMHVTeWlkY3pGN2NCM1l2Qlg3
aElHSVoKYkhXZytpTGR0dFcwTW1pVHBVZnFyMlhzS2hMSXI4WklNbFVQbzdoWTFFa2d3aFJ2T3Jm
U0lnaHVJQXpFUnlPMgp3OEF0bElqZm1UK0dhVXJrTVd4cjZvSTJoVTBLTkhidUREUG9yUVFneFNX
OGsrY3NXNkM2RGlpazZUdFAxaDNXClRKcmJMYTJzcGQ0OVNzNWdDcHZTWFhyUmswemRwNnZUcUp3
UzRuSHBnOEkreU1PQ2kxU2V3Q2ZCb2w4THYwbDgKWHF2d21weWNYaE1ZZXlEcTFkZ2pwWHlMREhn
VlZua3pMaEhLYk9PaGhEdHdoL0MzZUVCN1hvM2ZHbGFWb3VHTQo2K2VVcDE2NVBCbFl3Qi9mZW40
RDZuRkVad1h2b242N1o4VzFCMXVWVExyYU4yQ1VsczJMRGZmVlFyaEd5UFRFCmRnWjU4WFdjU3Bv
elYwSWl2SGNjWURPR2s2a0VkMTRpZnBvc0Vxbz0KPVEyUHAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000008686c60637eb646a--
