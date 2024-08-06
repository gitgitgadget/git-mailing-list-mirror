Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43352184D
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 03:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722914959; cv=none; b=ZB1cTCtuSBpwjTM/oU/P7V9Z2XDc3WxLAg13Zp1z8Lcko0RP9K2n0ooh3wF70u1jfrTby5jomtPXr9DvM2udDD0Hev82Eq6LQOCkEVG5CDOG0iAuPAhgSX4An+IeDswnEh7tKXREeK77yos0w9AXJzseGEBRP/HpYdUoE5Ub7FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722914959; c=relaxed/simple;
	bh=5Euytj0OMom6x4O7uZLavpPNUYptGSCp7NxJ/aGUoX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnqxgcXAXYn7TJVBHl7hxWbJkpzmNhelqAEyqVQursndVzZlnQDIyhrrGgbYQPdlGL9FIZ9kLovI5IOI/W962b/n7fIE/YKphXuDdLP9CwjSH5Mt25yiRcQ0f5x4vNzlkSj+QsiAo6Kik0cLBVe2WGl1HDrMhJA66Jfd9Kch+tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b795574f9dso1307256d6.0
        for <git@vger.kernel.org>; Mon, 05 Aug 2024 20:29:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722914956; x=1723519756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fWDvHrV7m+adl7dKSOjUb3yplz086jIXTiCMfgzau04=;
        b=fz4t5iPc7sZ5vaWcULKutLSa4GfW/Fh4QjUjeutOalo3B/SMUZlU+9tsnD87szSp9h
         ncTJzsPVpzzy59juqf8XHJmF27pqIweQDhWk76C9ZyTzAPLz6eYfvipW4/4Y+dMQwdfh
         7a19fuMMBkPvSEUhoC1MLsaUuVri9/ZUBInMU/5ESN3RMlbVtPpj22/tmPN67CByIc/O
         KKl9s7r3iVWr8lBVUDl6M7YrHFeuES6dcGA74krglE+OY1KF9NjZWOi62JZjNkrkBvtP
         9rrHiSTFj15yFMbzivxDuzrrqg/kIu63k+WDe/Yo7hd8BVCXdV9h7/d/SlvIm64fDTNN
         p2eA==
X-Gm-Message-State: AOJu0YykZx2xr3t8ksBbazZ2j6pnvHxmUvbUxdfaYszRY9ZxU4n5+Ns/
	uXP3UL3Q3fRk7kbV8vt08VEWmZwl5adNCLMlZu/WuC5rz6PoiBTVfYjQSMYRheZaj0CopUKJ1dg
	UtXrncYrp2AQ3dRWuS5rFJWBnlXA=
X-Google-Smtp-Source: AGHT+IH+O2hXmPvD7FsYzfQc+AIyYt3af9s76c7TFeWmWSFLZjtA5nIgQLHN2ODlkyyVhjg1Dnm/YtGGU9O2ew8BiDQ=
X-Received: by 2002:a05:6214:5b8a:b0:6b0:71c0:cbaa with SMTP id
 6a1803df08f44-6bb98374cd5mr152702236d6.33.1722914956112; Mon, 05 Aug 2024
 20:29:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805235917.190699-1-abdobngad@gmail.com> <20240805235917.190699-5-abdobngad@gmail.com>
In-Reply-To: <20240805235917.190699-5-abdobngad@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 5 Aug 2024 23:29:05 -0400
Message-ID: <CAPig+cQehwONpjnjPVJEVvviistiSLODLNx-yFBusEPaihnf+w@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] [Newcomer] t7004: Do not prepare things outside test_expect_success
To: AbdAlRahman Gad <abdobngad@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 8:00=E2=80=AFPM AbdAlRahman Gad <abdobngad@gmail.com=
> wrote:
> Do not prepare expect and other things outside test_expect_success.
> Also add '\' before EOF to avoid shell interpolation and '-' to allow
> indentation of the body.
>
> Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>

When you reroll, it might be a good idea to explain _why_ we don't
want to run code outside of `test_expect_success`: in particular, if
such code fails for some reason, we won't necessarily hear about it in
a timely fashion (or perhaps at all). By placing all code inside
`test_expect_success` it ensures that we know immediately if it fails.

>  test_expect_success GPG,RFC1991 \
>         'reediting a signed tag body omits signature' '
> +       cat >fakeeditor <<-\EOF &&
> +       #!/bin/sh
> +       cp "$1" actual
> +       EOF
> +       chmod +x fakeeditor &&

It's completely outside the scope of this particular patch, but
another modernization which could be done in a separate patch (or a
separate patch series -- it doesn't need to be part of this series)
would be to take advantage of `write_script` which eliminates some of
the boilerplate-work that the above code is doing. For instance:

    write_script fakeeditor <<-\EOF
    cp "$1" actual
    EOF

Notice that `write_script` takes care of emitting the `#!/bin/sh` line
and the `chmod +x`.
