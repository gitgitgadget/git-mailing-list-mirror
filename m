Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E2A18E363
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730799810; cv=none; b=RDUIYolhsdtFHaKzQLqQhgOrG1k8X5HII4kKIUEM9Rb1Fo0lQXU0n1krhbY/BxEH/q0p3cUuIEo7gwz+5ZB9OtS0e5kZj65cIAhfR5n6zYJmZh1FL4QANBSThqubOLDliWF6GzVLTn8uMyyLYqi0Ac7i4FtchsB5K86h5XoQN3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730799810; c=relaxed/simple;
	bh=MTA1sWvYxlnVmi59Q+ZCscvwBsiJAj7ozgGkRYuuWs0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RnLiYWSNQk40gOrbRm884kkppdiVtSI0t5gLR7OuILX3hg3HH686em/jnx8t8UfhgnHkBIcs2a+IKLTm5jVpxUL5Xu61CukJ1R0oh+k8r/9GztUFC+V3ezKRVzb7Z2nSoPw70/JfMwHdqyjM1ZdLwaXP9durrD07GXAazzfyQRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXnmd0Am; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXnmd0Am"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-50d3d4d2ad2so2231200e0c.0
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 01:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730799807; x=1731404607; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vq6USQoX7Xu2bLJ3WgYELVuUsQPdgwtwdtQ0P7s3HP0=;
        b=QXnmd0AmbMl0ovcZcwlrm6A0XM99r5ZA45fK/Y+RKABAOPubJt0kn6Fg1XiUfseA/d
         KYQadwlrZXfe/4YpHPMUNqEdDpAu4jZs89YILkXnIdQCpgUMQvCIP74hPH7xGFR+/gw4
         9Pn+n2HZ1Kymy8tnetYBXEtlktmo9FgvTbePGh5R81IteOVSZYVAafF6udCOHxKhoPyR
         UU9HKzWLuoRlka8yb88Nq3Z9b7+l/1HONmG8gqUs8Nx/zKHaPAD3ENr6tgoQ9bMGMIiI
         ECI7Fl6UuqKNsAUMttr8JRziwgMRjS+NfjMOVDaAn3t/LYOVNGH0D7Cqv9CmPnLDAQeK
         WMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730799807; x=1731404607;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vq6USQoX7Xu2bLJ3WgYELVuUsQPdgwtwdtQ0P7s3HP0=;
        b=ACbrVMLJYihHBKhH3zDgUcprZcHVEfei2BN4mWfrQ8I1Zub9ZQve0gAS6zGhaXVklz
         CcUi+Phgqa0uYrTfeT1zNeoBNO1guL0x6PDK8SxFeLzaTlQVWdQN4fKm3WtCSz1RVqlz
         SvnaLRp1WRCRPSd1cAWu68lNYl/sDgU/tUniPiV1TNc77z9c2FLHftM6DcBJGqB+TYyu
         dUazveiyBo9Xe9KnPpfSmfz9P/Y1GAX7e57JrVx+WhiU4RrIW9C7/WPzXuPr7+94qMbl
         hrG9xUYO4QiqpZ/SwNr8jwlBL0Oci+wjuw5BCly9e+iTKNI+BPUGMI5M1RPYhDUhUcff
         KE+g==
X-Gm-Message-State: AOJu0YxSMJSIdJaJZPtFtUXwoZZilBOFX7Ix/vrpamZwTQNjmTbS2Cvh
	Fp2wEkwhB/+lQEFYjWnevgTQP/MlSlCmj2I+oEBdpZBR94Kx4dCxQMQUimkEuj9O3FvzscYqW5e
	CdAguHkXiKh3TdSuIK+5QIbOy/qeVRIhc
X-Google-Smtp-Source: AGHT+IHkfT1O4JL3mGTxsxB5qha12OoEGUN5+b8TPQO82kIGjAFL0vfZo5WvsKqP2bZzwmLdTQ0BAQSwTN0NeDruPKU=
X-Received: by 2002:a05:6102:2921:b0:4a3:d215:427f with SMTP id
 ada2fe7eead31-4a962f7cbc8mr12239508137.23.1730799807587; Tue, 05 Nov 2024
 01:43:27 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Nov 2024 03:43:26 -0600
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <20241104173218.GB2989472@coredump.intra.peff.net>
References: <cover.1729504640.git.karthik.188@gmail.com> <cover.1730714298.git.karthik.188@gmail.com>
 <20241104173218.GB2989472@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 5 Nov 2024 03:43:26 -0600
