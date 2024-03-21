Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62605181
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 00:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710979441; cv=none; b=kpV29pAl9j7SEs7iigzSxAgqPsq4IBAlRCQ8RTmzfspa0wo/Az4PlzGfKjvFTIVXtvCQrYRuVi+5ca2KEmS5146OoLRhycsI0e0zFtUm5TjwxJFZeMvvoiSMuR4CKP6c02ff/TyTz2Mc6dm5qoAeNIZtp1yOUjjg8JrHr2mdNbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710979441; c=relaxed/simple;
	bh=N5uTPZLQFjGYtonbiYxZznUZ0H8GNcbEGasuORH/km0=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=alaLzdNFs8rvdsoCOBEtnZhxl1PSHDgYralO2LYv2jxzSOzgk3JVOe0onABqK72r32qF7Mxm/HHUShvL9m3vv2HH+GoIDEDn6lI9NV/jYpNMmkZwaBLpoBfbD2lU+bhbLx6MI3CvVX1cE42Qouw5gL3aq99DqMJ4/XiSgJAW/KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtDSSLNe; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtDSSLNe"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78a01a3012aso28933585a.2
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 17:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710979438; x=1711584238; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/Q0nTs09ZQxUZBQcCG1h4q3kZPO4WqW2Jdb0B8AcKqA=;
        b=HtDSSLNerCc3Ztx8Vp7FRjF9xdX5XYvl5g7hjGXZjgUq30/uPUuZb8SUKrGBYSVXH7
         fuh4DSLOoMmFUdbFfOhvfwdG/WBcD6pvirCUqtf6AtUdkclL8Aru6rO59mJuAyAoYUre
         maSgQa5zUSGf3sfaX0/5X6GqyOWuBU+Ezrfs0kLmgsAxQTOJABnGUtXlDwIoZGSopQoz
         HFoia494eE6sYlnRafES0/ioeU2GoY+2t9RgyXCez4dBoidqJHzlPME/VVpIlENfK/iQ
         VKkvxWOK8Lv0jXXTftOfgQpa5fk28yKVRaGMCOJms+EwL5+m2L+6eGWEKChbYBbomjSq
         PICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710979438; x=1711584238;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Q0nTs09ZQxUZBQcCG1h4q3kZPO4WqW2Jdb0B8AcKqA=;
        b=TaunDMxLgGLenFfjtcpNaGxGl4XiUqtyjj7/7OeNa/x31JPI1k0vm9TwQKwZaIDZKj
         0OTp1/P6sJvayTy4zXTV1tZ+9/fMxbLImJSAtMa28fQMdfRTEK6vNiACkiQtFtmyF+5T
         LmIt4MurV9raRDz+sHQgUqEO7F7TAFlxXyWFZPH6gJasnfoZgiE63Czuz8aP7C7bnTY7
         JcO0L2h5qWq2vnXkQIx7LYFP8DCpGzOWqNRFsPvyojsBq04HrZLGEXOPKwjIJ/C9y7sC
         w9HjsDoInRLw94qUoofFpiSADSVfPydWL/w9A+g94VdaH52+3XnOqsMjVWvUhE0RyKMj
         Gxig==
X-Gm-Message-State: AOJu0YxYzIhgKBaJx1/a2NlzBCNviu7xKfeKPvLgEszlOuTP8uQPdNJ3
	1ocHgNmCTceYN0PFr6pfwjSbKgqxYC5w0O3JnuMfuKJ7McO0/UEMzhUDaukLDpk=
X-Google-Smtp-Source: AGHT+IFa2vGZixRsgK7dLZSxlHQLQZsjPl32zEuXoB+ESUtnicxhmVHzhEc8S1002YkWR0N8LbeEGQ==
X-Received: by 2002:a05:620a:1a1c:b0:789:e839:297d with SMTP id bk28-20020a05620a1a1c00b00789e839297dmr21875613qkb.8.1710979438528;
        Wed, 20 Mar 2024 17:03:58 -0700 (PDT)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id x17-20020a05620a099100b00789f57cadc5sm4135096qkx.10.2024.03.20.17.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 17:03:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
In-Reply-To: <xmqqr0g4hopl.fsf@gitster.g>
Cc: <git@vger.kernel.org>
Subject: Re: A note from the maintainer
Message-ID: <17be9ebbcb24ec98.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Thu, 21 Mar 2024 00:03:57 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio

On Wed, Mar 20, 2024 at 11:18=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:

> If you sent a patch and you did not hear any response from anybody for
> several days, it could be that your patch was totally uninteresting,
> but it also is possible that it was simply lost in the noise. Please
> do not hesitate to send a reminder message in such a case.  Messages
> getting lost in the noise may be a sign that those who can evaluate
> your patch don't have enough mental/time bandwidth to process them
> right at the moment, and it often helps to wait until the list traffic
> becomes calmer before sending such a reminder.

I think it would be good to revise this wording in future iterations.
"Totally uninteresting" is a bit ambiguous, and also sounds quite
negative (at least to me).

To me, this initially sounded like it meant "your patch was not
something that the git maintainers would be interested in accepting". I
*suspect* that what is actually meant here is "your patch was
straightforward and non-controversial to the point that no members of
the list saw it and felt the need to comment on it", though to be honest
I am not 100% sure.

If it is expected that a "totally uninteresting" patch might, in fact,
end up in your tree without further comment, I think it could be helpful
to indicate that as well.

Here is what comes to my mind based on my (very likely not full)
understanding of the process:

    If you have sent a patch to the list and have not heard any response
	for several days, a few things may have happened:
=09
	- Your patch was straightforward and non-controversial, so no
	  members of the list felt the need to comment on it
	- The members of the list that would review your patch do not have
	  the time to process them at the moment
	- Your patch was simply lost in the noise

	If you are unsure, keep an eye on the next few "What's cooking in
	git.git" emails. If your patch does not make an appearance there
	within a week or so, you may want to send out a reminder. It often
	helps to wait until the list traffic becomes calmer before sending a
	reminder.

I don't know how accurate that actually is, but I think it conveys the
tone and clarity that I am getting at.

--=20
Thank you,
Brian Lyles
