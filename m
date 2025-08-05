Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABDA259CB1
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 16:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754411703; cv=none; b=ob9NV2jZfEezmX9gnX13uYGrq2jZvH5nVOxlBSsNP1LHZuW1TXxQSQ92mgS7oVrQCJ9XGz4YeRfh8yC1JJcueWRKCZA7cTbM6WFIsV8hFDuZKQ7boKgdQjzkOpfhdSTdhY0MqfOtPes2pjtEpj/QHZA8QV8nMr+wUaJukplSVXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754411703; c=relaxed/simple;
	bh=yVM1GGqZcMrwWartRiF5h+KzISBGj6pInk/LvgLfJ3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f6i9cLhXe6CJDJp6Q2sea0V+gQDGB7a83UXYdGgSDkmTOqbSVLVj3An3nrDcslBG3irhgRRQgVmAHByCQYfrZjURB2CrVaGEnv3+wvTwaUq2S4ucOXa6IACwvzui1eVI+kaFkt4/xTEfdJkhCbOdHiqX5UvnfSzzf9hlOvm3aP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XJAMEqP1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L/5FvDNP; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XJAMEqP1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L/5FvDNP"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 298C21D001C3;
	Tue,  5 Aug 2025 12:35:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 05 Aug 2025 12:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754411701;
	 x=1754498101; bh=PS9GxDYXN/3LBayCXo6iBh5bswbp0SH+7/csxJv/EKE=; b=
	XJAMEqP1fUfk/xDj90G/PxXwm6udG50vbZdIX6YEqckfbFGpeWYS09YKdVCkoGY+
	Eosod2Xv+mwZrJxLZPVG0swoGo28znm4u6q7NF05SnmsuoDwhaSn3EuiTOAmyLPT
	/D6ldqLZVQB6qnX+Azo1Y3z69tQQv3wBMswh03dUGrEBYcpLa3IuoK/lqWOi3fH+
	6QCJ2TSyKt0AOcTY+0gmSwPuBGER+GycdXfMoc0QQtlCmH+RuToxl4Ma3OCo7JaO
	Jksaa0ieNk0emQ/57RjJwbL3+ECZpSBh/lY999Bj+unudnlDrKdwfj9pCjmUcuQC
	XUgjc8M/XbI2A0TcdgLbDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754411701; x=
	1754498101; bh=PS9GxDYXN/3LBayCXo6iBh5bswbp0SH+7/csxJv/EKE=; b=L
	/5FvDNP9ny2goZXedcsXsWKrbohdhjlcFChxMXGITnxE+Nw/Jw6qZNdrtp+vXqWW
	j9fZIMEAtU/Ij/FRvPFERh5BWhguOiaDyPVW6iyfzFXTp5YKXGnVj277M7/6yXXv
	Msv+RjK9f0No0OCHz59120Ae1Hy+47z6GyE0GlWYbPxoD3ppMVpHbfhSsgBbYXq5
	5+xOuXgHhZWiOZcjpJ1N+qRMcJTZ7bRhjFYtj3VIZLKrNOZoUf6GHrrm9g8kzYwp
	1h5EIUd9WabRX1oKVUWkZAJNsPb0sf4BDmBKWmJv7VTfiBEqeQsCYgqSUvkzU8OF
	r7/CwK7J0lEeGo7iOQNjA==
X-ME-Sender: <xms:tDKSaLVC8tJnPmHQyz9rUmjUkEIujpvLoddhWJat3-zqQYFLQuPDYA>
    <xme:tDKSaOIS21sfFiz5KvaK5S7nS8Q4WUzRfI9tUekGQvUzn1tvSVu2OTMAnDXNLLao1
    wJ1Flh4UAapGlw-dg>
