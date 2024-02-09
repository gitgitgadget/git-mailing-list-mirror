Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E2274E2B
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 16:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707495386; cv=none; b=bLKEpRqD3t3UnvqJ8SJlZIMplOJBkpgrVLgBtQfHRnTbdXEb16pC7PX/FinONCxQsWsPFQTnytzhpncSJnFKga/0BoNR/pyd3E70WgEURTzU5hc5aZWjDauPiFPrrFrsUvxHOGmUjjE7pAzLlUfx/PSp/GAxu5FosgadVJUXeLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707495386; c=relaxed/simple;
	bh=iD4Ww05Q4SxIoGRZkuu/bby6Lp+V4LxnnRFphLYDP2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=MpZ7eyjed9yGSJY6f7lHXTwanMjtXRAaoztEg6NzeL+pZZuKQztIlaez79EyckGuPQc7p0NzCIdlAtcK0SKPA+2cb/v9UlSm0RpHLWJg1xKnH3T3jcki0P7qBky6aXv24+3Lz0s6xVWtC/RoEBI2JeM/3YrMLmwlDlbisCdW5sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVyPfRE8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVyPfRE8"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40fb3b5893eso9256315e9.0
        for <git@vger.kernel.org>; Fri, 09 Feb 2024 08:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707495383; x=1708100183; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BLHbIlJdefxOScECAipMrickRSWPaEyBDBz+Fv3XPoA=;
        b=OVyPfRE8Ta6x09H16ndvq2l5DPRYog68mLCXzIpkBLJ6++JhDSFt/r2z3DbG3I7jcd
         tKBz5kI7LF3jGPJkoeBDYICUtxH2Ke80eWSNbEoGjLcAxHAq4P6Yr+x0e1HIZZcn7b8t
         RQJltHOixssjUyjaqiPi0JgDugEulEiBwURgKTKAW1c2kj+JSyUq+aEvEPdhicZqq6hO
         BHNpHsegUUyNfrTNHrk/3lh7K0N7hWAuTujBg6qNeg05G3Q/mJzu/yhWjQ5Y3O83AxbC
         KVu3PdaISUF3mXbQXx/udTND9s0iqtPJ/I5+sTgeYxGy8c1patf8E2QlOv7My0AIFqzF
         6sQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707495383; x=1708100183;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BLHbIlJdefxOScECAipMrickRSWPaEyBDBz+Fv3XPoA=;
        b=ve6//TSI5CSFbPatUu6Xo/rVmUDfd9W65cISAMkteboeinNB67PegfSBuk1KxDmZX+
         SEUB/Y6hQgJek0vdxW+Fy7J583KMF2gvRaf1FaYzA7d4GkIJaKFBkSoZl0ar0u6shbTo
         //nAo+sq0XsVEy1VHT30ccmKDvIWaqOX/jD7NoufKHk/X3yqsZMFRiJAacFbDc7amUuC
         MNKksnnQ6nvQkpNKo+Gt3MAlL4qQIC8+PKXd2s535ye+qlDiZCVJiQIb7cf+AZxSZ1aa
         S7+KBf5ONdOmtFZuN8mlSC7ilhK5TkB4FfpZSDlZ3Djys3JlzuuC36vYJ0xiq/qPI3/i
         8Cyw==
X-Forwarded-Encrypted: i=1; AJvYcCWFe1buTclO86N0YiaK+n4LxeFDktIhPNei7peMw/NoyxbzWmtIe+B9GrTPEQggXsSoAHk/A2F1JZ/a/Qg1FLfIzUM1
X-Gm-Message-State: AOJu0Yy+WJ7VBYoVk9oemUEvL2fANFhrP2BxvQ6AfgiFJUllL9ut9tkB
	kJGalO8j30Cfr9d88tLiSZ/+bKKVz5ghh7uAUAQwjHXc8raH6UOt
X-Google-Smtp-Source: AGHT+IF+3h2P0oyU30fwNn/4BpB1skWby+FcwQxB2j9Y00AXKKdPOwwVxkFexX7oTao80v2TXcrPiw==
X-Received: by 2002:a05:6000:71d:b0:33b:627c:aaf8 with SMTP id bs29-20020a056000071d00b0033b627caaf8mr2000245wrb.8.1707495383193;
        Fri, 09 Feb 2024 08:16:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWUoy08N76tZikVidsFRfPBQIzXVQtAfCg00Dkgv+a0jGDKUnr0yFR7+2SOLToNNTqC8Jk3leuiNoD8JR3+ndsj+32H
Received: from ?IPV6:2a0a:ef40:62e:a901:386f:d8d1:628a:e68d? ([2a0a:ef40:62e:a901:386f:d8d1:628a:e68d])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d4c43000000b0033b3ceda5dbsm2165425wrt.44.2024.02.09.08.16.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 08:16:22 -0800 (PST)
Message-ID: <fbf859ca-43f4-433e-b111-377aa60f1947@gmail.com>
Date: Fri, 9 Feb 2024 16:16:22 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Supporting --no-edit for git rebase --continue
To: Orgad Shaneh <orgads@gmail.com>, git <git@vger.kernel.org>
References: <CAGHpTB+mCxvzJ4LDpQrMgHmzigUzcAnRcwMewV0oYKM2HwbNXw@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
Cc: "brian m . carlson" <sandals@crustytoothpaste.net>
In-Reply-To: <CAGHpTB+mCxvzJ4LDpQrMgHmzigUzcAnRcwMewV0oYKM2HwbNXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Orgad

On 07/02/2024 20:46, Orgad Shaneh wrote:
> Hi,
> 
> Is it possible to add --no-edit for git rebase --continue, similar to
> the functionality of this flag for git cherry-pick --continue and
> similar commands?
> 
> This should continue the rebase without activating the commit message
> editor, and just keep the existing message.

I think being able to say "git rebase --continue --no-edit" to stop
rebase prompting for a commit message when resolving a conflict would
be useful but it would need to be careful that it did not suppress the
editor for "reword", "squash", or "fixup" commands. You can use an
alias that only runs the editor if HEAD has changed since the rebase
was continued to do this

     git config alias.rbc-no-edit '!
         no_edit_head=$(git show-ref -s --verify HEAD) &&
         real_editor="$(git var GIT_EDITOR)" &&
         GIT_EDITOR="test \"\$(git show-ref -s --verify HEAD)\" = \"$no_edit_head\" || \
             $real_editor" git rebase --continue'

Best Wishes

Phillip
