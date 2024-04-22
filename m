Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793F9153BFB
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815311; cv=none; b=CI5P+/+uXZCWrbiO5JUmcV9pefzJCtLb3D9xqGgrjpq4D8ejBwYEedSZg+MppN6RVAokpZG4V45bRfNMolckwlQkREcmj8dO46cDCvh25dsAXH+xVEkdUljgz1OknBMEZgjs+lpwpm3rT1kAOw4s6grZtmsXH6FP+uTuwUfV/TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815311; c=relaxed/simple;
	bh=qY1HuSGBMbJF/z7DDhXf7tQdSoKZitM+4YpfzCjfj1k=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=Tv7/c/Md3+xdafcKdtkEYWO8TnjbeGpGg8txXX1UMiavqRRlZQXqxDoEQApGbNgefNXOrK41dDR0iy+jZpasbHO3VptDNivI0pZme5TzOU8lXoQng+WxVLV1v5b2fSK4WOoeDWmLKlgePUEEFj0GTbtIYPtcJ4LOrsHG/Xv95Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OSYESUfZ; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OSYESUfZ"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61afb46bad8so62982397b3.0
        for <git@vger.kernel.org>; Mon, 22 Apr 2024 12:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713815309; x=1714420109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2jyo9vEwVX15GHNM1XtOxrnuw1PO+ubu6Qm9McRNpA=;
        b=OSYESUfZ/rtqmE9fPpJeGeC5XUjNJJLRAy4uOWI89/kby9d/0ZWvP6eprpMIb03ifk
         GE3zWUesGMyDdGBmgz8y/15P/qmRr7NoCKDwHhSf1SocKG2aBqsJf216XkO9QgTZ2YQq
         YLqytcqZ0COE0PvXqxYQs/e4A2GVWS10JTGGoLJZ6SS4gaOVNQ5ufFssQPfMFxrk1WiP
         /4szgUEX15YQxCQfl1jzkmwRWOfFsIgUMG+g22oAFngv8+sfO4ozqzxqhg3tZoxUBYOs
         d8AsvledYmo92R5eESDdKuFZj0OV8Ju29SItmt/HcvW9IyxGNF02X1fee7cm64sEBx5T
         AK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713815309; x=1714420109;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D2jyo9vEwVX15GHNM1XtOxrnuw1PO+ubu6Qm9McRNpA=;
        b=HMXUVpHWJ6g9LJvYYaYVj6+IvHjIM2C/he5591DnkFy7FDSPAvQSBIfo++8KVDnvsE
         BoutL432Hk24ade8I0UqshFodkp2tGurutCAeNEOhnnUdcDX01EDr56b+lAB0JeaVyJ9
         be17czQKFGi6+puVdovwEfeA2Fe+YCp2Uk9dmBUBfkDNEfcM5jegZxU8lBSjxAHHd67B
         G9Y1glXu1M8cPo9S3F1IestECnhdzHXNv0uNroepR6436YHBk8uZo+p+Kyy6jqg05WKQ
         j0nACyJ97fd22A2LD87b/x6zqRB8pOIe6+1ABSJ0+dlJDuHSiJYSk/2Ybdr4GdBRzBME
         rxGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFSjYXUC6wwGOfdZEi2/JJNbjImUwX3sMaYRw0D6lEwVrEl+QbAV4R38R9M63kwmHKSiXM5fCdtfAfHXraCVyQEgMe
X-Gm-Message-State: AOJu0Yx1auUESULJFMVhYeXjwRKuvDhSDIlkv2F8IabgYQk+nbGMVrxH
	dX6WxGSfyeMsNiH1g4oZsvKnT6bgk1vjI6lSPVXae4AgKSC5g/S9Ewe39m4iZ7FIQzpSdk9MLnT
	oXKOwQMFNxvx8wQ==
X-Google-Smtp-Source: AGHT+IEZRkQu+1zGGWOGxc0oIjPEqABSu+HWNTdqQSYjlqKG9RhmNuDaYBxITc2kX9wr2OywekaaLV+R7muq+NE=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a0d:cb86:0:b0:61a:d420:3b57 with SMTP id
 n128-20020a0dcb86000000b0061ad4203b57mr146184ywd.0.1713815309475; Mon, 22 Apr
 2024 12:48:29 -0700 (PDT)
Date: Mon, 22 Apr 2024 19:48:12 +0000
In-Reply-To: <20200420224310.9989-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240422194824.340464-1-calvinwan@google.com>
Subject: Re: [PATCH] osxkeychain: restrict queries to requests with a valid host
From: Calvin Wan <calvinwan@google.com>
To: "=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?=" <carenas@gmail.com>
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
> make sure that requests to this helper to get credentials return early if
> there is no host ord the host is empty.
>=20
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  contrib/credential/osxkeychain/git-credential-osxkeychain.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c =
b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> index bcd3f575a3..2264a88c41 100644
> --- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> +++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> @@ -69,6 +69,12 @@ static void find_internet_password(void)
>  	UInt32 len;
>  	SecKeychainItemRef item;
> =20
> +	/*
> +	 * Require at valid host to fix CVE-2020-11008
> +	 */
> +	if (!host || !*host)
> +		return;
> +
>  	if (SecKeychainFindInternetPassword(KEYCHAIN_ARGS, &len, &buf, &item))
>  		return;
> =20
> --=20
> 2.26.2.111.gbff22aa583
>=20

We're currently using this patch downstream (removed the check for
!*host after updates to this file), but I was wondering whether this
change should also be in main. It seems like the discussion around this
stalled and there was no definitive conclusion, but the change also at
worst does nothing and could possibly be useful -- I see other functions
where we're checking for the existence of "host". I wasn't around when
all the changes around this CVE were happening so I'm not exactly sure
how useful this patch this and whether we can get rid of it or not.
