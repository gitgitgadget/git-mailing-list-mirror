Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95D7481D5
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 22:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712876038; cv=none; b=q4Ir8irbh/scSfbBvYHb6xNFqMov4VYJfOsOLSeKb8wbasRG2/jG/scWC6Q4P1BvE3r/m8PgHQ2R8kSmmOaZ0/rfOYJofd28iJCBRxASLEpcuxjHsYJGadgq1Qe7JtSohu7eVDG4WiYWMym2AmhPPKP/Alace8fhOhvnsrdrvNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712876038; c=relaxed/simple;
	bh=71jvKbFFh85OcsaKd9+w998yO5IFxUS+YpzCajog/u4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cIrv/TAm/LvQXKYKex3Wv/kHXc4dr8n8xlLz6Y5mvEiIJiprp0G2TpyNbeQjanKCjDxd1BIE//sR7TS4Dkr+E+rDa31NZ716XEnEBb0J5Izo7cdHrO9oPUf3frWklIzqGRCGjFSH7pMxC+D8OGE+fkYeNXhaXYkfm9a+h2bJl+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i0/zFxXW; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i0/zFxXW"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6ed34f8b3c8so391865b3a.1
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 15:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712876036; x=1713480836; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AVIkQPKgDVIcs45GR5C+JeBoHOgsO/EtvNv3iRLJ29U=;
        b=i0/zFxXWct4X0xUxmKfkcOL56DbnrZgH0XpgsnPULOZB0WyvkHGuQ29pXwobpaxALt
         +R3XvrPbcp1PdZxk6YMSxn3nyaBmwgsttlnKh0KarPub8Hf+pxeipZEtnZ65VoVp1/UM
         fyr7kjrc2ixgl++YpspdQbXRMBelGIU507w+Gyi/pOtWo5mJy/O//Pt+I2yoscJYZCgt
         0cFrVOx0Z3UimpnamQFbnFoQ+Pn2nONp3Rtw7apXV16vDUNqlT/4kflMb9XxGTEWD2QB
         oyMNh0MywVJSlBUsZow79pIC1OkBAtkJCkR1XsMc8Es0pc5sLezBz2maD00Q1lrAC6Qh
         qqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712876036; x=1713480836;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVIkQPKgDVIcs45GR5C+JeBoHOgsO/EtvNv3iRLJ29U=;
        b=sfkcFtkd81xjtCJZVK3m8EFN0H5CTxJ+3iBK9px3fg3KbXkMWMoXVWQFe39TWuWBpq
         2HxxVvVwbpsllLaCe+cBeXzNvtKVCaYGV/zaNqPBpJ+WyV5Syce0BZVZCjgbc8CEYoux
         jHJEYwedVcBqnotY3ZkivAaC8mpj16UgVx8fzQgyrIEw2cGvxXYokx8iBgwBKhdiRnbe
         g5ZyBFGbMdkRmc+VbLSj31LY8EihEIWBfaDiMP5t92z5Rn1sENh5qWJZ3TdNIPMDCfzx
         X3IyJzHFxdy4ZXj1eWJjUeeh0x0w/9XKLMwQ/fnqXEwJCWgnkg3gYNa0g4sVWIeAtSGP
         Xnpg==
X-Forwarded-Encrypted: i=1; AJvYcCVa8ed0YOswtc84VnmS+kHc/NiF4O3Fj82gJ9a+0Cq/4TEEVGU5B4Scd0VB1By8ospp7nWfhuVW4ERVCT4fsPoI7lM4
X-Gm-Message-State: AOJu0Yz0RANLArGYozoubVfIapKQiMK7oYnyUf1s37UaimTPp9XiLZNv
	9KvQRRr31H31FF7VLVuQCy036VI782N0cLfHdw9lN/z0YpRBxHQGyEZU2uaHSnthqcEMD6dccPg
	Ldw==
X-Google-Smtp-Source: AGHT+IGEj3h6u3h+iJAM7V50SNubOQMIW/wnLGY8aoDOvNeu1URZ5lpnN4KHNRYUnRrGzsmtUN64mYTXnqY=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a00:3995:b0:6ea:aafa:815c with SMTP id
 fi21-20020a056a00399500b006eaaafa815cmr43860pfb.1.1712876035973; Thu, 11 Apr
 2024 15:53:55 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:53:54 -0700
In-Reply-To: <owlyfrvurtl6.fsf@fine.c.googlers.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1704.v2.git.1712366536.gitgitgadget@gmail.com>
 <pull.1704.v3.git.1712699815.gitgitgadget@gmail.com> <1f65dc5ba3ded5b90ed929aa3884574e8b26cd9b.1712699815.git.gitgitgadget@gmail.com>
 <owlyil0qrxev.fsf@fine.c.googlers.com> <xmqq8r1m16n1.fsf@gitster.g> <owlyfrvurtl6.fsf@fine.c.googlers.com>
Message-ID: <owly5xwnse7x.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3 1/8] MyFirstContribution: mention contrib/contacts/git-contacts
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Jonathan Tan <jonathantanmy@google.com>, 
	Emily Shaffer <nasamuffin@google.com>, Patrick Steinhardt <ps@pks.im>, Matthieu Moy <git@matthieu-moy.fr>
Content-Type: text/plain; charset="UTF-8"

Linus Arver <linusa@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> [...]
>> For now, I inserted this extra commit between [1/8] and [2/8].
>> Thanks.
>>
>> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
>> index 00f4c63cb9..bb7e4174e8 100644
>> --- a/Documentation/MyFirstContribution.txt
>> +++ b/Documentation/MyFirstContribution.txt
>> @@ -1116,8 +1116,8 @@ $ git send-email --to=target@example.com psuh/*.patch
>>  NOTE: Check `git help send-email` for some other options which you may find
>>  valuable, such as changing the Reply-to address or adding more CC and BCC lines.
>>  
>> -NOTE: If you're not sure who to CC, use `contrib/contacts/git-contacts` to get a
>> -list of reviewers you should include in the CC list. In addition, you can do
>> +NOTE: If you're not sure whom to CC, running `contrib/contacts/git-contacts`
>> +can list potential reviewers to put on the CC list. In addition, you can do
>
> Nice. I think you can also remove the trailing "to put on the CC list"
> clause because it's somewehat redundant.

I will incorporate this into the next reroll.
