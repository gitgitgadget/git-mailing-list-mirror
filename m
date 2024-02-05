Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7D45FDB9
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707170443; cv=none; b=VBP9FriZjpAJ9RtS0bkEkLIMgCYWahc8clk4Seu8uhr4DuugxhfmjksDtv8H7QB/7zXZ80uFKDjBnoEMYBaGduB/+MwL2tl+Gfw+CCrZXiTAGqmojfiNm5oMwNWOJI/oEKbkvrEMFzdaUBZ9AgZsd5A9o8On8q7AzvfniLsT7lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707170443; c=relaxed/simple;
	bh=JVdPsRXtQfS1XuJ0Z3YpFBrdbnP7kzrwIG5h30MskBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qa7E/8YR85F7bSJCc/w4CfChXy06b2ihuQSHMQD51u3Ng4eiq6l5pnoROb5SI9vXo0bscz4iWzWJ1g24sGFRN5x2qWlkUKyrNSg0FmqKIxhz3n43nn7IAy/1P6QfpA2ONUXbXcF7n7e5suWNdiYU6yDuawCYjRIdkJLlpJB3gbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e0518c83c6so525269b3a.0
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 14:00:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707170440; x=1707775240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVdPsRXtQfS1XuJ0Z3YpFBrdbnP7kzrwIG5h30MskBA=;
        b=VyKD2t76Rx0wp7ACkkpGj9tTUTeNKER4uJw6jcml5bL7o4kv5HDZLp4qjJgVxfbx1S
         GKt7jEyW7AnYiY+Hf8DdQ/+mqX7HCh4dpzXxdLd9npCwu550bZM3zpjLDoTwCjyO3yuJ
         rgP8E86HBjuc3GYFFwI0Od3w8AMZ/tOxVTEBoX1ww60cgwDl4wvXS4YGcMyxBsgXS+Nw
         GiRBhBX4UhhnyNXRjELudbMIX4rOGouuZfe9f+s5nwzFSVtsBZadXUhNtNPYm+2kUB7g
         CZwoHebvJ6JjVc4h62TPIkfz+aEp4MTrenusWcBAZO/c0kBi2SR+B+ZX3a4crXhdOg2N
         p38Q==
X-Gm-Message-State: AOJu0YyC2wFaU5hA/N1RxmtYHoWP8jXTM/G0LubSl0c7LNJp/K6q3udp
	y5A9//wMe0LLuxjhBW8chgSNtFKatUFq14547ajFEazZKadXsF1Dc5DIryVMD2hmda3yy/hJWlW
	P+oPWMaI//AEVQYSOfxGp2/XFahsGkwYI6gM=
X-Google-Smtp-Source: AGHT+IFcYlrqSDvJvUc5y/hSdZSc7zVH6VFRvD6QEomY9uGbeZchf6k4wsriBpzy//nKBFiav4JM1G3rtKIjoudEx3w=
X-Received: by 2002:a05:6a20:a0a2:b0:19c:916d:8758 with SMTP id
 r34-20020a056a20a0a200b0019c916d8758mr634680pzj.53.1707170440595; Mon, 05 Feb
 2024 14:00:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl> <20240205204932.16653-3-maarten.bosmans@vortech.nl>
In-Reply-To: <20240205204932.16653-3-maarten.bosmans@vortech.nl>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 5 Feb 2024 17:00:28 -0500
Message-ID: <CAPig+cRVqnp8YTeDvxuM12B_bt7OoJJZc9_v=KtG_By0NJ9ZMA@mail.gmail.com>
Subject: Re: [PATCH 2/4] notes: use exisisting function stream_blob_to_fd
To: Maarten Bosmans <mkbosmans@gmail.com>
Cc: git@vger.kernel.org, Teng Long <dyroneteng@gmail.com>, 
	Maarten Bosmans <maarten.bosmans@vortech.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 4:53=E2=80=AFPM Maarten Bosmans <mkbosmans@gmail.com=
> wrote:
> notes: use exisisting function stream_blob_to_fd

s/exisisting/existing/

> Use functionality from streaming.c and remove the copy_obj_to_fd()
> function local to notes.c.
>
> Streaming the blob to stdout instead of copying through an
> intermediate buffer might also be more efficient, but at the
> size a typical note is, this is unlikely to matter a lot.
>
> Signed-off-by: Maarten Bosmans <maarten.bosmans@vortech.nl>
