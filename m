Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20DF1E86C
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 23:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709423342; cv=none; b=THC/OxjvRL/a230Qtsc6rDTeBxZgqam4cEbV614NggKhFKGEl2Aq9pzBo58k8xDaAB2dt6t31kkxi5BbktuVewL1t8sf+S50HjRRIMeoyBEtQ1Z9+otFqE0tsSIgy0JsGfFHY3SP/2ZTN17KJeH8xorzuL6fE/Hl7O+TDAEmF5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709423342; c=relaxed/simple;
	bh=ao3+ALloN8+yJLkYvdIjYAUs0htANODHMCHSeHuQOdg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=cY/NGCI4009m9Yy1K8dqU6JlNUZsk8fXYBCofpPo6cFUupdKVUkRSNceRW8JsqCAx7ejoBDJGDM3pyQRdVTRMgW4YD8VOgR7Dss0GQH7o0eUMyTsDbIUtr4KBW+u9nt7YV+RhXsodn3jdyP2QMkdRWFXbUTcMAI5rgbCX1yp+XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GHV47oiA; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHV47oiA"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5131316693cso4202906e87.0
        for <git@vger.kernel.org>; Sat, 02 Mar 2024 15:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709423338; x=1710028138; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ao3+ALloN8+yJLkYvdIjYAUs0htANODHMCHSeHuQOdg=;
        b=GHV47oiA9xC8fzUBXNit91OM3uNHrpeVle36YUZK3KhV8Fl5+Wda7vn46lxiJgB9Ks
         vDiEx7xWvmy8o7NV8ZSe1cQqd8vn+gjw4tKmzmWzbUo34KV7R/ud0e2tEzq8tevUc8R4
         xk2nXsR0vV+O9htG9RR7EEKzm8SBcBU+wL0hqQm3q/sIIZ8vDeIBQ1iFtU1IS06R15Yj
         5QU1MEf0/mLXvRLjAt6Fybbkn6H3JYkQwo9rxLeJQS3gN+ysSMqtm4VC5RcSJMjpuMon
         pIXB2jMQkxnmQPtdX1zUzZeBm3espznT0vTbI8shXadYyV3syh4yRi+1ZAgCHGXd9SeQ
         0iBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709423338; x=1710028138;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ao3+ALloN8+yJLkYvdIjYAUs0htANODHMCHSeHuQOdg=;
        b=NTKr6i+EZ2USr12RgSDBkJXwmMwaIzn+c5Ocr6gZTCYWYdLko/a7ozlokQqR+qIZNK
         MhfgZ6ukPR8jU81aaPLZXMU6sMkGQYUCqlA9DlSAb4gOajE9lof0GImi+RRRNanadrit
         /ij/tHBIl/XW3e3hYyzDsytlj1Sbk0HTTHTrsZc1j4fnPXP0H9JkLGl92ophm3sYweAd
         58ydNR10I/OKVdhWc/Sg1it3na1fBD9X1ErM6EBPogJIAXj6JlTWP8KvtKeDfZMuuMlq
         NEYhDd0JtrKV6owCpXkXdsq+I13T2iUTeoGvGbODp+UYP59Bj9w3LK5+fAO81MnTepzk
         kpkA==
X-Forwarded-Encrypted: i=1; AJvYcCXVG/R1NpDD1wSDFhWnFw6BS59rJQbs1nMaLuYZO7RvSC4GrdWCWtjxd4Ij+6QOQZ2xnUVSH6rFg9VqfOJ/6KjIjU9Y
X-Gm-Message-State: AOJu0Yx8afUH9bxCT0Of+lnKavomkD4uaNJYZALoKVn6lqFClce53/Js
	uz+3zIUxCaq2M4PPfXjQMiAqwQmKshfbmrDOk8r4ptKHaVjhO7nrCn/hr2tDKIQ=
X-Google-Smtp-Source: AGHT+IHkweanJwKoJOtY8KYf9U9Q45kNKOEAkYVKXykZLQghvHyMHZJjwyhPNWQhnXCsaCfTsmUWog==
X-Received: by 2002:a05:6512:39ce:b0:511:54a8:3adb with SMTP id k14-20020a05651239ce00b0051154a83adbmr5178149lfu.2.1709423338349;
        Sat, 02 Mar 2024 15:48:58 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id q28-20020ac246fc000000b005130ece9099sm1113148lfo.277.2024.03.02.15.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 15:48:57 -0800 (PST)
From: Sergey Organov <sorganov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <avila.jn@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH] clean: improve -n and -f implementation and documentation
References: <xmqq34v6gswv.fsf@gitster.g>
	<51a196c0-ea57-4ec5-99ea-c3f09cd90962@gmail.com>
	<87frxam35f.fsf@osv.gnss.ru> <6033073.lOV4Wx5bFT@cayenne>
	<87r0gs8kgw.fsf@osv.gnss.ru> <xmqqwmqkwdef.fsf@gitster.g>
Date: Sun, 03 Mar 2024 02:48:57 +0300
In-Reply-To: <xmqqwmqkwdef.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	02 Mar 2024 13:07:52 -0800")
Message-ID: <87bk7w8aae.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>> Oh, sorry, I misinterpreted the patch. But yet, I'm not sure that
>>> specifying that this is the default or not is really useful. If the
>>> configuration was set to true, it is was a no-op. If set to false, no
>>> message will appear.
>>
>> I'm not sure either, and as it's not the topic of this particular patch,
>> I'd like to delegate the decision on the issue.
>
> It is very much spot on the topic of simplifying and clarifying the
> code to unify these remaining two messages into a single one.

I'm inclined to be more against merging than for it, as for me it'd be
confusing to be told that a configuration variable is set to true when I
didn't set it, nor there is any way to figure where it is set, because
in fact it isn't, and it's rather the default that is in use.

Overall, to me the messages are fine as they are (except -n that doesn't
belong there), I don't see compelling reason to hide information from
the user, and thus I won't propose patch that gets rid of one of them.

> And involving the --interactive that allows users a chance to
> rethink and refrain from removing some to the equation would also be
> worth doing in the same topic,

Worth doing what? I'm afraid I lost the plot here, as --interactive
still looks fine to me.

> even though it might not fit your immediate agenda of crusade against
> --dry-run.

I'm hopefully crusading for --dry-run, not against, trying to get rid of
the cause of the original confusion that started -n/-f controversy.

Thanks,
-- Sergey Organov
