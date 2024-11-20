Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC21E158D6A
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 10:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732099151; cv=none; b=ssrxNW1emv6jN5pTb2KqZ3KBGM5RrpiiGBktWFeMMfWJBGWlQj9QLXmGtThatHk2+DQeyx2OUI7rW6F07gpEjEfWbl+YCbYKppbkhqAEdyjt5cQEpOW/hDpoUMNx+k88cCMLQPrX19RBgiwMH7lpfxK6u8aotWDaI90lQCLPNTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732099151; c=relaxed/simple;
	bh=wsGZzHKZSCGuXw0qIm4hEIiPqr4t6KzPFi+9xvX/xm8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=nvicnKNwzNeucCgirtV8lKrg9PQ9s00ra+YLD+mL8ZZ/mwxRNN5ZRvJMtR4e28jpFAuKbrRV4lGLxKr9obr2FXnXFIg2OCp0t+J0WcLnTD3AgOHcJUakEmTA76XP7997kH2ZkV79L5pgWJHTTXb+LbIeOcZOitkis0ZLvLgM6n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eB5ZUe7U; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eB5ZUe7U"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-514543a08d0so1777003e0c.0
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 02:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732099148; x=1732703948; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d9WHZC/HnnvFJGwh8mLsGvFJVfXa6x/baTnxHXCZZIQ=;
        b=eB5ZUe7UGKL52U3xYbCteAXoQ3EUzOu+5rLXiYZpJPnWHhaXLxOpJxLhJQTf5lnpGz
         1ncNiZr7AECruVSeVYwHbbXP9zoP0XmIoWuLiVDiST8a9AuCB4H14901We+5biUwpfFd
         3wXpBgxGU+V/fScjuTZiPIVKeXMYDZ38vBAq2ISWVpbxwmKknBaBwK5N6C61Rgj+L+/q
         9gLu3pKuLTSBrmeZ8UO+EIgBa+MrpOq+4br2mY6DUhJbLfOGyoy2IJ/AG5ce+tJ25xmF
         1uyUsucB9TlWCl0d+SPwZB+KyMQ/zU8jlGIh9OHRvCig+A6QBM3UmKIyqGby9OC+32qM
         UgfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732099148; x=1732703948;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d9WHZC/HnnvFJGwh8mLsGvFJVfXa6x/baTnxHXCZZIQ=;
        b=AiEjr1VM/EArMO2EzxYULLMgHhsHa0FCV+X+UoDAitYU3ELWYRJW+KsEHfGG28sFtM
         4MT5eEgM58mjg9Q3wZQOARaoKuaS10ObjitnkE4hsgVOpklKWW2Ds/+ln0JIK5TLd/yH
         CSmdu8mRCq2pWQGPN1zm6kFxthY0+cYyfHTKzcgncsv5q2pPpwbnjdenaWp3tPBclKVe
         bYP/Et3/lnO+EY6eC7W8NoYqXHfdemhXZL/nSHraMJ3WdzNafA9ffFmwcgkUoLHjDkAj
         WI0tF6Jv+w0gFbEIQPHsvQ0ccH9w1IVg2S0W9ywsposS4tgwRW4FrrXPIg3MNehvBKbd
         Sy6A==
X-Forwarded-Encrypted: i=1; AJvYcCXt+xPzEFsMPrktM+Ld3VnCeflNONTnaFHnCEmvovlg4LBqA+m6SHsvafmjc/nNHlV+Cv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgJlpVu5LeM7wfX4G20wAtkqb3ylo4kPggS0e6pz/tAG21m375
	1c/MnB7wJTJR5wEIXj7FLP9RxGApihmRtIzqxe/zr9USZeA2rX4hd1CYyDFJq9f/P4qpN4eNr78
	2pDQjMWMmX2WGA5NWHdGtipmCWxxXSTbe
X-Google-Smtp-Source: AGHT+IE92aQ55av/+PDOg2/L9usdZ9rseihI3T0cjVeA4L7acOCaulk4nYx7ZIiWa68rCdE5z60WCXswuWze0xAqRig=
X-Received: by 2002:a05:6122:893:b0:50a:c70b:9453 with SMTP id
 71dfb90a1353d-514cfba2ce3mr2535956e0c.10.1732099148473; Wed, 20 Nov 2024
 02:39:08 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Nov 2024 05:39:06 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqo72ai929.fsf@gitster.g>
References: <xmqqo72ai929.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 20 Nov 2024 05:39:06 -0500
Message-ID: <CAOLa=ZQ8uGRq0c-XWV=GxqyyqqHp0V_w1ZMJFduh6SF4pn-EzQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2024, #07; Wed, 20)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000760532062755c2a3"

--000000000000760532062755c2a3
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> * kn/the-repository (2024-11-12) 9 commits
>  - midx: add repository to `multi_pack_index` struct
>  - config: make `packed_git_(limit|window_size)` non-global variables
>  - config: make `delta_base_cache_limit` a non-global variable
>  - packfile: pass down repository to `for_each_packed_object`
>  - packfile: pass down repository to `has_object[_kept]_pack`
>  - packfile: pass down repository to `odb_pack_name`
>  - packfile: pass `repository` to static function in the file
>  - packfile: use `repository` from `packed_git` directly
>  - packfile: add repository to struct `packed_git`
>
>  Various implicit uses of 'the_repoository' in the packfile code
>  have been eliminated.
>  source: <cover.1731323350.git.karthik.188@gmail.com>

Anything I can do here? I think Toon and Jeff already reviewed the
previous version. Happy to reroll if needed!

Thanks

--000000000000760532062755c2a3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4a78c8a2940d653b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jOXZFY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md3VzQy93S21iZnVsSWRIOGtZbU1oNUhIMnFXZGlibApEQzRDZG81dEhP
cjJlVU1uSDdBaWtiaHhtMHJtYnk5VTl0VS93WXI1RzZUT0lXNFI5ZklnT3dTZDdDUHl3bldNCmRE
UFZxY0tZWk84WTZlekJSMEtGRnNEdDhLT3kxTVhTb3dhdEhUMXZGY3Q1L05sdVNNcGhMb1NDejBL
VXU2dFcKZ2o1ZUUybjZwWWFmekhDVzNsNTRWc0J2OHBjTTdBMTY2RzQrOWlLbVRSYjROa1NRMWE2
QzNpd0ErMU9NZm9yMQovc1I0TmVyM25WWnh0VndObWorSnVXRktwdGxUaXptKzZib2R6cTFzclJi
cnhYUXgrRHdVQnBsSGJZSm9HdC9xCk1tNmRyejUreEF5ckVha0V3SEFNM2NodmN0ZFJneU5rM1cv
MC9pZXRnMU9KdlRHOTNrMVBPZ3JBVjVTa210NWEKVFRDY1RTK2xYTkdEL3MzZnloZVVUcUNUdGEv
RFQrUHZNcG1SeXlXT05tT2R0L2ZWUTdiRDU0TjdjOEM2N2RIYgp4VkJKYlhXS3FlL2NuRVRIbWVQ
VXZMWkJKdXQydVpGcW9iY1FiT0t6VDRvdEVneDJScVYrWnd2ZEFIbDEwWEhVCjZqUklrdW5wR0lj
T0N1TkxsRXJFY0dQbXFjYk44blBGcTZUYkJ5cz0KPVVrMWoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000760532062755c2a3--
