Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7292517576
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709397146; cv=none; b=nFkfTzZi9mVvsmTHXuSe+/tgSX5uPhZ+xX2nHDFPVch3cg/EiQrE/f+GFxroW6A2BWNrIZ9kRoz1SeceV8ukrmy+kKdjuhDvTe8h9i3nHIfLf3qLKdgQjClfcOI6+r/UJ3fCq7+y1iCKh2dyIlQvnSIi8T4faJq5GDTdcr0c5do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709397146; c=relaxed/simple;
	bh=hk2iiNc9jR9yxR5VZmEdxvevpgOyJ/PZ0+OHc7bi094=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=kqcNOu2HwEfuvArtpvGtI3zPsMfanLvexvHKj4JNDmc6L3O2FyXXOLDCGCc9kTq3KFR9avrbGwwJGDUIwy72wpbJeGQR7rO752ft9D0s/pGKe0KXUOHhkUb+1SQeiXpPRZDA2EkiTtvfKtpJyALoXWhIyzcMdzKiIpCjYlC5HTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiajJZa3; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiajJZa3"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42ee23c64e3so898381cf.2
        for <git@vger.kernel.org>; Sat, 02 Mar 2024 08:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709397144; x=1710001944; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKguXzC19OZ/31NRxZ9qH1yOfxxHGCK1kzg4KYHK3xE=;
        b=JiajJZa3Sf0MnkzhlQC6zDUrwW7mmWa6vcFlVLUwq3GK792hKOuk3x40zAmPwaJdTI
         LTGKfW48qX9NhPpG5mAT6kUXkmAwwWj93O60a0YZUerktDqwFeF1tfNAjo5juGEztP4N
         k7nGBEyWPB20VSQAAe8hXGXq2MzRViSvTgDKY4v8B/4hO/2nSI4bgRWjjbotvvxmn66K
         s5Tfpq0U17IHXw4SkWlxH9N2oUsLKuvN4JqsxLadpSZnuwpIMXBdJfV9YUWpL8wdCn6x
         qsr466xBBx0alDvqEE0r9sBn5QeH3v48xZ9FDiROc/KxbH8OVjv/ufKKu9cxMsl8IqUq
         +JYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709397144; x=1710001944;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CKguXzC19OZ/31NRxZ9qH1yOfxxHGCK1kzg4KYHK3xE=;
        b=GMw3bcnKhTTTj5NYZjLln7iFqEPAGe1T8sIFnju2ujiZthdasLImPTDR/NU0iyimBk
         e/Fp+/pkrkvRXf8SQNJR5c7fzXyqwIF72FPTvj+lqTFpL+jAxj7ltFdsKumebWwLAqEO
         wNNAC8mNDvBdNKpLYXVfm+oMp5KXWvj24HqIv/swp64SkUytjZ/l4I81dkqootZ/QcBD
         /hI/oHEjU1NBISvzQym0P6GLt1gidDtLdsrvaQcck5N4cok/HwExzrKjYCGzpRHVHxLN
         bTBEH2hhYaxoRkzh21Onb95Or9R7lRDl7lsGph5bh7A3g+IbD00/T+aAan166Jnnk5ls
         EjHg==
X-Forwarded-Encrypted: i=1; AJvYcCUswQ5AmNtKwLn/KVOZpYGnujsxo18PUE+vPcBVSdq6S5YgcwEME+hT+L5PQtgraaQshBnTbsrJTk2DVAX15mRuPxun
X-Gm-Message-State: AOJu0YxMhl04G24yJ1VnlAbLUAqaaxMK4Rkdv1HotirxKgmp4l5baMP8
	rbKQa6htRobYBqmHqfQvF4aw4NS2FVe/fsqtGY3+7oAoallDOknU
X-Google-Smtp-Source: AGHT+IE3MuYfkXPfDGZpBb1VVVjjk5LAs779I5ch9A/ZA5qqet/EQ/pAysDOUzikrU2owpVe2+2x0Q==
X-Received: by 2002:a05:622a:28a:b0:42e:8dee:6815 with SMTP id z10-20020a05622a028a00b0042e8dee6815mr5698349qtw.11.1709397144295;
        Sat, 02 Mar 2024 08:32:24 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:ff90:4806:8044:1d22:cc7a? ([2606:6d00:11:ff90:4806:8044:1d22:cc7a])
        by smtp.gmail.com with ESMTPSA id jd27-20020a05622a719b00b0042ecb2fa152sm1587823qtb.48.2024.03.02.08.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 08:32:24 -0800 (PST)
Subject: Re: [PATCH] sequencer: allow disabling conflict advice
To: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
 Elijah Newren <newren@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>,
 ZheNing Hu <adlternative@gmail.com>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <16c57c5f-6296-041e-d747-881c5c670834@gmail.com>
Date: Sat, 2 Mar 2024 11:32:23 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi, 

Le 2024-03-02 à 11:18, Philippe Blain via GitGitGadget a écrit :
> From: Philippe Blain <levraiphilippeblain@gmail.com>
> 
> Allow disabling the advice shown when a squencer operation results in a
> merge conflict through a new config 'advice.sequencerConflict'.
> 
> Update the tests accordingly. Note that the body of the second test in
> t3507-cherry-pick-conflict.sh is enclosed in double quotes, so we must
> escape them in the added line.
> 
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>

I meant to CC your addresses in https://lore.kernel.org/git/pull.1682.git.1709396291693.gitgitgadget@gmail.com/
which I'm responding to, but the CC's did not get through somehow.

Cheers,

Philippe.