X-ME-Received: <xmr:tDKSaD8ktixq3zQZum4amHzE2uSOl45DmZ-m4BqE4WHrBwnhdG1olM2G5ajO5RsJJECCig2zmAvFy7X9vzZPI-orUWIdiY0MDsUQznI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhnrdgrvhhi
    lhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:tDKSaJI-c2e2cc5bd6WU-G2U4yEvUJvR-VgIcAnem_XW9oQd-Yjh-g>
    <xmx:tDKSaAkedy9Dinycw9v825KrY5hwLyvffgrKG0K4WgJ3HG0JMvtcSA>
    <xmx:tDKSaFPz6kBxuPfsKDlRqGaPiVHxSmMLx6qVD5trDh61deqDhrd0Eg>
    <xmx:tDKSaO0SVyC-e44EAeRQZAUp0ooZTOyJVmG4Nbhz7ciJxN-sc6uJbw>
    <xmx:tDKSaFSHNmhxMPEkrLDdJmklrk4CmnzVJV6pkHnQqZ7JmPFoIkJ0tIfb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 12:35:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v7 0/3] Introduce git-last-modified(1) command
In-Reply-To: <20250805093358.1791633-1-toon@iotcl.com> (Toon Claes's message
	of "Tue, 5 Aug 2025 11:33:55 +0200")
References: <20250730175510.987383-1-toon@iotcl.com>
	<20250805093358.1791633-1-toon@iotcl.com>
Date: Tue, 05 Aug 2025 09:34:59 -0700
Message-ID: <xmqqjz3h20cs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Toon Claes <toon@iotcl.com> writes:

> Changes in v7:
> - Fix case when bloom filters were used and a commit range was given. This bug
>   was uncovered in CI.
> - Rename the long option for `-t` to `--show-trees`. This option no longer
>   implies option `-r`. And resemble these changes in the documentation, with a
>   few other small documentation tweaks.
> - Move prepare_commit_graph() into get_bloom_filter_settings() which no longer
>   requires last-modified to worry about it itself. This is similar to
>   repo_find_commit_pos_in_graph() and lookup_commit_in_graph()
> - Bring back the call to commit_graph_generation() in maybe_changed_path(). This
>   is also called in the same function in blame.c and in
>   check_maybe_different_in_bloom_filter() in revision.c. I couldn't find a test
>   case that triggers this exit condition, but it should not have negative
>   side-effects.
> - No longer call diff_free() on the copy we make when populating the `paths` of
>   `struct last_modified`. Because we weren't doing a deep copy, this could clean
>   up fields used later on by the original. Instead only call clear_pathspec(). A
>   comment to clarify this mechanism better is added.
> - Add BUG() call to exit condition that shouldn't happen.
> - Switch some int types to bool types.

I am happy with the updates, but am wondering if documentation
update along the lines of attached patch is also needed.  I am not
sure about the last two, i.e. things that are not dash+option
appearing as enumeration labels, though (and Cc'ing Jean-Noël to ask
for help).

Thanks.


 Documentation/git-last-modified.adoc | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git c/Documentation/git-last-modified.adoc w/Documentation/git-last-modified.adoc
index 35bd4a1dd0..602843e095 100644
--- c/Documentation/git-last-modified.adoc
+++ w/Documentation/git-last-modified.adoc
@@ -22,24 +22,24 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 OPTIONS
 -------
 
--r::
---recursive::
+`-r`::
+`--recursive`::
 	Instead of showing tree entries, step into subtrees and show all entries
 	inside them recursively.
 
--t::
---show-trees::
+`-t`::
+`--show-trees`::
 	Show tree entries even when recursing into them. It has no effect
 	without `--recursive`.
 
-<revision-range>::
+`<revision-range>`::
 	Only traverse commits in the specified revision range. When no
 	`<revision-range>` is specified, it defaults to `HEAD` (i.e. the whole
 	history leading to the current commit). For a complete list of ways to
 	spell `<revision-range>`, see the 'Specifying Ranges' section of
 	linkgit:gitrevisions[7].
 
-[--] <path>...::
+`[--] <path>...`::
 	For each _<path>_ given, the commit which last modified it is returned.
 	Without an optional path parameter, all files and subdirectories
 	in path traversal the are included in the output.
