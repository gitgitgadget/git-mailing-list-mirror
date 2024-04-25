Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7EB134BC
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 03:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714014290; cv=none; b=ByFgR2upgqQuJWQtVP1hYOqyQBCUWR+T+La10iZYk/6nRXDRc2dmKcOgoufv8cdqyiRLvE4lRu/Cn9vg6MMVPm89bmE+mzeEdDbYhLNPkham8nrYckKb7rv3RNXTRmKERsZonJi4ELUx9JV7rIT+242vE3VPXsnFjHpQaZgvWrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714014290; c=relaxed/simple;
	bh=Mr+EdSiArRPZg30drtNc1jxItdYB0YBRAh3ffBthpvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=brVdR3IMDaBalkSCon778VXvvuXxaOSicqN0EKPFdBL3QDbcr0N60ABAzRVt4kZinx4DlhQCriEkWimP8rg+F7DHQrYzuqKqyErMBpoBcbYhEWcoG0tgUj0zsntpcFtlj+u8YbUckEhM3MYD7ciGJaTT125ie86dRYq/bsp/vSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8lOi7Tl; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8lOi7Tl"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4187c47405aso3783365e9.3
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 20:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714014287; x=1714619087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AS++PwdPXPtWc20mruHTrYnStWFA9a/bRGPNq3STSPQ=;
        b=I8lOi7TlvKPNJEA8v0tXDSkcRFSy/XCH/sIx5goINdgLOjCEMfBMhSoFXmuOO0XaTb
         4526YBPwgapaRZxoS2fxTWhwElmrjGoEWMC/QYHtWo19dFXlxhC1TZ+VhWcgLLzNbb2e
         YzszfXqmIs1CWCFxv4d1bgaCUKWcpSiELyv5PoyTNj5DcztEK29WhTtKZODduruT14wy
         oCWf2hWFBV6iuTAMdvPKgFkqY5t+np/d81hooxExTJsWjTUGjJobdYL3OBoY76dE9Y78
         HWu4KSXbkr6cZVX+VDGhH0bR6Xx2JepE3GHiG4kxxa12XADGhdmy561Gw7HRbghup18D
         cDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714014287; x=1714619087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AS++PwdPXPtWc20mruHTrYnStWFA9a/bRGPNq3STSPQ=;
        b=Q8AbtXQU/zIYZEZROJzqYjen5fPrjx4z7rMZjiJ86gUBVOr9iVXdVmsW+BfmnipGg5
         ViNbtMdWYWvfc+70NtGRiapSogAwb7Zkux+zbu91tP/ifEOy8qCMYwYof8P/h6xGUD0E
         wzZtSFoIwvuFiPd0MnGAuupeg7tvVpHXnLY6C7xkPmKqlkXkdqwKwKnhvXCoUHlPyZ0/
         CeDzLYECgE4mfovx7fPHpsNZi7DJ3vwk8h9fPdY6OwL5AS3gBvSYYiqULksUYgstgoa+
         ipjcA1uaLt2/l2ahVu5GQ54tX4QRrxkAQEzu1r5shTnujY+VVIG5NDB4UHY9USyt8v3W
         Y47Q==
X-Gm-Message-State: AOJu0YygTgAy2TRbGmD+fHTTkbVbeB+0u811w+kQl2HC5qyQx70Aoolm
	VFSB+ZWwP+YlVaWb20YMyZVzn9PMG9XopxA/3Y5TYn+1jagvwZt/
X-Google-Smtp-Source: AGHT+IHfblNk7Q1r5XcdtC203QIH6bf/vYE0algrYadS0AZVfxOhpw+iLuwqgEj9mIWNwTSXXLhNOg==
X-Received: by 2002:a05:600c:a01:b0:41a:fa9a:d86b with SMTP id z1-20020a05600c0a0100b0041afa9ad86bmr2615472wmp.11.1714014287004;
        Wed, 24 Apr 2024 20:04:47 -0700 (PDT)
Received: from gmail.com (244.red-88-14-52.dynamicip.rima-tde.net. [88.14.52.244])
        by smtp.gmail.com with ESMTPSA id l37-20020a05600c1d2500b004186f979543sm29743908wms.33.2024.04.24.20.04.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 20:04:46 -0700 (PDT)
Message-ID: <19ff10e9-12be-4a50-9163-1fe71414fd46@gmail.com>
Date: Thu, 25 Apr 2024 05:04:45 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] add-patch: response to unknown command
Content-Language: en-US
To: Jeff King <peff@peff.net>
Cc: Git List <git@vger.kernel.org>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>,
 Junio C Hamano <gitster@pobox.com>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com>
 <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
 <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com>
 <20240425014432.GA1768914@coredump.intra.peff.net>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <20240425014432.GA1768914@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Apr 24, 2024 at 09:44:32PM -0400, Jeff King wrote:
> On Sun, Apr 21, 2024 at 11:52:33PM +0200, Rubén Justo wrote:
> 
> > +test_expect_success 'unknown command' '
> > +	test_when_finished "git reset --hard; rm -f command" &&
> > +	echo W >command &&
> > +	git add -N command &&
> > +	git diff command >expect &&
> > +	cat >>expect <<-EOF &&
> > +	(1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command ${SQ}W${SQ} (use ${SQ}?${SQ} for help)
> > +	(1/1) Stage addition [y,n,q,a,d,e,p,?]?$SP
> > +	EOF
> > +	git add -p -- command <command >actual 2>&1 &&
> > +	test_cmp expect actual
> > +'
> 
> I got a test failure on Windows CI from this.

Thank you for testing thoroughly.

> The test_cmp output looks
> like this:
> 
>   -(1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command 'W' (use '?' for help)
>   -(1/1) Stage addition [y,n,q,a,d,e,p,?]?
>   +(1/1) Stage addition [y,n,q,a,d,e,p,?]? (1/1) Stage addition [y,n,q,a,d,e,p,?]?
>   +Unknown command 'W' (use '?' for help)
> 
> which makes me suspect a race. Perhaps because the prompt is going to
> stdout, but the "Unknown command" message goes to stderr?

I have to read the thread pointed by Eric, but my knee-jerk reaction has
been to think in something like:

diff --git a/add-patch.c b/add-patch.c
index 447e8166d2..0090543f89 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -292,6 +292,7 @@ static void err(struct add_p_state *s, const char *fmt, ...)
 {
        va_list args;

        va_start(args, fmt);
+       fflush(stdout);
        fputs(s->s.error_color, stderr);
        vfprintf(stderr, fmt, args);
