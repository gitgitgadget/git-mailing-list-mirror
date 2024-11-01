Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33FC1BDC3
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 22:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730499819; cv=none; b=RkYCYsjhwwG4ztvum4R6lZKWggLtcov4KyoB7p/ptEJuj4BksQVKB0JpLXW+ib89uGAIt/0aLsLelvScJlAyWttdloruzaPkz8wKbHnoED3Bf576ynPHMHURu6yqh9VK3M/BXBv3ws5Vr5cOBBVQLt6JvM77w8a0DVHUdVI5kRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730499819; c=relaxed/simple;
	bh=viLfaxnrp/s6ayrECQBeMx063YSUIUS8UotTsIfKXqk=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=TIn4nonNFEXWDJiVeT2rp+goKFF7zARL7LTJ91cOJXSNAsjA4wMMbluzhxZTSsG0prpTSUT9R8QF1Qv+n7RlOasU31ggxR2TJ+CLy2lZaRTppabL9sff/VDvGg8EMh2AploGgtbqVdntU6ZlW3Ksi8PTzGnjS3N/d471gSV8u9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SAMPU+3+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SAMPU+3+"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e35a643200so52059417b3.0
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 15:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730499816; x=1731104616; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9tPKHRSRcdf48jy8uoH5PpPyZTnHpZefuM8ARdRdNro=;
        b=SAMPU+3+7ANnh7/SrMfpQdoONmoQi6JRqSPIZxjhrBNMuu1wL1IzB4F5JuVPGgJTTB
         TFH1veXfUjvbrbMApKYZmBJLEkjTD8u84dL8wzOrbcT9IyuneO4TZu3IRqKuPTx5ejHe
         p53Oks3TEZ7Qo0tsPQMD0O2jFiQPMeJ7RXhzsEgqCDuxwFFSSqMCO+ZtMQnX8DAcw4mB
         L6UoZrGYtw8QgvtABzlCGaOwH1sEhpxDcMnPUFKle1KlBNesBiRSZF0u0TrPpXlatXyx
         IHVOwkMgiNW2D0b4Rayh/voZ2vF1WP92Gt7AVODtzUusxwIpYFc+YNQlz+zXNqcoo+PF
         eItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730499816; x=1731104616;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9tPKHRSRcdf48jy8uoH5PpPyZTnHpZefuM8ARdRdNro=;
        b=eg1sVUkxv+qc3g3puKVEy/UYDlg8i2K7TJ7GN0pn1WyYE3BogQH4ZbZcy9lbYxHUmy
         9mjzDDpw3cYIvLXe8/q9yAvVPLiv7kiCTkYu3o5SPE8dE3RWFGT6sz8YVbVMKViSFXhC
         5Gilo3gPPywrAt0FRTG3dxobyXLYv9twjkSdwCyRfabVTSh5L4OpSQPsYVZIFoZUq/3G
         9LWOdXOOKMXIW/dl8lqb09csvBE88d8Hy9eM/LOVoW3VbYGb4VcwxfxyR7EYjD4WjJi0
         bvIz+GoQujllUWPxFl2OVf8dIQ4cMoBVZX2yb8JLFrdyiPjjL/61DK4d6KlHMIg8bC1y
         RlYA==
X-Forwarded-Encrypted: i=1; AJvYcCWGYRxnqO108JYj7GpXihjeN4kRADR/RbzL5BAKKkHvwqwL6bUybP35XMtJCHniYTtWXxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyZDUIKpHyXGCJW3/I7YTMG5ztQapFw0webmsiRcWf0hCyBBp4
	wftxXv6ynSltC+LK0TiZ+2sjztHc0thC+DgTt18cQuTWSts1D/Tibk+Qcl2p29Jtu7jAf+Dgbxb
	b6H5xQgMXydhWxQSoUopGmYXUE0ejVw==
X-Google-Smtp-Source: AGHT+IEdJv8O9edjxsV52u1EauQ1MxjP6DwmuUvgeT9f37U2RhZf8UCD9WKL+z7MmFKkWo+bYIBPZ5LdDjN13MJYNlOb
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:87c0:a56e:d0ff:807f])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:628a:b0:6ea:571e:ac46 with
 SMTP id 00721157ae682-6ea571eb62fmr340077b3.6.1730499816324; Fri, 01 Nov 2024
 15:23:36 -0700 (PDT)
Date: Fri,  1 Nov 2024 15:23:34 -0700
In-Reply-To: <6f93dff88e7cf81800c8f2c8d39175d962a0576f.1730356023.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241101222334.1724050-1-jonathantanmy@google.com>
Subject: Re: [PATCH 3/6] t6601: add helper for testing path-walk API
From: Jonathan Tan <jonathantanmy@google.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, gitster@pobox.com, 
	johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im, me@ttaylorr.com, 
	johncai86@gmail.com, newren@gmail.com, christian.couder@gmail.com, 
	kristofferhaugsbakk@fastmail.com, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"

I haven't looked thoroughly at the rest of the patches yet, but had a
comment about this test. Rearranging:

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> +test_expect_success 'all' '
> +	test-tool path-walk -- --all >out &&
> +
> +	cat >expect <<-EOF &&
> +	TREE::$(git rev-parse topic^{tree})
> +	TREE::$(git rev-parse base^{tree})
> +	TREE::$(git rev-parse base~1^{tree})
> +	TREE::$(git rev-parse base~2^{tree})
> +	TREE:left/:$(git rev-parse base:left)
> +	TREE:left/:$(git rev-parse base~2:left)
> +	TREE:right/:$(git rev-parse topic:right)
> +	TREE:right/:$(git rev-parse base~1:right)
> +	TREE:right/:$(git rev-parse base~2:right)
> +	trees:9

[snip rest of "expect"]

The way you're testing this, wouldn't the tests pass even if the OIDs
aren't emitted in path order? (E.g. if topic:right and base~1:right
were somehow grouped into two different groups, even though they have
the same path.)

I would have expected the test output to be something like:

  TREE:right/ $(rp :right topic base~1 base~2)

where rp is a function that takes in a suffix and one or more prefixes -
I haven't figured out its contents yet, but

  echo $(git rev-parse HEAD^^ HEAD^ HEAD | sort)

gives us a space-separated list, so it doesn't seem too difficult to
define such a function.

> +static int emit_block(const char *path, struct oid_array *oids,
> +		      enum object_type type, void *data)
> +{
> +	struct path_walk_test_data *tdata = data;
> +	const char *typestr;
> +
> +	switch (type) {
> +	case OBJ_TREE:
> +		typestr = "TREE";
> +		tdata->tree_nr += oids->nr;
> +		break;
> +
> +	case OBJ_BLOB:
> +		typestr = "BLOB";
> +		tdata->blob_nr += oids->nr;
> +		break;
> +
> +	default:
> +		BUG("we do not understand this type");
> +	}
> +
> +	for (size_t i = 0; i < oids->nr; i++)
> +		printf("%s:%s:%s\n", typestr, path, oid_to_hex(&oids->oid[i]));

Then here, you would print typestr and path before the "for" loop. In
the "for" loop you would add oid_to_hex() results to a sorted string
list, have another "for" loop that prints each element preceded by a
space, then print a "\n" after both "for" loops.
