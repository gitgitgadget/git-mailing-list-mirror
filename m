Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7233480C
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 01:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708566197; cv=none; b=SDQmLvc+XIbJk1W3Fl1xd81JNbCE+EBInkL+yNFsjhFK90J18/zObXiVdCp6l28uGLFFKYfNogxNFYeJFEj8lwrKSV5WnZcKGukR7Lm+66nC2xwgJoolfnnfQOV13dBZAGbG5bUqYRx/UFHZXqG3lNSjKlwYLFsEdiXkEzpFm2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708566197; c=relaxed/simple;
	bh=MBRfogY4BRUwgkKhABV9PSxZHnVMh935SDs1HYuMT00=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JIFW2PRyH4ChPwBx8sVl14ru3gQIb1T7H3aSw72r3SSl+kc2ojmvUEad2kMMa8/4KHCvRCQKANuINKUdydUl5UaSa5xhrGXrFSD1ChuBdqiml/C95+FRqVAw7ODremK2I2fsemSdBcoNyN5a2rXTSsjT3MihOYR6Jvfz3TeOOaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AhpkG6t7; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AhpkG6t7"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3CEBC348E3;
	Wed, 21 Feb 2024 20:43:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MBRfogY4BRUw
	gkKhABV9PSxZHnVMh935SDs1HYuMT00=; b=AhpkG6t75Q8Edv5P3Je8Ze+AJhvv
	sVUqjWYlc/4+IvlYnEjJQFRFGjU8fvH62bu3ghUT1/jfNtwQ8gDqjYohmQFTKP2c
	6wnGOQ/IizKuEFJYxmxHL/NYukbyaHIsIvbJ/nlG33LifV4YDAJ6yIYmHvwr6dPp
	VeM7eq6/fIRXNhU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 35984348E2;
	Wed, 21 Feb 2024 20:43:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D09C6348E1;
	Wed, 21 Feb 2024 20:43:06 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,  Harmen Stoppels
 via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Harmen Stoppels
 <me@harmenstoppels.nl>
Subject: Re: [PATCH] rebase: make warning less passive aggressive
In-Reply-To: <xmqq4je1mo5p.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	21 Feb 2024 14:46:10 -0800")
References: <pull.1669.git.1708442603395.gitgitgadget@gmail.com>
	<xmqqjzmxofvn.fsf@gitster.g> <20240221183018.GB9696@kitsune.suse.cz>
	<2324063.ElGaqSPkdT@cayenne> <xmqq4je1mo5p.fsf@gitster.g>
Date: Wed, 21 Feb 2024 17:43:05 -0800
Message-ID: <xmqqr0h5i89i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 B9F0FCA0-D123-11EE-B427-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> writes:

> Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:
>
>> As a translator, I'm less bothered by editing a sentence to remove a q=
uestion=20
>> mark (maybe enforcing a language style and reformulating the sentence =
by the=20
>> way), than by translating again and again similar sentences.
>
> Sure, but if the original in C locale used to be "FOO BAR?" and you
> translated it to "foo bar?" in your language, and then a patch
> updates the string in the source to "FOO BAR", doesn't msgmerge
> notice that the original as a "fuzzy" matching and offer you
> something like
>
>     #, fuzzy
>     msgid "FOO BAR"
>     msgstr "foo bar?"
>
> so that all you have to do is to remove '?' anyway?  So I do not
> think you'd need to translate the "FOO BAR" part again and again.
>
> But the above assumes that for your language, the ONLY thing to turn
> such a rhetorical "passive aggressive" question into grammatically
> correct statement of a fact is to remove the question mark.  It may
> not be universally true for all languages, and for some language,
> even after msgmerge did its job correctly, you may need to do more
> than just removing the question mark to adjust the remaining "foo
> bar" part.

Hopefully the last message on this topic from me.  I just tried this:

 * apply v2 of "No rebase in progress?" -> "no rebase in progress"
   patch from Harmen.  This only changed _("") string, without
   touching any po/* files.

 * follow po/README.md and pretend as if I were a po/es.po team
   member, which involved running the command:

	$ make po-update PO_FILE=3Dpo/es.po

 * view the resulting po/es.po, which will be the starting point of
   a new translation.

        $ git diff po/es.po

The last one showed me this snippet:

    -msgid "No rebase in progress?"
    +#: builtin/rebase.c:1257
    +#, fuzzy
    +msgid "no rebase in progress"
     msgstr "=C2=BFNo hay rebase en progreso?"

The "#, fuzzy" thing is a signal that an old msgid has been updated
and corresponding msgstr may need to be updated.

The primary problem I had with Harmen's v1 was that it touched po/
file in the first place (which was corrected in v2), but the updates
to po files it did looked like so:

    -msgid "No rebase in progress?"
    +msgid "No rebase in progress"
     msgstr "=C2=BFNo hay rebase en progreso?"

Notice the lack of "#, fuzzy" marking?  If v1 were accepted with
these changes, then the "po-update" step I showed earlier would have
produced something like this instead:

    +#: builtin/rebase.c:1257
     msgid "no rebase in progress"
     msgstr "=C2=BFNo hay rebase en progreso?"

As msgid alone was updated already, the "po-update" step has no idea
that the translated msgstr is out of date.  We do not get the
helpful "#, fuzzy" comment to tell the translator which msgstr is
out of date and needs attention.

So it is another reason why we want the developers to concentrate
only on writing good C-locale messages inside _("") and N_(""),
without touching po/ directory at all.  It would avoid making
changes that can confuse toolchain l10n people rely on (like the
presence of "fuzzy" comments).