Message-ID: <CAOLa=ZR4G52kZt==80xNiEvRAabNHUMC7587qqwAuD6snLGAXA@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] packfile: avoid using the 'the_repository' global variable
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, me@ttaylorr.com
Content-Type: multipart/mixed; boundary="000000000000b58b6c0626273b50"

--000000000000b58b6c0626273b50
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Mon, Nov 04, 2024 at 12:41:38PM +0100, Karthik Nayak wrote:
>
>> Range-diff against v4:
>>  1:  b3d518e998 =  1:  6c00e25c86 packfile: add repository to struct `packed_git`
>>  2:  bb9d9aa744 =  2:  70fc8a79af packfile: use `repository` from `packed_git` directly
>>  3:  d5df50fa36 =  3:  167a1f3a11 packfile: pass `repository` to static function in the file
>>  4:  0107801c3b =  4:  b7cfe78217 packfile: pass down repository to `odb_pack_name`
>>  5:  2d7608a367 =  5:  5566f5554c packfile: pass down repository to `has_object[_kept]_pack`
>>  6:  2c84026d02 =  6:  1b26e45a9b packfile: pass down repository to `for_each_packed_object`
>>  7:  84b89c8a0e !  7:  7654bf5e7e config: make `delta_base_cache_limit` a non-global variable
>>     @@ Commit message
>>          this value from the repository config, since the value is only used once
>>          in the entire subsystem.
>>
>>     +    The type of the value is changed from `size_t` to an `unsigned long`
>>     +    since the default value is small enough to fit inside the latter on all
>>     +    platforms.
>>     +
>
> I think this change is not ideal, for the same reason that the other
> type changes were: you can conceivably have a 4GB or larger cache here.
> On Windows using "unsigned long" would prevent that. (On most other
> systems it is OK either way since "unsigned long" and "size_t" are
> generally the same size).
>
> I do think the config parsing should change to use size_t here (like I
> mentioned elsewhere in the thread), which would fix it on Windows.
> That's outside the scope of your patch, but in the meantime we should
> not be making things worse by moving the variable itself to the inferior
> type.
>

There is a subtle difference though. Both the configs (this and next
commit) although are initialized with 'size_t' they are bounded by
'unsigned long's range, since they do to the functions used to obtain
the information. The only difference being the defaults, which could've
been greater than the range of 'unsigned long'.

While having said that, keeping it 'size_t' makes it easier to know
which configs need to use the yet_to_be introduced 'size_t' variants of
the config parsers. So let me change this too. Thanks.

Karthik

--000000000000b58b6c0626273b50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bba6ede4348fc52e_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jcDZMc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meTk2Qy85WUZ3bk0wUWw2Z0YyNjNDR1NJQ1JYVEdkawpEWVBTenRibldK
azhhTG05aC9EQzJOV3JMbWM3VDNFMUwrOHBTS092ZXNyOWNZamxvQnJtZGdQQWFsdk5hSXJJCi9T
WlBrdkk5VlhkM0dGR2pqK0VaeThQdmNTZWYxQU5ZdnRPa3RsZm04VXJla1p3VHUrdEtPTTkzWGRR
QnhsaDgKeU4vYVVocWg3d3lkcU9qOHBFN05HK0RBMU1uelVEZ1NobVNvSEpBUU9GaEd4eUllRThY
Zk8xbTZmS1dMV2hkbgpmbU9IaDF2aXVESEhuSHBkMzU4KzJOZHJQTGxGb1Q2THZjZUx5aElYOHp4
UWFRZUhOQVZHaG5yM0xrMG1SdjBkCjJ2dHNTWVQwNmhtaUdoaUkzSkMvRzI2ZzUzcGNZTmx6Y0tu
cnNxZFAxcU1vNEQ0dWl6UUFiVEkxSDV2OXgrWVAKYm55dWlTQml2YWwzeXhkbUhSQ2YzbHN3VW9n
SXQ1MlR4T0ZPZzI2ZlhvQUNERmpuVEZWcmpwTnBaeUZJdUpiTAp3QjJZQnpwMExnNWRKVGRLN1N6
MzVnY1Y3SW03VFZBVUxCRmxvdkd4Q3Q0ZllrU3BnTlNmRy8rZlQvcGM5MFBaCnEvcVBQZmtjS3g0
V0JQTVltd1hlcGd6VzkvYTlFUzlZcjlBemxTcz0KPVppeWcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b58b6c0626273b50--
