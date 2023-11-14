Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C542FC22
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 23:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fud-cz.20230601.gappssmtp.com header.i=@fud-cz.20230601.gappssmtp.com header.b="vKSO2/qY"
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F276D6
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 15:33:30 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-280cd4e6f47so863092a91.1
        for <git@vger.kernel.org>; Tue, 14 Nov 2023 15:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fud-cz.20230601.gappssmtp.com; s=20230601; t=1700004810; x=1700609610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=asP2tbaAS6aWP6hgRJed1PMjX59L6pO8wP466X5T0yk=;
        b=vKSO2/qYhHEjeylJFQcc9/b9M1ov4mUX33cm4DZP/cYRGQwL0DrSW2tupXSVwZMpvm
         Sb3bn1GynoVWFjPeYrDFbNCLXyY9oXHn8itP46bBbyVZwieD0etix3yV9B3OgSo9r/E+
         +Hc4As5oZ0spgeTRjWZmVZ2h3+yU1MJd+UFStaYptGTxWdSmrF4cp63eWOa0RTwuW7AG
         WyWrp82YxAETZytUTdxrHGcVIWAcrIXqcQuQ0vBcnuYFBWAssVXbXJq3zpPhYxJOQHex
         hgFH69+9AL80k6Z6AbKgB3JkUAvh8d6qWO5r7f26+TPYVoooEStFiIWrrlxM7o2jN4Vk
         qEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700004810; x=1700609610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=asP2tbaAS6aWP6hgRJed1PMjX59L6pO8wP466X5T0yk=;
        b=IxObzg2RqEoFd2fuYSQVnyqAW1LnjvSsY87H4FwPcTYRDBkpXTbFswGno9RcYi2U78
         xALPHvz+aQ3CK2xaTPqwnvWPB9poc3SbVlkk8r3DGevJgdOOP2UFNTtDjXRFhAwKZdzF
         3yAKEz1YIDFqJoyxz5i/jAqpjX0NouC/dPi8KN512argZn6DwjAaDY6+55HIMo0XyqD+
         sXiAY8lt+YmqUyh8VBG+x4k7kK/2Ir3S2TXz+hrWyOkr7RFSSwpun1npTnMVgYAof05x
         hgITEsoHjRGeA0B9ha0bRD/NikdOvyqTj6FZSelZeGBAcNY/Xzxx3zAm+Mdb5y2P9Nsg
         0wlg==
X-Gm-Message-State: AOJu0YzvBzCtgUKRZKOQ2EXOvgmmZK+RCCEQjoY94DerDKqKogJz4+iH
	Jx9bXdC12ywVOoA9jHV2UdcSHLW00vJAx1mfXRkYxA==
X-Google-Smtp-Source: AGHT+IHwUM30Luv+AZWB9G5xV6pDZNedMkgtfjYM6RALHkL1qhzt8lCutb2V4+Fo5FMkSHY0N/BC+oO5k54cwqqM+50=
X-Received: by 2002:a17:90b:d96:b0:280:a26f:5860 with SMTP id
 bg22-20020a17090b0d9600b00280a26f5860mr3680946pjb.1.1700004809989; Tue, 14
 Nov 2023 15:33:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113212243.1495815-1-jonathantanmy@google.com> <xmqqv8a515ge.fsf@gitster.g>
In-Reply-To: <xmqqv8a515ge.fsf@gitster.g>
From: =?UTF-8?B?SmnFmcOtIEhydcWha2E=?= <jirka@fud.cz>
Date: Wed, 15 Nov 2023 00:33:19 +0100
Message-ID: <CAGE_+C7h6HOh+ptdhwJ3MNn5HWFoc1WF-foLRrew6FJEo_yupg@mail.gmail.com>
Subject: Re: [PATCH] remote-curl: avoid hang if curl asks for more data after eof
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"

> Is this a bug on our side, or cURL library calling us when it should not?

I thought the same and yes, I suppose it _might_ be potentially considered
a bug on cURL side in the first place. But then also

1/ it is not mandated anywhere in the API that the callback will never be
   called again after already getting an EOF once,

2/ I looked at libcurl code and it was not entirely clear to me that the
   behavior would be accidental, that it could be clearly called as a bug,

3/ anything that follows how fread() works would never be affected,
   but git-remote-curl is, because it does something differently,

4/ even if it gets fixed in libcurl today, people might be building Git with
   whatever old versions of the library for years to come,

so worth fixing here in any case (imho).

But I'll reach out to curl-library and get their opinion, so that we have
a full picture here. Thanks
