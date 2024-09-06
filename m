Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ECC156880
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725639044; cv=none; b=FO/+wIgBBC26uWkVP16uyH7yzVpm3cvhnW1KvWlAITPZY/Zu0N7CPuFubx7SNDwJmF//YnYhltaaKZ+kmpIMiMp+5RIOOC+W96a9zr9DWo9SoM5C0bnwteaL7mg4/VBS3yCMEryN1ufrlrNLFlJFpClcrG5JYYa+ND+wb6+q424=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725639044; c=relaxed/simple;
	bh=NPUDJb9lA/xh0q6TydBiTZ9P8qzBFOqIXcV6AQpxXIE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nR6yUOpWxmpPyTx2T1CyNahBSfjPYIQMdfMAPLp44M6nPbBI1xXz5tZ8W92bxvxeFvtXM5WYpYUpQZVTlAdkDZskjwV4cTBYwEbzJQ6zpi5+gkBcMvRpYp134QRFju3rbEhAMBI5Fio7LYTvf7aYhagTiQBKXr/sPk1LJfCUOrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jOx+qqaX; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jOx+qqaX"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 63E9C36478;
	Fri,  6 Sep 2024 12:10:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NPUDJb9lA/xh0q6TydBiTZ9P8qzBFOqIXcV6AQ
	pxXIE=; b=jOx+qqaX5ii0nKOXEEiqUkM7/gJdRlugRjJaQ6HpIOO/SAlSrgm8N2
	JXf2OgZMbYf8Tnz+e8R63Yvd4p+EfHl6KsuIrAGXfq8BP6xyqwktMQJEefM9ZFNi
	pmjwTtRDdF5w4pvi/geFL1vEs1hGE37gRU5XcrWAU9mTzptivdQTY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B10236477;
	Fri,  6 Sep 2024 12:10:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B7ED436476;
	Fri,  6 Sep 2024 12:10:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Stephen Smith <ishchis2@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/1] Add entry to mailmap file
In-Reply-To: <5909617.DvuYhMxLoT@thunderbird> (Stephen Smith's message of
	"Fri, 06 Sep 2024 08:49:53 -0700")
References: <20240906153003.110200-1-ischis2@cox.net>
	<5909617.DvuYhMxLoT@thunderbird>
Date: Fri, 06 Sep 2024 09:10:39 -0700
Message-ID: <xmqq34mcyd8g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8FDCBCA0-6C6A-11EF-A54D-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Stephen Smith <ishchis2@gmail.com> writes:

>> From: "Stephen P. Smith" <ishchis2@gmail.com>
>> 
>
> I don't know why git send-email added this extra From line to the body of the 
> email.  This line is not part of the file that format-patch created.

Most likely that the author name recorded in the commit object is
with "P.", but the name your MUA knows you as is without.

In such a case, the command adds what we call "in-body header" to
override the headers MUA uses (in this case, "From:" that the
recipient takes the authorship identity from).

As the name with "P." is what you signed-off your commit on the
"Signed-off-by:" trailer line, it is absolutely the right thing to
do to override the name MUA knows you as with the in-body header so
that the author name matches exactly the name used for signing it
off.  IOW, what you sent is perfectly fine.

For future reference, another header commonly overridden with an
in-body header is the "Subject:".  In a general discussion that is
not a review thread of any specific patch, somebody may come up with
a patch to improve the situtation.  In such a case, your message may
look like:

    From: A Project Participant <par@tici.pa.nt>
    Subject: Re: why does git do this?
    To: git@vger.kernel.org
    Cc: ...other particpants...

    Hmph, it does sound like a documentation bug.  How about
    clarifying it this way?

    ---- >8 ----
    Subject: doc: document the condition under which gostak distims the doshes

    The document does not exactly say when gostak distims the
    doshes.  Make sure it is clear by updating foo and bar
    documents.

    Signed-off-by: A Project Particpant <par@tici.pa.nt>
    ---

The "scissors" mark (horizontal line drawn with "-" with scissors ">8")
tells the recipient to ignore everything in the body before that line,
and then we have in-body Subject: header to override the "why does
git do this?" e-mail subject on the discussion thread with the title
of the commit.

