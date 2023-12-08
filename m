Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="n2pvc8nd"
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CB010E0
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 14:14:49 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-67a91a373edso14389226d6.1
        for <git@vger.kernel.org>; Fri, 08 Dec 2023 14:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702073689; x=1702678489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9HuSxhVeuApqEiiblUofakMoB5tJznr12BZzWHojPOE=;
        b=n2pvc8ndf9jgRzteegnxFzXAK6hG+qQIR63uiCQaXHJTMC9Sm2l7rW3pdETlDOrRgE
         2dB7STFEbiZpFYq3jZu70hNdXKyb1q9d3EPujGWXqL7qXjqjS0+9bh3jbu6+zS2dk+DY
         DocRuzuvytw3dMSOQ4DpjLOgyruupPU4QPowl8+YZPLFQEuPEU4NC7B8kdSaKLjICkaL
         FKzrfEEZQsk/GTYtOmMc/tEb3RgkJPS/7VmBYKgDrKF4X8CGaT6oX1xEP6HZeKPINikH
         hpyHu8pRbqW0PCqcWMzCFxpebQmllaVxxHkXHXlCzAVxlRsp8Nhp/NoxtK6ViR53CAZW
         byjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702073689; x=1702678489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HuSxhVeuApqEiiblUofakMoB5tJznr12BZzWHojPOE=;
        b=SchECR43Wx5ft6RQJLDuENSznkA4RP13VgF93WLrK0I2R80CLj7Y42BxuoPSb9nBMf
         GDjyDfxIMQMHseire+8tZgu7VoYlRFRN3KrHf8jTAcA+mvoif5Q9Fk/u4ztZGKagNr4J
         nvdG7FiBykxau8tt90Bc79L2BUZ/MvBikHl3i1vDQjQh3YBeJTAiEsWU35fPM07tRna0
         r30rk1nZhKg6MfPO0tc3lGjTZSrQIL4ZvUSjyzm5V+ju/sU0wN3fXPIjsBrsftBlzG5O
         +C5RZ03HOGVq7yaogtwrnxGufv/wszQYDN37wk/fiBusjInfPOaZbvZDyZBsG9149JQJ
         bVxw==
X-Gm-Message-State: AOJu0Yw7HbTppANkHU8A6uSaAzfdroNHckuDSM1pxt1hFj0X36CEom+o
	K0alAY+RQhMdFmOFVQdr7YjyHw==
X-Google-Smtp-Source: AGHT+IFEZ8UjGtvCDsuXF91B8VPpqaTp2UJLTmQO7nxyKP+LT9xszWD6cH1huTTwCi3uEgDV0nr49w==
X-Received: by 2002:ad4:51c4:0:b0:67a:a532:2f1c with SMTP id p4-20020ad451c4000000b0067aa5322f1cmr630917qvq.31.1702073689031;
        Fri, 08 Dec 2023 14:14:49 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ez9-20020ad45909000000b0067a89dc28ecsm1121405qvb.95.2023.12.08.14.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 14:14:48 -0800 (PST)
Date: Fri, 8 Dec 2023 17:14:45 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 05/11] reftable/stack: perform auto-compaction with
 transactional interface
Message-ID: <ZXOVVWGyUtrGWYMB@nand.local>
References: <cover.1700549493.git.ps@pks.im>
 <cover.1702047081.git.ps@pks.im>
 <77b9ae8aa675dd96dd10f4a5369f1f994fa59939.1702047081.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <77b9ae8aa675dd96dd10f4a5369f1f994fa59939.1702047081.git.ps@pks.im>

On Fri, Dec 08, 2023 at 03:53:14PM +0100, Patrick Steinhardt wrote:
> [...] It can thus happen quite fast that the stack grows very long, which
> results in performance issues when trying to read records.

This sentence was a little confusing to read at first glance. Perhaps
instead:

    The stack can grow to become quite long rather quickly, leading to
    performance issues when trying to read records.

> But besides
> performance issues, this can also lead to exhaustion of file descriptors
> very rapidly as every single table requires a separate descriptor when
> opening the stack.

Well explained, thanks. Everything else here looks good to me.

Thanks,
Taylor
