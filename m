Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFC322C35D
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 12:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335321; cv=none; b=p5VXkNa9R1qdPu88qNu84BJ+kIk7u8n1Ey5IhrjcOWfmwcdzAKToIrbcIGq4WSqZbcb2f552bLGZQYsU1+YIF583pGT/76kdxHTr5Wo1yeZgemgSb9oWD4XNkTKtxccZaiIXs//Kzg+BJwyDUiplU+0ktUvGfCCY82hq/0DY5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335321; c=relaxed/simple;
	bh=2pMPKMHxim+cwvG0LLpOJ6JQVSn09cfHmLfsO8T2CNE=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mY+2b6Y2U3xRLvOSo95Zvxa+yak7Tkpu/++5d63BGLTvZpBuegqzAHo4Sl75mNTgsTgUctFtu5+6lUAgVUe98h+lCfPSZ4287hoKa0YoLEiwVB12iTect3Se/OyBmcu4216h7k+UbH977UppAh50rXz4WffE3ffbvYBMTgCd6Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjHdUJTG; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjHdUJTG"
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4e7949d9753so231392137.2
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 05:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750335316; x=1750940116; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/AIAM5gWgBlR8wKWSGQ692Ml5NP0s1wqegIIxTJCpcE=;
        b=WjHdUJTG7xriZzG5/a3VYM6GzeEHkEAm3sQZ4slETqqX5hW3GK4s1EXlMn1YUQaLan
         6lkcYprE+nwmhU/NhzDnvHVCFB80Qi30/8ZgSqE0Unk+1w5TAIw3CWfHbZfa0VpdiGyW
         CJevu7HTV3FzmRi4xsJJcktGwCSxkYppufwnJUkqmvO0PSrmYTmuIhPUNAmq5SNYX2bb
         I3ZCzn4UaGbShRxDdajPBi7L9Ou/uhP5JspJNqDzBTQtNUkBv3XDDBkEZxH214J8kyH8
         kraI6ubMMjgK0dVyG9k0kMCJd+ZIyzv33g3BFsSesj/1+wr+WPfVHK4e+25BkwPjFyMQ
         /KPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750335316; x=1750940116;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/AIAM5gWgBlR8wKWSGQ692Ml5NP0s1wqegIIxTJCpcE=;
        b=kL13FHrmMP4QdDb6YEYbZl5ONLcw2ilbi5iQyjOMWRj+4boUd6eENYDubnjyDFc0Do
         GrLpd9rk4Qz/4KrIj7ZpeeBJ0q1eFAYav2Z1+rpmTZ9PvM9zpvkcg76jxLosU17MI/r7
         EtHez8LzlFWJD2DB8OywE5enEfiS0c4NCe/5ugCWyHwluCt3Q1NBYHfhZUn2EU7VQsdm
         HgD9c/1kjiPzBNIDsM8VnCoW75/B/s7k83W7bt6NQMqj2Bg0TYKprSHr6ppT4DyqE3Ki
         kHCG+3n+Q0DnWe4qa1tlRU3Igq/gZEIteUhlF9a25OiusEXkPfwPYsjsTDlP+pl3a5GT
         ilzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGE3lkR/yG5WAccYibQ0Xz8ClYreAR8U0F/l/E/QC4LpIy75X0m77G6OFmlndt494sClo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTGd1e4naYs4d3zNapXBVu1t/35ypR+sJo7AAyDlBVJd6MN4yu
	n/85A40qT7BXcpMjDrNqJvZMPs+0pVzbrKepDhZMu/j3Jz4oAyfLC1wW1s9S2origbo0QDNKYoy
	1Sbz6l5l1M7XCx4BrYS8gx+lcfT5CfyU=
X-Gm-Gg: ASbGncv4XwjZuv0cbsUpuWp0O7EEYh4ojVwNY96DwHp59O9SOSLKLi8zaKScrq+v0WB
	gYK6ySxWgASBiTziEd15ofs9+C2cufHBnUTNqSRLoKjWAXgN0PeNTe2iCuw7kQxd5tBqubOeUcM
	m5xOwSiYvOu3VE1b6NV8UFkzAqn+cXd6O1nfR4FqeWfvBiGewCS8A=
X-Google-Smtp-Source: AGHT+IGIS8xetc9wqrxA2bPnsFs07bUxsuEJM11K9TAxyZPJmH8h+1S2b6QiZGBciNV6AnhNA8mv8wVTDsv7vALMmk8=
X-Received: by 2002:a05:6102:a48:b0:4e9:a01a:ed57 with SMTP id
 ada2fe7eead31-4e9a01aee6amr3613483137.20.1750335316254; Thu, 19 Jun 2025
 05:15:16 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 Jun 2025 12:15:14 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250611134506.2975856-3-christian.couder@gmail.com>
References: <20250519141259.3061550-1-christian.couder@gmail.com>
 <20250611134506.2975856-1-christian.couder@gmail.com> <20250611134506.2975856-3-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 19 Jun 2025 12:15:14 +0000
