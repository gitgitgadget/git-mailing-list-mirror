Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43B517E8E2
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721219957; cv=none; b=Qs9+Unq+nxHm2xJP0KGvLGg53zC3/XDRMjw134etvUifK1dWeSOx68enpiZ+ZybclFiVRsmKn6DTeWlA6ak3eLH++w+dWAg06YgMq7ft3FhT9CiC9m4qfWj7JSZlcG9oBy6JoOIDzaUhNJip5SsovM/qc/Un0cfeGdOsYAhYTIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721219957; c=relaxed/simple;
	bh=tUZuGOXzxz5ey536yVhBSWvMxT48aHdYCU/AyFKCmoI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jPOgtO/u6NzOT12c/F5y4/eKpUZjMC3fIozThYnGbWhLqck8VgLIK4GPBtZkly7NUar+Mz4ovYinS2mugOqQBJ707ek82Zy8Gcapg2Aj82ChXU/9QPdRNLp1uItQZsdcWnElgJElwqNxGFTuc1AfCsjGk7VYlJpx/lOyaEDrBis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIilvaNr; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIilvaNr"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5d4071e9b93so338341eaf.2
        for <git@vger.kernel.org>; Wed, 17 Jul 2024 05:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721219955; x=1721824755; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lobpX/5MXvBnqzwSW1XKWQmJALTeiS5LKSxTe5qi6N4=;
        b=XIilvaNrtx+asGa2A7+Jso9NvyPJjav+GaamdcV42a6+mob8bvh+wzu/usZ5AMR+/E
         u/enGSEzLpCIj3HGCMsQc4nvgLJBpbgYy4PnL5I2hCPxIcegPBK6Or0L6KkoMRlFcb2z
         2VmPh3fSoYK5y25mMiYZ46Ui+AW2vC2/fmxgewwRKwNwkHCAkoKfu8CNmccacg/30GPL
         BKmhs5DS0E7zgUvxUXOHwWbCeguisIrif/GDXfegrR/sg0EQGGGNhqYkcu2ZeGWsUyMH
         1DLXNIGiXjxBIfrEc6WLe2pzD/Vse/81iEYlPElttvALhL/0MbpJx6P0hIKLkiN5geZl
         BtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721219955; x=1721824755;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lobpX/5MXvBnqzwSW1XKWQmJALTeiS5LKSxTe5qi6N4=;
        b=pDEvZsH3Lvk89p0sxPLy6JpBNpLpJbBuLMLE+8rYfl1IzC+P6+5zsrkydg0zrf2zuf
         nUVUWEqKi8Zw4L3tNWOpv9xloMT+AbAdw5qZIJYPb/nG72X/hP/lw5CgdYYzX8qjSzNJ
         CUQ/ti3WKY12YHSEty1tBsPJYr0/8PLtJjc3dSnzxjly+IlhTa9ICcikq9t8kncpMhq7
         GdInkUsEfTSBT7qERBnbkY2pI9FQTGrYeEsMoDqwr+BoNKAdqsscazqWg1XEoUtLX9In
         NhIbROj1oRCWKpKUzkgQHHuRGyIpnjwtRqOa0G+KdIHbNqlQxVC9FxhoWRl30eClS6JW
         wzoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRVTMxjemw9MJrieEvm3hRlEMUdWqN97dbxWgNqS7xK8T0mHXBsmAt7SZYZUuLXkw4GFRPK9dVdmIwJhl+UEDggNs0
X-Gm-Message-State: AOJu0Ywo/CQ8B+U4JXPvDlnZU7eJabFDrNJAkkIIYTclRSm1p1Ksptfv
	Ozqqnkqkz2rgT4TF68LpxgcOYVs7GXtecilhB+L9Zkkowr/2kMB8U2X1aSQsBNUxlL4WUiFfeog
	7iaMgy7d+VRNsIIbqAxzq/VUhIh62VG5l
X-Google-Smtp-Source: AGHT+IGK6Hpcs69L/znO0Ez2oSTWSQ13XBZyBkxSS0gGJa76NzbKxecCsk4eDQOKCvGqmZ9KK0Wnc/BXH/u2cW+ZMcw=
X-Received: by 2002:a05:6870:b51e:b0:254:7b89:1003 with SMTP id
 586e51a60fabf-260d9506613mr1151020fac.52.1721219954682; Wed, 17 Jul 2024
 05:39:14 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Jul 2024 05:39:13 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240716075641.4264-3-chandrapratap3519@gmail.com>
References: <20240612130217.8877-1-chandrapratap3519@gmail.com>
 <20240716075641.4264-1-chandrapratap3519@gmail.com> <20240716075641.4264-3-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Jul 2024 05:39:13 -0700
Message-ID: <CAOLa=ZQxDXDDWXQrt9kpykuMr6nxSA8uf2U2nu0ChTf3yuH8sQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] t: move reftable/tree_test.c to the unit testing framework
To: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org
Cc: karthik188@gmail.com, chriscool@tuxfamily.org
Content-Type: multipart/mixed; boundary="000000000000fac909061d70bf60"

