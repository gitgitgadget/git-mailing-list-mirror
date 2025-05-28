Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094A41F463F
	for <git@vger.kernel.org>; Wed, 28 May 2025 22:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748472731; cv=none; b=bQs+tBNqLs8ywFDkjvqo0ujj6fEikpiZinD96gIO3A3oouQq13I0Y/dyV0rZk4Jq89JnGomDVMQZf3ZrQDVWaYbYpAHgPU7dwmCARYwKlZIpKHfMcnPCc0Kof4jvJePCpnyLCxuu+0OVE5Oy1JgFNyICt+ugVGsSJ6GqbSGzgiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748472731; c=relaxed/simple;
	bh=4Tq0GOoDBqnXgF3zzp4www8wJQ4f2zUQ2vRhxil+YzM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=arSF82FkO+gJFVHhCxc3BgiankaZJ4OVnPoYA/ShjaaelcAg/4zLx4HzWq+lu3C6OF1osd+FIIqMbndZ71W6E4l/gutMBd0Z9p+1yusG1jD6NLFF7AbOr9p5i2uDc9XAWlbNtLgE/fztMZff6pWWofRD+s5iFkrV0U3PilpKV6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KGm1cvPS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XyRmBQJi; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KGm1cvPS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XyRmBQJi"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id A4B3711400DD;
	Wed, 28 May 2025 18:52:07 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 28 May 2025 18:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748472727; x=1748559127; bh=35GOys7bGV
	iecba6BIS78xxUXhjkc8ppHMzN25WTGCk=; b=KGm1cvPSY0sGlH4TN5WDI89H7R
	q+mYYx95EHnIinfbpXB/lXpQzXGAH+Mmz5xlUq41nyoQlLAH4uUnJkGgxoO1vBQ1
	0oPCxagBKyfIyn6TlYBs9JjzYUSZPgbH+T+pY8mUYAtYRtpoJc+4e0fUQgMwt7GU
	tO+SB0bChRtTVhIpo2B7Kw59F64PxBhz9q2SOmE4G1uhaOH+t+m//P/D5TEGLc1B
	KI+8VXsaAtq4DS25ckqrUsI3sQU36yxQwd/pA30DBD4Tm8Ly9MZV9y6VDeqd21rY
	L3AoIAX2CFNTC8PHr9zAzhStR+9xkA2bubnUPSduJ7Ck6GrpA9UhbA9+CUsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748472727; x=1748559127; bh=35GOys7bGViecba6BIS78xxUXhjkc8ppHMz
	N25WTGCk=; b=XyRmBQJikjPMAD/rDHdbwI1tHkw34YgkdDVfyDIOOM+os+E5Cdu
	/JhFUKzW17XPhURG08TIjq8dcsPrcoGUjOeOoSIQ5A0s81VjLNnWoAt4/aRYC5dc
	Pr9ptnx7AHroBmBCGL5eZcaF5Tge4HyL/vT85W+mml1/b9w6hnBYBd3GYuj2jt9N
	MGO9evsQQe9E8CR7Sr/Mss88t651O0lN9fIA8xV/QDaK3046Ez9wV4BsZahM20PP
	nHRQwUMN1iKn1LEiOrnl2e3ksj/bNKLqtNH0c4ornWUz4/qAOf9QD0Fcnm7WVXjP
	KrKXHvnRzDM3Ofo8lT+2VrxhzJgX9KP3cEg==
X-ME-Sender: <xms:lpM3aB5bZNHlD4GTlMJ1ySMWl5aIjPdTU00F4qcVZjBqtM5rIvbM5g>
    <xme:lpM3aO7bNZ2wDNxBZFHbVaij9zxkhyPNUYDBIjHNcW8KZsiOkcogauTTWAanuTIhn
    7KSIPJfct32b-9O0g>
X-ME-Received: <xmr:lpM3aIfQTm5niGotEh0AyfwRCEpq1JKn4iKFw2Jmqkta7e_R0mP-hUAiwK4pKJJgvH4CeP8rsqx0aLn8NY6T-05JQ2qpQaBQ6eqsZws>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvgeehtdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefh
    tedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghgrrhhgrgguihhthigrtdeksehlihhvvgdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhshhhinhgvse
    hsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushht
    hihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehjuhhlihgrnhesshifrghgvg
    hmrghkvghrshdrohhrghdprhgtphhtthhopeiiihihrghoseguihhsrhhoohhtrdhorhhg
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehjrggtohgsrd
    gvrdhkvghllhgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgv
    rhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:lpM3aKJ_P1onT4DOTl69dcRtxeufMYOEervMx7Y-OhRwiFMJjEpyEw>
    <xmx:lpM3aFKoUNuTq_AgDOysW5hCjdaguashNFFZgU2XkbY12szZ2f16Xg>
    <xmx:lpM3aDzzD6E1yrJRnRJv1RSz8TMv0J6DjKzhJgD8JE9kveXlER8Wyg>
    <xmx:lpM3aBIKQJ4pABi8vxsI-evKXcci2NbIzV53dn2h_t-03SlIhK9m7w>
    <xmx:l5M3aGDFKkpKdPyy_ZcazaVQM51NNy0SYLv24jtDZs7N3zhhJXOAHrRj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 May 2025 18:52:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
  Eric Sunshine <sunshine@sunshineco.com>,
  "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
  Julian Swagemakers <julian@swagemakers.org>,
  Zi Yao <ziyao@disroot.org>,
  Jeff King <peff@peff.net>,
  Jacob Keller <jacob.e.keller@intel.com>,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v5 1/2] send-email: fix bug resulting in increased
 message number if a message is edited
