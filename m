Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7EB1F1304
	for <git@vger.kernel.org>; Sat, 25 Apr 2026 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777137656; cv=none; b=EyENP9y/N9f4Vu8APxJKD37i+kcD0sCjYjgcituG7P5WWbV4UCcWAqu4pOP7NAy+tH6P66gF9p2Qn4gP/dcPcPTsZNcZczf8zEywL5JiAceOcVC+7YgMTVHA0i/Vtd2RomfTHbrxvfR+J8b8VFIaPbIzaV6xYFo9+LwZOraCI8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777137656; c=relaxed/simple;
	bh=vVc5IcYb4xKXRWDJS+hPfpS+9RTh9NZERWk56fmyEZk=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=UbZFRkojbIyXLDiJpkUaHt9g5lZ/ViITCMpp4T5jtFEwm1Lap28sTDgI1rREsFAB20WD+/aaLpxtx9+cFNPNNiKywu3fveDhd/qTqb39M2WwQvANnUaa08DI/Tncbj/esb0xyoaCTP8bOBzjK3c54/Y4r7GG6bLLE43uPA15EVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvD7Ns4f; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvD7Ns4f"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64e87a81639so7994158d50.0
        for <git@vger.kernel.org>; Sat, 25 Apr 2026 10:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777137654; x=1777742454; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dp6ufvY3MefA6manh/OUbstIiL4sLMWKjfdsUZxbvR8=;
        b=JvD7Ns4ftg5ZhJnHM3yTWdbI7Rbr6iP2z400GhkVT7SYmQ4DskhvD+gJhY0J/O3WSL
         6QwrjJsfTS56eERo2uTjs9O2znNKgRRhFw82IONv43kR/JtaSAhSOMtejPXgypfKE7BT
         /fXxt12sLpZ55CNUQ3Vu9TAGg5YgPmJ4h4DFcGNSK18qgsi4KFJE3Seovcwryo5FEefY
         z6h7iGjvNJOy3uCEXDKfzaM0d2So8jvs4rJJ7fPnSudBAi0gtR55qh77LTpT4Muf4oNH
         W39yappyo10bQeNpQhTE5HBJGhLutn5io3XTJnPVMR+xMsLH8lDr6mUimkJh/BmCuhYk
         IDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777137654; x=1777742454;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dp6ufvY3MefA6manh/OUbstIiL4sLMWKjfdsUZxbvR8=;
        b=N0vHyiWf2cnBEAvFS4SwsgARTizT6KVliNymihmegXklu92AZWjNgml85bakUBbJZv
         zzTJmyrHON/0h/WFv5lwVCl81SxBjaWNQQUciLNInQTvv7A1gbfPc0RJhAUeU8A7jmUY
         6QZnKjeskDHEfk/Hypg+ka/fU/6t1t0UDICSTIY1HiB0shiO6Gp6G6Vx5MTsWvVI/Y2P
         mWevrppoI5ItXtWDjApfpQNIOQt+BhWM/How7m+vonil0wU8lvZcMIzxNSKy+by591ms
         KxNG+NVwNlAMmk/MTaaGoYNZh5dfbEFoTiqOOLewhRdbYh7GTCwSmRIPy4XymUw67LE3
         485A==
X-Gm-Message-State: AOJu0YxkANeHlf/y24kjn11QMv5wKzZ1DSbrW4AKkMI8PT+6ms6RGNnI
	Iej+6d82xEqcu1rwzuqxInTeLkqpOe92GbSsdwjjfrd73sHfHyQsmyRx
X-Gm-Gg: AeBDies+s977lMoLNPlYs8avtK89sC2SKchx1zO6FYiQ6B+vIhwXJmj+0PUMB9NAenh
	ZkU3WNrS0PnTSQKXbzcgjvDIyU9QmsGC06Iro0Zquhyj9inMnaf3LfEe5hX3uyr4DzMV5zQNtFI
	ArfTiDy8BrYbOUsaBC/slL1RYvOaAl703T+h0VMGVI84P09iQB+I3tMdpTCRBlMzSEHOJZOYwzi
	jE8aIJ53eD2JKRMHJjhWypyofjDSnG7K2ukYhHPxvb7ohazLMeIU02+Y7idG1UwinTCgJGNk1S3
	ZCCdkuHf13pn7tlFgMrdeqtXUx0a8qRZS65VMEdKgikkKw1Yw2XLbtppI2KPwQ8A9N+q+dbwOxk
	tzZDYoeZoRXcFarz9xXCwCcKGI/Y/YtcJuzKvwQrNmd/Lis4sAon7rDb07KecxYByTpf638Uk0k
	Dl00dxFuywOxqyYa4FGezIF6yh5lo45BdHCHcDLuiJ67vrdgwl5hURqaAG8Gs58EK1AnyQA3BRB
	1haQz+OgPfQatRnIcslZ2Aw43AcqrfC4HzbKLiktIVpXHnIJHD43bE=
X-Received: by 2002:a05:690e:d56:b0:64e:c506:6fb4 with SMTP id 956f58d0204a3-653107f2a41mr28173698d50.9.1777137654040;
        Sat, 25 Apr 2026 10:20:54 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:89bf:c6d2:553:2cb4])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65314ea3ee2sm11930957d50.16.2026.04.25.10.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 10:20:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] remote: add --set-head option to 'git remote add'
Date: Sat, 25 Apr 2026 13:20:42 -0400
Message-Id: <6F9060F0-20EB-4B60-8677-86DA2AB39B35@gmail.com>
References: <pull.2283.git.git.1777115978088.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
In-Reply-To: <pull.2283.git.git.1777115978088.gitgitgadget@gmail.com>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (23D8133)

> Le 25 avr. 2026 =C3=A0 07:19, Harald Nordgren via GitGitGadget <gitgitgadg=
et@gmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFFrom: Harald Nordgren <haraldnordgren@gmail.com>
>=20
> Mirror the behavior 'git clone' applies to its first remote: after
> fetching, set refs/remotes/<name>/HEAD to the remote's default branch.
>=20
> Equivalent to running:
>=20
>    git remote add -f <name> <url>
>    git remote set-head <name> -a
>=20
> The new option implies --fetch.
>=20
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>    remote: add --set-head option to 'git remote add'
>=20
>    When using GitHub's gh tool to fork a repo, it seems that set-head isn'=
t
>    run on the upstream remote. So its default branch is not recorded
>    locally, meaning that 'git log fork' will not work.
>=20
>    With git remote add --set-head upstream , the default branch is set in
>    the same step and things can work out of the box after a small change o=
n
>    'gh' that I will do as a next step.

I=E2=80=99m not totally opposed to this convenience, but couldn=E2=80=99t we=
 also just teach gh to run set-head as a second command?

(Of course, it will need a version check; if memory serves not all Git versi=
ons used in practice have this command? But I am on mobile and have not vali=
dated the history of git-remote=E2=80=99s sub-commands.)=
