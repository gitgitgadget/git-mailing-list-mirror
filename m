Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274611CCEC6
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 15:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729526195; cv=none; b=Hh3+1AOpuBdXIlQ0kvndNmRo0lir7jt4WEQQvVpBPURzuNhD/oo8GoqLp736bq9PPQSZoGIkeMiDdEDE31EljrKB1lp7Zmzf4PtPPcZfbYL6Hup72yDXiRH598wOCV7a47FZjei9QLMYLG9yx7x6k/Yyu/a04aI95awe8cZMF+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729526195; c=relaxed/simple;
	bh=9OoBnH/OWO95Ow0jtRi4HWkV9sc4uBm98voPWBauDGo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6ZhH5e8ystE+OY/3VmbQBHpL3sAYJk2pU1bkPjOvxHoEgyJKDIx1vELZE/RteRN5ipYvcdkNuwLrCWx3afHhZT9Gd1EpiQzmiLyEahnLq2ekTAKAPFp/6UpY+Lny9DD/3D8OPEnyI/j+tw0rnTHR1wBju33JGklnr5qyfyti7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKIYBb54; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKIYBb54"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-4a482cb53bdso1524962137.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 08:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729526192; x=1730130992; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vfbNlPJ+lR/rxwqztYXmVq/8dK8ypU4Rw0hhh9A3NvE=;
        b=EKIYBb54XQrqPk7UEm4EfCSfUmU7YKTBwaq418EPxW3do0Ua3szGiq+j3W8ojfyDtI
         NC8gb6V2EGNQ5gVjU/9a5c4K2D9Vkuq8jKhg9JoRcFyJqWIphE014R1ERmRQzbk6siBD
         KrdJutearMO1DYreYBzra8ownnfnAsOO8onOQ9a5we9qQxX2WUr0LcCbRH2iMNy0Y8nc
         7IO6ZjSpmLdJYC/gzLQP4M4sced9M52ttiZkQu6L+7d/4KrNPv4FNQ1IGNb/u81iNATQ
         rn5KVBr0GpoNJMDt7+Q57iVFIcuRNg6bcMEocpMbFGaK0pfChnFfYniJemOQzKj7qMdj
         /vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729526192; x=1730130992;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfbNlPJ+lR/rxwqztYXmVq/8dK8ypU4Rw0hhh9A3NvE=;
        b=m1ZglqaJBo8fuXLdPUZM5E3t3CayI78S2SiXGVnjx+bzp6KlQccMEm3ZE9M0bjr+NO
         TP4qRInSNsyOv3OOPcLzU90nHkPkooGmUAphd048Rb6Uf65WlYhSbe8/pWOTX9iC/vxe
         UGV0pv6sm0hQecCCK1wzs7JYLmKcbbeAXMJTFQQ2mIxrpjqL9Nhd1bcOK4r6exBog65w
         RUL2w+q8V1UV+/h73eg45k3EkZSa0lEuss8bX9fJsGHrK+Wpht3I17lvNRq2FL+4VGBQ
         JNxSoZvSlYS8STgFSUWSb6zMPT3qma46IVnMujNjn6gZL1cNoviCpPzYvav76Hlpx45s
         ezrg==
X-Forwarded-Encrypted: i=1; AJvYcCWiDyN3z0WO0mw/QHvc9yKzv4TaFsKvPASAVszxvdL0XEbGd/9PpWkz2SjJs9EETy7k6Go=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxRUoIgaTevfuIPo9NBEab/rKTxzzRJCsaF6MBKXnnY0kR2pD1
	LJ8SCNpiVV5+eE9cBfXMlpxNCXQp0OtP5AlgCKDPh+JlYrxK948Wfeu5eatq/o42vMOa4mv09gF
	ZGCjwg+XRASq0+AvTyMMNFNmlMTQ=
X-Google-Smtp-Source: AGHT+IGIstGl+EeZAOHRTZKGCssVK/5aHQX3To/Ev3b5uo8g2AujAWZbEhNS7z7Aqhek6LsklhUWkO0dNQQVorvjHso=
X-Received: by 2002:a05:6102:2ac7:b0:4a3:cf4f:e19 with SMTP id
 ada2fe7eead31-4a5d6bebf88mr8044745137.24.1729526191974; Mon, 21 Oct 2024
 08:56:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 21 Oct 2024 10:56:30 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <ZxZYcPwLB5oLTFUo@ArchLinux>
References: <ZxZX5HDdq_R0C77b@ArchLinux> <ZxZYcPwLB5oLTFUo@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Oct 2024 10:56:30 -0500
Message-ID: <CAOLa=ZSGuBsLxUaA_gvXrYzR=Abzno5PEMZZD+dAs_smcyoqLg@mail.gmail.com>
Subject: Re: [PATCH v6 4/9] ref: support multiple worktrees check for refs
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000004d9be90624feb22a"

--0000000000004d9be90624feb22a
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

[snip]

> diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> index 0aee377439..6eb1385c50 100755
> --- a/t/t0602-reffiles-fsck.sh
> +++ b/t/t0602-reffiles-fsck.sh
> @@ -105,4 +105,63 @@ test_expect_success 'ref name check should be adapted into fsck messages' '
>  	test_must_be_empty err
>  '
>
> +test_expect_success 'ref name check should work for multiple worktrees' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +
> +	cd repo &&
> +	test_commit initial &&
> +	git checkout -b branch-1 &&
> +	test_commit second &&
> +	git checkout -b branch-2 &&
> +	test_commit third &&
> +	git checkout -b branch-3 &&
> +	git worktree add ./worktree-1 branch-1 &&
> +	git worktree add ./worktree-2 branch-2 &&
> +	worktree1_refdir_prefix=.git/worktrees/worktree-1/refs/worktree &&
> +	worktree2_refdir_prefix=.git/worktrees/worktree-2/refs/worktree &&
> +
> +	(
> +		cd worktree-1 &&
> +		git update-ref refs/worktree/branch-4 refs/heads/branch-3
> +	) &&
> +	(
> +		cd worktree-2 &&
> +		git update-ref refs/worktree/branch-4 refs/heads/branch-3
> +	) &&
> +
> +	cp $worktree1_refdir_prefix/branch-4 $worktree1_refdir_prefix/'\'' branch-5'\'' &&
> +	cp $worktree2_refdir_prefix/branch-4 $worktree2_refdir_prefix/'\''~branch-6'\'' &&
> +
> +	test_must_fail git refs verify 2>err &&
> +	cat >expect <<-EOF &&
> +	error: worktrees/worktree-1/refs/worktree/ branch-5: badRefName: invalid refname format
> +	error: worktrees/worktree-2/refs/worktree/~branch-6: badRefName: invalid refname format
> +	EOF
> +	sort err >sorted_err &&
> +	test_cmp expect sorted_err &&
> +
> +	(
> +		cd worktree-1 &&
> +		test_must_fail git refs verify 2>err &&
> +		cat >expect <<-EOF &&
> +		error: worktrees/worktree-1/refs/worktree/ branch-5: badRefName: invalid refname format
> +		error: worktrees/worktree-2/refs/worktree/~branch-6: badRefName: invalid refname format
> +		EOF
> +		sort err >sorted_err &&
> +		test_cmp expect sorted_err
> +	) &&
> +
> +	(
> +		cd worktree-2 &&
> +		test_must_fail git refs verify 2>err &&
> +		cat >expect <<-EOF &&
> +		error: worktrees/worktree-1/refs/worktree/ branch-5: badRefName: invalid refname format
> +		error: worktrees/worktree-2/refs/worktree/~branch-6: badRefName: invalid refname format
> +		EOF
> +		sort err >sorted_err &&
> +		test_cmp expect sorted_err
> +	)

These last three loops are the same, couldn't we loop?

for dir in "." "worktree-1" "worktree-2"
do
    ...
done

> +'
> +
>  test_done
> --
> 2.47.0

--0000000000004d9be90624feb22a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ca44b68f330815fa_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jV2Vhd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNG80Qy85RVVMMmUzS1dWc0RUNzdacW5IK1JNZ3M2TQpydzUvNnA5MlRW
RXRKbnVmZjY3SDZhWWw4VmN4aFJSQXAvTm5uZnpKQzFrVTN4Y3FsVVNKOThTMDBmNHJTaVMxCkdi
RWRnQzc5V29FLy92bXdwVWpmTHkyYlpOb3N2YzR5QVVwMWtvaXQyN056QVFkNjlNeGw3ZG5Nc3lw
aElxd20KRjY4aDQwUDlkME1SWkZzVjUzQm56TkJUb003WW1CRTlkN1NiZXlvMzBxeDZzSkZUQWYz
aXZqMXVCbzNxNTByWApQNlZaeXh1OVZiZGlwZHVlZGRBQVh2dVFsT0pGUloxN0FCZEZsUkFETjk1
OEx5RFZqaG9VUG03d2JGVlg5cFVLCnRpZGR6TzZWaWRiSGF6R3Uvenp6Qk5JU1pLRlBtajRyTGRB
S2JxSXZPN2hQQjBoTFlnUUFYZU1Hb1M4TVYydTMKcG1YRXBUUTY3dWxHL1E2NGZZMnR3TTNSbVRj
U3NWdmIxb0dUWlJUVTdiNFYxWUhTVUR6WXpFSDZERzRsdGczSQpIM0Vjc3FDTUV1NGI5ai9BaU1z
U0FHUkNWaWMva05ocnhYYzVpcW5qL0U4VUh6akZCaVV6TUlsYlZtSHB0dmJZCjZsbk1PeUwwT0R0
TW5FcHh1UDQyMWhwZ1U1QnJDVllMaGZzaHZaST0KPU85TG8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004d9be90624feb22a--
