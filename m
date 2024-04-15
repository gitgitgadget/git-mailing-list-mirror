Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9012231F
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 17:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713201663; cv=none; b=gS5xhMLykhwF7OprZ9GO0eSj9VmH2CIGg3Shln/SRzPE6nwL2Drq/7BUNJWx9pK4Z+TzAVvaaIGU77k8W08HvoFl3WlQ6FoMY4GE7ElEbbcME5FJSWDb9M2d365o/Xzf2zpzmDrz+czqPWmh2vvJZ3AUHqbscLvnsGtK2jxPPE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713201663; c=relaxed/simple;
	bh=XDtTCYZ+Jw/HuUInEVVNlMCJzZ4hbJVO+xFMrRkGMBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sRU8vgFefiKkI56z/iHxTgaCGcWYG1wklAZ3qvTzYPoXzVo7YtCzcF2L6xI4vPDEhALIUqbjAvQH+8LHuq4fAmCHb4vq7yrRawmkME2XtrlUfpOA10uMtZLDyWvhU4GY69zbWNq+pnJlgawN6UJvPTxz1I7+q1h8FyCSioNUKNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HHkIxvID; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HHkIxvID"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1E6E528C94;
	Mon, 15 Apr 2024 13:21:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XDtTCYZ+Jw/HuUInEVVNlMCJzZ4hbJVO+xFMrR
	kGMBw=; b=HHkIxvIDqC7J7SBtUyQGU/0+weAg8dgysGQK4wbhCoSnnxE46N5UnT
	l70dnp7zFOmifa98g7L6wQ3Ht9GXclzejcqnUc8Pb+UXHUihx7NwHR0dAx5YEbXC
	IrErv7ca7uk5STaWDb4Y4rvslcvRNQV/jwAJpfjgQYIFZhZ+j5ZSE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1606F28C93;
	Mon, 15 Apr 2024 13:21:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 94E0828C92;
	Mon, 15 Apr 2024 13:20:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,
  rsbecker@nexbridge.com,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4] launch_editor: waiting message on error
In-Reply-To: <beebf170-31d0-4ecf-b029-d6bc499f6da8@gmail.com> (Phillip Wood's
	message of "Mon, 15 Apr 2024 15:05:32 +0100")
References: <e60c1217-aeb6-48ce-9aa5-7c0b13396e33@gmail.com>
	<96bef5f9-1286-4938-99ec-6beed13ee68d@gmail.com>
	<0258a583-a90a-4434-bb4e-a1672d574b9c@gmail.com>
	<ccbd77a1-d334-4d8f-8de0-b542c79330fd@gmail.com>
	<e208da74-8f16-44ae-912e-ae968da82057@gmail.com>
	<beebf170-31d0-4ecf-b029-d6bc499f6da8@gmail.com>
Date: Mon, 15 Apr 2024 10:20:56 -0700
Message-ID: <xmqqa5lupmo7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 85D1D036-FB4C-11EE-B81F-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> As I've said before I'm not sure how likely that is as I think the
> editor will probably have printed a message if there was an
> error. Assuming the message from the editor ends with a newline the
> proposed change wont do any harm so I don't object to it.

Yup, I think it is a no-op for a well-behaving editor that emits an
error message with terminating newline.  An editor that leaves its
own error message incomplete, its error message together with our
"we are waiting" will be erased together, but we probably do not
care for such an editor.  If an editor silently errors out, then
this will still clear "we are waiting" we printed earlier and say
"there was a problem", which is what we want to see happen.

So, this looks good to me; let's queue it.

Thanks, both.
