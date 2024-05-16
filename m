Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478F11F19A
	for <git@vger.kernel.org>; Thu, 16 May 2024 23:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715901217; cv=none; b=ERkcC9ilGXkrXJAelhU2rODGICb3Supqd/rcQ+3VSKyQ8znSQBlQqbL1WkDdOnOxtmKrLfW/cd8pg/MAoCnAeHekYfS6pgRekkELG6ptNsDQ3HuSKM71tnx+csQqOHENXnf4ZrBRbXGIdtGBPSyV5672xLX8eqy6uHm9DEtSAEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715901217; c=relaxed/simple;
	bh=oKe9OC1d1A4VBqPFiDDyk1O0CtjQaDVNWYlPgirh+YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KKgg8IHyPF1jYatYrykbdvL4ic5OdCshKuIOf97FukYR1dQxB44kgTSAxoU/ixOZCA2+Lj7EsM9MoVc4jPmWFy84b3bBYDQY8qN51xZUE79RbSmezUzjpeq1rtXDijLXVpQw1oYJkXt25o0fS/UnX/UYG1y0zIguvchDQ0nQ0cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sqe0zHil; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sqe0zHil"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61e0c2b5cd2so66235777b3.1
        for <git@vger.kernel.org>; Thu, 16 May 2024 16:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715901215; x=1716506015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=asUVekqU7EGyaMnnvJnQjyiyOIhQxMKHfU+1/4AsxzQ=;
        b=Sqe0zHilGy85GX57Rys+imMfReyWhcQSEjupEWSotI3zou97w/xU/Q4SeFLbHH52S0
         AeR2aTNvCvxnvwwGe7Dv8s3DtcWcflEsip7+g2EWP5wdPjksujRD+5WHCV2BXZOcTU5U
         J0WLhJwM7L0SODhOjW+C2hQU2cLrHmckFKN/kg6VGpcaNC1FmNISpNRtOp1IDzt0W2WG
         PFmVHpQkfyV0Ipb+B+4bp4jiiex/sSp8rP8hiXfrm4lt5AImSeRFcJRDb+bUkXpZWYAb
         UZBC5bhgp8cS2SyfzDkK1emPVe3oLZ6w9Om6oT5iLtD16wd5mzIarEsjVE3hd6ZgqCUn
         LpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715901215; x=1716506015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=asUVekqU7EGyaMnnvJnQjyiyOIhQxMKHfU+1/4AsxzQ=;
        b=U/2Uu8tf8e9JVfiH9pHxKOTcEtuuJui+uMnkGTwmkPoVf5Irmol8toNOWq+5LyqaPL
         y9QKUyxgahP95541XkZzVgDWQnT5B1SECxwkyLzT3BarqlgVSr73k1d9ftSwYJl9XuDw
         ZMQos9P3P+TrtP0XObGpjOnFhB4gDbRnZ5aHXHPnlt8bksS3DUkagVnnnKYHRYhWQRu8
         AJEue0ARCSgXwUfcxLMdObWjI20QhXza7dzYZXiAB6zZfL4zOpWxx/PlyE0SCORq5BMH
         ZI177USnNs/KsmcZ4AnBKlD+k9YL1cSBqQ3bl33yjhjx9F6eibBHuZOhqjhp/tfJgsGb
         es7A==
X-Gm-Message-State: AOJu0YxYTq1bIIF32bP4vcRzf64BZTYdAzbq9fbFxdTY/6YAof8lMTDl
	wYpfn6DFjZGhqTSXij4RiqEbyDO2QqSSpydycYv3yl1jAM95Bg9P
X-Google-Smtp-Source: AGHT+IEdApYB2vCzI/Z3BXwhlNZXne8GmEnzqoZ6MVxgQE9Q9ad+lkNbC0pR6v1ZBM5GE/vH6Xakrg==
X-Received: by 2002:a25:d3cd:0:b0:dee:5f05:2a2f with SMTP id 3f1490d57ef6-dee5f053a37mr13444797276.26.1715901215114;
        Thu, 16 May 2024 16:13:35 -0700 (PDT)
Received: from ?IPV6:2603:6081:1e00:aaa2:f93f:6c8b:3a2:6559? ([2603:6081:1e00:aaa2:f93f:6c8b:3a2:6559])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-dee6073d62esm2996519276.1.2024.05.16.16.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 16:13:34 -0700 (PDT)
Message-ID: <c239ab15-4d48-4328-8bd5-8e2d77163e03@gmail.com>
Date: Thu, 16 May 2024 19:13:34 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: git log --name-only improvement: show old file name in rename
To: Ed Avis <ed.avis@qmaw.com>, Junio C Hamano <gitster@pobox.com>,
 Philip Oakley <philipoakley@iee.email>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
References: <BL0PR11MB3460BEB60550854661B5178B9D800@BL0PR11MB3460.namprd11.prod.outlook.com>
 <xmqqsgf1i46l.fsf@gitster.c.googlers.com>
 <25ca66fb-82bc-7278-90e9-5e1999593068@iee.email>
 <xmqqh7vg2p4p.fsf@gitster.c.googlers.com>
 <BL0PR11MB34608AE271344D508676D17A9D9C0@BL0PR11MB3460.namprd11.prod.outlook.com>
Content-Language: en-US
From: Nathan Faulkner <natedogith1@gmail.com>
In-Reply-To: <BL0PR11MB34608AE271344D508676D17A9D9C0@BL0PR11MB3460.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The documentation for --name-only says "Show only names of changed 
files." I would interpret this to mean "output the names of all files 
that changed", not "output the names of all files that changed, unless 
git detected it as renamed".  --no-renames makes it behave as expected, 
but having to specify it isn't obvious.  A warning in the documentation 
could help, but --no-renames should probably be included by default when 
--name-only is specified.

I ran into an issue today with code that expected git diff --name-only 
to output all changed files.  A file was created and an unrelated file 
was deleted in the same commit, but they happened to be similar enough 
that git detected it as rename, and thus git diff --name-only indicated 
only one file changed when two files were actually changed.

