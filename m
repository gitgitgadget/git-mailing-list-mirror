Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FBE2773F0
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776801171; cv=none; b=AubDlDFU117Vb807jEt3jBgGMF7lDtrRuIRjOz0GkllHRilzAbTPzq7JAHKuQrsIxOkoN2Zur/g5+qilZgPz6E05VEfS815I4D0CCvwKKOuTfnUMyRrPcYdjEdTkyeLO7ttB1HtuDzXbY3AodOTSLQkrZa5umMdhkrKig+4DHvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776801171; c=relaxed/simple;
	bh=r+/io/ZzQ+iPJnmqd2rH0ZFY6T/cNt9VHI8gz11n5Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+bMXRfxP/KU5AI/tzdMtAEGGI8h+gghT/PSih4JIttVJnWdpPGhD/9FB4v7bpl8l3+lqiGElvmP90cLRYw6TKhHCAyRyVOCcJ49rLayVWiuKRefzaCggmoQBPiKyeMa43wE8vdot/GHYRXjG/AvGjK4Hg7MNHKB33kh8pwTx9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=lf/phoJI; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="lf/phoJI"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-479e7e88fb5so1063486b6e.3
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 12:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776801169; x=1777405969; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8jpnDoykGMy92CwFh7QaFbFD6gsbPqFjzc0YtBLS8WE=;
        b=lf/phoJIiOIe2DMnFMGJBcxO4SpxFR60Wu0adkS6VTobAWygMs3TYzmot+B68L6o/L
         IGeKBnvT17rgsuc3+2wVOxbKImWZ/INaoJEqgDA20Vz90ir8cSD9AiNtymg8huswu/76
         5s4EDdFMlRuHRMM5OjhzUx+9/pJCtdEu9JlRn3VBbtbiGR5CIDXmC8941GZBRgeXQcYu
         LwSZxgdwDYyrQxlUtEbiAlXVSc2ntkPV9Ee2225BbBEUbbv9TpjgE3aWiGpQIacIdA0D
         uJRAC7P8r8PpXXgbt7M8uLSGzALGtA0A2d9cE9r/DUV/dP1E1iYF8/oPJIVxHgz32OO9
         W3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776801169; x=1777405969;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8jpnDoykGMy92CwFh7QaFbFD6gsbPqFjzc0YtBLS8WE=;
        b=qtIXCwmNJDPYFyI4atRU6n6+Xtzi2JpbaeZPRnFAgpVFaDwmBhQhQ3E7tAHXFqel5r
         an9JpGtmKmRFFJqXnfOQOuU8o1d/ODudB/Ne0yA4kpvqW/kJoTj7MLFKZ1+RwQrj9xks
         WpOQRSeuqUUvAUo0w+nrgAyhmlvmVT7cD+AlfiX3cWAWEkbkQ9vDgJ0cQVSNlBT3Khng
         zO6sbAysCDSiYApG0bYsj2+YzitM5kRf+2F2PrvFUn4GMZhMIK9K5U4f9xGWlHdj+OMH
         Mk9+p/AtmUuLPeq8LLm9nLih2iqlw83zT8T9j5e3kfp/XavYsucsMRJulA7jHxaghh5g
         jBrA==
X-Gm-Message-State: AOJu0Yzx+mPL1kHiaG3/n3S5CT3JNIZx5jfeoeM/rl1zERS5hbCsDz5k
	MbI+nT1PTNDFX+xJT6wKBUAOX8c6F9P1UwGsdyv4gaQa20VHwS6rKmSHVhlWck/xHZ/M/L2P+aF
	QaZ3bgt0=
X-Gm-Gg: AeBDieuZgjaOwEBKkZ5yA4NBjmV8zlA4ObiehUFrMeWsDwUqWCf3SnM+mwLNyBwgz6S
	HDx4AQYQxyIJYPdcxkl6e6yF5CejsaMwG3zHPvdjGpUh5+HQ4yW1U5svtPvvUNl8BivTaK1O/kB
	elfrX84zoxj8PraSCdLhTURYJeQJeM8SagN7NIr+2hWKpNNO53IYV1YgauKpvBmqmiw5FWX8nDQ
	ZDq84FYmjsqNUsQdcflCHOMIJjYkbzaFf6Ems9geQ0dgigF9XTHhxuAiec/uCLuSca87IkCPHNt
	9SK+jm4LMnBjqBvP+HZnBY+ru856o8y6npdSk0pActbCwPLuLpw9Cp/cJ0N+iheUIpAT0n3LGPc
	8pHxe+9sXq7Gc+1sWpVoWEGqtHX3/xzpZI1HFlaVTZriZ+QE45GEbqCWYYwYvnRuR+E5+QlWAyJ
	RVJ6Z3Fx8BgAimZAfeSJ3dVzLKpuNOZG+n1isD35WNZvVamcknRtnqIj7MvnYLY02bhZYoZFxuo
	VLTvhvZ3clK+ue6cq3KRn479YXpthPl4MI6fW0LOuC429QglzW/MyTuuOyL1krx+M5ev9+0eNW5
	64zvHxkuwxuFE2vh9q4Tljvi6Rw=
X-Received: by 2002:a05:6808:bcc:b0:467:e7b:6fd5 with SMTP id 5614622812f47-4799caf8d0fmr11758456b6e.41.1776801169305;
        Tue, 21 Apr 2026 12:52:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dcc953e39asm4886135a34.15.2026.04.21.12.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 12:52:48 -0700 (PDT)
Date: Tue, 21 Apr 2026 15:52:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 15/16] repack: introduce `--write-midx=incremental`
Message-ID: <aefVj2fSB5M3VWF7@nand.local>
References: <cover.1774820449.git.me@ttaylorr.com>
 <e8e22d7958d513c3b7d4165857392a19277df65e.1774820449.git.me@ttaylorr.com>
 <CABPp-BH-Wd5vwxHCx8BXJvCANxTzD=54DzB+YCME7bL+xnQG_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BH-Wd5vwxHCx8BXJvCANxTzD=54DzB+YCME7bL+xnQG_g@mail.gmail.com>

On Thu, Apr 16, 2026 at 03:53:28PM -0700, Elijah Newren wrote:
> On Sun, Mar 29, 2026 at 2:41 PM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > +       if (!strcmp(var, "repack.midxsplitfactor")) {
> > +               repack_ctx->midx_split_factor = git_config_int(var, value,
> > +                                                              ctx->kvi);
> > +               return 0;
> > +       }
> > +       if (!strcmp(var, "repack.midxnewlayerthreshold")) {
> > +               repack_ctx->midx_new_layer_threshold = git_config_int(var, value,
> > +                                                                     ctx->kvi);
> > +               return 0;
> > +       }
>
> Should there be any sanity checking on appropriate values beyond
> is-an-integer, such as requiring midx_split_factor > 1 ?

Very reasonable, I added some basic sanity checking for both.

Thanks,
Taylor
