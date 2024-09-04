Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45031465A0
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 07:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725435794; cv=none; b=W/7RpB8HmxqII3MEPxiOFnzCJUOmVKAMcWQVCawLybdyNWi9P4BR4RlkDEkUAaD05fDFGEj55LQ89PsDI0Wnu6MtuV8+9bsiuVS4M14CiAYJZs+9ySdHhEKlbHbWPLJ1ZfuhKzbLAhFRXsLSuDcFYsN4jFqq+UWcg2cj/dkp76o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725435794; c=relaxed/simple;
	bh=eKhs+sovH6ps6oj/aB7H6xi9aOzG7tnYUZj4wKbrrbk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMcQHz40S33pzQ3Hp5VCO20AWBWDdHBdtk8nn2po+BQ5pHfRGPyYstMIFnqvDqKJfMalG32cDaU0UMPsJ8ED1azz/cF434xHadul1Gzshi/uNPyPFydyr75iSZaVET0jnISjFVx32FMIiA/7hgRfb1/ww3PKvbCVvIDu5CvM0Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4BE/C7f; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4BE/C7f"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso78000341fa.2
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 00:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725435791; x=1726040591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKhs+sovH6ps6oj/aB7H6xi9aOzG7tnYUZj4wKbrrbk=;
        b=H4BE/C7f5MzNXFQyjE9WBhD+G7bcQUqT3FGz3mW3Tm4kS4jWL/FSsw0eA3U+r3jG75
         ljVFR0q5MJIHG+1zvlug52+wzPHr2dGCeJdgkQ6YjauGt2SnnW2WssS8FP3J0jAU/cpY
         FO1oDXA5kKh+fPR5sWhfIQ1vLzT9qQ3FeNRFfPxeiss+jP+y5XmRHUBOwqHo5Lw22fga
         t48WzJ5dXdWQhERhNoIJxGsrHYiCaLeYz51AXn3RYH7/r5Ry3UJ43D5wRl9/bF7TSugB
         k0LKvJr1cGOc63jmQRp2nr75YztofxoEQ0lPm27h8H2r/Pkde+DhKa1yVMKV+zefLxM6
         Gwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725435791; x=1726040591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKhs+sovH6ps6oj/aB7H6xi9aOzG7tnYUZj4wKbrrbk=;
        b=D9h9Pd8rPdfHuzTQeTo4ruVVRl9Kjl3zqiXiq9xqEdd++il8rrB3qEM4HRt19wTbeX
         47XbxXTVzgY80GZ1uck6m+qmJ792DLxND7Nw9lkrqh3CNM/a8XQWhEw6h2HuJ421HvQr
         xcN7d+PN0LoLzsAK9jwiQjNJw2ze9VHwaFKdjbHSsM3hjctE4XYjnCBAkpWiVeZ/tuPu
         GrYm9AxMd9ioHTOLRKMIpXJWvfjhHf9vo/gKm7I6QL9v+7nVHuzUS1/7H3a3ursWC0Ws
         z0zQj2BvutvEbOAYtkeSJwTlLPxVZG4YBc7EJn34T4V6nyH/Z7tFanblhXwnZ1Hu9VN5
         EDbw==
X-Gm-Message-State: AOJu0YznBU+Chc8l9W3N4WatzHNUGwNVSF/wXXmM5HMrh2bF1Y4QkmMH
	HvOKVeo1r68+0BSqWhyYzdx6K0NmxWS0JBj3V1oys+1fTGxtKaFfP77eOWEr+HlW9AAmPjVK4EQ
	m6+ESSeiJoAWVBC+uuBIdO+3IQXo=
X-Google-Smtp-Source: AGHT+IHjJlLBstAv1tUGNJw1k1c1tLC3Cqv2CR5zb29BD4fcqa3ao3ffPVkppx5II+sFBRW+WH3gIHlmJmgN8bbIWRU=
X-Received: by 2002:a2e:a993:0:b0:2f3:eca4:7c32 with SMTP id
 38308e7fff4ca-2f61089355emr186522531fa.38.1725435790595; Wed, 04 Sep 2024
 00:43:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240824170223.36080-1-shyamthakkar001@gmail.com> <20240901212649.4910-1-shyamthakkar001@gmail.com>
In-Reply-To: <20240901212649.4910-1-shyamthakkar001@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 4 Sep 2024 09:42:58 +0200
Message-ID: <CAP8UFD0NMCUeFpQmLzXZmTUQQjQh5Dk79QxxMH_GN62w8ZC6YQ@mail.gmail.com>
Subject: Re: [PATCH v4] t: port helper/test-oid-array.c to unit-tests/t-oid-array.c
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 1, 2024 at 11:27=E2=80=AFPM Ghanshyam Thakkar
<shyamthakkar001@gmail.com> wrote:
>
> helper/test-oid-array.c along with t0064-oid-array.sh test the
> oid-array.h API, which provides storage and processing
> efficiency over large lists of object identifiers.
>
> Migrate them to the unit testing framework for better runtime
> performance and efficiency. As we don't initialize a repository
> in these tests, the hash algo that functions like oid_array_lookup()
> use is not initialized, therefore call repo_set_hash_algo() to
> initialize it. And init_hash_algo():lib-oid.c can aid in this
> process, so make it public.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
> ---

It would have been nice to briefly summarize here the changes compared
to v3. On the other hand they are small enough and this version
addresses all the suggestions that were made previously and looks good
to me, so I think it is good to go.

Thanks!
