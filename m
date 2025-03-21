Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FEA22F173
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 21:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742591456; cv=none; b=LaL8Pe28aBeaikTzlT1luNcZ7O+4LeJtJYXBj1T/YsyBQLFQp5fahmeQnon7RfJYynrmABX4hi9emrgPpEYsu8c7pyJU85kvtFtu/yWsENso++O6Wbynjv3yexvs3kr4ex5PrVnYj8ngDqxtBCFTdWX6dJZ3Q2x6HYOPY65eE6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742591456; c=relaxed/simple;
	bh=4orbeBIy+0WFlMcqO2SJtYm19ii51xbqy5vNMXjkJ/g=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=nlf3Oe0HdV/ajOI6Kl3iZJNHZLEtNxjhpR5gx4iSB9Y8iA20ygBHiQDZbcK1GrlZ/zpWu6YF6zJWDhMCgR/kBQBnfLERuRa/yNfEiCj9ZW9CCriR096aeP0mCQY5mf4Y8DqsxsIBwhyvN11Ywch7lYIb91NmucKWLn+JUPzXSdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIfIbtqB; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIfIbtqB"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-523eb86b31aso1110065e0c.0
        for <git@vger.kernel.org>; Fri, 21 Mar 2025 14:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742591453; x=1743196253; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+w3ZSAeTEqniFyvNXvGyzg4NVSINshFZrl1maVbFNvA=;
        b=SIfIbtqBWqaO/5IZz3XtyH3U6L8bHNF3TJ0WsvnWzPSPq3hEMSIwlDrQaYzk00KWJX
         pR8sYRha3q9l8kgo3Jeta+Tgy3yXswbuMvCBtu3VANuZxWSI1YlNAqnGtlHSkB3d66SH
         RBxNMqf7PhXGnYJV5WZB7epDMbG1ccvJnZCDyKAbSHA8hKq2hr/pSBQJORGMYlBGuyUy
         ec/xDvzTAkWTsGy6zPmjeH42q4Cr/ofmT0g19CsxXashi8mOaQgA1NZKUl39m3DfXa9M
         XOHBFR+gJJuWpRwxRcRhS4s54OQFBcckewu7EUlyzAtcnN/aURWGE5iInorNUC00yVfR
         6gQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742591453; x=1743196253;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+w3ZSAeTEqniFyvNXvGyzg4NVSINshFZrl1maVbFNvA=;
        b=cnhLpgc2b84tnJW1rCP/uL5EEWdidKVClbuhkYeQOEDQhln/d4CIVBbZs7UQFMF0Z+
         MvJa39jNRYWkqOZheSQ2Ih2/4oHNfNNhH/frhnGlp1AsboCVMjFIxSmNypN0YhrxOaC0
         YXgsNpL3xpQw2mGCoUccyz7guYYRz1O0VbvfIzknjKL2gEMp9ItF7pdSTuOky0OOnFyk
         tYrRWL79gagYErEGPaiy35V/QKCF4XyYh/tZZI5CD6X65OaSWSwH6h0YGN0q5oYn3pcz
         iholNlDDc5jWshgonO5DhRzr3kdbmKnGNrRX7C/wccZIopVdX28DCmGj4jDXMk397dBn
         EV7w==
X-Forwarded-Encrypted: i=1; AJvYcCW/gBem40vncSB1hR7lkUydwa7qDhRh341/aYHnX12XN3Sj3TfV0jLIuOdXKh0njy52EiE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNmur78h9C6NNq8MbElUK0M2gZtfIzwS8i/taq4tIrVx0dRN2s
	xgOmruvkjhur3arPMwTCn3UKfaNp0nXkcL+FF4i5c7xdxrb3iHPPY65hYe9DCrcCoS2XRIGZZUl
	vZe2CarbUmXFcrdU3QL0QUe9TA2U=
