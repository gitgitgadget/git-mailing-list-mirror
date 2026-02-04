Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2492459C6
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770215969; cv=none; b=Uh4RXCgxntmzeFOg7oVjtL6CX/t036NBrTrTPJ82CgKtmMD+aCWHqhFydtlWikOGJrCOQuj7BH1yvmQzoiqTTzcZaEyfpcfjRksjxBsRN6fk0iwZBmJ9vPBBFmmAH9q7M+f1VJ4yc2QnIfpMS4UFJUONjEJzZnzBg3QxUVMV/yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770215969; c=relaxed/simple;
	bh=4ADdD3bu74uuW7HHAzKQk8D0iNPaFz85BIEr/marsH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h8SBZ7OJKKPOmnfMcWzQcgLaU59PNc4damahzWZXrkjXDlJo130o52qXnqHfWyMKnnJtOeM1VjrDZCysmVK2UUjxgO7YX4cQLxv9xwUBF2jxKr/QKVR4Jsk8Rhs5J0x07lk8VYFbFsiYmCn9eKjVjOpb2neAyhkTxzlPDopDTNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzL3zTXh; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzL3zTXh"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-8230f8f27cfso3690698b3a.0
        for <git@vger.kernel.org>; Wed, 04 Feb 2026 06:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770215968; x=1770820768; darn=vger.kernel.org;
        h=disposition-notification-to:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J66gf9aTvIBRnX3IQKdy2RyvPO/Csf+8zTpFBhE2QnI=;
        b=KzL3zTXh+EL0dHzCxUXNnpU1BgK3hKt7IwYziIGNp75QUEynzt4ICDVkl2OM05YsXi
         +54dIFojjT3uFP0fafY5abhMQrh79SjmmglC9NHAUwcLDv756TfzvlmTTxpmMgyeMleA
         LMTvDMXnQpvZpJrNAi8g+D3/EYy2toQQ0SrkS+GmFJRMejyUm3PdAqJaG1Z5L7rnP2Oz
         Ll0vNVppS8To/LvhGjAZZI+hQ5wmH0wcqa7V9m61hf8A0eLrMxpykfEVAhJvi2+2UCeM
         D8wDHsT0M+fai2hstH7Dtr0DuA6NNDZWQiuEaXsmaBAnB43Yla675zzVXZFVr7r4f6jN
         F8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770215968; x=1770820768;
        h=disposition-notification-to:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J66gf9aTvIBRnX3IQKdy2RyvPO/Csf+8zTpFBhE2QnI=;
        b=Yo87OkAS93Sh4/pOU44u2TODkqfbEyqkACZBVbF4KvWtRPmVEeOQHdKJs1gHUdnN25
         YiQIP2TM2pcqQPFByH5nvgKkTsZLrZOHye0g+//KuBAb/lEge/U8+zwr9H56NJym+K25
         tASZg8rc9/dKMDCfllHtah74j12AXebInDZ3PWlsuY5kZK+k/IcNSdB7sdkGozm0nbiX
         7PnfbxR8dXgK12G347PRCoyf6TRmQ2gjIy03LKJllboAn1fVk7cMLOsA1LrSfWUGuijB
         CzV8CW4QXlM7zIvWWooXA2ZKTU6dXyO0chRzushwRQpwE/ikOuNSSh97TQjts1Zp8zjW
         rPNw==
X-Forwarded-Encrypted: i=1; AJvYcCUasMhQnqaLYTA2Wbl5UODvNcNn9AZpC1m5KenVaCMJd1ku0R05PI39bxnBp8okW6+6nkM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6rPX8y9Iwe25T6TSLeUvrpMFI+NG/Rdjf1o6flq1YGBqO9HtY
	y9eOK8/P1nyYlhXBM2NNeB+V/NHqqUTzfMFz+yogXu0De0boQ/170JZp
