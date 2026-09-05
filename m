Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB7F27AC45
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 17:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788628428; cv=none; b=LQO/BKn5qMaAfVv24O0RN1h0L79WQMjRomNdL4O2kOfi7OLdLgeAVPkck9pP2UFe+HFBBxP4OeEwro1vdTA3XarxMrgE7wELMkOpeLD4KSTYuvqYHuB2mHwD9ZMeOn+k5PK6e/7Qd8HmVfX9y7jNu3sx5Bbam0Ic9i8kW7oF28Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788628428; c=relaxed/simple;
	bh=2aGcUYlMamxEpIbRA+UeKWW1jGuoaXd7miWuBsLwXUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLLKBe6MPtRLQanNGKgePmRTYKF9k0kIvvrT+BuLRClji/P6ZGHNN28gqDCaxkDCpNf4mIJFjXc7i3uBUfBhlBXTb5mfLVN0wpLHqZxl1SdyzE2nsVgoocxpCspb87o9wr+f0Bo2OA2uSiD1KqC+u/KLo3KiwdgnNfEjz2+tMKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=ivjlaUCt; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="ivjlaUCt"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48441fa5c37so1465871f8f.3
        for <git@vger.kernel.org>; Sat, 05 Sep 2026 10:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788628425; x=1789233225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2aGcUYlMamxEpIbRA+UeKWW1jGuoaXd7miWuBsLwXUM=;
        b=ivjlaUCtXTuBh+mgRP6J6l1stvcOzsyR0ODd0wQdCJrAcp0H+sxvXAZNa7ScNAsoyW
         50V/QcsLNhNPJ3nlWo0e4IBkZzlHMGKuytpI+gEAAfDqHXHGG/X+yfGvtPBBfRn78jrj
         /AahiVEtaQ9NGs0DtguJyEeRw7dbdWstQr+a7SQmNLVmMuwO4zS9CSeahkCfnwcUFxcH
         DbJYwRdijPszK/8vqWH+PLkEouA97Tscjsy4x1NxTgnMMlA205+UMqhK1jvaLkHbdXqb
         M0YEVo5j5A2CZEplLsdyF99ysdX6OG8qC1H1Dx9tJooGmJpXjzr23zc/WJwQOQMKdsMP
         l4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788628425; x=1789233225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2aGcUYlMamxEpIbRA+UeKWW1jGuoaXd7miWuBsLwXUM=;
        b=RghEzO7dXQ3ehakcGxk7Zi03TqwPnx0DNRh2bJmuNndMCZdY0j+BAWr4CpjtaC/TdB
         D0vmsysIA7qMTjE3EbzfOjmeH7b1dPhvXSuSqtn++OcpYBAUKw4YxAypDBfGKdXCV9tv
         iP3gZxQgcqFfmXwWBTthz7jcQPhKVYp6pzvzhKLqDjTwOSB7FIuB/bQeL8j33i7dPw+q
         /uzEIUA+XyNhkWGw/4Z8xAMmZnz0A+e33wJ/6xreSB0tmk4cgSjELqwHZI9n8MED6DjI
         R/ofMf3VcJi+jhXONRzmfRQ/6dR57h97+mURXCWnTwiqiyYQPwJxkWYc2X2MeZdh4mCS
         Js1Q==
X-Gm-Message-State: AFuF++mEHU19R9Agk9Sbc5DlUtdVKSBu8Tp2cSAri9qWvYHMzRWwkvvm
	6C1gqMoZzZ86kQMDtH8BLxBVky1cq2YciAdwP2krZmne4Qcbu7Wdl3OIdFXWNFDLkteecYdVLEi
	Ruq4Obd9YAWz/
X-Gm-Gg: AYBFou0E1tKiPcV/7WmIaY2IzpUCGbT88RjFqzKVChjEH8lTvZA65SDPyqCJAKKYw6s
	7PRniWwjv+eBU9Zueqk+FxCLT8arl/UclmNRUJ+nq473iGbscMg8UccCCOrNzmieDxWTNBtrEsg
	cPG5Gi6LzVPnDkOslLUG2WOSkbAoiudIu49FCJxR+oXKzhJkHeygmHFBTK/cbpeDDAs0893HZSl
	Kh3Dv2vG+6M/9AtJs+zU7iITYzDWD8ny+00GRkyqD6frVpW7jQjJclSJcZ5RuGMlWmovjtvdwZ3
	BAfBvBFmSoMnI/O9FUNrpnE5iDWsG02OOfWN34wkZYvnifJXKnRn5j762EYLWuJB3WxiSVL2E30
	Y64CeP2kuLXlxtxeysZx0Du5oNDdme7+qAlAb4awQPzg79Clb7KoYV3VVML21PjZjTd2SmsCSRg
	yLbJTqRVvH9xF3BhTOEgRVtvipBZF1JN6qk1eiOsWmVfty6OL2zA3J9Bgt8AKqfQWEqaEM
X-Received: by 2002:a05:6000:230c:b0:485:8a46:b3cc with SMTP id ffacd0b85a97d-4858a46b4fcmr10618984f8f.52.1788628425412;
        Sat, 05 Sep 2026 10:13:45 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588390e30sm14922056f8f.7.2026.09.05.10.13.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 10:13:45 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Aleksei Sviridkin <f@lex.la>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] push: fix --force-if-includes when remote-tracking ref has no reflog
Date: Sat,  5 Sep 2026 20:13:43 +0300
Message-ID: <20260905171343.34722-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <xmqqpkyt3qul.fsf@gitster.g>
References: <20260903010547.85469-1-f@lex.la> <xmqq5x0mfgyh.fsf@gitster.g> <20260903200015.36849-1-f@lex.la> <xmqqo6ee9jtx.fsf@gitster.g> <20260903214551.53918-1-f@lex.la> <xmqqpkyt3qul.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:
> I prefer patches with human-readable explanations and known origin.

Dropped the trailer. You will not see it again.

On origin: this comes out of git's own tree, not an outside corpus, and
that is why every claim in the message names a file or a commit you can
check. The change here is one line, timestamp_t date; becoming
timestamp_t date = 0;. I read the whole thing and can explain any line
of it, and the sign-off is what carries that.

v3 uses your wording for the first paragraph and explains why zero is
the right fallback rather than "now" or a fixed age.
