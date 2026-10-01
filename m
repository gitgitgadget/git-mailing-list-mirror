Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4518714883F
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 22:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790892173; cv=pass; b=fQg5VlsZG22zl1Y2LvLV0pjPlHLgQKrIMdmxRiouygVHncViFeBLcHyvYyGOq61bezHQAprTFu69NOxBuhArrsaz3x37LLZiRzFq4Wl2pM/Gqs1dac6D1fpPCbm/NJhxXPOEgMlwie/zNKrdQqpJTAAR4/E8aHevBPq4NM1jAAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790892173; c=relaxed/simple;
	bh=mEQX5QM0172t9OhBmbojUIcSVln99QQj2SUnbQkHTIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oYgLMAV346Wg/eOSHOpjzYzx5+cVNJVWeDIZaPT9ol2mZA+9dNTWF5khaPV8kUHSKSY7gCLs9SDGd7riNbAnCubgm8ngrmIa4uvx1cAjd0NGpaZY7xKK26tDg/ZtHoV2lCWcFprZijA0R62fFHgmZGrlmXTBmFGCZJ0jpZVc6wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c7MLjoPB; arc=pass smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7MLjoPB"
Received: by mail-pj2-f38.google.com with SMTP id d9443c01a7336-2e2db9f927cso16177055ad.1
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 15:02:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790892171; cv=none;
        d=google.com; s=arc-20260327;
        b=G4xTNGvoLwOhGsQlylFigzt6/DwENcRxuwFjH6JvUOHQufk8qf7CijXNWZ9y7x+hgR
         8stj52u6y6/nv378z+P9vyzfDqWudAVAbCGEuaHuuJc7i7zypbR2e7ezQyJcALvijk69
         q1htd4G80xVhJBDse1Hu70qUmh7nwjSt/KRmXz27nYF8MY5GaMf8dFwAekTAd0csd+mU
         OkyX+mtpSJ7DHWSPGoUNNJ1CTALmJBMie/I81nxEqC+J85NAnm1AVGspss5vjVVPOG1/
         TsKhmVzTWRh72+H78tYmK290rgwNAPJwJVvdqWny1xWVywn+0wyTNPTVS4Em295qqUXv
         rpeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mEQX5QM0172t9OhBmbojUIcSVln99QQj2SUnbQkHTIA=;
        fh=Lz2vXbM4TUYL5SkdyqMdHX9P2czbDgprfYfqLdIhsMk=;
        b=fD+RIdZepaROA/6GJ4juTf5sJJfYedxtaMDlitCLTj+di7rmG31RERTHBBUXtUlkZm
         Of1Vhu0uHFI9aCIrlSW1oY0NExp/f9bLXmKFtWb4sOWktWxsoCE3ROVfkpQjTge9GTWv
         WTMFruB3hc11Uq+4vjbGd58kISY8j7egddDTh6cVydDDc1OECIYI2QBf8stu8pVXheaK
         F/pA1036iGNIrb6/LtnF8vL2/XdQM2qfgpclqb6ra3f0I5BIuRFjThXtlBEcs4M95IFJ
         Ix9oMLcaa8yoMWMCu7ihr/4VpjwcG1BNRh72+0Qdl2HR3hq8v5nww/8Xon/AzCkTdyp5
         XzGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790892171; x=1791496971; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mEQX5QM0172t9OhBmbojUIcSVln99QQj2SUnbQkHTIA=;
        b=c7MLjoPBYDsfDQJ4upZwemEGGictKMQS+c8Ptho0P3GS3b14S8pcoCGvuXsWPLxYtL
         cWTdjxz2GLIMntnQtrH5PNRp0OmmGsYhlEiVjzrcWHG237U5JoHdaSvCyuw4uXAsNXMM
         XnqQO/sf5ALhCi//qU1ri7F3bYzgXx6TDv5Loppd+BrWIOo7fXdnu0yuxqzx1UuU7kcS
         Ywq/UABUztEVLuu31v4h2WSdlchOETeeWH+sXf0pUelUjk3iVK/AkHlFebqd4oEYvGAl
         w9TAZ4JCccpRNYFUoW8fr4nZH+RK2zbV3EuLmg4e+pNhGAQ3urbFlM/xqM0QHYNIY2Gc
         vr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790892171; x=1791496971;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mEQX5QM0172t9OhBmbojUIcSVln99QQj2SUnbQkHTIA=;
        b=vsfdmhIHg30d5NulpjIzuHSPqkwY+xOiEE+QZ4UcdN32p7boNxoKK1zA0xA2/X2h6N
         rXblLwmsnbiTqwFZDH1JqV8CmVaKeTMiLn/UjfV2IoLZJa2EOrRwk5n56PL3c+Nstvb1
         EdoQKccjslh0lpNCu+zR1lQOHi+DxegtZVjRWd2EPB9Cna+ZYe9o3/+Oa9Vs+0mE2fQe
         3TnlSHVS7J6lLAwl95aXN8qk8k0Keix9OPWwDCrYDcWlWDb8OXlmhlt0FewmBgBdM/WE
         K/Zk11ZJwlj+k6P4rgtQaBIoAegUh65rgrP7AAR3Z16I5kyyumlrzvTxURA17lv7rpMf
         2eiA==