--000000000000fac909061d70bf60
Content-Type: text/plain; charset="UTF-8"

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> reftable/tree_test.c exercises the functions defined in
> reftable/tree.{c, h}. Migrate reftable/tree_test.c to the unit
> testing framework. Migration involves refactoring the tests to use
> the unit testing framework instead of reftable's test framework and
> renaming the tests to align with unit-tests' standards.
>

On second thought, it's easier for me to review here for the existing
state of the code. So let me do that..

[snip]

> diff --git a/t/unit-tests/t-reftable-tree.c b/t/unit-tests/t-reftable-tree.c
> new file mode 100644
> index 0000000000..5df814d983
> --- /dev/null
> +++ b/t/unit-tests/t-reftable-tree.c
> @@ -0,0 +1,56 @@
> +/*
> +Copyright 2020 Google LLC
> +
> +Use of this source code is governed by a BSD-style
> +license that can be found in the LICENSE file or at
> +https://developers.google.com/open-source/licenses/bsd
> +*/
> +
> +#include "test-lib.h"
> +#include "reftable/tree.h"
> +
> +static int t_compare(const void *a, const void *b)
> +{
> +	return (char *)a - (char *)b;
> +}
> +

So this is the comparison code, and we're expecting the values to be a
character. Okay.

> +struct curry {
> +	void *last;
> +};
> +
> +static void check_increasing(void *arg, void *key)
> +{
> +	struct curry *c = arg;
> +	if (c->last)
> +		check_int(t_compare(c->last, key), <, 0);
> +	c->last = key;
> +}
> +
> +static void t_tree(void)
> +{
> +	struct tree_node *root = NULL;
> +	void *values[11] = { 0 };

Although we were comparing 'char' above, here we have a 'void *' array.
Why?

> +	struct tree_node *nodes[11] = { 0 };
> +	size_t i = 1;
> +	struct curry c = { 0 };
> +
> +	do {
> +		nodes[i] = tree_search(values + i, &root, &t_compare, 1);
> +		i = (i * 7) % 11;

It gets weirder, we calculate 'i' as {7, 5, 2, 3, 10, 4, 6, 9, 8, 1}. We
use that to index 'values', but values is '0' initialized, so we always
send '0' to tree_search? Doesn't that make this whole thing a moot? Or
did I miss something?

> +	} while (i != 1);
> +
> +	for (i = 1; i < ARRAY_SIZE(nodes); i++) {
> +		check_pointer_eq(values + i, nodes[i]->key);
> +		check_pointer_eq(nodes[i], tree_search(values + i, &root, &t_compare, 0));
> +	}
> +
> +	infix_walk(root, check_increasing, &c);
> +	tree_free(root);
> +}
> +
> +int cmd_main(int argc, const char *argv[])
> +{
> +	TEST(t_tree(), "tree_search and infix_walk work");
> +
> +	return test_done();
> +}
> --
> 2.45.GIT

--000000000000fac909061d70bf60
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9f2712cbfdbe2e22_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hWHUyOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNnNGQy9rQnBhSmpwMFo5bVVPUnllZTBlakpmbnk1VwpsSVV6UWdwdVFy
MFlaQ3k2eTM5em4xZnV4d3ZaY3dYUnJOSzBwY1RoTm1KZ0Fjd1QxYkhEWWJoYW5WTFZsNi8yCmZB
MHZRYUhRMTBXa0xEYnBiTmZRbG9wOVpMdUd2M0Z1NDlnNktEajhidzJCTUJWVGQ5cE5CVG50Q2pr
Y1BHaXkKVkhvbkVibmdmZWZjU3V1ajhBUGNqdTVzZ2tIR3EvNFhId21vUHBQY0dnditqTDQ2QmVo
WEZERGd4N0VOWEI4RAphc2VQWW9IUVhaVUMwR1VWYkZFbG1YY3g1ajJNNGloN3dyNjNPbVllZGRx
K0E4RURYTkNtZVE3UzAyMEVBRndjCk1DbE5TVThrN0taL0Q2Q25QOTg3bWwxaEVpVW02K0owTkJN
ajl4dlRsQUVwSUlkbjJUbDFPR3FrQUVTNER2TVgKd0QvRURnWmNGVGpWL0t4OWxlcHE1c25zQXdp
RHJXOGx0OEFBMk5NaC81cTR6TUF3cVpvcGJsdTdtMkFNYlV3cwpUb3U0SGZnc1ppRkovTFFkUUk4
YUdOTDJ1aHpEN29YbHdUaldyWlhLN09zVVE0anFTZ3dKbXVYRVFoUC9UaDEzCnVMK2VkSWN4VUcw
RDNRemtpeWNZVnlYOTM4a3RSa2E0UjhscHRPZz0KPWpITjAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000fac909061d70bf60--
