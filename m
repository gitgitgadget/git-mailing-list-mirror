Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0206024A05
	for <git@vger.kernel.org>; Fri,  8 Mar 2024 02:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709864495; cv=none; b=VPA6DE7hS8LPQc/2BZumVzvfVIcG5S+Eurc7+xB1U/IwMAnE0LPlTqJh/ndPL3nDb/bb27upw0SbrJwQFpz6H13+pxSYqSu5VmN1OjUZMH68C+YG9bcQ4P7jYusGHaEOo9/1ll6MHnEPQvoH16Xe+rksd1u6rsT6dsy0SCw0cUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709864495; c=relaxed/simple;
	bh=aOHntCZR3BdCyDjMG+PXTEPbcPoGrUodNwgQtol2mW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IgfMewQVa3TODUCJj0of6zsiTNbOksi4EE/BuGsu6W19P0hWQQ9I7q8LF+G6BrvWFJokT03DGIJynF1F6hoytpZ4PMXmYRWHoSxZC9L5jxYEGVY0+n/6kYb0OV9XYjWZD1bwp0pEWgmxSd3fJJzMvIYQUGFeIiIGL//KlaisCP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b5DV57eZ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b5DV57eZ"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b2682870so2789267276.0
        for <git@vger.kernel.org>; Thu, 07 Mar 2024 18:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709864493; x=1710469293; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aOHntCZR3BdCyDjMG+PXTEPbcPoGrUodNwgQtol2mW0=;
        b=b5DV57eZ5Yl72i6hm/624s8A26lIK4mE7Xw57KKkjXUsbunkID4NR1utULcQXWfm5X
         zVGNnytL2mO1MglCz6bet4Vlq2kNVl3Z4Zh7N5EH45+VkBtFSp8atPzLMb/+66b0bdp3
         Uoqgn441ZjJnkTqwlSse+ao0cyot4xZYn3DEf6dWJIF8cEeOm/864akDmxsCkqxbXD0w
         wYyM5J9A7cOlphCRfw4Ua3HMEmU/lFQSXtpJcAw1RX3RIsfXdqcH2ldQYQA4BalPSx2P
         XHqkgrWlg3RI/soOLxK0Z8XF59CIEtiUQbFXciFroiUuAeU1byE907GfUBl9D1VyPwFq
         +txg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709864493; x=1710469293;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aOHntCZR3BdCyDjMG+PXTEPbcPoGrUodNwgQtol2mW0=;
        b=WR2ORcjlyCf/oIaTjHAgBGUHaqPug+Xx05Tdyb4KIBPcAEiuntdL/9rvFoNUxF9akb
         ka8RefnjUIyGM92wlHmpO3sYruOOQqBbNv4I/okohWY45/j3FhDeSMy0zTxEBNcwVK/7
         yhTdOWhm6Vtsh64puE3QNJax30qeqZWi7DeSepYmb/DsOj5W+8OAGxqBbnEklQV9I0BT
         Dhro1p5Da3h/y73D+y7SoXR4HlWDri6hEI0QRjawgemtwbqKln9H2BL8NrOxnaKAg5LC
         0MDXPeDHSDAQy6xGocwnarLT6H8rhgi4uPYtNNEkYWAN/xTtLOTmoYdB4WnIJGuVXW1H
         NQFw==
X-Forwarded-Encrypted: i=1; AJvYcCUleDXk3JLDOkKhigUaE48rwPYSnUuXH8TUnUZ6JProRMvkHGKfIfUtg+hrv8BfCubTsMOQAMXqSSLQymJCwfoGUGoF
X-Gm-Message-State: AOJu0YwkzJyknSO2FtQp9yqCEmn14T8j0tIIma6V3MLV07pkdKxb8mNZ
	40/lNpEZK9FD9XUWgFY+2yRD8sgUQOFLtKvg3n49IYmH9UwZ2817UTdedfL87DfPahJuLcNp8NX
	OPg==
X-Google-Smtp-Source: AGHT+IH2Zhw0mhxhEUaw6Pr1+QMR2OX21ERLPxLmUKhB7niFQkwxOyza30MlmJOkq7CWcowQe0/OeUFT59g=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:1243:b0:dcf:b5b8:f825 with SMTP id
 t3-20020a056902124300b00dcfb5b8f825mr5063631ybu.0.1709864492875; Thu, 07 Mar
 2024 18:21:32 -0800 (PST)
Date: Thu, 07 Mar 2024 18:21:24 -0800
In-Reply-To: <20240220010936.GA1793660@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <8b4738ad-62cd-789e-712e-bd45a151b4ac@gmail.com>
 <20240217060434.GE539459@coredump.intra.peff.net> <ca6a73d3-58b4-e65c-4a8f-e6ddb3e86902@gmail.com>
 <xmqqfrxo9ty2.fsf@gitster.g> <20240220010936.GA1793660@coredump.intra.peff.net>
Message-ID: <owlyfrx14g63.fsf@fine.c.googlers.com>
Subject: Re: [PATCH] trailer: fix comment/cut-line regression with opts->no_divider
From: Linus Arver <linusa@google.com>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: Philippe Blain <levraiphilippeblain@gmail.com>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Mon, Feb 19, 2024 at 10:42:45AM -0800, Junio C Hamano wrote:
> [...]
>
> The fix itself is pretty simple: instead of returning early, no_divider
> just skips the "---" handling but still calls ignored_log_message_bytes().

I realize I am late to the discussion, but this fix (and patch)
looks right to me. FWIW I independently discovered the same problem and
figured out a fix locally in my larger refactor of this area (with the
same fix, to always call ignored_log_message_bytes() regardless of
no_divider). Thank you Peff!

Sorry for introducing the regression. My enthusiasm in changing things
up without unit tests is regrettable.
