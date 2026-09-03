Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775AB38F630
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788459780; cv=none; b=WXGeesgX6k1MmVwgY8YMNy83tvyNJjVpZ82GdZfcAfjMU5nsRRZfPUYZD85KD8UjXQVkueFt7wKnbspKl0gD0rddh4gETrVr5Rg0BqNN4uXGr0DRbItEIm5PmhGiV24i9LRm5aBtP+8LzQ0S3/Vw9mKmpnjBFBTMFQyazCIxctY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788459780; c=relaxed/simple;
	bh=9y4iy+BxfQSKf1+S73dZP6Yh4deSpAKIHo85xYU6sfc=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=bFdC+OL5eORDWU1kLzpWNQ5TM4kVTDazg3D8Jm1jdEEgoPq38+R+X8KXaUduapXSraoUEND2RjIfYkJS1ycRLpt7oKWZPrSUxTPJkwaApfJhZ3iJSMTcQK2Am5RqpjcDrSIFM2uYmS3WkJDTpSQxiUWdBtoDQAWGIdh5bv64a7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEbTV1xv; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEbTV1xv"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-864cd11a932so15554827b3.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 11:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788459778; x=1789064578; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IxghaF29vG8TeagbxWa0lNhXAA1RWW9qYSCUrHgaEO8=;
        b=HEbTV1xvIjUrYYzmTiNuwu2vjzG6KhAPFdNvOxOjUIHda6nqsxl8muNDrFVX3TppFv
         cxfFBqJ8RWCD+TPnCMvTfQbKAH5/e1UsqHcGyyLfVf3oJc4DCsO9uCAEsy4tGuUmD0Gg
         v/svi5BqZyIRhouMfk6X9omjaN4pt8M3CqyFzImL/R3+oPjuavwAgGdrxCxzPZ6aD8zF
         IAVvdQLufc4/WuCszQv37R8e3/znMoGdDb/6TFHfgJr/UCJJZBs9gEMft9cyQ2Qd0wDs
         v0TBCUJDu6hmYSLmUUf2OqYGZkjjJ69JxdtY9Dgw7lM6A80wXcoaiVDHXwFMOvWgKVg4
         e4ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788459778; x=1789064578;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IxghaF29vG8TeagbxWa0lNhXAA1RWW9qYSCUrHgaEO8=;
        b=D9S1QV1ByVt6jXi/bLKwN2eoR3e2Y4SfFMyuJsMlSgbRtyW+QLfhKedNOX+mihH+ee
         KnJFWS5Spww77jjAqufAsTvaAi+QhlrzZHVq0nirPfLDiKQEB/CXG6pIW37jC76VOmRU
         u8fkLRpTOdTkYt4VTxzbTCo7J1rK+Av99uCHlL2992j9XQMaMEX7QOjylUNqgeDio5q1
         9pHdQAH1McJRxxZJ3hkOknU4loP6V9nVqxiHY4Wx3Z2YXh1ebzzAICYTIBjgfKiyg699
         Bc4+yWJli6w7UB3wXR79sNjCb55u0p1xKxVAHwyC/tKm64MyEiQjKy3CTnXPwMbd8Szc
         g1uw==
X-Forwarded-Encrypted: i=1; AKwUvBxtIDl7h2g4DeCkk9P1PpCjavwdpXh4/tNg0SHjy+jq29twmHLw0nyDtnxGc2qP5di0o8A=@vger.kernel.org
X-Gm-Message-State: AFuF++lxnLm1sT0Nav5J5j/4dUBM6Hg4uIfYmTXDdx88YVu2x+ApPXoL
	hWuuX8rG69jqi5YgvZhrOhEFdOs8Z9AlpfEvF4Oo5DiJyXS2mbMWDuIo
