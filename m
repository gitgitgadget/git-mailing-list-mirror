Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6682E53D9D9
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 15:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077592; cv=none; b=oriTy5r7LyojfTydhHF90g2EyunypvW4LmR4XNGJ+RqTs0FdwJCrg2gaWgTQRU7gBY10F4t/GgHkLt+anFRI/MD24ekni8FhysJ528f1C2/jtSuEOgBtZlBmKnqs22jgftH2/gDl6SvMclq+7Btdk6CWMdMbG4DVJjE64Tookhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077592; c=relaxed/simple;
	bh=raU2WkB+Ck6/WY+kTQKfbdLUS3VeQ8oT5BUF99TGCOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LTYbgvTAnqOlv6ve2sh+cwgfM0IIKh33SakimFLA7nNKFLFcSBcTECsjSPnsm+izOGElb18f/mUynl1ylwxM9g7AXTBa1YnjHr47iOzs/RciuQyURF9YdXacY93r/SKWc64rvqW0hmFI8ZhHjo5FZf9Dh3qFpj8So0LucgX6uGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsXWW5hi; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsXWW5hi"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso583250f8f.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 08:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792077587; x=1792682387; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Bc+ABHQA1xWSUDz+PAzrH+Em5PIQAlLyeyXAiiqcIWk=;
        b=JsXWW5hiSCtkvajWdviZrTn8faStfRrPUp6H0mgaubi9nauLNOf1MBKj+kcBPhNBXO
         q7rstDnQn3/CGaKnt/5EweGxZF8KIKknybfcJqtJted/pivxUGVeozV/xIlNU2DwBNbx
         FfN7vRnCbhX03Lt6v2tFgp11HL5H32bMHA6q2g7FekreQdrQ5b90GGFDfJIiIq+xtKan
         jnuYRpFWGqhGwm7JUvGoS8jWVt7XuNpIDsYlgzHRXN/+mboZtWGQBMfPjWJZJe/e7s04
         r8BQdnb+fYreeKz+uoRwudZi+SiUcBHZITqBmFLiYW33mzgaigWGXziRrrU/6bZx1eY+
         3nUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792077587; x=1792682387;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Bc+ABHQA1xWSUDz+PAzrH+Em5PIQAlLyeyXAiiqcIWk=;
        b=N8SUaqLKUREU94Gx/SfmvGMxXMKZuLrAi99BzJpGLws5PxYFnZ/tDsCyYGo6qV+NWw
         ZMEnDZX40lmwr+IQenn9QbcTOsVrGYFT40yhtnW109cg3O9/n+Cm/wVP7EjX/khUxqU0
         1lXigdc0QhqAPygVS5KsDbxs1VQaP3JoNpmX7NBg8HR1DsDVRSi/EgmTciBjhBZiCGRy
         BRn40jSDii+IftFbXV99Uu7v16VcvzHwteBWwW/ineVQTP8hNFEsh1x6GHHFzURDp1yQ
         DPD9oTtWSP2NwJGvyZcTHeZNJ6+15k7dVF46VFfO8pRVzn+qogB0X0Zo9VqgzinO2tsl
         EwlQ==
X-Gm-Message-State: AFq9FYI9iyHqwLFjy3790VpK1poBbRelRnhKz/2puUasHIBOpgbU9GyN
	MNZbnWV06htrEBTfer/YMLu/rgksVsNYRXTcCk/DvyYF4SN9LemtpEF+
X-Gm-Gg: AYBFou3zDHDwAjwlVoWlVuXWvhN5yJeubezj1bZ04oH9oKJncwiHgKKbO122TytOi3x
	5Gr5OWUi5nUXr2zIy2l3cahutYblXXQ6rd92dNkaUv9tyz3j42C3xd2GnOJFlSo0/hdfu20owTp
	OQH6GYB6JUsAcSws4bJDj7Oi0b/NbdtPBixQ7aYJS9ifgPt17TmM5ivm/oc4wFLU4ZtxXxL8l2I
	PEqFf3Qbk7WY0+SDh6QXlZUcbhoQ0e6ZAEwvSIEkigK3SCJRq5tsw1xT6pBUpaaRAVJN2gWa3k8
	xWz0E8M/iS2/Sc/DRirxpaqUKJ0GKkuRfBQxIygjwVf8f8OaBC19PkZlrj5JyNj75ZvsAGpi54d
	F1SoRvB931IKNhYNK3Y/Y9iy9M2iQnKHgRkbDJKqhCSGsi/gmyY2s9GYJWhyQx/r9GMXZ6c7/hx
	XlaQkM/UmLCorTvb9DHYEqswUWYPoyOWalVBgqJgDRT/XdRMaqbdDPwe440OtIwCNIPhLgKCD+y
	Is6vR8vpTteXTUtqQrNuFlX5agMw4HsHWr6SSkBle97yNxtMssOj6J/C1O09Zw=
X-Received: by 2002:a05:600c:3f1a:b0:4a1:ac66:6ac6 with SMTP id 5b1f17b1804b1-4a1ac667160mr187813575e9.26.1792077587211;
        Thu, 15 Oct 2026 08:19:47 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc6b82sm19931612f8f.51.2026.10.15.08.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 08:19:46 -0700 (PDT)
Message-ID: <d9c282e4-f960-49a9-a9a5-edd833e3d6ae@gmail.com>
Date: Thu, 15 Oct 2026 16:19:45 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/2] blame: ignore revs in .git-blame-ignore-revs by
 default
To: Junio C Hamano <gitster@pobox.com>, Ravi Mistry <rmistry@google.com>
Cc: git@vger.kernel.org, Ravi Mistry via GitGitGadget
 <gitgitgadget@gmail.com>, Abhijeetsingh Meena <abhijeet040403@gmail.com>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
 <pull.2224.v5.git.1791902175.gitgitgadget@gmail.com>
 <xmqq4iepzex9.fsf@gitster.g> <20261013202448.2116038-1-rmistry@google.com>
 <xmqqse29uyh3.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqse29uyh3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/10/2026 21:39, Junio C Hamano wrote:
> Ravi Mistry <rmistry@google.com> writes:
> 
>> In v6, build_ignorelist() passes i->string to
>> parse_default_ignore_revs() so the string is actually used (both for
>> the working-tree path and for "HEAD:<path>" in bare repositories), and
>> cmd_blame() sets ->util = (void *)1 with an explanatory comment (rather
>> than passing the scoreboard).
> 
> Very cleanly done.  I very much like this new design that still
> honors what the item->string says, instead of "ah, .util is not
> NULL, so let's do the hardcoded default thing".
> 
> Unless I hear objections in a few days, let's mark the topic ready
> for 'next'.
I'm not sure we need the lstat() call before open_nofollow() in the 
second patch of V6 but everything else looked good - I'd be happy to see 
that version merged.

Thanks

Phillip