X-Gm-Gg: ASbGncuVkQ95l7BaI4tr2uwrUY6iB8VTsL/cvSYmVIzYxvTD6Snhj9NqcDVGP3UBBwv
	j02jPCXSWFXJM0DWcz9WROMOX3LR+tcLnSCT8uX0vXAIg0MOyiq5srQkgdAbdCkXRNh0Qey2Tlj
	4/jjwKKEMEHbH3TqhkC5PAmTdKuWW7QS02LhBcfepkgiHg7cxaOyolFr5DXuEt
X-Google-Smtp-Source: AGHT+IE9yf3n0MUfVRJcFuepC9erujb8iJVh43jOGh/tXjtSDIoYkN/wpv+AH/IEdImxpWoJ0IQRxMNGrlRojB8/F9U=
X-Received: by 2002:a05:6122:1c8e:b0:525:9ddc:381a with SMTP id
 71dfb90a1353d-525a850e31fmr4191785e0c.6.1742591453441; Fri, 21 Mar 2025
 14:10:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Mar 2025 16:10:52 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqiko2tguo.fsf@gitster.g>
References: <xmqqiko2tguo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Mar 2025 16:10:52 -0500
X-Gm-Features: AQ5f1Jr6NakzmIY3hCMUMTUJhsQr_BdzxkE27Lb_6NHLjeGDQYgLpsa2NA4SygQ
Message-ID: <CAOLa=ZTAEKyFBc7HY7HxGLHCiM66i=RhM7=trG6tb5j04g7vfA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2025, #06; Fri, 21)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000924f550630e0b053"

--000000000000924f550630e0b053
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> * kn/reflog-drop (2025-03-17) 2 commits
>  - reflog: implement subcommand to drop reflogs
>  - reflog: improve error for when reflog is not found
>
>  "git reflog" learns "drop" subcommand, that discards the entire
>  reflog data for a ref.
>
>  Will merge to 'next'?
>  source: <20250314-493-add-command-to-purge-reflog-entries-v3-0-c24e23a6146d@gmail.com>

This should be good to go, Christian and Toon reviewed the last version.
While they did have some suggestions, those were inline with how 'git
reflog expire' works. So we can take that up for later.

--000000000000924f550630e0b053
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 78438f6806e7d7d7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1mZDFkc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOUsyQy85aWtpTjRGTmk4bDhoUElpYnoxOTBrZE9UVQo0WVV4V0JiYS9C
VWk2V25pc2Rrc0FJSnRtT0c2UDJFcnA4eVlqRE16bzhvLyt3L1ZZUkpGVkZjTG5uWW14NjZ6CmFZ
RWpSTW9WVFRUSzdMWU1tVVEvMDh5ZVJEUGd0U1ZDU01DV0h2eGZCdHRtZElmWWRVeWZqV3pXTVJy
QWIzcC8KdFNjb0U4YWhaL0M0TkM4N3h5REFlNUVlcnJzTTE5T2duNksxMTlncGVod0xwU1liWGVF
SnI2ZzVjbkRvWTlXOQpYM29yY0d3SVhBYjBjUnFueVJNUk1sbHc4VDZmcHl0TmxsckZCd1dYUXli
d3lWWHQxcVJ2Y3FxclZFeVUwMFo2ClpTVC9rV0NRSk9VVFNqMmExREZHdUNFemdvNUZIZmJobVkv
dXpOTSs4VDdlT1BSY2QxTnRqSUpFK2NlSXNUNjEKc3hRWkVxVENxSjdGQlNHMHBkUVIvcGUvamp4
ZGY5MDVEMnVWZElLV0ZQSGtlbDBGU3FmUk9VcjVrdFpPdElTZgpHWUg1YlpxKzBOU01aTUJ3NnZ1
VlhRN3lZaEU2bHB0ZEgrNEtjOEcvTGJsV3VrdXJZZUpaVnprdGZwYmF0alRSCkFqbkFHWTQ0ejFu
TDJERUZlODVudFNuWGNqYUtNNzJVTVQxLzFidz0KPUNwSGMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000924f550630e0b053--
