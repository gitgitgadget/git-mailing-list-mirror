Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C37D51A
	for <git@vger.kernel.org>; Fri,  3 May 2024 19:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714765381; cv=none; b=U4ber7BCd9ZvS4b/VfgOw1saaw4q/kVJCmjwH6knEvYQkJqZcKSoGH+lXyR8ebbGbbTB4flH7sqIdSCDZNiHHKvLuUFRx4U73sXvQmd10CuKuo5yV9pxyoAj+AdbUWzEWGuGa1yfL8OC0zuAr34BL258VwtflaoL0lXIPWYQtig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714765381; c=relaxed/simple;
	bh=OkPaorFowUbu+fpxzQp8O8RBS9DvDMWyU0tKiMeSlQM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gp69utsmOA2zVcvnrPjA/qQwy8nbwnMRw+dB4uECGg07lZqGiIfQy/tI+GCw+pAJnJooGDI3pZ2RSJ/ZubMxUiQ20BGb2eWOTpQ4+gIiWqlIT0j9i2bGhol1pGmh2kPrebO1nKudMQOhMJ+mixCYfIOCMBjY9Pi3zGWjz9r/o0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=j6gJ6EAw; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="j6gJ6EAw"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1878227612;
	Fri,  3 May 2024 15:42:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OkPaorFowUbu+fpxzQp8O8RBS9DvDMWyU0tKiM
	eSlQM=; b=j6gJ6EAw5uZmbpiRipZJyH4+SSYiHKcxJYxewx7eRyRvAMhFdyZt3g
	g8YI6DK6vo2WG7bZkGI2csLsTgevmFVTWYB5lDewettITekpkhMkghNS/dk13keE
	dAIneRd55lGHV/q4ofb8xQMZ/SvLSKgTGoEAXdKIrgF0S5eGh//Jc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1135527611;
	Fri,  3 May 2024 15:42:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 783A227610;
	Fri,  3 May 2024 15:42:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kang-Che Sung <explorer09@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: Combined diff format: Show all filenames by default?
In-Reply-To: <CADDzAfPbSv00AfzdJ5DZbXM8YjAr=po6Y_1Y0weyw5dvVA6qFg@mail.gmail.com>
	(Kang-Che Sung's message of "Sat, 4 May 2024 03:11:06 +0800")
References: <CADDzAfNz3R5yj1SdJYbBe0f8m3Sp-R+X6dRpYoJ8Foj6zijcDA@mail.gmail.com>
	<xmqqmsp7aqoa.fsf@gitster.g>
	<CADDzAfPbSv00AfzdJ5DZbXM8YjAr=po6Y_1Y0weyw5dvVA6qFg@mail.gmail.com>
Date: Fri, 03 May 2024 12:42:57 -0700
Message-ID: <xmqqjzka65ry.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 58186D84-0985-11EF-BB01-25B3960A682E-77302942!pb-smtp2.pobox.com

Kang-Che Sung <explorer09@gmail.com> writes:

>> As the format HAS ALREADY lasted for a long time since its
>> introduction in d8f4790e (diff-tree --cc: denser combined diff
>> output for a merge commit., 2006-01-24), it is too late to change
>> the default.
>
> I wonder what things would break if we change the default behavior of this?

Human users who rarely if ever rename files will start complaining
for wasted vertical screen real estates taken by the extra lines.

Nothing is broken, and you are proposing to break things.  Be more
gentle to existing users; "what would break if we change?" is an
absolutely wrong attitude to approach this.

> Well, I won't expect the default to be changed for uses in scripts or
> GUI frontends. I wish to change the default for interactive, terminal
> uses, so that usability comes in "out of the box".

How would a script that is running by interactive users whose
standard input and output streams are connected to a terminal adjust
to sudden change of the default?  The "git" invocation in such an
environment would not be able to tell if you typed it or if you
typed the name of the script.