In-Reply-To: <5103ea4034cd4a8438865a2d3da19a92dda54013.1748414082.git.gargaditya08@live.com>
	(Aditya Garg's message of "Wed, 28 May 2025 06:39:32 +0000")
References: <cover.1748414082.git.gargaditya08@live.com>
	<5103ea4034cd4a8438865a2d3da19a92dda54013.1748414082.git.gargaditya08@live.com>
Date: Wed, 28 May 2025 15:52:04 -0700
Message-ID: <xmqqcybspcvf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> Subject: Re: [PATCH v5 1/2] send-email: fix bug resulting in increased message number if a message is edited

Is this the same title Kristoffer said that it does not give much
meaningful information, to which you said you "have re-written the
whole message"?

cf. <PN3PR01MB95973C8CEC731B43816AB38CB865A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>

> Whenever we send a thread of emails using send-email, a message number
> is internally assigned to each email. This number is used to track the
> order of the emails in the thread. Whenever a new message is processed
> in a thread, the current script logic increases the message number by
> one, which is intended.
>
> But, if a message is edited and then resent, its message number again
> gets increased. This is because the script uses the same logic to
> process the edited message, which it uses to send the next message.

"increase" -> "increment" is more common to count up by one.

> This minor bug is usually harmless, unless some special situations arise.
> One such situation is when the first message in a thread is edited

Which makes it sound like you know of more than one bug but only
telling us about "one such situation" here.  If so, what are others?
If not, the phrasing in this paragraph is somewhat misleading.

> Here `$message_num` is the current message number, and `$in_reply_to` is
> the Message-ID of the message to which the current message is a reply.
> In case `--in-reply-to` is specified, the `$in_reply_to` variable
> is set to the value of the `--in-reply-to` argument.
>
> Whenever this whole set of conditions is true, the script sets the
> `$in_reply_to` variable to the current message's ID. This is done to
> ensure that the next message in the thread is a reply to this message.

OK.

> To fix this bug, we need to ensure that the `$message_num` variable is
> not increased by 1 when a message is edited and resent. We do this by
> decreasing both the `$message_num` and `$message_id_serial` variables
> by 1 whenever the request to edit a message is received. This way, the
> next message in the thread will have the same message number as the
> edited message. Therefore the threading will work as expected.

Hmph, isn't it more like "after editing Nth message, we re-process
that edited message, and we used to call that edited message N+1th,
which was wrong.  We now keep the same numbering and call the edited
message Nth (and the version before editing we didn't send, so there
is no risk of sending two Nth messages)"?  

> The same logic has also been applied in case the user drops a single
> message from the thread by choosing the "[n]o" option during
> confirmation. By doing this, the next message in the thread is assigned
> the message number of the dropped message, and thus the threading
> works as expected.

OK.

The above explains why the patch needs to touch message_num.  It
would be evfen better if it described what the variable is used for,
exactly.

    Side note: during the initial round of this change, I explained
    that $num_sent is the counter in the batch we are sending out
    (hence it is reset to 0 when a batch fills and the next batch
    starts).  If there is a similar concise and clear explanation of
    what $message_num?  "The number, counting from 1, of the message
    in the set of messages we are sending", or something, perhaps?

And none of the above justifies why this patch mucks with
message_id_serial.  Should it always be the same as message_num (in
which case the natural question is "why do we need both?")?

If we can prove that message_num and message_id_serial must be
incremented in sync, it is OK to have a separate topic that unifies
these two variables into just a single message_num, but I'd prefer
not to see message_id_serial mentioned above and touched below at
all in this patch to fix the in_reply_to issue.

> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>  git-send-email.perl | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 55b7e00d29..b09251c4fc 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1639,8 +1639,20 @@ sub send_message {
>  		         default => $ask_default);
>  		die __("Send this email reply required") unless defined $_;
>  		if (/^n/i) {
> +			# If we are skipping a message, we should make sure that
> +			# the next message is treated as the successor to the
> +			# previously sent message, and not the skipped message.
> +			$message_num--;
> +			$message_id_serial--;
>  			return 0;
>  		} elsif (/^e/i) {
> +			# Since the same message will be sent again, we need to
> +			# decrement the message number to the previous message.
> +			# Otherwise, the edited message will be treated as a
> +			# different message sent after the original non-edited
> +			# message.
> +			$message_num--;
> +			$message_id_serial--;
>  			return -1;
>  		} elsif (/^q/i) {
>  			cleanup_compose_files();