X-Gm-Features: Ac12FXxaWyqb9hTOmyn3SqJF2glil8tBTaJ5U0IBNNHxLnA_o5t6Nofvfd8lKF8
Message-ID: <CAOLa=ZSAU4vfNNvcmpVrEavYWss_txVwfutY5ZZLzvVmv5wPdA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] promisor-remote: allow a server to advertise more fields
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Justin Tobler <jltobler@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000c37f700637ebb284"

--000000000000c37f700637ebb284
Content-Type: text/plain; charset="UTF-8"

Christian Couder <christian.couder@gmail.com> writes:

[snip]

> diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
> index cb061b1f35..204528b2e0 100755
> --- a/t/t5710-promisor-remote-capability.sh
> +++ b/t/t5710-promisor-remote-capability.sh
> @@ -295,6 +295,37 @@ test_expect_success "clone with 'KnownUrl' and empty url, so not advertised" '
>  	check_missing_objects server 1 "$oid"
>  '
>
> +test_expect_success "clone with promisor.sendFields" '
> +	git -C server config promisor.advertise true &&
> +	test_when_finished "rm -rf client" &&
> +
> +	git -C server remote add otherLop "https://invalid.invalid"  &&
> +	git -C server config remote.otherLop.token "fooBar" &&
> +	git -C server config remote.otherLop.stuff "baz" &&
> +	git -C server config remote.otherLop.partialCloneFilter "blob:limit=10k" &&
> +	test_when_finished "git -C server remote remove otherLop" &&
> +	test_config -C server promisor.sendFields "partialCloneFilter, token" &&

What about testing only 'comma' separated and only 'space' separated
fields, since we support those too.

> +	test_when_finished "rm trace" &&
> +
> +	# Clone from server to create a client
> +	GIT_TRACE_PACKET="$(pwd)/trace" GIT_NO_LAZY_FETCH=0 git clone \
> +		-c remote.lop.promisor=true \
> +		-c remote.lop.fetch="+refs/heads/*:refs/remotes/lop/*" \
> +		-c remote.lop.url="file://$(pwd)/lop" \
> +		-c promisor.acceptfromserver=All \
> +		--no-local --filter="blob:limit=5k" server client &&
> +
> +	# Check that fields are properly transmitted
> +	ENCODED_URL=$(echo "file://$(pwd)/lop" | sed -e "s/ /%20/g") &&
> +	PR1="name=lop,url=$ENCODED_URL,partialCloneFilter=blob:none" &&
> +	PR2="name=otherLop,url=https://invalid.invalid,partialCloneFilter=blob:limit=10k,token=fooBar" &&
> +	test_grep "clone< promisor-remote=$PR1;$PR2" trace &&
> +	test_grep "clone> promisor-remote=lop;otherLop" trace &&
> +
> +	# Check that the largest object is still missing on the server
> +	check_missing_objects server 1 "$oid"
> +'
> +
>  test_expect_success "clone with promisor.advertise set to 'true' but don't delete the client" '
>  	git -C server config promisor.advertise true &&
>
> --
> 2.50.0.rc2.5.ge8efe62b7f

--000000000000c37f700637ebb284
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 19823b8aaf5ddb85_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEpCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oVC8xRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM01yQy9qMENTMmdPUW9OMWZFbnBZRHY1L00rWjRUNwo3NmlYOUVBblA5
azM5WVNlR3M4STVLTTkvODdvZUF4a2FtRG0vT0wrMHFnRWR6eVBDVTVvbW5jckdaSWlGS3JmCmpH
TnIrdmR4Q3NjcFFRemQzVVpQOVZjSkRJRmJRWXNIdTVYS1NvbkVwbUY2Q2Y5NEw5bFRvNkpDdVUw
dlZRVncKY2Z5SE8yRFNnK2EySXgxV0wzNXR1eTQxZFVOM3F1d3B0dTFNR0p4VEdpNzdQQzRJYmJK
Q0RLZlpOWFN5bmRLWAp4Y0t2dkltbE5TVU1zbUFPc09PTE1MazJRNUN1L1lDVmdRZXdHdGM2VE8w
U0tFODdUMGM0bXJyakkzU1JXbmF5Cld0ZU5CRXA3cUNzOHR3ZVpWSXpIaHk3R2J3TEZNSktrUjlB
eWZVaVFWRFVxV1lrbDZ4VTR1TU4zUUZDc3VKdjQKQ251ZU5tbk1uTTVOa2g3d1JsVGxqSnE4Q0wr
K0pzQTAxcDU1M0xTNDB6SFBwajlCR3Rjbm9DTjcyVVF1WDVQMQpSYVFwbHZqV3Q3Ri9jcUY0T25F
R2Z2bk1IMmFybExzOVlLK2JDUlFJMzlsOEVrMkg1SThYdURXN0FpOTZoY04zCk9ubE5MekJLSGtC
MUxneEVZOW4vd29CcUxmOFJVdzR2aDZPMUF3PT0KPWYvenQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c37f700637ebb284--
