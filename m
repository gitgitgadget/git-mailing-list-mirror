Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119F81E1E04
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648461; cv=none; b=jxHVCt/c07E0O5B0Pd4C8lo0uD55QJ4V5+l5zElKtwX6tfRL/TCN8WRACMxupw71cg2oQtfIpON8fnJAvMJNAMheGwgDGGmm1rxljA2mvX504wDdw0l49KR326NLe5MpCZdBJM2zIeCKK+YeP/qB+wNfNo9WnfnGqpwb3U+GXXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648461; c=relaxed/simple;
	bh=gy+r4sVjPWmZi6DUYjU7SbFUnxDmYaXOOK/eVnJLYys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sOnvm6DFuIdbGdJVjgacNOW/CxFAxrlEeXsa9cyM7yqlWauIgUsfsX3AiU0Irvua/jlkQ6dJuNkSU9LgUjFDHlJtTl9+6L8lSFQ8UAhA339x1bTL9ILfrYSZ516ESg0viciDjT2hgDIbNNC8X5RfkOwnmZY07vch8AHmUGEFypg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qoq1pv9e; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qoq1pv9e"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-824adc96ad2so6946457b3a.3
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 10:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772648459; x=1773253259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qyK4bTDxzWdwT9wpB/DmZn9OZ+ziQBhEzBeVVdE0Sc=;
        b=Qoq1pv9elArzPgtY/ytqyPFS5db8zrfC9g5zZhbrPhsokqGJi33ukwEVxpA/J2Skkr
         h4nQshQLzHWgWWe6TW+ZsqeR5V4vRhUP32vPOnzy6q62hOzTEovb6fW/3nmLHSwbJ0B8
         qDbezuUPCDPrMINPwA95G4dX38glO42RBILNv1Z92bLfxBuomMJ8+n5YA+scb8C/1VU4
         zr+YPuMeMtDmzjNTfUpy0KOUMiYMrLQa8EFkjcyr9W475BiFmluzqUfL3iHDxcr0Fhkv
         yA9qGKmEPRQh3RPSMX3sd5VAVc7yPYlZGNRc1SfquGur0WES7TWCXsvj+qlCWfCQa0ut
         BxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648459; x=1773253259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6qyK4bTDxzWdwT9wpB/DmZn9OZ+ziQBhEzBeVVdE0Sc=;
        b=n+3Vk+7yO1R/sYHfG2MfC729fibXFhuNWfXQ/6061hR/9LcdPAkMsJH1xiHuvRPzDG
         tWvMTg3y57mWk8fbhOSWYqACG6BopnYI7nbCH3Yy4Y40DrlY70UIUT8zi1P2219RelD/
         PslgC8timyzcJCgZcyJeTXK1mfFdn58pJdTfXDa9/YbKbC8s57c3bHVabC90CmEl6NHM
         yT9hD6/FCuRfy7o2JvsE0qpw2m3OYbB3fS+MMPv+vEVR61mYMiICJAxBs9gJeZMSi1UR
         Ryyoa7ftgEGilmfRJAtPyQdAGZ+Xg9raVIJeYiQKsI2lteohaSliX0O+ml2txgC75VLe
         lUtw==
X-Gm-Message-State: AOJu0YwQFOQIJAscskbvuAKiGPT2A/rtWBYdeqCnobPEpFPd3mApZ53f
	Nx+cCdBS93yqoJ0bdUHVzl19+N1nlNwI/1ODJnMasre4pwAMxYr9houEFw6jIA==
X-Gm-Gg: ATEYQzynVE0X1wqLKYn1UIIelXdW6ELn48HrjVQSYglJI+dCmP0OHe/l7Ie7vmVLx6D
	82GrCsciV0h2x4h12DA3NlGWKS0y5/z/LqmcCOficMEfjT1xBIV5g1B08un48Hcysr8tCLDDAEg
	wC53M16EFnbYSfiW32LVrxlIsY9eD5C41GHiFO+VLcbKzekugz9AGP5XvnPO+5TDj7RtmiUUZWT
	TQujJMk0g97/BOtzHk1AHbiLNZ6ifkzVsZnu8IQoecA8j0ijHlj/yhleX2FgI5SIBneBMVkrRJC
	kqS7Z4HyuBjatkxxNh/HtaG/z/sAHlXGewf66W70XOxP1ZsZ6W6d8AhH0tHmXvR5SZuHFqy4TTC
	j+954S60wzNAwzU3a0U28tz/k50ORVYWVRZcQw9zJWpcLwHDaoFjvoz5Y/MOEHAHkl0QaoMpamI
	0XFhFLunMqa8g2jQQRWAP0Hc38t4SSHWMLpzbMB2yxkWI4M+wd8NNhuldb9NhblOBOoStFAs2r/
	NGvPOaF7g==
X-Received: by 2002:a05:6a00:1407:b0:827:4372:dd15 with SMTP id d2e1a72fcca58-82972c6bcf1mr2843473b3a.40.1772648459146;
        Wed, 04 Mar 2026 10:20:59 -0800 (PST)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82976924148sm1768672b3a.2.2026.03.04.10.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 10:20:58 -0800 (PST)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	paul@paultarjan.com,
	jonathantanmy@google.com,
	hanxin.hx@bytedance.com,
	jeffhostetler@github.com,
	christian.couder@gmail.com
Subject: Re: [PATCH] promisor-remote: prevent lazy-fetch recursion in child fetch
Date: Wed,  4 Mar 2026 11:20:57 -0700
Message-ID: <20260304182057.26463-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqikbb8pbd.fsf@gitster.g>
References: <xmqqikbb8pbd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Mar 4, 2026, Junio C Hamano wrote:
> I would suggest dropping these CC: lines from the proposed log
> message.  As far as I can see, they do not have their intended
> effect; [*1*] does not show any of these folks listed on Cc:

Done, moved them to the PR description for GitGitGadget to pick up.

> I also do not see much point in duplicating
> most of what appears in the proposed log message here after the
> three dash line, but that is a separate story.

Cleaned up the PR description to avoid the duplication.

> Hmph, do we really need an entirely new test script file dedicated
> for this single liner change, instead of adding to some existing
> test script that already covers related topics (like promisors and
> lazy fetches from them)?

Moved the test into t0411-clone-from-partial.sh, which already has
the other lazy-fetch tests. Dropped the separate t0412 file and the
meson.build entry.
