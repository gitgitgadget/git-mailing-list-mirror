Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AD61DF270
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743435274; cv=none; b=BPRLCpthb2+/z9HuYO3SCrCIno4PZYcma0rRqshrg9ZM7Vkc5McDN2Vk95fuGXjuJu7jLEBDKfAtzggb1nITqsUxSgZr/oe1eY3wmtPGGeablE8TF3XWfqQj9lusSRRiD0wD/L1iVGqvnMo1XRTHCxCLnqI+yCzcEfj8+Irb69E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743435274; c=relaxed/simple;
	bh=Zq6ReFxxJxEsPRwbYt/A93ohLatFqEX0cAL3KdjKHU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YQsurD/m38ynVGdzWM51XSE3LjcCmMUqnQckK66z7i9tfMf7B5/P1+xFhUVbQ8eOZOhnnJdp9AtkndbDXYDoZ5hKewRmO/7IlshrLq+LqcqbhE/SO1z78cUjXRRawb6rOR+sW1mk7LWaJYrRQgy9dfGpzl2vu12i28Qm/FANqO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ly45F/e6; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ly45F/e6"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e60ad903382so3218123276.0
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743435271; x=1744040071; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zq6ReFxxJxEsPRwbYt/A93ohLatFqEX0cAL3KdjKHU8=;
        b=Ly45F/e6C3VDAVVmJ1udpvo6cYl+9Yvf3De5gSKWfSfM7R5ZrS6Uc1WpwEJaWGZdsf
         ECgRCFlAgRGpX82lVe8c3qkGyG1VxtLgyRb1MNFK7cJsJVbJ4DFi/SIWLeIjfCIjNHHC
         AVDM1s+gJyR4KrFAvkh8IwyRmuDRfFoW0Mx2r4lrB6aUfgQOvRQGuIbFs5BhUy0BucCr
         fQPQtIdBkNPjcsUTBGtGe2z+YTNTKJtxlVFhb7745Ouyj9/E5fGzZhnp/D5mMVqzqcX3
         huHq0JViCtLfyFX8o5QAL5GfnvByqpWKMSaYUlsy1iV/HXMDe2ymb4YtQUGWWzYRm7vS
         6HYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743435271; x=1744040071;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zq6ReFxxJxEsPRwbYt/A93ohLatFqEX0cAL3KdjKHU8=;
        b=CUBapEBxeRr+JddSupJ4Ea7JxJaM5NzQveRUtCo5VbBL3fsQJWvKABcze55DE06eQl
         zPFrHwqoZgtIAwIaMWi3I2z1jde5ScrzxpmtdocPJi8hItGiCT2kBxyD6vcbLqMhqLZs
         ZRH3DvqWB5z/9G+7m3zZFC275P17ww5oR2nmiWEGV5krLaNKk8t5dItB4qRb/M90l/GF
         ypEFs2EIH1hlbRfrPvuIKMfHnrTK688QHZXLQRruSZr1zvIMD3dhi25tYnX7i4ThOwxn
         m805v3chW1tOguM1Z+9netx51yeIkCpURcmCV4UPMdtGND21QE7OSQasLZmGxCe1oqdI
         wxVw==
X-Gm-Message-State: AOJu0YxNMq7Vv1o50bSxGuR8Y9h+2cAnoCy/p+QgBnHQ7htnlPZXx+tM
	wUuCZrTrGwdYlniXrwT5Dn4CcVTfKRWK+h7eEXjRckfy8zkPDhBmdaIhfXJ3h453pfZtVK0qWPn
	e5+Ljed5nIMsR7NubnZAZJUr+rzqoNA==
X-Gm-Gg: ASbGncvjMDnqLY+5kRs4V1SWQ+Pc0R0QyyS0f4wJ29iQSNJRmJTsRuQe3oTDWMiZ3un
	DfsosK198+5kApbjjVgHCv0QDWOfYIL0vAhLDdzR2exDOdgZ+SdEvkVTHXRTGbc6SfwlAEULmzK
	+dPMTnRcTe9Giis99JoMHG1bkz
X-Google-Smtp-Source: AGHT+IHckTyGBf049JaR7lFAqXOi+t5dN8Q/uHG4iu/QuWOdZY7R6Sl7hacDtI/MbxXbEaW2Nmg5oOeFVwf0Ge+f6oc=
X-Received: by 2002:a05:6902:2309:b0:e64:9dc:b8a1 with SMTP id
 3f1490d57ef6-e6b8391d815mr12034722276.15.1743435271622; Mon, 31 Mar 2025
 08:34:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DM6PR10MB36907032718A4340FAC6088EAFCB2@DM6PR10MB3690.namprd10.prod.outlook.com>
In-Reply-To: <DM6PR10MB36907032718A4340FAC6088EAFCB2@DM6PR10MB3690.namprd10.prod.outlook.com>
From: John Giorshev <john.giorshev1@gmail.com>
Date: Mon, 31 Mar 2025 11:34:20 -0400
X-Gm-Features: AQ5f1Jof9y0z4OOdlXjZrOYDNnp5bD9jwJZF_GBrKTEf-0Dc6_pm6RvjEVF9GMs
Message-ID: <CADJmAEi56TzaTqDtEHAkGnaqRgzE=QADHL7jfF1rRADSp-DF7w@mail.gmail.com>
Subject: Re: [PATCH] add --must-filter option for fetch and clone
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

testing mail client


On Tue, Mar 4, 2025 at 7:21=E2=80=AFPM John Giorshev <john.giorshev1@gmail.=
com> wrote:
>
>
