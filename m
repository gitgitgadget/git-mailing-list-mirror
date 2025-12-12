Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CA520C463
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 22:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765577219; cv=none; b=fvqHlRM8KYAAQwcmnKwPYmkDw7ShNOXj65GIBKD9jPToMkBV3A45sxxJz6sb+Fis0i95HDoh3CWJ7o29sVNTf0kikFWw0p22arawQRlCkCS1HaPzMgaVMTzgW+Tgvh9RwdkJ6cI3EDC69fDUEyroIdzJDljb/Gwd3vLj7UdBlts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765577219; c=relaxed/simple;
	bh=SzN1GqlyamgdGdZdSIJGIGnO/HNJwMBXWO9ZdXHKOAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cjjs/rXKwLroadAvPqJo4FYzirDJS87fjxDSlylGan82cyE1wm1s6WXEOd/sYFmFqZxMebtQEhkhvrsSAdiH+9I0IYHGzaFy0JGdFD9VBDwEXjuE80DouDRaOiDNHEXSMeHpy3yaMz9Su42kzKdwagB++il8/LujQIwm1UctF3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuJ6tB1F; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuJ6tB1F"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297e264528aso18444605ad.2
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 14:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765577217; x=1766182017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJiZ4WtxnTnGzoebgxhQ9CYSZzT17NBgC99cujKmoP4=;
        b=YuJ6tB1F9QO5Kys9//PoQVIv/ktlKzsvaJQcDIpUT1kKsEs4W5pfNUYW177TSyh0/3
         ie2VlLiWAinGomPRujQXaMfYo6KEwRe8dlZKAr79DcUo0MCuBNA5JfQSX47ZCoOryK1Z
         NDWjNEQNy0g91yLTxyMPCBRBiQgrh0WFW9pKpRwcrLTP7oYKPoi6GU7TNYiYkpYQAb6F
         ytG99yeuaKoh1timNOZfN2c/8phMpTjcFehl+POCw9g/HkrI6A6TbxvqRRnAkaWrS9jy
         /FGTCezPOgYYun9g17UqrZyiUpPBC+s7/w3KeIG1HfJPuh/G/CLskSCqsODozwGQFz0l
         CwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765577217; x=1766182017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fJiZ4WtxnTnGzoebgxhQ9CYSZzT17NBgC99cujKmoP4=;
        b=p+o3a6GVez5KUn4/GFs8xCwxgL+d3PDbLKT2L/vcHi/ik6/twws6oVRmftoxTFgLXq
         rk81RHkf+uF1Hj064nhYhUL1tOBIoNRR/Oyl/S9nAFtWdC65FifRob5kZL5PSAllq8L5
         NXNZXcZSnKvHouGFJ0+Dp4JcdlAUEbcfmHM9nhXbV1llZoaFMeP92cGhpjAMlmSsQh7r
         heriA4DurBwZfFeQj40dPt/ngWZo7jW1iDlJ7qDIj9sRr6d55FcfklbKQUWHV60E9rcU
         mW+199Gnzc1sFoV7iIeoUPQdiD3ajGt/WlZBqHCKC+e1x75yo2AB0WBuvd9lmR+jdipv
         nEOw==
X-Gm-Message-State: AOJu0Yw+V29bc7BEmDSEflZC2f4X23pUmYHwZHZu6FZoSrXUjJ9RMTIw
	raYQ5VQeVz5AyqabxAoHUNlguIuWM/OeEzBjuvv2y1t3Hh5rDh3FO8E2wILjM6hSrqrAlTNI2y1
	eQJRmTBApSwJgTd7+AQJ0Rwatp5FwSfBRThFJ
X-Gm-Gg: AY/fxX4M32QX44UFlylC0eVyQ2Q0oxKRuXk1ve0IEq4/Dr3faZhLBzQtB91oSrKt1D0
	zOekEVu/E67faZ/2VxT5ibji/JS/0gnrwx3T7yDZuA4+1vCfx6D7I4BGpyOZGOlNfJks/k/Wc7B
	7/fsvUGyA2wDK7wHmXxCp1jFyIUqFIzwmluWDWpnlqrxJmnXHRDxxJ7p+EIyT8d+SOP1riQksEC
	srRdM05QyKPezhdRxgCwrxLrvRVf11DpTSfNUGiGE9vbxQheEaEQu95GVGmUupuDrv4J8qoO+Fb
	ZRjhUqs=
X-Google-Smtp-Source: AGHT+IEpkYS19JJWwgAyjd54696GT3tA2FFdrXDrIAA6Lm/PVG6Nt1XGboWmlpaglrcL9YviyeB88YStSFYHR2HzNDo=
X-Received: by 2002:a17:90b:54c3:b0:32e:a4d:41cb with SMTP id
 98e67ed59e1d1-34abd7e762fmr2644827a91.1.1765577216844; Fri, 12 Dec 2025
 14:06:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM0PR02MB44500013C2F28CBBD99A113EB3A1A@AM0PR02MB4450.eurprd02.prod.outlook.com>
In-Reply-To: <AM0PR02MB44500013C2F28CBBD99A113EB3A1A@AM0PR02MB4450.eurprd02.prod.outlook.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 12 Dec 2025 17:06:45 -0500
X-Gm-Features: AQt7F2qnURQy8DYjsDFaEb3Zrk7SX42TAD2acn_l6Cb7RaV15FOtl7g81Sy1XfY
Message-ID: <CALnO6CBt7Z9bRhOzci8S+QndYUQUEszYHxfqHqiHkTXQ67ptsg@mail.gmail.com>
Subject: Re: Color remote repository part of a remote branch "pink" instead of
 red. I.E: [Feature Request] Mixed coloring for remote refs in git log --graph --all
To: Skybuck Flying <skybuck2000@hotmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 4:46=E2=80=AFAM Skybuck Flying <skybuck2000@hotmail=
.com> wrote:
>
> git log --graph --all would show something like:
>
> X:\Vite\Repository\LocalControl>git log --graph --all
> * commit c2234c6162cae9e7bfe5013a76b6c381092046fb (origin/Branch/Feature/=
Delphi/SystemPromptUpdateForTestingUsingFreePascalCompiler, Repository/Bran=
ch/Feature/Delphi/SystemPromptUpdateForTestingUsingFreePascalCompiler)
> | Author: Skybuck Flying <skybuck2000@hotmail.com>
> | Date:   Thu Dec 11 10:15:51 2025 +0100
> |
> |     SystemPrompt.md +FPC testing, +common/types uses.
> |
> |     SystemPrompt.md updated for:
> |     + Use FPCUnit for testing with Free Pascal Compiler.
> |     + Special directives for common/types imports/uses clausules.
>
> origin is a remote (the github remote)
> Repository is also a remote (locally on my disk).
>
> Both branches are in red:
> origin/Branch/Feature/Delphi/SystemPromptUpdateForTestingUsingFreePascalC=
ompiler
> Repository/Branch/Feature/Delphi/SystemPromptUpdateForTestingUsingFreePas=
calCompiler
>
> There is the possibility when creating branches in all kinds of ways of a=
ccidently naming it the same as the remote, so it's not really a remote, bu=
t it's just some kind of branch name with happens to have the same remote n=
ame.
>
> Maybe these remote branch names are just one string and the difference do=
n't matter or maybe it does matter, I think it does matter, if it does matt=
er/stored differently then the idea is to:
>
> Allow mixed colors in these remote branches.
>
> So the origin part becomes pink.
> So the Repository part becomes pink.

Perhaps try configuring color.decorate.branch or color.decorate.remoteBranc=
h?