X-Gm-Gg: AYBFou064T2dbuX53vaxyYuY8v3xlshXr8ljjXCfSxNJsPMoNxqo6fCWhE4Skf/LCE3
	QyTMWpHWj7Im+E6lEkbtfrYvNzzbpE0Bj1ch1bD4yX0Oj7nkdx2s5EUySf0MiHWfqERDlvOLwdz
	hl4P9RZLbj1nfYPrJVupBV7bkB+tosXTMkUItKywu8zIXEeTA/0sWeq57unNM2yNizrx2fPVzZB
	mAB/4hg3kS2CyZi/rrEusjcit+NXe9vvzP0fiPbnxwSRn/WNipBJsETEV2tXoNZHNnZsV3NafzB
	eKsQYY4Xp2mcxpkPuoWun7ysJxXwC1Ui7HGKedKQHgXwTL6Y1POt1bYzDW1RX4tOON0/eSaWc7m
	kbMSXXmaBf3kAlTD5lysyXelGnzGVdWo96DeBeycmGXRqoPBKdflHoD6I/76UEVw0rYiSTyJ2I1
	rYNIv9l0aK0RyGZzvesLbWOrYRtPmCcDkGjVvvQ69iT9IcnktgBUDDBSCVIrgneKXRQDbFHfFad
	yEKfRROSTJxzpMKGt5XffPeaf0kmRXrv4eD39WZlRPDituxWSi6C66RbsTqGvqJPPJbLrDO3DkC
	CWxsQPxd8y84Bex6fKW7TSQ/DVqwz+RjiGLEnA==
X-Received: by 2002:a05:690c:e153:b0:80c:16ad:2f16 with SMTP id 00721157ae682-86e6e13be1cmr38790307b3.8.1788459778169;
        Thu, 03 Sep 2026 11:22:58 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:dd08:3986:f73c:a217])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-871439c4566sm1583867b3.4.2026.09.03.11.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 11:22:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] var: support broken-down idents, default key, multiple args, and -z
Date: Thu, 3 Sep 2026 14:22:46 -0400
Message-Id: <D27B3BE0-56E7-4388-9324-C16E2AAE2498@gmail.com>
References: <xmqqbjaecjxb.fsf@gitster.g>
Cc: Andrew Pleeter via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
 Jeff King <peff@peff.net>, Andrew Pleeter <andrewpleeter@gmail.com>
In-Reply-To: <xmqqbjaecjxb.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


> Le 3 sept. 2026 =C3=A0 14:02, Junio C Hamano <gitster@pobox.com> a =C3=A9c=
rit :
>=20
> =EF=BB=BF"Andrew Pleeter via GitGitGadget" <gitgitgadget@gmail.com> writes=
:
>=20
>> +    if (!vars.nr)
>>        usage(var_usage);
>=20
> I do not know if this is friendly for a tool meant primarily for
> scripts.  "git var foo bar" would give information about foo and
> bar, "git var foo" would give informmation about foo, and it is
> natural "git var" alone would give nothing.

I believe =C2=AB git var =C2=BB prints usage and exits 129 today, at least o=
n my 2.55.0.340.g8e2bf96aa5.

Lifting the limitation may be sensible, though I suspect the empty case is l=
ikely to indicate a logic error earlier in the script; either way, probably o=
ut of scope here for now?

> This matters because it is plausible to have a list of vars in a
> variable and then run "git var -z $variables | xargs -0 ..." to
> process the vars and their values.  If you barf for an empty list,
> then they need to see if they have nothing in $variable, which
> becomes more than "test -z "$variable" because people often take
> advantage of the fact that IFS is ignored to write their accumulator
> like so
>=20
>    variable=3D" "
>    for n in ...
>    do
>        variable=3D"$variable$n "
>    done
>=20
>    case "$variable" in
>    *" "word" "*)
>        : has the word
>        ;;
>    esac
>=20
> which means that $variable may not be an empty string.  It is easier
> for scripts if "git var <variable>..." did not barf when the number
> of <variable>s happens to be zero.
