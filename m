Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5502905
	for <git@vger.kernel.org>; Sun, 31 Mar 2024 06:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711867890; cv=none; b=J1t088gm/RUL08Sly4p2apMA04cKCqD+gDSph+G3gMUEw9eIoZWM89Fq4poALI9ZqvYOpFGCLhds7+L6nGc4eSDrqOy/7CEfpwwubbNol0qjeQJYCINk5IdWNbZMv9YAlkDri8Wwfdt38ld7jpmHmnfhfLWuXfNFqAN9YovAnnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711867890; c=relaxed/simple;
	bh=A2zfDofGLjk9/XbcRRvTsjBIeUFv8XkJmHA+PmJJkxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M0s6NGp0rwzNq3yMBpuWlQ+av3mtNrIPVdnGa3+HEvqGbH1ZkBbKhkZxg1QLvX/rOUuTILok5Ny1falp1wsyUw+i5sSKGBn4RBCojpFooWgQlaJ/UTiNhfyrJmU+2FKuA1mRn/w7Y11p6hR1qbWy1YiegDJ+NS0WzVIpjV6I+so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6964b1c529cso27170016d6.0
        for <git@vger.kernel.org>; Sat, 30 Mar 2024 23:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711867888; x=1712472688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A2zfDofGLjk9/XbcRRvTsjBIeUFv8XkJmHA+PmJJkxU=;
        b=s9cMN/2N1QzVEHqLxziTiD35yNlpxkb9u9fQyTkWtFz8Awt4+FXaXQrR/lX7e+e+Ki
         U/tCZiYtL1heDbSvojlXo20B8bwm1w9A34cLmSvMerd1s+DLW2May6b0Ouns6aQTjGkS
         +wBECFYo+zUjC+SWpONiBWOsOvTZvEVnYN1C2ToJmFkLQ67HLF5SrL2p8dfZ6TjKCEj4
         wTcerB/HCmXb0fNlaKQvruYQwTlZH+1Ug5al09L62LXn4kCyUWP8Msl/4IpFZY0OmhWd
         eivAX4/YgV5XGQtoB0P5HGFQAUKcnSAEcDiMUd5S1QIltYgrdMxeEoI0rWqiR8gGwFgU
         oYQg==
X-Gm-Message-State: AOJu0YxP7zBbyzOmGR6AFunqfYY5G2qZNokhgRS1SlthicaxcSvzmGq+
	Nmd3cGf7a2krgVvoPg4h03pHrv/9NHD7QGDuDX09xm5YzPEUhrvb8QJAyZvY6DhukFV+MZN3U29
	weh9RXqeCGCxVHWz3avEBeH+UnCQ=
X-Google-Smtp-Source: AGHT+IE9oonChngHHqPx4E7CwaqxZHuMbSh5aiC7jdwDKcasdKhsfqB42NjB5FQzbh/DkRlJ4NsqHjgMX8SIOVIScl4=
X-Received: by 2002:a05:6214:2484:b0:699:415:2326 with SMTP id
 gi4-20020a056214248400b0069904152326mr1067888qvb.56.1711867887722; Sat, 30
 Mar 2024 23:51:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqmsqhsvwk.fsf@gitster.g> <20240329222703.9343-1-ericsunshine@charter.net>
In-Reply-To: <20240329222703.9343-1-ericsunshine@charter.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 31 Mar 2024 02:51:16 -0400
Message-ID: <CAPig+cQApMC_UEgee06e=jbu9VoNHQT10hCU1OAQtpn1W7Fqmw@mail.gmail.com>
Subject: Re: [PATCH] test-lib: fix non-functioning GIT_TEST_MAINT_SCHEDULER fallback
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 6:27=E2=80=AFPM Eric Sunshine <ericsunshine@charter=
.net> wrote:
> When environment variable GIT_TEST_MAINT_SCHEDULER is set, `git
> maintenance` invokes the command specified as the variable's value
> rather than invoking the actual underlying platform-specific scheduler
> management command. By setting GIT_TEST_MAINT_SCHEDULER to some suitable
> value, test authors can therefore validate behavior of "destructive"
> `git maintenance` commands without having to worry about clobbering the
> user's own local scheduler configuration.
>
> In order to protect an absent-minded test author from forgetting to set
> GIT_TEST_MAINT_SCHEDULER in the local test script (and thus clobbering
> his or her own scheduler configuration), t/test-lib.sh assigns an
> "immediately error-out" value to GIT_TEST_MAINT_SCHEDULER by default
> which should ensure that the problem will be caught and reported before
> any damage can be done to the configuration of the person running the
> tests.
>
> Unfortunately, however, t/test-lib.sh neglects to export
> GIT_TEST_MAINT_SCHEDULER, which renders the default "error-out"
> assignment worthles. Fix this by exporting the variable as originally
> intended.

s/worthles/worthless/

(I won't reroll just for this minor typo.)