X-Gm-Message-State: AFq9FYIPV8emo8T9WtjZi3KbnTk/B/eV7rUEBvvwdP/bcBG94ClMjuqe
	MUmliR2l/7/ew+D+U8ftRl3nEsUhnCrYDPJTFVdFZR87VrPwKr1smDzlRLGSpl5bWrff+DDR3Qh
	yCTJ/xjQf3in5z9aZEt6AlKWmr0Gy2npRKj+1ySA=
X-Gm-Gg: AYBFou1DVd97WTdqZsPgpCxFtrVAII1ofRNLCBq9ZRkyJwzsIFahjJTFQTtPeLceoMs
	An8g/b14sRTiZyNmR48UXsbnaVoXA/TScwObBnkj0OV9nrYJCrTAlFITzYHDa0eW8QOknK2VClK
	J9D7ao9SxVorJLWYYJEL7vZqgVIyew9mgheRqoFyXsT+ZRPnH8OURhnOqrAOok/gcTmNAaV7kUS
	5I/nwEybukZ/onJ6q14SMLm+zwAEWKHVeE/BqH9UD3BgN3gzFmuHVrtV2l0B93s287fkf7Vk4e+
	XU2/ZX7z+VxDCzr05LXURNoJQm8wCtHeSpkTfFz6pOG5LKPEsZGcQXx6ehffNrM+j0P4gVY/ZMF
	pGq9qfWIe20ntv+RWFB+ek1jG0CkNKfPYHYTBOvSxJADd0GszfWlkt2+92zlB9vOAjMHs645Uag
	==
X-Received: by 2002:a17:902:dacc:b0:2e2:c69a:bd7b with SMTP id
 d9443c01a7336-2e49b6082admr6516715ad.13.1790892171219; Thu, 01 Oct 2026
 15:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001085330.73586-1-hananarshad619@gmail.com>
In-Reply-To: <20261001085330.73586-1-hananarshad619@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 1 Oct 2026 18:02:39 -0400
X-Gm-Features: AclHuK9Ivvh3nTc1cnz7Owzj2PhVGie7MIFoOt5HsCCa0GZwkbwGtL3B35A13U8
Message-ID: <CALnO6CBL552Ny8-cqo9EE0uy6j-TMszJFRrRuTOFC=nRJEv5qw@mail.gmail.com>
Subject: Re: [RFC] git stash: add porcelain for sharing stashes through remotes
To: Hanan Arshad <hananarshad619@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 5:37=E2=80=AFAM Hanan Arshad <hananarshad619@gmail.c=
om> wrote:
>
> Hi,

Hi Hanan, did you mean to send a copy of your prior thread
(https://lore.kernel.org/git/CAKPibBw2XxjGpE_DZrWLZmMHs7kAyvOaP8504kfoh61c4=
UkGyg@mail.gmail.com/)
?

--=20
D. Ben Knoble
