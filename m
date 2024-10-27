Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6466188A0E
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 23:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730072292; cv=none; b=tFtxHbWHGlW8QPdldbZHot3+jV3gvN+WRuk8+Bin2M8AGwKLAY+fxISSFJIEci834die+RkbNhQ6dbJG3OoJ27tujAg5O44wgCRDy5C5QPcM2ZcuVC6qoGilQDlF+CHpVSghjn9dYRszYNhp9uZsc/fDr7fpSJiBUsEq1uRuN9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730072292; c=relaxed/simple;
	bh=ZibV2bu61h6tWSLlve8oaPjmI04ugzx+C7rbY5ESOew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqrqehNKPXv+x5s0JKUvnUTAiHwnGJTC39cA/ffSVu6hichJlQSQ/+Xz1OsqL+ImHIJTF7MS7uO2ODkaMAbka/nWWhkOAKw3KeVsDqlanJ5fgBB4dBMuxD4ydNdAdNXlg1QwywnKbPP+ToLWSGpcJ51ocq0tmhAAq3ok629qA1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=j1rotbpr; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="j1rotbpr"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6ea051d04caso2478527b3.0
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 16:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730072289; x=1730677089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZibV2bu61h6tWSLlve8oaPjmI04ugzx+C7rbY5ESOew=;
        b=j1rotbprbcUKtJ+MQf9j5T/z6BDTVgwxRxykMgvGFdK9r5mK6n9tg7rcffT1CVyryu
         285n6Pi5VhXlX7m85zjjF0fikjbnVARi4rpHQv/Gj+jJS4etW9yjE3Cq4pWn+8O0PbnY
         W9zq5ur8OsXhzTxL6o6eP416YXDi9c0QGgR34APVqhpHED2UbjzOIKIu2vSdRNWMbYJZ
         cWYN1vhIw5Mtr5NWuwhx143wa3HZO88HQdFSPlgLP9jEH/UAS2qqqVVzYcI+jc2KnVmT
         /WtBTZEaAnoUoSaFpX897BRCkY5y5y0YsjUDbWuUsvpxhLUO4Vkk7E60PKeccwj/Nasb
         QcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730072289; x=1730677089;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZibV2bu61h6tWSLlve8oaPjmI04ugzx+C7rbY5ESOew=;
        b=UM8WtvpXd693uLPr3bKM9uA7JBwu/Gap9QpdVdVebpDd0/JeK4c3vT8ybVY9L47gZM
         e4fQW/0+ru6t7twt4pHx65MQiEctQhoYQjhoqDMN1TCNEmLLDfAxz79DNkqXkgBJuC4E
         ytxb2OTAJEZ2EtS8kotlLjsbV1CCdQifBo7aUzLVzaTxutppCO4qxx3dA8RcMcYjzbRp
         Zd2JXBkiiIRKGNidMg1MguCGTk8Rvcve7MEY73VJZG3WCk1cD/UINlrVqMx4DD3OIvQN
         aKTJfZtMzyLiWpfQVC4r/7RNIqSDXnAiAqHfdoaeZZ7fEFCMlewdcS5U1x8kBC6yPrfa
         r8Pg==
X-Gm-Message-State: AOJu0YyNr2B7JnwAmX/jmH12PXZeuVuWjinB0ylRR7qQu61BhTA5BciK
	9MHXnKF4ZzFpJxfjjcdyNT8ETg4zp/hjcU5CjnPNvNCc3q60pyP3ckwfM5C57casuYbo0oZQ5OU
	wmqc=
X-Google-Smtp-Source: AGHT+IFXnZsvYHOieTUykG4TN3uP5WoJkqWtS+7IaFcp4UtASDq1YGNmwEdQAUU6dBAPb/2Ig/68+Q==
X-Received: by 2002:a05:690c:b8a:b0:672:8ad4:9461 with SMTP id 00721157ae682-6e9d8b3c742mr62089477b3.41.1730072288843;
        Sun, 27 Oct 2024 16:38:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6c19de0sm11955197b3.73.2024.10.27.16.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 16:38:08 -0700 (PDT)
Date: Sun, 27 Oct 2024 19:38:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Devste Devste <devstemail@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: 2.43+ git checkout --theirs on stash error - no alternative?
Message-ID: <Zx7O3VsZX2B9d9qN@nand.local>
References: <CANM0SV0KKd+WN4MQ1_8fEvFyD4tYY3qAUsUh9Njcy1xo1hNSBw@mail.gmail.com>
 <CANM0SV0Muk8KT6Mv=14ui07c6OzaNDDQwg2bUVRb8JyJWTyHnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANM0SV0Muk8KT6Mv=14ui07c6OzaNDDQwg2bUVRb8JyJWTyHnQ@mail.gmail.com>

On Sun, Oct 27, 2024 at 11:31:05PM +0100, Devste Devste wrote:
> Turns out the previous behavior can be achieved with
> git restore --source='stash@{0}' -- "some-file.txt"

Hmm. What you wrote above here makes sense, but I agree with the
original change from Junio (CC'd) that using `--theirs` does not make
sense when the source is a tree-ish and not the index directly.

This is different, though, since here you are just trying to check out
the contents of some-file.txt at stash@{0}, without `--theirs`. What did
you mean in the previous example, and why was `--theirs` necessary in
the call there?

Thanks,
Taylor
