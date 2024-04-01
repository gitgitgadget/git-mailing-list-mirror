Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBE04AEF0
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992377; cv=none; b=o+SO3uYd5qAvYF34jbGwXqOMWKKapHB8E7W023/q+NGp+IFZccM/dHOp4mXNyEzh8MUGabKcJwr3Z6Mu9Xt25UlMWKoFFGbkanxYghf7YowSegt1e2qv5DBUw3cnVkCHQBqkpFGWCsdMZ4wW+hizL03pkd1OMHuaWi6dtn44tNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992377; c=relaxed/simple;
	bh=kBm3lArTkA4J47yjkeE04CHBb6P4PF1n6PJSliReCl8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uD/WaYHzD0YEE6EckspsQhGvW4jU9I8EI8D0KB7LYUj3E0eow/aU88WoYD5rOxfj5Hn0gjGsl08rRCLSNer/2ZqJMC89aIqlEYJiUDgVYHKemR5HH+2nxTF5/LmWg209FhP58i795ulM/e+AJTgESDjcpiuEq+G8N+RqOQ1UM9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WmX37u9V; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WmX37u9V"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4F83321461;
	Mon,  1 Apr 2024 13:26:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kBm3lArTkA4J
	47yjkeE04CHBb6P4PF1n6PJSliReCl8=; b=WmX37u9VmntuqtJv1/ppNJWZLMxe
	R2uu1hKEzNkPOIX9DdUU9Se93XvYh/UmuRU7I3GzftfyH0ZKJw+d54k3wiU6AvP2
	8kpxcXRUlVUx0IACkNhtJd+Xvc3STamMYAwqSvn3XQUcMLpMWWQjQDudr0GloVEj
	Wy1OAbWm8lhIxhM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4636521460;
	Mon,  1 Apr 2024 13:26:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D63E32145F;
	Mon,  1 Apr 2024 13:26:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] completion: fix prompt with unset SHOWCONFLICTSTATE in
 nounset mode
In-Reply-To: <CABr9L5A_zz6ZvBWUoX_Px6Upyiur3+SPp8U91uw3OXO0mXZgeg@mail.gmail.com>
	("Ville =?utf-8?Q?Skytt=C3=A4=22's?= message of "Mon, 1 Apr 2024 17:07:01
 +0000")
References: <20240401113033.28709-1-ville.skytta@iki.fi>
	<xmqqttklcd6d.fsf@gitster.g>
	<CABr9L5A_zz6ZvBWUoX_Px6Upyiur3+SPp8U91uw3OXO0mXZgeg@mail.gmail.com>
Date: Mon, 01 Apr 2024 10:26:10 -0700
Message-ID: <xmqqh6gl9eq5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 EF5A7176-F04C-11EE-A5E8-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Ville Skytt=C3=A4 <ville.skytta@iki.fi> writes:

> I initially actually changed those very lines too when working on the
> fix for the issue I faced with GIT_PS1_SHOWCONFLICTSTATE. However,
> both occurrences are within __git_ps1_show_upstream, and the only call
> site for that function is protected by a check on the variable that
> does take possible unset state into account; the function will in the
> file's current form never be called with it unset. Additionally, the
> first occurrence is immediately following a line that sets the
> variable, so that one is "doubly protected".
>
> Therefore, I decided to undo those changes and not include them here.
> I guess it's a matter of taste whether one finds it desirable to
> protect those accesses nevertheless, but it's not strictly necessary.

I am glad you took a look into it already.  I wonder if we can
somehow keep this "institutional knowledge" to help the next person
by saving them from wasting time wondering about the reason why it
is safe (iow, what you have found out and described above).  Perhaps
a patch like this?  I dunno.

Anyway, thanks again for digging!

 contrib/completion/git-prompt.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git i/contrib/completion/git-prompt.sh w/contrib/completion/git-pr=
ompt.sh
index 3826f52dec..b05e4cb049 100644
--- i/contrib/completion/git-prompt.sh
+++ w/contrib/completion/git-prompt.sh
@@ -113,6 +113,10 @@ printf -v __git_printf_supports_v -- '%s' yes >/dev/=
null 2>&1
=20
 # stores the divergence from upstream in $p
 # used by GIT_PS1_SHOWUPSTREAM
+#
+# Note: ${GIT_PS1_SHOWUPSTREAM} is used without the nounset=20
+# protection ${GIT_PS1_SHOWUPSTREAM-}, as the only caller calls
+# only after making sure it is already set.
 __git_ps1_show_upstream ()
 {
 	local key value
