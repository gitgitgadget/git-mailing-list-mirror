Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407831DFF8
	for <git@vger.kernel.org>; Sun,  2 Jun 2024 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717348313; cv=none; b=Sjly759I/HlYZF93tneOGdflStzRx7tIhtRDqYJLR8sigq3Z4/nKQCpYnIRnyHWuBi+tRp55JcbBSPhvG37taJfMnxZLRMzVhcnwnhwgOMzkkaXmPNvxOQs2CY8uUN+GvXfGtKcx9n3qchCp8oqPWFMySLLAh7oUrCXdvlh5Inc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717348313; c=relaxed/simple;
	bh=WWYA8FJNPIPwGYGbXMTFKfbyGlnF4ehGf8jvBKUwIG4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gW3H8R7UoCKxvc0f6VtlvlHlxb4y1IUd5g31G4COnpvp2iZiAg8FutN2w5pfkp1Xh8QtFgamT9wQzuZ1Vy96yq5+RGSjDOZ8kzCpDOxUSQ4aa36gb8Ww7BD8oSprIBFnPnIWDNFb05eZtlHZNUzveJazr7MTPSr+iKiKSmprj0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VdOuCP9g; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VdOuCP9g"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C2CF2BA75;
	Sun,  2 Jun 2024 13:11:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WWYA8FJNPIPwGYGbXMTFKfbyGlnF4ehGf8jvBK
	UwIG4=; b=VdOuCP9gfAQGQL9ukPQJ548qDD/tkvw7uuA2iHdkj7sccWMPzul7Uw
	I9OTWIifFIvkPRPaMea+tSMBSYy5cJtFx4u4KD7Y8l0ozx6OTIQzOVoMXWvZbeMg
	J6juwt8pb3l5cyJzb+EM1TbR56EvoTHfFBNl0rcSy6UB95tJrhHT8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 13C9A2BA74;
	Sun,  2 Jun 2024 13:11:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7FF122BA73;
	Sun,  2 Jun 2024 13:11:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Dragan Simic <dsimic@manjaro.org>,
  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/6] use the pager in 'add -p'
In-Reply-To: <xmqqwmn79u98.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	02 Jun 2024 09:36:35 -0700")
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
	<199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
	<b7e24b08-40a1-4b18-89f6-e25ab96facaf@gmail.com>
	<xmqqwmn79u98.fsf@gitster.g>
Date: Sun, 02 Jun 2024 10:11:49 -0700
Message-ID: <xmqqttib8e22.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 338EDEF4-2103-11EF-9ECD-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> The 'g' and '/' commands take _mandatory_ arguments, but we do not
> even mention it in the help text.  But we need to say something for
> this new thing, because it is _optional_ and if you do not give a
> program, it does not ask.

By the way, although I personally do not have much sympathy to those
who set it, in the presence of interactive.singleKey configuration
variable, a command that takes optional argument may turn out to be
a mistake, as the user cannot give the argument even if they wanted
to, when the configuration variable is set to true.  To help them,
we'd probably need something like the following to allow them to
optionally set their own program, like the following:

 1. read the command, notice that it begins with '|'.

 2. if it has <program> after it, call it <program> and jump to 5.

 3. if it does not have <program> after it, but if single key
    operation is in effect, give the user a chance to give <program>
    by prompting.  Call the answer to the prompt <program>.  If it
    is not an empty string, jump to 5.

 4. at this point, we have <program> that is empty as given by the
    user.  Replace the <program> with the value we remembered from
    step 6. during the last use of the '|' command.

 5. if <program> is all whitespace, replace it with an empty string.

 6. remember the value of <program> (so that you can reuse it next
    time the user says '|' and without <program>), and call the
    "set-custom-pager" thing with <program> (this design assumes
    that "set-custom-pager" thing uses the GIT_PAGER when fed an
    empty string).

 7. spawn the program set by "set-custom-pager", and feed our output
    to it.

So the end-user observable behaviour would become

 * There is the "default" program, initially their pager, but after
   they use the '|' command, we remember the last program they used
   during the session and reuse it when they tell us to do so.

 * For singlekey folks, typing '|' will give them a prompt.  They
   can give an empty string and spawn the "default" thing.  They can
   give " " plus <RET> to reset the "default" to GIT_PAGER and use
   it.  Or they can give <program> plus <RET> to use it and update
   the "default".

 * For the rest of us, typing "|" plus <RET> will spawn the
   "default" thing.  Typing "|<program>" plus <RET> will use the
   <program> and update the "default".  Typing "| " plus <RET> will
   reset the "default" to GIT_PAGER and use it.

which is quite straight-forward and consistent between the two
camps.

