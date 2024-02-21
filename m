Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8627C12AAE0
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 23:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708559645; cv=none; b=qQ7clH0Q2aj+TKP8Zbq5aVY3oMoNFXKFnx27Sid1TKn+ymduGVs9nlXqYV30XhVbYkxEuBwnX7PS1HUDqdnmq1HXbzP5Bkfk5ZQmY0ybWcBrrxFQIRrL31g4D4xnGc124EcGh22Axc0Nl0yCG05v4R+dMCPo0PB4esxTMrBdyek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708559645; c=relaxed/simple;
	bh=qfJJ85SGm+EbwXHDPp9JA/ZwI7W+183+HHnSRkJQH3U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VuuepqAHwcJajgULZ4kQBS7EjLgW8F3soOwQ21+mq+zm/KULAsVix4210WGXFTE1Fi+0ipGOKBjjU9N7QexIjNa6AVoF1TC9It8CVqBjAkopY9qVyqCmZL902+kl8XNIBQmvoHSpOGUHQPN9aJ4JQmqFpZn64xrk1EFDnWwzwqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ssXqguA7; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ssXqguA7"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 25E4D33E0F;
	Wed, 21 Feb 2024 18:54:04 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qfJJ85SGm+EbwXHDPp9JA/ZwI7W+183+HHnSRk
	JQH3U=; b=ssXqguA7ns2E6lqRey6JOJpOwoRH8O6IYrumlKz5gbVZ62M0Rr/ZWq
	S1bwVt/pQMofAV1QoVhd9Rxq77MXf0rAlzd9JWz9zX53uxHZNTID2TXwJLk9jq6o
	IiDD79XbK6GtIh9hSoYsvDwkBSpYSC9F6IChtsTq1Zzl0E3NlzPoI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1E6E933E0E;
	Wed, 21 Feb 2024 18:54:04 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B475E33E0B;
	Wed, 21 Feb 2024 18:54:00 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ricardo C <rpc01234@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  phillip.wood@dunelm.org.uk,
  git@vger.kernel.org
Subject: Re: [PATCH] builtin/stash: configs keepIndex, includeUntracked
In-Reply-To: <xmqq4je1o9yu.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	21 Feb 2024 12:09:45 -0800")
References: <20240218033146.372727-2-rpc01234@gmail.com>
	<99346639-5a36-4c2e-a5d7-035c3c1fda8b@gmail.com>
	<df020dcc-afe8-4dd8-b476-4ca032206214@gmail.com>
	<78a8733b-c74a-4017-8905-d29b2e05adb1@gmail.com>
	<xmqqjzmzqb85.fsf@gitster.g>
	<b84e77a1-93e4-4de0-a0cd-4d76a5691a9b@gmail.com>
	<xmqq4je1o9yu.fsf@gitster.g>
Date: Wed, 21 Feb 2024 15:53:59 -0800
Message-ID: <xmqqzfvtjrvs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7C271B0C-D114-11EE-B96E-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Ricardo C <rpc01234@gmail.com> writes:
>
>> Permanently enabling keepIndex is mainly intended for people that like
>> to stash their unstaged changes before committing (e.g., for testing
>> them independently of other changes). The main issue with what you
>> recommend is that, if they forget to use `-k`, then the entire state
>> of the index is lost, which is especially problematic if the changes
>> were interactively staged.
>
> Doesn't "git stash pop --index" meant to recover from such a
> mistake, though?  If you stash, because your "git commit" notices
> there is no change after you did "git stash" without "-k", your
> recovery to "pop --index" would apply the changes to the index and
> to the working tree on top of exactly the same commit, so there is
> no risk of losing any changes by doing so, right?  IOW, such a pop
> will always round-trip.

Actually, "git commit" gets into the picture of making and
recovering from such a mistake a bit more costly than I made it
sound in the above.  My bad.

The common sequence is

    $ edit edit edit
    $ git add -p
    $ git stash -k
    $ build what is in the index and test

and then when you are happy, conclude it with

    $ git commit [NO -o/-i/pathspec]

followed by

    $ git stash pop

to continue for the next commit.  So "git commit" should notice if
your earlier "stash -k" forgot to say "-k", but by that time, you
would have wasted the whole build and test cycle.  The HEAD wouldn't
have moved, so the conclusion that "pop --index" would be a good way
to recover from "stash" without "--keep" does not change, though.

