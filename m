Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7101598EE
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713975722; cv=none; b=t3CwVb7tSG2MbaePcEr/5uXtEuncRIGPVgv3lyV/jqOrlZyNaf9O1b4YyOXAQdcc3uwEngK0NZ9VSUjzbBJ3p8Y3kkXu3TMNHGfz3yUcSja2GxWk4KqmIDHL6Ta+bQdvMFc4FQmGHgrsiSyBVnJQoFqm/Ey/TdKgOZ7cQko+MOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713975722; c=relaxed/simple;
	bh=Bi4vxJ5Skn/CiWAeQY2yxzIMtNhOkDEQV3afPHtEhSc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fCkh1l95U61hAykWQmVN+ozTKOJjpxUUW022NMqxCV+wkAG3AZutNspvsllqz+8D2oYz3vB96tlX8v5CNfmJ+yeoih9nAXhWFE0IPAbjfVXI8l5SKp27tdNCZKI0ATRdOFbOKDosYyXWPuYQ1o2rSb8/RC1mrBhmuRzyvbZGd50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=dwESnIlc; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="dwESnIlc"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1713975719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IBOk3gC3wg3nQiDy0fOPzSY/YwP+toNQTpHH9K1TDjM=;
	b=dwESnIlc9/fO5CDKa+exmrZNpagnDPxWBDVDDNKd5LmLQTputHXHJzIvkfVKiCjV1kB8QV
	LeitppErH7NH/hvJu7knF3//yU9wXoz80A36zr7RELFOSvqXRjo0MsORHscxLqeJUyoXOi
	UYJ7AXIhU43vATbCCtH+5hDiQuAeW06zxY2qG1ImRBfpPugXkBl1DRxqRxhsanSeCUigV2
	3rV6/euJneTYm3kitbu3hsnZ/hxVKDUVtIhX56xizkOKt3LipKlS1aeT4BZnBGU79RTve8
	Z7RQr+5Sk4ra4LbrXXJSmHooEQw/xKaFMY1+Xi5A6wI2ERAJzhYPNx+wjl4eww==
Date: Wed, 24 Apr 2024 18:21:59 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>, James
 Liu <james@jamesliu.io>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] advice: add "all" option to disable all hints
In-Reply-To: <9befd5382109eae65e1c177ff6f04f60@manjaro.org>
References: <20240424035857.84583-1-james@jamesliu.io>
 <xmqqo79z2s24.fsf@gitster.g> <ZiirKgXQPLmtrwLT@tanuki>
 <7d1d2892-d486-4e91-b100-e44c1d76893c@gmail.com> <ZikSNSszRzBz715c@ncase>
 <9befd5382109eae65e1c177ff6f04f60@manjaro.org>
Message-ID: <462de4ec1fb1896fa7f26b3515deca57@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-24 18:14, Dragan Simic wrote:
> On 2024-04-24 16:07, Patrick Steinhardt wrote:
>> On Wed, Apr 24, 2024 at 02:52:39PM +0100, Phillip Wood wrote:
>>> On 24/04/2024 07:48, Patrick Steinhardt wrote:
>>> > On Tue, Apr 23, 2024 at 11:28:03PM -0700, Junio C Hamano wrote:
>>> > > Do not close that communication channel on us.
>>> >
>>> > While I agree that it might not be a good idea to set it for our users,
>>> > the usecase mentioned by this patch series is scripting. And here I very
>>> > much agree with the sentiment that it makes sense to give an easy knob
>>> > to disable all advice (disclosure: James is part of the Gitaly team at
>>> > GitLab, and that is where this feature comes from, so I am very much
>>> > biased).
>>> 
>>> Maybe an environment variable would be a better fit for turning 
>>> advice off
>>> in scripts?
>> 
>> Sure, an environment variable would work just fine for our purposes. 
>> It
>> would probably also address the concern that users may disable all
>> advice and then miss out on some information.
> 
> Sounds good to me.  I'd support the addition of a new environment
> variable for this purpose, perhaps GIT_NO_ADVICE or similar.

Actually, after reading Junio's comment, [1] I'd rather support
a new command-line option.  This is quite similar to disabling
the pager, so a new command-line option would IMHO fit rather well
into the grand scheme.

[1] https://lore.kernel.org/git/xmqqfrva3k9j.fsf@gitster.g/
