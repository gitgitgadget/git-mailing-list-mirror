Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29A938F22E
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012470; cv=pass; b=jC9qN703S20opa5+tuD9PCIY9DY9QS4tMIbzORcJpwW7rm191H8o8SltBN02Bx9J+mBR7OSzZx4s9hgpWqDBp8lXcDgyWcJYaM8OUkKbLbyjji3cZcu+RKeVUnJWjoufANrLl123NX+EbWmXEqxjVmxSo/ytsqjOuHwNqgueydM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012470; c=relaxed/simple;
	bh=XeuG3zQ/XaVIaI+5k0jYTrqx5L4nN7QgY02h9FgjkXM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEjWj6/ny285DIQqoUjcCvVEXAayBDKDntoPktZgaytTnUb1/lPPnj/QG4abr8UrtbKOmg+7wnbXvNsXZzGRQ4QhLnuyhLer+YlZxu7wLEUYg5/7Bx9mpKvimAA9xCnp7jwMyuapGpcE0f8bVzmCo9GlZRZ+XU5jXYa6vcnoiik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adTHBO5q; arc=pass smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adTHBO5q"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-567530bc03fso5276009e0c.3
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 01:41:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772012467; cv=none;
        d=google.com; s=arc-20240605;
        b=V/NJ4VwdKGXwjEj+2vQygq4/hWdedzSTgNGkYYVaRSTSQoPBoTo+Y+3RFRzKPO9uwp
         ppQ8cyCk1Z+4845FawmHeoDlTvzXPYPCfBZjOGMd9h27tk9KLDVJGLXvCtTzT/R2N7Hf
         XeVTyEftUXwCwdDJzs/u1kd56409XcE3wD13b/kMx7/0w/EnFKvvwcOP1OZMRDgVh9nE
         4j8zR0YpxnIrUghi194L3Amn95PqaP5mbY8DWcODD/Idg6Dm+MvEDpP01IYXfMbRkztg
         wbaqgs63Xwc+9QE/X3lrDvLUnSudG9clMnw1+V4RRHIRX8r1M9gfHqnkpHvRbtPubSol
         w0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=1HESsn4yb0CGmx4gbVOtO97dCJnYDtLatYxwwNl20Q0=;
        fh=7o792llG9EbTqV0Dsbyv1ts2cuNjwg+QmhZsoS26nig=;
        b=UhI7vqYpkdgK/iepOfmM1yy8aV+xgnctikSYtAk5gyjmvVBhscrfTY5HTA+ODpnyJk
         nGBXxNQzis/Wb3PBLS2aKNy3irLyYzUdJHApC7qGh9D8tL+NlbjCZjGINwj2rej9MPQ6
         H8ig5ed5dv1sxgVKu8420OZr6h3k7ua7BUXOJ47a2Jl/Opo/z2PaMhq9X1fBk76PoKmm
         pnpAMt5GcRZoeN1kQlpahlipZqGac4/VjzD23wzMbPtiepiYBzci7CZP2EyEs/b7h8FN
         dymjGFGxEADMPlIJtJuZQZ4EMoPtc96kQb0jyYb1+zceDg+6RAYa14A42B+StIPeYrCM
         PodA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772012467; x=1772617267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1HESsn4yb0CGmx4gbVOtO97dCJnYDtLatYxwwNl20Q0=;
        b=adTHBO5qze/ZSuEcu5EoW+ZEnSXp0GElLzU+5gkTiI12hsWrHuOcJISBdQnfpGCyUW
         OHP6PaSH62z3jPUSsWj/qvdC+RE1ihF8vjy9C8/n+jBdmO+fhTDinjfU8EVyHVmZDMWU
         FlG/HkWnQZSYnpYg/63D+hTJyLPhvDRfyqsYrS2VgGU6WPx5vlCXzzd16ghqCw7f8fDJ
         3tmbh5YU3/gNTlT+UmJEN+rT/x9M4O/trTKS1cLFqStTY8tpeDR3odYm18/df+7ezETO
         3SO8L4Pf/VXjU6c7Cvc0kNrSDbU9obzZIxGDLd30qZzvfeAApTqZxfiwXpSxlFJZZpWo
         mmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772012467; x=1772617267;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1HESsn4yb0CGmx4gbVOtO97dCJnYDtLatYxwwNl20Q0=;
        b=wMzqc/4iEDcxRAB7UHhFjjPmQr3yADcfF1vAuWcEC5w/C/Hw1g+OfT/u+OpX8dFvZA
         gfX9jRaoD0Y9hNccJZ2Z38lTjxaE+b75HJnKUQE2zGfTpfsX9kesEdzAP+u8Ex9nhnd8
         ojOyaXpUfwiI0A3sFAupsySHFS3S6Lm066DcRXCmoRrDB6OG5Szofg02ysolZAHiBcYd
         ga5+XVAsOLeytYjbkcw3CnBp6VVmJvo3/uyUAcJnksw/ULW+en3b6PYByyGryZ6Yqm1g
         PMvpEEFdBMa/O1mNBHOcIClRmQ6zNMCP/Dp/qz7oEHGEwLSugCTvUsiY/f6mZBrUcve6
         Q5oA==
