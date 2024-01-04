Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59CF2D606
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 23:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xWhVURyk"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d3ec3db764so5541855ad.2
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 15:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704412457; x=1705017257; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J3wzi32SgaVuj8CklCK8iI+7u7N4ByhvzEWAWayEKo8=;
        b=xWhVURykvEUW7Z/rzVIuJmE4PMYcQ16JVQIuAPPpC7DY2HkT9UVC5470bIkf+BvhV7
         0bv/NEB9mjfCcYhXd+GJsiriiTjHLOgYZ2HU09kI2kipz5OYvCihFDEJDDan/07o9KKK
         iTEbSDU4QhSJKkQpiXuzepqiICdTuh1sW4/xXujDo4ZweOVfEVpIHio3/ipMdoJCKO/a
         NCzi5pg5XXrsq6iJk30ErYUuMzGZTQdV1GIzPSNWWHPPeOwa9/OI9l6aZY0d6am4VXjo
         V2aQv3fPrpPbK5EHPZA2AY72wu0euex4kZ9e1TL3MFr6mIugwKU+/5fg4HqoVGAXJML0
         R1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704412457; x=1705017257;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3wzi32SgaVuj8CklCK8iI+7u7N4ByhvzEWAWayEKo8=;
        b=UwOWQwsqZ9TzIFfLHFxEUdMfQhp93hrvkcmPAw5ouehtYjx9glcjJjvZ2l6jzm/AEN
         bh+vCjxiqWpuMW4Je4NtjlwaPYpn1dLtnD5llOCAXuB8SNJZJ1tGVb2f71bOtRdVFAmx
         KfOcmE/daWUXOasNmR6fJYfecW1GS20a/JkT4E0eTyhHpUXv3GuQuUd8ta23s5E2cxgH
         aWQB7U3S+uB+oLyre5/N7U65tMShwFZVievm4C838GG5SCjYLOM5SX+DUV1bryfX0ews
         lwfPqHVG59Qch8wZaDwQWsi+yWBu0+H+/qpa7t2Bx74FUEGUnXgjEnsKn+ENUEuxNDhj
         iiWA==
X-Gm-Message-State: AOJu0Yy2Q7TRANiznbPFVgyKG/OaBcGUnpiouRWUEkPg4fb9gi7+V7ki
	4FJZo4acUmtxneOXK6PIWWjgCk++FZKg
X-Google-Smtp-Source: AGHT+IHYDST5ZtQU5TKM4OG6kOV6tKu7/sPzlhK+Qw4GZ3HpkRXrQjJAlNEWzEQA4IUtn7rZlF/mCA==
X-Received: by 2002:a17:902:e5c6:b0:1d4:2b6d:d745 with SMTP id u6-20020a170902e5c600b001d42b6dd745mr1354943plf.56.1704412456737;
        Thu, 04 Jan 2024 15:54:16 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:a7e4:a1c4:6ce:d64])
        by smtp.gmail.com with ESMTPSA id y9-20020a17090322c900b001d38a7e6a30sm171904plg.70.2024.01.04.15.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 15:54:16 -0800 (PST)
Date: Thu, 4 Jan 2024 15:54:11 -0800
From: Josh Steadmon <steadmon@google.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: Feasibility of folding `unit-tests` into `make test`, was Re:
 [PATCH] ci: avoid running the test suite _twice_
Message-ID: <ZZdFI8KXsVaZuQiY@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
References: <pull.1613.git.1699894837844.gitgitgadget@gmail.com>
 <20231113184909.GB3838361@coredump.intra.peff.net>
 <ZVU4EVcj0MDrSNcG@google.com>
 <850ea42c-f103-68d5-896b-9120e2628686@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <850ea42c-f103-68d5-896b-9120e2628686@gmx.de>

On 2023.11.16 09:42, Johannes Schindelin wrote:
> Hi Josh,
> 
> On Wed, 15 Nov 2023, Josh Steadmon wrote:

[snip]

> > If I was forced to pick a way to get everything under one process, I'd
> > lean towards autogenerating individual shell script wrappers for each
> > unit test. But I'm open to discussion, especially if people have other
> > approaches I haven't thought of.
> 
> One alternative would be to avoid running the unit tests via `prove` in
> the first place.
> 
> For example, we could use the helper from be5d88e11280 (test-tool
> run-command: learn to run (parts of) the testsuite, 2019-10-04) [*1*]. It
> would probably need a few improvements, but certainly no wizardry nor
> witchcraft would be required. It would also help on Windows, where running
> a simple test helper written in C is vastly faster than running a complex
> Perl script (which `prove` is).
> 
> Ciao,
> Johannes
> 
> Footnote *1*: I had always wanted to improve that test helper to the point
> where it could replace our use of `prove`, at least on Windows. It seems,
> however, that as of 4c2c38e800f3 (ci: modification of main.yml to use
> cmake for vs-build job, 2020-06-26) we do not use the helper at all
> anymore. Hopefully it can still be useful. 🤞

Sorry for the silence on this topic; the holidays plus some family
illnesses kept me away from the list for a while. I have a working
implementation of this. I plan on cleaning it up a bit and sending it as
an RFC series either tomorrow or next week. Thank you for the
suggestion!
