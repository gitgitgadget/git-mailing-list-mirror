Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2719B27EE1
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="gdbiuprV"
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3613131
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 08:46:09 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77891f362cfso84729785a.1
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 08:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1698248769; x=1698853569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xsCAN8tmMOWfyTreR0/tw/chd0RYFl8oTKqlD0Je9lU=;
        b=gdbiuprVY5NneM9r2Z38UDvknWkBcURJiP0aI2IpgvJ4TsGgw8zH7/Hy7o2yqcOOLc
         z9eOsJwDfcp6FGhtk8WLiyb5NPH+K3UxM/+V4f6t4+EUmGjGd+tl8mxL7T0KJFXRtjkr
         5pA51J6t1Hcf7gsWU29w0qT4Mnx1Fq0m+tM64BABCys79cVlsQHTEbro/H2gWc1FzxsJ
         zh2joAKOkw9KtkLiW4kbG/3ha8qV1yKrQfhV4yBjyWVYHfqaz0s4wMTYd+hExck8+hxz
         GCne5RDa0Ul4h4caayXEPtx+CLsN74/4HcoVNIOQRzpmP+kzAm4pb+LlzibjGQLsjggi
         JT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698248769; x=1698853569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xsCAN8tmMOWfyTreR0/tw/chd0RYFl8oTKqlD0Je9lU=;
        b=TWHtsT5jj775r0KvuTUmbNRangE5yLZJMwL1+Khbk+rSIVzBJy0+k3R6PJrgnFKrmf
         AuXcEN9O8Nj7uAiRdgWImiG6/WBBWPlE/yyocPPvXWH98gYHYsPkVOIsxdjjgiYImjZr
         odB3hzTmYOrOc2wb0XM4cQ10OOUI3LfkozwZqLuzIwPosg7xB8lHld0WyYc+htISj7ir
         Gsu2aSMjXbLRxtW92eoqUALYYI8U1nC9zqsosYO8XNOa7AS/zLZampxEUaSnguun1AXS
         xpqtIDM45DFCQqdAPBGb4UZKjnqS42UhhFGO11wQfsxG8uHo8AdL0V5zcvzinCsoL1i7
         FmBQ==
X-Gm-Message-State: AOJu0YwQkWAtIiH+Bbgoj8HVJ0nN98QWxkDEvE2SqevQ5rETF24DLrDx
	A1OU/c665kZNHhGMhmhSEB0b4Q==
X-Google-Smtp-Source: AGHT+IHgnr668ASu0JkCT20kMCBozL7Rs6k1Xekm2FuT8wYI9apUoHn9Zzd5IdYHDieBLItlXNB+ww==
X-Received: by 2002:a05:620a:4004:b0:778:a4b4:f32b with SMTP id h4-20020a05620a400400b00778a4b4f32bmr24207858qko.34.1698248768983;
        Wed, 25 Oct 2023 08:46:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ee3-20020a0562140a4300b0065b260eafd9sm4515777qvb.87.2023.10.25.08.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 08:46:04 -0700 (PDT)
Date: Wed, 25 Oct 2023 11:46:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	"Eric W. Biederman" <ebiederm@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 5/5] builtin/merge-tree.c: implement support for
 `--write-pack`
Message-ID: <ZTk4Oz0ETcEMSgan@nand.local>
References: <cover.1697736516.git.me@ttaylorr.com>
 <cover.1698101088.git.me@ttaylorr.com>
 <3595db76a525fcebc3c896e231246704b044310c.1698101088.git.me@ttaylorr.com>
 <ZTjKk8E55M7lQN1m@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTjKk8E55M7lQN1m@tanuki>

On Wed, Oct 25, 2023 at 09:58:11AM +0200, Patrick Steinhardt wrote:
> > +test_expect_success 'merge-tree can pack its result with --write-pack' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +
> > +	# base has lines [3, 4, 5]
> > +	#   - side adds to the beginning, resulting in [1, 2, 3, 4, 5]
> > +	#   - other adds to the end, resulting in [3, 4, 5, 6, 7]
> > +	#
> > +	# merging the two should result in a new blob object containing
> > +	# [1, 2, 3, 4, 5, 6, 7], along with a new tree.
> > +	test_commit -C repo base file "$(test_seq 3 5)" &&
> > +	git -C repo branch -M main &&
> > +	git -C repo checkout -b side main &&
> > +	test_commit -C repo side file "$(test_seq 1 5)" &&
> > +	git -C repo checkout -b other main &&
> > +	test_commit -C repo other file "$(test_seq 3 7)" &&
> > +
> > +	find repo/$packdir -type f -name "pack-*.idx" >packs.before &&
> > +	tree="$(git -C repo merge-tree --write-pack \
> > +		refs/tags/side refs/tags/other)" &&
> > +	blob="$(git -C repo rev-parse $tree:file)" &&
> > +	find repo/$packdir -type f -name "pack-*.idx" >packs.after &&
>
> While we do assert that we write a new packfile, we don't assert whether
> parts of the written object may have been written as loose objects. Do
> we want to tighten the checks to verify that?

We could, but the tests in t1050 already verify this, so I'm not sure
that we would be significantly hardening our test coverage here. If you
feel strongly about it, though, I'm happy to change it up.

Thanks,
Taylor
