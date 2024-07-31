Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E7F17BBF
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722440694; cv=none; b=FZ8x+B5PEQWo+8wi7WdfALfuC9tC1vGsENiirNdcAmBgwz8uTR2cwKZM2nS3gvuJV1c0A3oU8GJ67dMtRRvFGwATId2CvU8SWDSAgUDBpikUcb6AEBq5qv8QJv+TMKFyyV1e6NaPnF7v7x2RecdVKrsBQm6L+N59NZMguAPrbas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722440694; c=relaxed/simple;
	bh=nDPcIwwaWdTkKSe0WxjqAjbIYpBkB3IuIvz03RawKI4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EyDrxVYKzqSRoVai9ke0xRFXFIYTX4LmynwsBEU4sFZ/tGGjUMlbGk+uo/SU7SwkT2e/Z+i7zZC+D4HYTT+KQZ7aqblO9WrgreBN/ICzOBrLX+l/QE6oGGoSPSxof6Th9+yUdlNjRLarLaEVLY/HDU3Tv6h4yf9HUId1gv2LXNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QRd/KwPV; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QRd/KwPV"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 77F202436A;
	Wed, 31 Jul 2024 11:44:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nDPcIwwaWdTkKSe0WxjqAjbIYpBkB3IuIvz03R
	awKI4=; b=QRd/KwPV2z6OpMr53Bi4gFmE1I1SsCqdRLNqdnPhwTzvejD0u1Y3/A
	gu4fi4EZfzzJlxk7CAyAYh30lW9V4xMCd78rNehOlWYl4b4WG6q2B86xidwjUn5k
	FAsMTbByOGdjRH02PDwcPBSgUvfDMdCVZ+PzmSV+rk4XGWhQBnqds=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7096F24369;
	Wed, 31 Jul 2024 11:44:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8975D24367;
	Wed, 31 Jul 2024 11:44:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: KwonHyun Kim <kwonhyun.kim@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Possible bug or error in document?
In-Reply-To: <CADLV-7+mQ0K6_-L_Pws9yOYfQ++b4NyH5+FXwbyHuXBiOALeYA@mail.gmail.com>
	(KwonHyun Kim's message of "Wed, 31 Jul 2024 15:08:50 +0900")
References: <CADLV-7+mQ0K6_-L_Pws9yOYfQ++b4NyH5+FXwbyHuXBiOALeYA@mail.gmail.com>
Date: Wed, 31 Jul 2024 08:44:46 -0700
Message-ID: <xmqqh6c58t1t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D16607A0-4F53-11EF-AA0D-9625FCCAB05B-77302942!pb-smtp21.pobox.com

KwonHyun Kim <kwonhyun.kim@gmail.com> writes:

> --ignore-errors
>            If some files could not be added because of errors indexing
> them, do not abort the operation, but continue adding the others. The
> command shall still exit with non-zero
>            status. The configuration variable add.ignoreErrors can be
> set to true to make this the default behaviour.

I think "--ignore-errors" is meant to ignore errors only about
"adding" a discovered path (i.e. the exact path that user wants to
add) to the index.  Perhaps the file exists, but an I/O error
prevents Git from reading it fully, causing it to fail computing the
blob object name.  Such an error is ignored and other paths that got
successfully computed their hashes are added to the index.

On the other hand, errors while discovering what exact paths the
user wants to add are not ignored.  So "git add --ignore-errors --
no-such-file" would still error out in order to notify you that you
asked for no-such-file that does not exist, and "--pathspec-from"
does not change the story.

What is missing from "git add" might be the "--ignore-unmatch"
option that "git rm" has.  There are other commands that supports a
similarly named "--ignore-missing" option, and we may #leftoverbits
want to unify them over time (i.e. decide which one to use in the
longer term, say "--ignore-missing", teach "git rm" that
"--ignore-missing" is a new synonym for "--ignore-unmatch", add
"--ignore-missing" to "git add" and probably other commands that
would benefit from having it, and then in a far enough future,
retire "--ignore-unmatch" from "git rm").

