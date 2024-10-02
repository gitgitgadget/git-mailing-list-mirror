Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3822123CE
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883474; cv=none; b=VQfpDCequEAXhZM8N79T04NyRZ24xiAhbPiYmHXy8etT0qTNYuyfeQFSlnJC/Sm+ynejppTTRL2KQvIPjsHFjTCpn0MlHGKCYRGqdkRfpBp9oGXYqqDeoejgkcHdzj0Iw4nBhaNKaEX0+nVySgv4Wh6kU1xLQrPONAneTDaJ3YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883474; c=relaxed/simple;
	bh=9O+XL07UUqHWGIVRmN58XHBeLlQzOLDGEAYTsYER3d0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iJBvLlp562IqbSERjwEReDGPYxmHFASypZwZNtEATvGIPys0LC69GVW4VannZ38qCVPxp1GOuKI9JpDi/cK3vkl7PB9B4LMofuY7NyVwMyS6zQB7SIIvTrHfu9xv3sEULFAS4gmqBwpEpAo0zlMb1RDhr64ksyOQQJsC/JXgwWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cuydgpEQ; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cuydgpEQ"
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-5c721803a89so8802227a12.1
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 08:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727883471; x=1728488271; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9O+XL07UUqHWGIVRmN58XHBeLlQzOLDGEAYTsYER3d0=;
        b=cuydgpEQl8zL5MeX5vYfTpSIrtZUCtbrYDMY5bzSUBpJKou5I4c7HRxUeSKlLJ8+jZ
         35aEdSkPNN+1wHK0WFgkJHgPYJT+oUBFG7f1FAm5CGLnT/Qqkt2DCfThyrr/TxNolOxJ
         3Xfs/PHbFbgw5FkrjBjUiLbMDANKulkNwz7Gtgt/h30sqCB0A0yUW4+Nry7M7ySSzaI1
         xHSmGP3kaKqgDjfnEJIDselzljeVtd3vXcxn+NV27NmqSy0ziPAOMgiZgGzeX/0yt2b6
         P+Hh0Qwn7HYensb5oey+TmkHZwDIsWa2UTLoU7fATDw2+pejfISSC+8PAGKaZuiU9Pmx
         vUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727883471; x=1728488271;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9O+XL07UUqHWGIVRmN58XHBeLlQzOLDGEAYTsYER3d0=;
        b=p9IOdonAWk1dppaW8zJ+MmmD9AAk9qcI1zV1j7LzfXCEWArqwLsH37Cag3fCrZpfXL
         uco5/my71sgvxfUqiFoPSUPTLsdUEyN4FFLw6kBcwIjcKDuVPJL+hVuaeaUrBsLFgkfo
         hq6g6So9EEM571BUhm7VT3rsnMXKXwwwUqoYyX1Gsy+M91J0wRx9NOnzUBzwQcXN/dSX
         ZKlbWH92LP1e+DGI5QWveJjALPZgitdL9bchJtoNaz9/rncgMfHxIbgvLl3HZQOb8vZd
         xCatUp7VRqtZajhn/FtC0bbSqQwa7zij/mbDG72pdU8yqkZhjf5JlFaxg8cZ0lFPTrrZ
         f2/w==
X-Gm-Message-State: AOJu0YzSvBqFs/mQ3K6H/j+zOY4dOgtyNCYUrsoUeZ0lQ+TX6+5mA1bo
	dyWO3g6+V0pj1O6QJ4TmbdAyScsaxkybI6izfYAUYeklrlWmXjMg7cLYA+wPI7BoVijNM8rRVnC
	j4ot1ahz6tjPgTdgHBKiIr8UEuOjvKU8hALBMkSQw
X-Google-Smtp-Source: AGHT+IFbQrOjA/1TCFiDQ/9/KIAq4xI2kbzWS7jZy885AV0JR/U+rG3Tq8LCGfUmfjP9c4Q6Bn2NkHkjYpXj1QJ+Ur4=
X-Received: by 2002:a05:6402:524f:b0:5c8:79fa:2e3e with SMTP id
 4fb4d7f45d1cf-5c8b1b6fdf4mr3269322a12.28.1727883470493; Wed, 02 Oct 2024
 08:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ekikereabasi Nkereuwem <ekikereabasimachine@gmail.com>
Date: Wed, 2 Oct 2024 16:37:40 +0100
Message-ID: <CAK83d8qQOHdXGpWnSLLVe8cOZ+VT2PTJsYKV1sP1jGAbgEDUZw@mail.gmail.com>
Subject: [Outreachy] Intern Applicant - Proceeding to My Task
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

Hello,

I would like to confirm my interest in contributing to the project [2]
'Finish adding a 'os-version' capability to Git protocol v2.' I have
reviewed the project details, and I'm ready to proceed with my first
task
