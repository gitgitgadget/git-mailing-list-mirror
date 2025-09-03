Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F80B2030A
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908681; cv=none; b=o83ATw7xidgzCrlUYgwcE61uw06dxXyYo83ulDiIaNjUsPfOrX+mmix5fiv7OMdCSqfYYflIldYmBiFDA95QlrTdOPBnk9cuq3uwuu3wotSvpvf3Usadc5bea4RU4H07n8+FUsuUBhVn/x4MBCcSshqtclS32yeu0EC95HWmcz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908681; c=relaxed/simple;
	bh=PVNjLaE1ZU1ngnjtcsfOKQIqj6/EcIw4mahP/LNC7AU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Fzh72ZY6MHGBb6lxgz17IsOtVb3VJiWRLsFaXBoT+1Q+WLYZ47TkpMdGmeP3CA6qWkERsVQrIGmxkXqQXpkuzFYU03jPThfAGzKtTFVCEjjxs40/Y/AdmwSAYAGwLk+b//PblHC6tHUg+JIpKlFs4te0HBPXrFsnxO2YJjX4RDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anqtmEic; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anqtmEic"
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-55f753ec672so4511295e87.2
        for <git@vger.kernel.org>; Wed, 03 Sep 2025 07:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756908676; x=1757513476; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KM0HasdSeliZKTd6kZjwX1JZOHFeQvc8+3CRZuyRZi8=;
        b=anqtmEicul5lVNP8fca/xTpRURkRevuKt+lX1QoairWaFudfhiDqjUhfyGJooSQ++s
         XXlv+uRVYKGm+f212oF1B3EYaPUaUvF4Xy9nDq8KM3VUVuhfwFYaieuSlOIKYOEtKbVA
         7wNOlyg7au7t7cZZQzSRq0lHlY4AQI7/+RP8YVw2jZLYoqsSWLF8PfwKbTN68gGfPOqS
         067o6YI8Ne9gf/v+lUEIXqfsGypjOukzkY8GjlhicD3B3GbjaF0KTZ4ZQVtB0PZibGWm
         Vo2Xr0mKbBGRYNSvg++8OrUzgIC1HLugxvFI3sDXFRRFvUp4WMOKxtnpYAaRFrymYVpQ
         79aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756908676; x=1757513476;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KM0HasdSeliZKTd6kZjwX1JZOHFeQvc8+3CRZuyRZi8=;
        b=hJvF1u2Od3UUSQszPPABucQMSYYPHn3HIkdgj6tjrFX8UAAkWhJ6oujHcRIqZtJclq
         mdDZG5mzja23E+SB+kEKCP2sCdubvvgBFu4rCqGeuYeOxbicZwA24Yff7O00g8pNwePg
         BJ9c2ORVMQlab4cOs9ncJwrOouDktx7BSniWw51ZsW37umqRhgzMNPu+lODdfQuOHpjI
         WRRW07iyUTbd0lD3X8XtulTAnp4ofxNtySCKrr+T5bqH1aJ7B1A0FpxW8Dkaxe7/0myA
         YdzlAzSL6Z7bqfodle2nyBtY4HbswYt+AMVg0mgrxt8VwHIOCRCch5Y1U4/bMKpc1fdJ
         MWAQ==
X-Gm-Message-State: AOJu0YxtMLQp2iqtWspUpzU2NBzLX4Dru5gYMDJYha3x2yOSgFausTCn
	hDXOQL2u0nZHyX+KfgI+3ZbNTyaNQJt7rRUGoQxD2BIkK2DhPTJz68MI+xuaHnvQE9/vi1nGMTo
	MK8uGjkk9R9tIeC5zeP2FN1b4mTWeov2pwZcx0Rw4lg==
X-Gm-Gg: ASbGncvuc4ZMwg+EN7IGfAQilZ07jV6A0ZfN7x7ZriMHq1yNxyh2uOpZdbFMYwgn1jo
	2+QLouS7bGOi1MGylb5bhW1/tH3d6N9TVqoX/27CRNhZaFSCDwGKTwJcxiHdNrdbRhqDxqnXz7P
	RXs4fm8O1ZbbXh+ERyiOLCKKCqcSTMncCNgorZg6RfWQOsC1UI/9HtGBXJ6xrwLgnnS+FkI2Bvd
	7ZcWz1aH12qfkQX
X-Google-Smtp-Source: AGHT+IFVwDyPYHYs7/rVE0rKW6D4WxIXB9G0/k0WdyohbYzR5kRCgVKDbSc4i/Xi60uBZM33uXOeGd2nuqd0UGbYXhc=
X-Received: by 2002:ac2:4bc5:0:b0:55f:3e82:9c7f with SMTP id
 2adb3069b0e04-55f7099a779mr4152528e87.51.1756908675921; Wed, 03 Sep 2025
 07:11:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: elhmn <elhmn42@gmail.com>
Date: Wed, 3 Sep 2025 16:11:05 +0200
X-Gm-Features: Ac12FXxMvTPcoHtJvkgjIjCcvvQc2HsEMctmX1VmSS89sX6iXFShHoyfsEJZ-vY
Message-ID: <CACpeKQ=sPOc2AqsMT--2tu=BMEK9MaCAq5=PTG5w49gbRcQgVQ@mail.gmail.com>
Subject: Reference transaction hook is unable to find the old_oid for
 pre-existing refs
To: git@vger.kernel.org
Cc: ps@pks.im
Content-Type: text/plain; charset="UTF-8"

While inspecting the reference transaction hook code,
I realised that the hook was receiving a CREATE ref update line even for
references that already existed on disk, where I was expecting to see
an UPDATE ref update line.
That behaviour was observed for the file and the reftable backends.

Using the `reference-transaction` file bellow:
```
$ cat .git/hooks/reference-transaction
if test "$1" = prepared
then
         while read -r line
         do
                 printf "%s\n" "$line"
         done >>actual
fi
```

I created the commits A and B

```
$ git commit --allow-empty -m "A"; git tag A
$ git commit --allow-empty -m "B"; git tag B
```

Checked which refs were created:
```
$ git show-ref
9b18557013105bb7a7bf681f18757084ada9d948 refs/heads/master
01077b2840db5baea0084921d8f3158a240e8d85 refs/tags/A
9b18557013105bb7a7bf681f18757084ada9d948 refs/tags/B
```

Then ran `git update-ref refs/heads/master A`  which logged:
```
0000000000000000000000000000000000000000
01077b2840db5baea0084921d8f3158a240e8d85 refs/heads/master
```

But I expected:
```
9b18557013105bb7a7bf681f18757084ada9d948
01077b2840db5baea0084921d8f3158a240e8d85 refs/heads/master
```

The git/git t1416-ref-transaction-hooks.sh update tests seem to be
expecting a $ZERO_OID for reference update, so
I am not sure if that's a bug or a feature.

A test case: https://github.com/git/git/blob/2462961280690837670d997bde64bd4ebf8ae66d/t/t1416-ref-transaction-hooks.sh#L55

CREATE: <zero_oid> <new_oid> <ref_name>
UPDATE: <old_oid> <new_oid> <ref_name>

I ran those tests using the git version `2.51.0` on `Ubuntu 20.04.6 LTS`.
