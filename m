Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F66515383E
	for <git@vger.kernel.org>; Fri,  3 May 2024 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714743416; cv=none; b=tMSX9WLl6UER5VZxqu9o9fhqDvOpvOdri+i6l++YPDuJWL4dr0ap+L+wgjwKrtvbf2ahUfb3/Wa7529K8ahVI/NuSVY68qBG/4qvMCz7Avm4up5n/ldhOjxgvtPlMG/6m2sT7Ix6haWKozz317kZPcWOxnIuEMuoU8RNnACZkNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714743416; c=relaxed/simple;
	bh=17WkA0lgYjhNE3CyThEpYdnARQABM7bdogLbON9n4k4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=IEKYEXdvjf8KqvAm/B4KJb9yhO3p/QH7mboL7aS3RV5YeUiSNxyNt7hoDnZjfq92of8IL131/G6mz+jvuIHZQxhnxaqcsHygHnxLpYBZ4ybsc+RuiWWJciey4PUqUVZSTcJzP1WkDpqkDSOzwXtlckiZWwGgsOBMT5vAkFm+1s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=kIyVHqj1; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="kIyVHqj1"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714743410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5alypHxJnXiKkh0WUZxt5VE+pADL+PfdBPAXKGNdR10=;
	b=kIyVHqj1HPnjoZwnDDtNn/JywyEwf1Qo1yyLsWLRSO42OXXetQuTFwvH1h52c3+APyh5Y8
	cu/v+v4T9TyrTcUSjA3ifP7kcHmWNHE3kmWKBIVqdQGt/ReoclBRpjWD0q/pTPUVLH75Dr
	xTJ+PgZPljBSnzZoK0w/ojjqFjuXT10mlbro9qXCpDxgAA5aVNMg/veRRa7fP+oG1ZHfaK
	xMulkXC5WhS9vARHDPhRmqT8S6sFlvWbKg2/jGs5O77zpoKXou93wYKzHrOonY/UF//I1Y
	K5OpeU0C+s2BTnmSrOzron8A1lizaIvwCCfZkAS+xBfAgNV2mazK8JMd+0E81w==
Date: Fri, 03 May 2024 15:36:50 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, Taylor
 Blau <me@ttaylorr.com>, =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 00/14] builtin/config: introduce subcommands
In-Reply-To: <cover.1714730169.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714730169.git.ps@pks.im>
Message-ID: <ae41e7b58ad156e0c035c6eb120a32dd@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Patrick,

On 2024-05-03 11:56, Patrick Steinhardt wrote:
> this is the fourth version of my patch series that introduces
> subcommands for git-config(1).
> 
> Changes compared to v3:
> 
>     - Rebased on top of d4cc1ec35f (Start the 2.46 cycle, 2024-04-30).
> 
>     - Implemented support for `git config set --comment`. This switch
>       has been added since the last version of this patch series.
> 
> Here's hoping that there's a bit more interest in this patch series at
> the beginning of the release cycle :)

FWIW, I find the introduction of the subcommands really great.
It makes the way git-config(1) works much more intuitive.
