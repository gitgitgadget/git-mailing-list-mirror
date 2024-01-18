Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919CFB64A
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 06:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705559187; cv=none; b=k8hZPVljtL9X/OGa1PQ69STQeB+jiMt5R429IMWFkEZawMy3H9eb25VXYe16CJbhmgsWIozU4bOquGJU5LZYdfRANTl2LqUfj/IipJkZKr5iipPwsXNO7wxqlXTwoBLc9EC2VyU5isPDs/t/909JSVRxFUWGw5ecVp5XajZIGXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705559187; c=relaxed/simple;
	bh=9ByQVGspcCGbAz/QJgFrQCc4K8VXJW0mDJMxx+Pm1Qc=;
	h=MIME-Version:DKIM-Signature:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding; b=uaxK5M/hMdu06YM5i5+QMfR1p/ZUfppWJdM4p4EyjH1PQOw8OCV6TN+CcwxVm8vUaQFIYKBp9MJX7fxB74r9I5hnt4NfpDbZ970sGPywkPsdqdZAZS4a+qEyYFv/s8Ah7XcEW1E0BWCxok7T1UrCGeb5jGqW5KH0GaAmIy6PLf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=PnY+5KlW; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="PnY+5KlW"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1705559182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ByQVGspcCGbAz/QJgFrQCc4K8VXJW0mDJMxx+Pm1Qc=;
	b=PnY+5KlWJ26sPEj6eCGY6NRj+nGCEO6Mlf/Au4g2GGVEB4GCrqr+aFMhswvbeoypTLxn0Z
	o4QuWwWRw4LKQ3Cg4jAx6mZe+MIrlNFcPAb9T09ucjDnp6KJ0AxAsAMriw/baQUBlF+Y/v
	Lm9g3Yp5PiBy/7R+hX4kr5ZkQZHpSCPRMurzz7q9kKxmRL09RCgOb2WRDvAyWJPIzqlLhr
	+UrWXl7tWY7QOvnYm6Bs4eN8TxeVAx6m2ujkmT5EJfZjUYu81jny3lr/2Vk8ni9yvZZ+ks
	sHQbA0ppyxElF1nY/zuCWjP6b73IgTRUSXEOgoTQk+b/uVnmfY6KMAKuspj3Jw==
Date: Thu, 18 Jan 2024 07:26:22 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [Bug?] "git diff --no-rename A B"
In-Reply-To: <xmqq34uvtpob.fsf@gitster.g>
References: <xmqq34uvtpob.fsf@gitster.g>
Message-ID: <b14b9ed73398505f44e1c38434a78041@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello,

On 2024-01-18 02:07, Junio C Hamano wrote:
> When the user misspells "--no-renames" as "--no-rename", it seems
> that the rename detection (which is ont by default these days) still
> kicks in, which means the misspelt option is silently ignored.
> Should we show an error message instead?

Unless I'm missing something obvious, an error condition should be
generated in general when an unknown command-line option is specified.
