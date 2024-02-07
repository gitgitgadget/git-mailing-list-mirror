Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91B381ABD
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323990; cv=none; b=YcaV72O+S0NyuC4/GLU5eL1lI+PinaASmn9j7H7qD0hvXmQpSFxxSf9ZeJr2W5OHapx0Wdj7aRx2J5vwBdmeqAOzZKIkOIhwyTXX1bk32PGWDkOXxqr6oCx+4kHlT7qt6FjxQref7IwDpxGJMxO5y+cXt1BkG91I4hAFG9oUE0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323990; c=relaxed/simple;
	bh=pz6ODPNJjQq2CeeSv/1n4zsdVW3ed4SgDgWg54PBuRg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=XHHLfcI4zqNkFyANTgY+IL9uIgKt2ABkHTE5xYlN/SjC9XkUZdzL+umwQrhYIDrsvNdm/KoJzzlVku4Pngyy9W6UEk8laZ6TM74oBhYJH0mCNCnuDmNqBlgzVPeIiG9ZCIabV1tDBg+FL8YUNNIv80VpI5DbnXIPPv0e8ovs8C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=azuLeAiL; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="azuLeAiL"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bbc649c275so510145b6e.0
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 08:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707323988; x=1707928788; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NN276FnGqxDEQaoaxFPqiXWDN7TAuqRcGoCisCxbnf0=;
        b=azuLeAiLQwq5aP2X6zmlRisk07gQLdV5LsPUUBagnc7SixP50CUxUZlnpG7gDFvTw5
         f9e43B46qrAIeC6ZopgH4wIb8/GYt+YtF7/2NgJCOWP2rn6NTapcIrJnx61QOasPsIDx
         lxSRugu95ID3jYyHEgtEIXzJEE/JJNYnYuJxlc/87snZ3sHZJQVHRH9AfmWoAw7/GDIk
         cJKHW2pw7HLRFIGxRuS+FhvQazDsP6IHioB0MFyC4NhZHODNXIGKl0kxq7dqw+4vATab
         wicpSyvg6oJKFItPayBzip+RdY2dfX3/sSzkbHLSRydmY19WWJFfSEzVFlv1uyRUuwin
         ifDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707323988; x=1707928788;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NN276FnGqxDEQaoaxFPqiXWDN7TAuqRcGoCisCxbnf0=;
        b=dE8LfN7B3uMO00/vxQLVLG6YL+WIuJYYEBIrJrNm0Qt+cu9NPcMvdvCdHxhsxFtxnF
         sl4P6chQ1B9aEDn9bMEdbV0jcSFspftsZtyOJxJZKE7gr0n5hW64eGts3jM8jWyRv1EI
         d9G70gi+Pf98AnMmBkv9CyIAsB5NuOKT58WKnjptgBdvw5dG+fRgRtZJqX1nUQ20dXk6
         FKNk2zosK9R0uVADMbs3HfuflwPD6F5FWk07rz1HF+GgZlCI13XweEz8/5Kv/xhl4EvF
         Yf10Ug73Dq2lpLENLY7nUyb4xukFML/o8LBJqt80f0E9IHqswTeEs7RxHM5asoHs4yJ7
         WlhA==
X-Gm-Message-State: AOJu0Yxzx/ys6mCItyb2x3PJXeiN2LgjADuhpfMXwutouBSEC9roRRBn
	3TD+umaAM4FueUzFzQJJHmVZbwkLkAlsF9uq/C2MfmLWbfSSKXeCvcYs+Su+
X-Google-Smtp-Source: AGHT+IGeiuExI794Dm3Z/A2okTIkjl1QVTU5UoDKxa96unyB8+6y78186a4tfMl3QitDN0TZC7HwJg==
X-Received: by 2002:a05:6358:3426:b0:178:f47f:e5ac with SMTP id h38-20020a056358342600b00178f47fe5acmr2898353rwd.13.1707323987769;
        Wed, 07 Feb 2024 08:39:47 -0800 (PST)
Received: from localhost ([14.139.110.146])
        by smtp.gmail.com with ESMTPSA id q18-20020a637512000000b005c21c23180bsm1788383pgc.76.2024.02.07.08.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 08:39:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Feb 2024 22:09:44 +0530
Message-Id: <CYYZUAGA7I6C.2M4CHKN00W3P4@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] restore: allow --staged on unborn branch
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
X-Mailer: aerc 0.15.2
References: <20240206230357.1097505-2-shyamthakkar001@gmail.com>
 <xmqqle7wcl7h.fsf@gitster.g>
In-Reply-To: <xmqqle7wcl7h.fsf@gitster.g>

On Wed Feb 7, 2024 at 9:36 PM IST, Junio C Hamano wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
>
> > Some users expect that being on an unborn branch is similar to having a=
n
> > empty tree checked out. However, when running "git restore --staged ."
> > on unborn branch having staged changes, the follwing error gets printed=
,
> >
> >     fatal: could not resolve HEAD
>
> Sounds like a sensible behaviour---there is no HEAD so there is
> nothing to resolve.  With "git resetore --staged ." in such a state,
> what did the user try to do?  "git reset" (no other arguments)?

Yeah, I did "git reset" (I am that user btw). But I suppose this is a
case of UX. If a user is using "git restore --staged ." every time they
want to unstage something, then why would they expect it to fail on an
unborn branch when something similar (e.g "git reset") does not?

Also that HEAD, I suppose, is our assumption of the user's intent. And
intent of the user using "git restore --staged ." on unborn branch is
to unstage the changes relative to empty tree. Besides "git reset" already
does this so the matter of assuming empty tree on unborn, I suppose, would
already be settled. Therefore, wouldn't assuming empty tree on unborn
when also using "git restore --staged ." be reasonable and consistent?

