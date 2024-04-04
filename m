Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAE5CA40
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 07:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712214539; cv=none; b=CthLocDxsMXzZRSdB2VP94aFVx3hPUlqLHOP9Dd9jIfc4yQ0b+1acWfUDGip5C4TJrYtZRi8vlMqVAUwxrQPqYKrqHo1xFmGY7AoEj14W9hBNe7OcPm5RfMtU546mwXO/t4Gco4cCaDPhQbQKbrbzLZCtpmonGh3S0e164+MPss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712214539; c=relaxed/simple;
	bh=jBx7DU6kcfGT5jGVPwatjGoN35lQsmAkV8RasQj9418=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jsV1nHLBBMixi4Iqw1Plnf4AWFxbaBQ6SxIMi8gVvReVazeaTMXWlp7+DjzTZaNYHIGkd3Db17ceBNHV4a+xiKurTSWSJGDhxNbHIyrsEFXc2tvz4j7MIloVPbPizOekZWVvKZlAGLyDZRa5VQq2QixVSp2/Ish++JsrRBbgeBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePw5LXDc; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePw5LXDc"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e703e0e5deso554854b3a.3
        for <git@vger.kernel.org>; Thu, 04 Apr 2024 00:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712214538; x=1712819338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHhhZtARqy9Ll6AK8jM2iZqzCooL3cO5RkE+j3wW12U=;
        b=ePw5LXDcQKtnYieRhk/9D/YFwcsu92IG6oGDeU3HLUHMdb4MtQmmnKCkoanGAawWYC
         Cbe+ewrstZZKhwsMTlYLWF8rxXOmVoT99xqXxZYpkxos3XnDgAqnZX0DCfrW4hLVD7EK
         BrifKKZGYAIGuUUZYV773XuRvwG6nMsc2Y3OLchLAZ8au12KFcVMzeoNwfLB/xFeI3Ka
         kxeEraFYVSEKEHMW/6B8DN5rDB3zgUlTPpAYQRuhgHxsEJT42P8F9TLT6EvYhHz7PTWS
         MYhTlGDal+0iqyqA4Xmiv4LlBWfwJkjy2plqqevq0TdZiYh/V+TLti8XPnyMbpy7FQJo
         T3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712214538; x=1712819338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHhhZtARqy9Ll6AK8jM2iZqzCooL3cO5RkE+j3wW12U=;
        b=T1SqLEZF9My9ZK24VbmIVJVLcMUhTOyRv3n6lraoMubV5DjA0/L2VdG9n6CyZ8MMi3
         4sH+Cvwy9nM4tQeyhMAnmfrvz7rgNnlVLQ6CyO4Z1oXlqfnVZqlV7o/QORnhdhaHikv0
         Nk4hlnVm/iU69E6nk8Suoo2fMjjzc14xMuZC/kK1NIGViYjsiXl/cJWda4F75IjC1OYD
         DpckTFQlJttaghXmeoQG33+u96BRbf8GRj5PAi522RMOLE8fKnSR+S5Nzow/Z8zOU+ED
         DaoZTIKMpOHq+UdQWpW2uOPblC/B+jTEKRaUMfTVc2jp4QR8ScVNkj1NTV6FxX0JNfVB
         gOAw==
X-Gm-Message-State: AOJu0YzESNbGihymzx94469R7VvL+13J0g2KvctKrMJkWPsGkLQ0Cnzq
	4ChfOUiZF8xE8ArZ17Lxtq9/WYiYLmNzMe9+2Nk+XES2t0nKaQatfNFE8GqmD5kSOj/ImTWrUPx
	iBy1qPfut8xVzmWM/2O82GfBF1w+dPnOfFo0=
X-Google-Smtp-Source: AGHT+IFhuYP2Od7USYqkx8MefOrf6Etlvcr++1hZxTAKl2MJeaYPRa8TJVddYJ5JGeJu4FUr2bilfsAekJuBOA6d53c=
X-Received: by 2002:a05:6a21:62a:b0:1a7:2e5c:391 with SMTP id
 ll42-20020a056a21062a00b001a72e5c0391mr1503684pzb.57.1712214537773; Thu, 04
 Apr 2024 00:08:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1712078736.git.ps@pks.im> <cover.1712209149.git.ps@pks.im> <41db7414e17201f85b476af5e0183e72de450310.1712209149.git.ps@pks.im>
In-Reply-To: <41db7414e17201f85b476af5e0183e72de450310.1712209149.git.ps@pks.im>
From: Han-Wen Nienhuys <hanwenn@gmail.com>
Date: Thu, 4 Apr 2024 09:08:46 +0200
Message-ID: <CAOw_e7aBPF1vPvF7iYXCM5VBQu-Nw00dO2pRC_6DU3PtdDUsbg@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] reftable/writer: unify releasing memory
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 7:48=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> There are two code paths which release memory of the reftable writer:
>
>   - `reftable_writer_close()` releases internal state after it has
>     written data.
>
>   - `reftable_writer_free()` releases the block that was written to and
>     the writer itself.

The bifurcation is there so you can read the stats after closing the
writer. The new method makes it harder to misuse, but now you have two
ways to end a writer. Suggestion: drop reftable_writer_{free,close}
from reftable-writer.h (rename to remove the reftable_ prefix because
they are no longer considered public) and find another way to read out
the stats. Either pass an optional reftable_writer_stats into the
construction of the writer, return the stats from the close function,
or drop stats altogether.  IIRC They are only used in the unit tests.

--=20
Han-Wen Nienhuys - hanwenn@gmail.com - http://www.xs4all.nl/~hanwen
