Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7354037707
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711556026; cv=none; b=F23Z+2sRkmeHGfN+phg89ynuYfL6HIJNDJyAiXbVVW0OpWiDuZi+Sdf/1yVlzx3AsQFquydHVyUjWEL3UpK83lkL19IlE6fIzE9ZCfZUuubHncocSw51aQNpRvoiSLNoCXU39EIm4PfWP1v61dizCpGNpQXSHz+pYWdLHXc7kBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711556026; c=relaxed/simple;
	bh=f70iyAKSFk0QCRkHNAh1RLfG3A13u1k7o/Z4UehpdiQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZiUJVT7mvNlrM/hWaR4RdhoiscIgH+zxXe5cHtTApheTBSM3otm+n00VWQH6K1bVz9QlKmfC87KN2W5uJbfpHfiTyj+Tq7k+saQu2eN/HdCF+G1ke9m0qtqz3BfRZD3fwkWXwJkRc1GaCMlSvpT2qUux31Rw4d5NlJN8QbloYOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vDhxmHrx; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vDhxmHrx"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id ADABC365CB;
	Wed, 27 Mar 2024 12:13:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=f70iyAKSFk0QCRkHNAh1RLfG3A13u1k7o/Z4Ue
	hpdiQ=; b=vDhxmHrxKIJsaKQgAeUnllAI07QmKAfxTbk+e+bW1eH6PcS3xJh5De
	mUOI/Y3q8Bf+yrfc+7SX8PiXm8aXKXS8POhTBNeKFdBz2PPOxEDkIA8uyHSpLvoC
	hoZ/h/7fN973pcKKYNRpfp88tR+9dlAhc1k9xBNb87gTnaRFlR1ag=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A5D5B365C9;
	Wed, 27 Mar 2024 12:13:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7A902365C7;
	Wed, 27 Mar 2024 12:13:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  Dragan Simic
 <dsimic@manjaro.org>,  Manlio Perillo <manlio.perillo@gmail.com>,
  =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>,  Phillip Wood <phillip.wood@dunelm.org.uk>,
  git@vger.kernel.org
Subject: Re: [PATCH 17/16] config: add core.commentString
In-Reply-To: <20240327081922.GA830163@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 27 Mar 2024 04:19:22 -0400")
References: <20240312091013.GA95442@coredump.intra.peff.net>
	<20240312091750.GP95609@coredump.intra.peff.net>
	<0426f7bf-6032-4fc7-886c-c4278c6e105b@app.fastmail.com>
	<20240315055944.GB1741107@coredump.intra.peff.net>
	<6be335ed-8598-406c-b535-2e58554b00e9@app.fastmail.com>
	<20240315081041.GA1753560@coredump.intra.peff.net>
	<xmqq8r247igg.fsf@gitster.g>
	<20240327074655.GA831122@coredump.intra.peff.net>
	<20240327081922.GA830163@coredump.intra.peff.net>
Date: Wed, 27 Mar 2024 09:13:31 -0700
Message-ID: <xmqqa5mj3b6c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F57EDCB4-EC54-11EE-994C-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> Note that you graduated kh/doc-commentchar-is-a-byte, which says "this
> ASCII character" early in the description, which will be incorrect if my
> series is merged.

True.  I could tweak this patch to force a conflict

 core.commentChar::
 core.commentString::
 	Commands such as `commit` and `tag` that let you edit
-	messages consider a line that begins with this character
+	messages consider a line that begins with this string
 	commented, and removes them after the editor returns
 	(default '#').

and let the rerere database to remember the resolution (which will
tweak "string" back to "character").  But I'll prepare a merge-fix
before I forget, which is a cleaner approach.

> An alternative to using "$var cannot ..." in the error messages (if we
> don't like the all-lowercase variable name) is to just say "comment
> strings cannot ...". That vaguely covers both cases, and the message
> printed by the config code itself does mention the actual variable name
> that triggered the error.

OK, because the error() return from this function will trigger
another die() in the caller, e.g.

    error: core.commentchar must have at least one character
    fatal: bad config variable 'core.commentchar' in file '.git/config' at line 6

so we can afford to make the "error" side vague, except that the
"fatal" one is also downcased already, so we are not really solving
anything by making the message vague, I would think.  The posted
patch as-is is prefectly fine.

Side note:
    I wonder if we would later want to somehow _merge_ these two
    error messages, i.e. the lower-level will notice and record the
    nature of the problem instead of calling error(), and the caller
    will use the recorded information while composing the "fatal"
    message to die with.  I actually do not know if it is a good
    idea to begin with.  If we want to do it right, the "record"
    part probably cannot be a simple "stringify into strbuf" that
    will result in lego message that is harder for i18n folks.


$ git diff refs/merge-fix/jk/core-comment-string^!
diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index bd033ab100..bbe869c497 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -522,7 +522,7 @@ core.editor::
 core.commentChar::
 core.commentString::
 	Commands such as `commit` and `tag` that let you edit
-	messages consider a line that begins with this ASCII character
+	messages consider a line that begins with this character
 	commented, and removes them after the editor returns
 	(default '#').
 +
