Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9453A288A2
	for <git@vger.kernel.org>; Sat, 27 Dec 2025 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766830722; cv=none; b=E9TW1EYJhFqUwiJjae7EOfp8MschEumcDQOZBJk4DmDSdD2SNHykp5pfTbW04LGiJUMjuWgqbatR7oFnHar3J6HELAYCYRGvzePblI2HQjWoPb2MHT5mH0wt1WQ0YrBbUvEgrjUSS1Vi4MiSmulajaseQx+aFf7orDmE4lPOuLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766830722; c=relaxed/simple;
	bh=V1lXRNpbzOq3iShA2AVtZyci4FHREbtKn36Jqt8sdMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZOCNB6yqiH47jCyeXcYot9pO+9jhCYI7wLLYEUXlsfuY+auRmuxhfdBZ07OJ0P0cXYEVh1sSt54XTYkDgQAhuB0MpcaNaq+DNtQ4KAcdDlwYcBqwpaTExCl78Ne9zCpsUpky7nc+Jb2W0kbkyWFe8IgncKxCO0BgTEOiPCQblSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTMc+7bL; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTMc+7bL"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7a72874af1so1334084066b.3
        for <git@vger.kernel.org>; Sat, 27 Dec 2025 02:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766830719; x=1767435519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1lXRNpbzOq3iShA2AVtZyci4FHREbtKn36Jqt8sdMQ=;
        b=QTMc+7bLwcY+xjBezma5uNPTa2DTatIK+toTtCv1gq1z7CzYLKIsYaIwa7BGs3vS7A
         hzBBQ0UJsuK9ZBR2a1eWIKoArgmqq0UDq44a66M5Gcf0mdotgIcoUptO9LSGkvApA0bE
         OxcK9wJSbWP+R+560a83gXnWZgCe5KsjFVS342lvmDp0VSbS9VhuIyk50ylokSA8PCRo
         PE3wCL0YutRok7gB3sLqizq0tXNHucCCkUQCb03/yDOKi3jvM35BwI9fMW0PRprI8YPU
         xCk99Ge05HsQp1QYPzuZGF8s44VAJ//t+xXVpwSDO/ZkaG15JLOffRhyd4iJ8vRIVD+3
         qV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766830719; x=1767435519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V1lXRNpbzOq3iShA2AVtZyci4FHREbtKn36Jqt8sdMQ=;
        b=Jd7Etb0dU7amdtgPJlxlo8yFari3sylhN5YJ1yF0PkrgTethcwp/KhgCAfNnDubEqX
         p5p8WoUfIcGz73zelAh1PaE9/qajaOM536xaDAetwFkQhRVIhvFDLEQJS29hEM/4VGOq
         zk1BIJdxGMpSiV282PBkVTdd6/Il1EtddO6sbGzdTAE2wCVX3VPB9erSCFd31wBsFFvN
         AokGepZ+wUcLlSd5eT0NO265PnAi52T6xYDFcug5bp5NUHX6egcRTQ1duhQX9mx2S2fv
         Rj8Rf61FnzKJyavbCAUANT7721lmd1a/HYcqH66XyWnIeN9cVbz5CCsUrwfUvRmVmYI0
         EpdQ==
X-Gm-Message-State: AOJu0Yz4ZQ9eSUiliKhR5x5h7OV9hdvZ3lNG/QLmjhu40HwEU29a0AaA
	Rik/ggaE1KG57w58bBjA34zkpogT5u97alLvc5rrtsLfB7QUNWSrYAZVJCdppPUDKGrk+FrHWHn
	7ytCliCTCsM9jHaHXzMetcRCsifYZEzg=
X-Gm-Gg: AY/fxX6/ODnsH6ms+1iSR71vOhydl7ISssI/1RSR5zGt7YoPCDrzGbVvE06bBs+1aSe
	2Yq7YlzZTZrZgO8Wd6uvJPHoks84TPFJMRrFWz6NZq3cIX86muv0wXDHq9SnJlNP9Somk+gVHIV
	JaiBKTQrDDh8TzdxCgrn29tyiVhmWJGnqW3TCBcYqJO2iB4f0WMZud9oEQDNRUvQw5e8mB+/WA/
	Qplqc4BcPoFjv6arby3Ysx2fz9G9Y2nhHkpl+beLuQRkGX6nVugFHRLbMSJThtiCPnL0jGLYc1U
	JFv9pLNT+0X95w7cPwBIONj1T8jkDcT3A36d14E5rguMq/nzGxZ1kYUu
X-Google-Smtp-Source: AGHT+IFhKEWy78F7Pm9EOvl4HAaZGoOW7ZFTLl6Vvj2fc3oFXx8ifTq2VUA6qOT0xLKFEDc3ZvWJ4kIDaIQwQuhasSo=
X-Received: by 2002:a17:907:940b:b0:b72:b433:1bb2 with SMTP id
 a640c23a62f3a-b8036ebd4d9mr2444730066b.7.1766830718819; Sat, 27 Dec 2025
 02:18:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMQGJGT+BYams0dxXYd33A91hiONCSAoUiomv-2_XqOZidYSwA@mail.gmail.com>
 <CAP8UFD2of-qANoGzqCMLOzuuuSK7c0bnC4P=FjDZrFfFh6qHiQ@mail.gmail.com>
In-Reply-To: <CAP8UFD2of-qANoGzqCMLOzuuuSK7c0bnC4P=FjDZrFfFh6qHiQ@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 27 Dec 2025 11:18:25 +0100
X-Gm-Features: AQt7F2omQq___k-XlHXfGgnuOitT85XU2I9WcjnwHBgl7h7WLSfx2j6PppaHyC8
Message-ID: <CAP8UFD3yFrr43zem8dab0Z-hGnVko5vQF4dzKf2Sva0rWSr--A@mail.gmail.com>
Subject: Re: Introduction and early interest - Ayush Jain
To: Ayush <by.ayushjain@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 27, 2025 at 11:14=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:

> Thanks for your interest in Git and welcome to the community!
>
> You might be interested in the following pages if you haven't read them a=
lready:
>
> https://git.github.io/Hacking-Git/
> https://git.github.io/General-Microproject-Information/ (I think this
> is what Lucas called the microprojects page)

Also please make sure you send only plain text emails (with no HTML
inside) to the mailing list, otherwise they will be rejected.

Thanks,
Christian.
