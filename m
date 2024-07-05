Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17EC79F3
	for <git@vger.kernel.org>; Fri,  5 Jul 2024 21:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213489; cv=none; b=rZVEyIfUCI5VfsgwdYhl0yJnpLQLLrz8DHkKmI8poLtEFa0nIsZY4LhAyJTM0CQkbIpnH9p0/x+oLGkp/HV/wqc28dHNJKplJmM4H4oGaTuYGwX096QOEy3Tzkm5lzT8uLtiDkd+vRPQ2OycYkfXbCJCtyI1Vc7gPQMgOPrpopk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213489; c=relaxed/simple;
	bh=tCFyRNgclf5ePLkk/5S3TXQxQMLMhXdpL10AEf98Gfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+OiawNb1n/ZDkxK0iXm1grAY4W3c9dp1bDUB7dfQEDRPo2r7V33jzJbtJNYgCtRbJx8Tkt2bbyoLWIX/pZ9J5E7zrHIJK38QiA/IAsPK1xNTyY+2bhJcR5pQAueVdmUA7p0qu4yhXp0lDA1a+EIN5y7W4NQoK0VVl5m0Y8iGlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=vUD2HXLg; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="vUD2HXLg"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3d9229486efso284885b6e.3
        for <git@vger.kernel.org>; Fri, 05 Jul 2024 14:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1720213487; x=1720818287; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tCFyRNgclf5ePLkk/5S3TXQxQMLMhXdpL10AEf98Gfw=;
        b=vUD2HXLg1kySVE7P7mQBwP3hoRVnh+qsWh/bqYJ1jNTE8hzRfvEVkoTIPYchX7U4zV
         nr532Bf+jIdcPkSozRy+caP7RTu/g5c6YNDTxvyiR1giBXA+W/YLhDyqrpLH4t5XzwQL
         Z4aQVp3hMyh5KhIcfz/h1WWMV61p9ZzZd/mJEFXONyjUcXt7s583/RyjWD9Z4NtTLgTw
         F8h9xnrJ7LHsyRZv5L0vkCzEwG0/24dYJghc2Xg44IvNvhbGTPIdI7XQKyEYlwiXIzXp
         MPvux0K5rUALVwweO7E+cawN/QLEtpihgC+9B9rc5vqJUAObmQKJEEDBloLxZEsw2OGa
         uCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720213487; x=1720818287;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCFyRNgclf5ePLkk/5S3TXQxQMLMhXdpL10AEf98Gfw=;
        b=ieBYbF9iKvtcLgXf8M7T+c9imgAH885bkskSiGe/SgPWTGtS7jZ2azCEGp93A1YuyV
         ibAbd6g5kab+WxpijslymuwdMVl5R+HH6cmYcyTm5CynWqzxSJaox97EMxeSrKfFAGuZ
         7HzEaNdAZL6e3e6jRldnX5fmvHzLGY2kUvANi9X/g67qSyTZS2QbNij66/i84LOdvsEx
         K3uxLcZIncNoH31rOfYSsxmLnFkEaS0YQ+ktV3Ean2crl2uPtlonf+F0MoNnGcSK4/R4
         7qP4XAu/411Wuov9yAl8ihLfVa3UvszT7HNqV5lZfKtECmXtY1PGbctMNlUPW0EYTlDy
         gZ2A==
X-Gm-Message-State: AOJu0Yxl+4Oj5Ci3Oc/GKS7fQWPWkV+U6gQ8ANlVMRVsA3oL/sttxgRN
	3NufzriACQ0OYqdRIkzyJC88pBa25TsCWgcUnCNgZptAYXZslHRQlHFTGU3JlDK3Cv2hdy691nH
	NsLE=
X-Google-Smtp-Source: AGHT+IED0Hof8Qae/n5VAnhwYdYYshs7gdqlaqiOxDmSh5WInROKnjx2665IoA7ui7c1BltBoePXZw==
X-Received: by 2002:a05:6808:1593:b0:3c7:3106:e2e1 with SMTP id 5614622812f47-3d914c51bb7mr6494471b6e.8.1720213486835;
        Fri, 05 Jul 2024 14:04:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4465149bad4sm72163021cf.65.2024.07.05.14.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 14:04:46 -0700 (PDT)
Date: Fri, 5 Jul 2024 17:04:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Tiago de Bem Natel de Moura <t.nateldemoura@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git diff-tree do not honor diff.orderfile config
Message-ID: <Zohf7LzaRHaG9vX6@nand.local>
References: <CAJFVNCfz_-Dvd0ctc4w-2jsthyPFxy=HOutj=3PbNnQ-Gsz84A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJFVNCfz_-Dvd0ctc4w-2jsthyPFxy=HOutj=3PbNnQ-Gsz84A@mail.gmail.com>

On Fri, Jul 05, 2024 at 11:28:23AM +0100, Tiago de Bem Natel de Moura wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
> The config `diff.orderfile` is not being honored in the `git diff-tree` command
> as stated by the documentation.

Makes sense... the diff.orderFile configuration is part of the "UI" set
of diff.* configuration options, which are honored by porcelain commands
like commit, diff, log, etc., but not by plumbing commands like
diff-tree.

I think from 6d8940b562 (diff: add diff.orderfile configuration
variable, 2013-12-18) adding it to the UI-only configuration set was
intentional, but it is somewhat awkward that we respect -O but not the
configuration it falls back on.

So I suppose the question is whether supporting -O from diff-tree is
sensible. If it is, then reading the diff.orderFile configuration option
is a no-brainer. But if it isn't, then we should probably not make a bad
situation worse by adding support for it.

Thanks,
Taylor