X-Forwarded-Encrypted: i=1; AJvYcCVZt6lmZOvvZFjBINQChp5N4jZAYACyXGggmfrPTsazc/0zk6iImDH+kUTjcEW8K5Xc9CI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxudaHnfU1Bf5qP3YnCWuCZO3YsDCMUZ3UiV6vwMP9ugL3kIOzh
	Pz81qlPh4485MoFkYWJ00ZJEsP9vaJVo9Bez2XU254Ewgyxin7C2vzQCqQOmiNM/SAS1kaUh3FA
	bECEza6339MF0ifAM9Toe3uAAVjNdFXo=
X-Gm-Gg: ATEYQzzDiFnr9czY654WOqJ1a7a2fLHY8mVwZak3fVvBYcV6rGX66A6DYFSZJQeYieS
	ljJCN76wM4+06HjTWIIG4g7mK/XI68Ji7PamPgc9sch6JlVr5VUusshX+hnXrHzae90Jr7tNRTx
	K/rqnNMT7CpBHgehQFPzK97VawlxnWT534w/L1pkxatElubtDaR7wSYkNsiKFEV4rqb82fQzxka
	1QGDqAmICs0o+6apZiX51cWB2usPoGzH7Xhglbu+1tSndRSa8pK1xt7i2FrXCaEGeR6EhHDhCGV
	JTXscfrM4dkQ5SXACoGk2yfkIQ/RhCM5ifj/TQw+GB/SwxgaQuSp
X-Received: by 2002:a05:6102:38d3:b0:5fd:eeb6:c945 with SMTP id
 ada2fe7eead31-5feb2ef99bbmr7337280137.11.1772012467413; Wed, 25 Feb 2026
 01:41:07 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Feb 2026 09:41:06 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Feb 2026 09:41:06 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <874in5nr5p.fsf@iotcl.com>
References: <20260223-kn-alternate-ref-dir-v8-0-0509c132a203@gmail.com>
 <20260223-kn-alternate-ref-dir-v8-6-0509c132a203@gmail.com> <874in5nr5p.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 25 Feb 2026 09:41:06 +0000
X-Gm-Features: AaiRm53UrmaTOGHvkCZ77CbsQX9TwMW6vcKa_3L0Yy8mgu76RrKTFgF5RNna0dI
Message-ID: <CAOLa=ZQ54NpKGywvW2aVdZNmSFarkWyp97hmwB5Ou3K40FavNA@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] refs: add GIT_REFERENCE_BACKEND to specify
 reference backend
To: Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: multipart/mixed; boundary="000000000000a881f9064ba2cd56"

--000000000000a881f9064ba2cd56
Content-Type: text/plain; charset="UTF-8"

