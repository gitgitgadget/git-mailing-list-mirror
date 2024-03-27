Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A1145BE9
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554198; cv=none; b=KB34ckwA4Mf1+eaEbMyURWAfBzgBHkPRbEX9yTUc6o6vnW1tAQ5SeHa6HIqzmzvEU41h5RY9kD1ZUci7TkMHMsZcFGn9/STbDhKkcZXFXxQvY3GGGw/bN76hDuLogdpaiXo2IZzjkQOfIf4Kv5tz/1qJh9JpvDGyVszjV8NSkTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554198; c=relaxed/simple;
	bh=DI7Qxw8eLE90IbCPM4IJQoteNwtGqo2WODVRShOsVUU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AJZm0GMF/IvpfMXKC3hiQhrmp3C+mWvNVkRYsC/sPXXVxosp5Dil7W77pEbyAHfo6MyscZYXs9wujf9b/GkHFRUzAByIJcan/viWQHVpr35MhSjfbsdbJnNznIzJ5At0u0QEx8glF117sinEcOp/kSKhJg0uuat8CmWF38djll0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=teJjxngz; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="teJjxngz"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E2561F59A;
	Wed, 27 Mar 2024 11:43:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DI7Qxw8eLE90IbCPM4IJQoteNwtGqo2WODVRSh
	OsVUU=; b=teJjxngzvQRzdge85rGlkhdGWuQ38CNvrJeoOsM1kCzci5JG9fe6jG
	hypWswPt1EOkil0wbtKjSE2LjbfEFWXnk4deSoXN9PvdDewiEgqpkDXg8CHFGlth
	JPctEperuCTlJDhoLLJIHo1AVfnbmumtkOdxvvI5GvZH1B2OSuyPA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 465C61F599;
	Wed, 27 Mar 2024 11:43:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EC8A01F597;
	Wed, 27 Mar 2024 11:43:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] improve interactive-patch
In-Reply-To: <8a05d7f7-6d94-4228-9507-d3af44f100e7@gmail.com> (Phillip Wood's
	message of "Wed, 27 Mar 2024 11:14:18 +0000")
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
	<6f2ed406-2152-476b-b463-3010afe7e11e@gmail.com>
	<59f19783-a663-449d-a1ef-3a9ebc43cc59@gmail.com>
	<xmqq5xx9dn6q.fsf@gitster.g>
	<8a05d7f7-6d94-4228-9507-d3af44f100e7@gmail.com>
Date: Wed, 27 Mar 2024 08:43:08 -0700
Message-ID: <xmqqttkr3ckz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B69577D2-EC50-11EE-9B8F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> ... My
> reasoning was that 'p' does not do anything useful for the user, if
> they press it they end up with exactly the same content being printed
> to the screen ...

Actually I do not agree that it necessarily is useless that the same
content is shown.  Especially since we do not page, it is plausible
for a user, who saw a huge hunk, to want to tweak terminal setting
and raise scrollbuffer size (which may be set to 0 for usual
sessions, like me), and say "please show it again".  Or even in a
more primitive environment, just say "please show it again" and
immediately type \C-s to stop while the early part of the hunk is
shown ;-).

Thinking about the name of the option again, if we are omitting to
show a hunk in some situations, the request to ask for the current
hunk to be shown is "please show me", not "please reshow me", so the
verb 'print' may apply to wider situations than the verb 'reprint',
strictly speaking.

Thanks.
