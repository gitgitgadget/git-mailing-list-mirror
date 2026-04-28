Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315893A63F6
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368824; cv=none; b=aLFZQZ8wrwzTA69xYQyAvAbuJSrFxpUsys+3CikcMor0y9Ux/vRshKlBcp/4yAv/rdl76JW9j1m5Cb8+SRTcutQAPPqQTfqEsTnK96Q0/UcWHLl8nDSPbgxPmlcV6PLDFBhjnrtSKMzia2cLacKSOnFJX++NRqRx95WytaJEWeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368824; c=relaxed/simple;
	bh=sMFK8QizYVz8n3LxBPZfawCXEYKkDb+hBGfG9D5gHoo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WC4Vh+KGk4AkBH092b60H3uncnIx3s+2uPmq4MZMV2kTtiYauBmWaqAxv4qne7MHaVPdsjbxCiYiDdYNeUzMIeUFm/WKN3wbzaA7uiMQZ+CPn7TBB385HUIgdQrLosWuVP52yT1IoUlGO7Bpt4qGur0H2uwCzzRRvIP3uyy+ewg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rau4r2M/; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rau4r2M/"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso116671305e9.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 02:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777368821; x=1777973621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lBKcF9nLYUz/x0mDMFEp8eKBrQnS0DcrPj21aU5Jwfo=;
        b=Rau4r2M/XUKiP706vaYwa/bz95b651uf4EefZgBgBl+ueRopKDFmlj1rPjG60cCz7W
         GPHudRUIQCI+p+E/m/wiOlkwgYuQeWTJfc0YF20fnwcarQ9Q4E/8WtQY7HgKneNmJYZA
         zxW1miKTYpgWQQ4Ot+4TwMto+NcqF58o/NDs9r1riaMkf2F2UnU3PaiP8MODhdWijkRh
         AagR0CsTyo2r7tJ67IIacVJHB/Vsfrn62F85dpqxvTYmxw3eZsKbNy+ZfaxblPpsXEvA
         mW7xHWLZjHB0sXsblSRR+1haQEzm7AgkeDW0z3aCWpJ5AAFeoHxDaSyB1D8G4JQHr6yH
         L4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368821; x=1777973621;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBKcF9nLYUz/x0mDMFEp8eKBrQnS0DcrPj21aU5Jwfo=;
        b=bG3ZGtjfhTliRVEu+ZyNgp2/ObELTouc+y13AWLhRupyxBotYN2tqgUuuJO2zSBzZH
         nvCzv3pV7wshyL7fNiMdHKYXHo6Wvv+wCr7XFMJIpr7GkIa31f2tgWTNT8L/BGVkw4rj
         WKDoAZQhodyuWN1eCV97J6w1CDLSSkbLvVn6efNedXMITAG3Y7tuwPJizvRvyOIfZpxv
         87rjVlWAc8k25GBs90XkcBxytoeKU5Wb6+mqy+QuiUWhr/Xtaw67rTIf4/d3j7WKVpsx
         MmyWm2rdAOwh7hPUcn3Vh4eICTodwYd+H44y5E7nIW8dbjMWmSYMXxKR//GKeO8mCKP9
         jetQ==
X-Forwarded-Encrypted: i=1; AFNElJ9AfVJ/0yY27POpZud3PDGjOk6Y+rbvEAqsO83dyk6zIUM21ptuccJ7mmCzc5JvmaGcREM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGi+42QJjk8p3FS+7wZDguYpvXGomxy5IThIIU3NaRIAvuhaRP
	QWvNAnM+fA05d2cGcxcEjzLM+7asrIX4FpMMjUjnzLeKg7e/0e8GWc+B
X-Gm-Gg: AeBDieuLB4u6SPuKIrmalNqytYSVuFCbwkgH0S/wapXCfcH9PwOnsIfHrWL4fKSx6Xk
	QqgLjJ8mEUfddK7Xb1oz3lmIiZSnrT2vg61//86swHzAmd/9yTCVorZLbdAO2ISbphgh3H1tiWE
	h7hz9NmQUanr7ZG5NXNznmmczSaQbxaiIrs7Uk2LA7krTVJg21awddkuhb+JrbYvpg57Wu39wxI
	y0wgdMEQZ8aOpOlWu1U20pWapw3UTroz6kzgS6uhr8WtHEk+sNprKZOxRmXhjZoZKhctWhxlEQX
	wNvvCSDxTi85RuhAEPeLsu6CIeEy31KslsA4BPzrPNjBNCTZMN+z/h5nB4f+lZPbsS5H05TqLGD
	kLpnSDjdg/iO/Rbu53Y1KxDPLUfIk9GHMJbztXXrgVBQ7b1Ms7G/3OzSd7d2rSFhZ99tdCfXueO
	yE2HseCEiWon25DFe8kjtfR5nSeQwEcF3WfU+L/iu7GsqVjm0/1Qw+R0rYdXtqFEoN52tU86OSX
	Wxu+0JjLldC6Q==
X-Received: by 2002:a05:600c:3b96:b0:485:35d3:ce59 with SMTP id 5b1f17b1804b1-48a77aefe5amr36582015e9.10.1777368821361;
        Tue, 28 Apr 2026 02:33:41 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-446401431d9sm5210295f8f.35.2026.04.28.02.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:33:40 -0700 (PDT)
Message-ID: <66e3b1f0-e00d-4b9b-8ee7-ca71444cf56d@gmail.com>
Date: Tue, 28 Apr 2026 10:33:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v15 3/5] sequencer: teach autostash apply to take optional
 conflict marker labels
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Chris Torek <chris.torek@gmail.com>, Jeff King <peff@peff.net>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
 <pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
 <a428ce73281dd288f0c4f44c4f92c03129556b7f.1777065012.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <a428ce73281dd288f0c4f44c4f92c03129556b7f.1777065012.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 24/04/2026 22:10, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Add label_ours, label_theirs, label_base, and stash_msg parameters to
> apply_autostash_ref() and the autostash apply machinery so callers can
> pass custom conflict marker labels through to
> "git stash apply --label-ours/--label-theirs/--label-base", as well as
> a custom stash message for "git stash store -m".

I said before that I was confused as to why we need to pass a message 
when all we're doing is saving an existing stash and the stash already 
has the message we want. As that didn't get any response I've had a more 
detailed look. The message here is used in the reflog (which is what 
"git stash list" shows) and it appears that the reason for passing a 
message when storing the stash is because "git stash store" is not smart 
enough to reuse the subject from the stash commit message by default. It 
would be nice to improve that rather than having to pass a message here. 
"git rebase --autostash" and "git merge --autostash" do not have the 
luxury of calling "git stash store" from the same process as "git stash 
create" and so to improve the autostash message for those commands we'd 
need to generate it twice which seems like an unnecessary complication.

One problem with that approach in the context of this series is that the 
stash commit message begins "On <branch we're switching from>: " rather 
than "On <branch we're switching to>: " but that means this commit is 
just hiding the fact that commit message is wrong when we create the stash.

It may well be that fixing all that turns out to be a lot of work as it 
would mean modifying do_create_stash() to allow the branch name to be 
overridden and modifying store_stash() to use the commit subject as the 
reflog message in which case we should leave that for a future series.

Thanks

Phillip