Toon Claes <toon@iotcl.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
>> index 9912433b8c..1a7b8eadba 100755
>> --- a/t/t1423-ref-backend.sh
>> +++ b/t/t1423-ref-backend.sh
>> @@ -138,22 +189,92 @@ do
>>  				git refs migrate --dry-run --ref-format=$to_format >out &&
>>  				BACKEND_PATH="$dir/$(sed "s/.* ${SQ}.git\/\(.*\)${SQ}/\1/" out)" &&
>>
>> -				git config set core.repositoryformatversion 1 &&
>> -				git config set extensions.refStorage "$to_format://$BACKEND_PATH" &&
>> -
>> -				git worktree add ../wt 2
>> -			) &&
>> +				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
>> +					"worktree add ../wt 2" "$method" &&
>>
>> -			git -C repo for-each-ref --include-root-refs >expect &&
>> -			git -C wt for-each-ref --include-root-refs >expect &&
>> -			! test_cmp expect actual &&
>> +				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
>> +					"for-each-ref --include-root-refs" "$method" >actual &&
>> +				run_with_uri ../wt "$from_format" "$to_format://$BACKEND_PATH" \
>> +					"for-each-ref --include-root-refs" "$method" >expect &&
>> +				! test_cmp expect actual &&
>>
>> -			git -C wt rev-parse 2 >expect &&
>> -			git -C wt rev-parse HEAD >actual &&
>> -			test_cmp expect actual
>> +				run_with_uri . "$from_format" "$to_format://$BACKEND_PATH" \
>> +					"rev-parse 2" "$method" >actual &&
>> +				run_with_uri ../wt "$from_format" "$to_format://$BACKEND_PATH" \
>> +					"rev-parse HEAD" "$method" >expect &&
>> +				test_cmp expect actual
>> +			)
>>  		'
>>  	done # closes dir
>> +
>> +	test_expect_success "migrating repository to $to_format with alternate refs directory" '
>> +		test_when_finished "rm -rf repo refdir" &&
>> +		mkdir refdir &&
>> +		GIT_REFERENCE_BACKEND="${from_format}://$(pwd)/refdir" git init repo &&
>> +		(
>> +			cd repo &&
>> +
>> +			test_commit 1 &&
>> +			test_commit 2 &&
>> +			test_commit 3 &&
>> +
>> +			git refs migrate --ref-format=$to_format &&
>> +			git refs list >out &&
>> +			test_grep "refs/tags/1"	out &&
>> +			test_grep "refs/tags/2"	out &&
>> +			test_grep "refs/tags/3"	out
>> +		)
>> +	'
>> +
>>  done # closes to_format
>>  done # closes from_format
>>
>> +done # closes method
>> +
>> +test_expect_success 'initializing repository with alt ref directory' '
>> +	test_when_finished "rm -rf repo refdir" &&
>> +	mkdir refdir &&
>> +	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
>> +	GIT_REFERENCE_BACKEND=$BACKEND git init repo &&
>> +	verify_files_exist repo/.git refdir &&
>> +	(
>> +		cd repo &&
>> +
>> +		git config get extensions.refstorage >expect &&
>> +		echo $BACKEND >actual &&
>
> Shouldn't these two be swapped, like:
>
> 		git config get extensions.refstorage >actual &&
> 		echo $BACKEND >expect &&
>
>> +		test_cmp expect actual &&
>> +
>> +		test_commit 1 &&
>> +		test_commit 2 &&
>> +		test_commit 3 &&
>> +		git refs list >out &&
>> +		test_grep "refs/tags/1"	out &&
>> +		test_grep "refs/tags/2"	out &&
>> +		test_grep "refs/tags/3"	out
>> +	)
>> +'
>> +
>> +test_expect_success 'cloning repository with alt ref directory' '
>> +	test_when_finished "rm -rf source repo refdir" &&
>> +	mkdir refdir &&
>> +
>> +	git init source &&
>> +	test_commit -C source 1 &&
>> +	test_commit -C source 2 &&
>> +	test_commit -C source 3 &&
>> +
>> +	BACKEND="$(test_detect_ref_format)://$(pwd)/refdir" &&
>> +	GIT_REFERENCE_BACKEND=$BACKEND git clone source repo &&
>> +
>> +	git -C repo config get extensions.refstorage >expect &&
>> +	echo $BACKEND >actual &&
>> +	test_cmp expect actual &&
>
> Same here.
>

Makes sense. Will amend.

--000000000000a881f9064ba2cd56
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8e9e23bc9a69e9bb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tZXc3QVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meHhrQy80OVNVQ2J3VHpDZkJrMy9UQ0RlZkRjMC8vcQpOWGsvVkhNNmRa
aEtWZC81Rmc5dDdzdFVZenVhNTQrMHdqSjRGeExwUjRhc0pBWDdveWRZTVRaN3liK3ZlaUZ0CmpB
clRoY1gzZy9jbkkvRlJzb2FRN3o0eC9FOWhncHFmZWRrNmV0OXM3WHR6RHlBSnAvRnVGd1VLVUxJ
SEptYloKWGYxQlZVWERxQ0Vvd1l6TjNwditQV0h6TExLa1dmOFFyNVRWakR2VjlMUGlza1ZrV2Zq
bDR4T0FJSmxabitwWgpJaUdVYzJoRTl2aEVxajd6MjE4ek9uY2N6bTlpWEFZTWx5VHc1Z1hXN0pW
Vm5oZUxGV0MrQWZncnRPWWtWekVBClVta2l0UDV1RjVXajg3SDQzMmtQU1R0MytwM0dXVmZ6cHl3
Wkw0NUlHR3VPWW15b3pZQ2FFMkpmWG9JcFU2VGoKNnZCbzEwOU9MNlRkNU8vcEFRSXp4N1RDU2No
bGdjeHNSSVY1RmdKL2phelo3eFB1WkZLU04xamRyOE5BWmhLOQpGLzd3WFp6a2NQYUUvay9SVEpB
ZSthZ2FzczdHZlozeDVCT1htT1lQTVJyVCtrWjJGMHRRMktNM1FHVGdKeWNzCkp2eExKWTZ2OVZ4
Y2g2U00vT1NDSXk3a2hBb0xUVEFrMEYwVW11OD0KPTN0ZVAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a881f9064ba2cd56--
