Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3491BB6BB
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 17:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728669111; cv=none; b=chPeXc0przzcO6mhtnSgapZRpiXHBWaJDnJ4aBDe2Ya+WPpNptJYSC2jcteHaNYBGUgNiz7NbVZ79WZpykeXmEBKNpG1w4I3ZA9j9M7zy0/Z81+KesK83W35HHXOS+ukgvN7uRgVPM+S1qna2auldHTPchFbgg5gANYlvk4GY3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728669111; c=relaxed/simple;
	bh=kVvQhMfNBPDRtslOZDOaj/sWS9/vBOHYOTNvE6FBed4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gleTzDklIr/yWPNmGRFtfRBHrEU2Yo7TL4KDM1vQIFt6U6wQvehYngpFjVJVFRK22GdnmbyyLpBxR5oDO3KooxBzFvbmGWo8mZmECzYV1sVpZhwrNtIj7K4hAVCO2zEabpJaSrDgkU89Fwo3ZIYYhAjE8gi5n+iMLFa0R6VrFJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UesoiGvf; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UesoiGvf"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-460395fb1acso23471cf.0
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 10:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728669108; x=1729273908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVvQhMfNBPDRtslOZDOaj/sWS9/vBOHYOTNvE6FBed4=;
        b=UesoiGvfdZKn72XAweMkuSQb2b9x/bbodTy8v5JDBGyj8bfQ7rrRfC21bIARA9OFS6
         0X4GxK+p+/TCYyEabFanLR6pwsU5vHQEPiUF41w+Vs1lRy+optPx/Y/wFQXGt6xtsKf8
         58kqn8rvpZY3B4cI7UVN4Ekg6TgtYLS5mSPOFTwk0FruXc+D4iurKs3ZKiJ4Ha4+tgZn
         Jz9c8DDcIhnp4aySPGhN53qWeJOJOwpOMvczmm3rbe1M93ZqSRUjpivcTmJe6oLhwK+J
         QPNZmltm8lFhM45ipAPA33DErtzUCMYbmHVF5kBeqKAdIWTe1Z9W3w9on2yzYBqs6agp
         MHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728669108; x=1729273908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVvQhMfNBPDRtslOZDOaj/sWS9/vBOHYOTNvE6FBed4=;
        b=sgKHGLE9wVb4cIIfG6yLf1pbhZ95khqjQiOl6Vpcy4F/3dmd/wVsiN/3fOuXMiPqqH
         8CsrG8mr1ih3msWDzekhP4niBhD3fSjyPUcw/929gcG794q7uj6dBizBpjL55XMBqc6+
         FKbcMO4H3KfncGZSepjPuGGnyZnO50TI+KuNHUemx3QAI2zn32o2oSl86F+0CdOYwOIa
         qQjFaY2AyjDpka5M4CY6IA0tJ5uMf0mV3VMyB7RJmMjZrjsBXXHhuNMG1jWuo0cgRxx+
         cR+Ofs/QkSaeaJLXarztDxZbGgqbUHWE+FxneGGFRIwTBRRdVrhDwrBcipYqEEdtBTOR
         6OlA==
X-Forwarded-Encrypted: i=1; AJvYcCVdh8UNWSSm5NUztXAloK7Kz9Xp3bVEv7iTAEbTBeAsjYJqK1GAaCIFOKsjW2cWOJXbDQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWULQhcN+cHGyg9L9TYZIvqt3xJbD6Y4SRjuvFR1+wNgzGM/ml
	eEp3Rbx3yGQxFWgVI9PGfcI1Zi5deoGeWDIgsxGXmut6jWP6TXlwOYqrsNGQRy1kYKCuQeaxhPp
	wYEQuU2bc1KyHULszM7gejU3Qjuf/sVaOmU6Q
X-Google-Smtp-Source: AGHT+IGXBU44LiZw5tCQ99v+3k/ERy9LyE07xHOkJIXi92YYJsocRnXc2Ocbrv18vvzao0HfFwt7itjbvEr5ukAyC3Q=
X-Received: by 2002:a05:622a:450f:b0:447:e59b:54eb with SMTP id
 d75a77b69052e-46058f5e530mr116531cf.26.1728669108288; Fri, 11 Oct 2024
 10:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJoAoZ=UyfDjAvG0-kC++R7fpR871Gsi4crR=o5F3PvNfB=7Uw@mail.gmail.com>
 <CAP2yMaJc8ZDiyZrxym-azUpkUOCTjLWEkv6gO_hJ1TqU==Bdcg@mail.gmail.com>
 <ZwlLgJ6e5aWQKJgm@nand.local> <xmqq4j5ifs2g.fsf@gitster.g>
In-Reply-To: <xmqq4j5ifs2g.fsf@gitster.g>
From: Emily Shaffer <nasamuffin@google.com>
Date: Fri, 11 Oct 2024 10:51:35 -0700
Message-ID: <CAJoAoZmrGZGpKbF63aPY-kkKDEG1WqZ1N9OeKMbZyeWnfcNcHg@mail.gmail.com>
Subject: Re: Interest in a Git meetup in Bay Area, California?
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, Scott Chacon <schacon@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 10:49=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Thu, Oct 10, 2024 at 08:53:18AM +0200, Scott Chacon wrote:
> >> Or, what also might be interesting is to do one in the evening on Mon
> >> Oct 28th, as there will be a lot of people in town for GitHub
> >> Universe.
> >
> > I'll be in town for that, and it would be a lot of fun to meet up with
> > some CA-local Git folks while I'm there, too.
>
> I may be interested if I were nearby, but unfortunately I won't.
> I'll be back online at the end of the month, but not in California.

Yeah, I'll miss this as well as I'll be on leave - but I think it's a
great idea, if someone wants to coordinate it.

 - Emily