X-Gm-Gg: AZuq6aJ2LUYVeZ/+A0hEQIEvNa4HorvwDsMDIgLwwFuWZkvwa2gzrJYtnfNgYd9jMho
	AKZKxE/wkcGmKLn8vcZ0cKKNJ4U4VI6ivHqf8cIGeEJ3ZWlqLBQdYJUPlUoXanVawjRauKTa5Ow
	adbgrG2Lux7wXYFX6TaoGN64yqqCrLSa0Ih93crmDMnu4hfBc5fJNyvnN0wamNptVPZpdfHXhvw
	sQinaN1pIPPaOOYFNZhQAnA0EgTC0PqTfARMiYKTR3yR+mVURyWX0dFBGQe1LcptPnq4tpGV3Ox
	Se8hYkHJZawwW9zhgZFP/M4egp7Pyh5sdJqFv+z+Fc4EY1+L/aaWCaioz5NBMsLhHzeJ7cg+iQ9
	KkcerSCCYXOHz48ZFB60oiCr1BG2X1sFe3tPDVYqY/YJrGriAOCm4UW/DhjfnkTGtE4g1g9wRVr
	5zOO3kwtWzMQVPdrTN1cc=
X-Received: by 2002:a05:6a00:a227:b0:81c:6ca8:8007 with SMTP id d2e1a72fcca58-8241c7229b2mr3190764b3a.69.1770215968352;
        Wed, 04 Feb 2026 06:39:28 -0800 (PST)
Received: from localhost ([2a0c:b641:69c:caa0:bcb7:3b3c:acc6:a132])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d1d338bsm2689143b3a.28.2026.02.04.06.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 06:39:27 -0800 (PST)
Date: Wed, 4 Feb 2026 22:38:54 +0800
From: =?utf-8?B?5L6d5LqR?= <lilydjwg@gmail.com>
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Peter Krefting <peter@softwolves.pp.se>,
	Jiang Xin <worldhello.net@gmail.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Mikel Forcada <mikel.forcada@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= Avila <jn.avila@free.fr>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>, Emir SARI <bitigchi@me.com>,
	Arkadii Yakovets <ark@cho.red>,
	=?utf-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>,
	Teng Long <dyroneteng@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>,
	Jordi Mas <jmas@softcatala.org>,
	Matthias =?iso-8859-1?Q?R=FCster?= <matthias.ruester@gmail.com>,
	Phillip Szelat <phillip.szelat@gmail.com>,
	=?iso-8859-1?Q?S=E9bastien?= Helleu <flashcode@flashtux.org>,
	insolor <insolor@gmail.com>,
	Kateryna Golovanova <kate@kgthreads.com>,
	=?utf-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Ray Chen <oldsharp@gmail.com>, Fangyi Zhou <me@fangyi.io>,
	Franklin Weng <franklin@goodhorse.idv.tw>,
	Git List <git@vger.kernel.org>
Subject: Re: [RFC] Introducing AI Agents to Git Localization
Message-ID: <aYNZ_jsPtXbn6Nu-@lilyforest.localdomain>
References: <CANYiYbFhshDwfttKWYGDfO+K1qAz3ptVHuuHrWXhD2oYBF7baQ@mail.gmail.com>
 <534b9313b19a73bcee6e0ac1d7299e19@softwolves.pp.se>
 <aYNC5dlL8wdwdFuy@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYNC5dlL8wdwdFuy@kitsune.suse.cz>
X-Mailer: Mutt 2.3 (50e3b1f3) (2026-01-25)

在 Wed, Feb 04, 2026 at 02:00:21PM +0100，Michal Suchánek 写道：
> On Wed, Feb 04, 2026 at 12:58:05PM +0100, Peter Krefting wrote:
> > 2026-02-04 10:31 skrev Jiang Xin:
> > 
> > > Please try using AI coding tools to update translations in po/XX.po or
> > > review historical translations, following the prompts below:
> > 
> > No.
> > 
> > Please disable this altogether for the Swedish localization. "Translation"
> > using stochastic parrots is not mature and just creates gibberish that takes
> > more time to clean up than to do the translation from scratch manually.
> 
> Hello,
> 
> a similar attempt was widely reported, eg. here:
> https://linuxiac.com/ai-controversy-forces-end-of-mozilla-japanese-sumo-community/

FYI, less known is the fish (a command line shell) zh-CN translation
fiasco. Last time I reviewed zh-CN translation for git there were
a bunch of nonsense. And I'm pretty much given up the
docs.python.org's zh-CN translation.

I don't really care how others do things, but I hope that I'm not the
gatekeeper to review or be fed up with rubbish sentences.

-- 
Best regards,
lilydjwg
