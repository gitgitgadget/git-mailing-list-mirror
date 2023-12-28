Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD70101C6
	for <git@vger.kernel.org>; Thu, 28 Dec 2023 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-67f9ace0006so30033686d6.0
        for <git@vger.kernel.org>; Thu, 28 Dec 2023 10:13:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703787195; x=1704391995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Nz6yf7VmjQ9ofZgOdbnX1lmDr73L9KVEh9mgTfY0iw=;
        b=HgLmj5eP0+3EpujZ6jBFq1AR1uHLXmJ35YNsSww7FVtjZ+ZEly6qPHDYZXCFuWR2Ig
         XzW9g5FWiOvZ0xCPTUhk1yBpgXPZALzJqW8OHbZjXb8mR9KiyCZSSYCWMLc+9Sma9l9J
         jx4eSHufkQlXgS50wAif4bLA1iZLWyRj9piCSjJMfPnUhuExdgOPalqzrplVHAQqnusQ
         rlu97D8kE77qBvGs4c+zZ4vQuNadQV2es/o5bEMt0eMzJTH3x5VlnV+AIFJIQj73joTd
         batgHkok1SlLOInC9Ej25G+Fj7Y+nasWvfovhKNtvpinlJZwmjXRepwm/k+JXq0U3rA6
         OGpQ==
X-Gm-Message-State: AOJu0YxUvU6R7h5z0eEQy9YtKDR99wuve/2RDRq0oArIuY+k8FpRKQW0
	2Qea0G77hLaLSCvRhDCRwycefEyQLkZZzpLta1k=
X-Google-Smtp-Source: AGHT+IHLQlsSTf9nnEdo+R0c14nVaDAi0AIxmlNAwYgqHQJhS3Q0Fei5hhBkqXzvOygR30WausgdkGXV+NokcS0kC9I=
X-Received: by 2002:a05:6214:5006:b0:67f:4f8b:8f31 with SMTP id
 jo6-20020a056214500600b0067f4f8b8f31mr16302316qvb.31.1703787195207; Thu, 28
 Dec 2023 10:13:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1703067989.git.ps@pks.im> <cover.1703753910.git.ps@pks.im>
 <ecf4f1ddee36643f0ff7e3d40b9aa7c7e6e6ce43.1703753910.git.ps@pks.im> <CAPig+cT6mRyJijL1qo2g56Yny-JxkDYjjmGpAncyS_4Hcpaz6Q@mail.gmail.com>
In-Reply-To: <CAPig+cT6mRyJijL1qo2g56Yny-JxkDYjjmGpAncyS_4Hcpaz6Q@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 28 Dec 2023 13:13:04 -0500
Message-ID: <CAPig+cSKpzOCOzC_mtNoA4yYmHCtMxB-Ujsd7YYHK-SPJvgt8w@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] worktree: skip reading HEAD when repairing worktrees
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 1:08=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> Having said all that, I'm not overly opposed to this patch, especially
> since your main focus is on getting the reftable backend integrated,
> and because the changes (and ugliness) introduced by this patch are
> entirely self-contained and private to worktree.c, so are not a
> show-stopper by any means. Rather, I wanted to get down to writing
> what I think would be a better future approach if someone gets around
> to tackling it. (There is no pressing need at the moment, and that
> someone doesn't have to be you.)

I forgot to mention that, if you reroll for some reason, the
get_worktrees()/get_worktrees_internal() dance might deserve an
in-source NEEDSWORK comment explaining that get_worktrees_internal()
exists to work around the shortcoming that a corruption-tolerant
function for retrieving worktree metadata (for use by the "repair"
function) does not yet exist.
