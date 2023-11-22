Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UM66o0Jt"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108F7171E
	for <git@vger.kernel.org>; Tue, 21 Nov 2023 17:09:02 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 30580310C1;
	Tue, 21 Nov 2023 20:08:58 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WUHAkLjAkBQRECgtLghMqc2jh1Trp7SsSH8E3R
	KU9F8=; b=UM66o0Jtc55GS0dXoKXisj3Pjlrkx+crZKK9lkhFiCbezUzjA/ys2H
	F9H/PXA8ZGHkPYXEZLq4IsrrZUKGDr07mt7ddb3dFTBs9bJxeW+gxGYKC67BMtO6
	4eJNOZROcUEYG/yuyxvuslYw/D27k5IBR2TWBA6vIWo2NP5dYsEVM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 28B57310C0;
	Tue, 21 Nov 2023 20:08:58 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0E495310BC;
	Tue, 21 Nov 2023 20:08:53 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Craig H Maynard <chmaynard@me.com>
Cc: Git Community <git@vger.kernel.org>
Subject: Re: Orphan branch not well-defined?
In-Reply-To: <FE2AD666-88DE-4F70-8D6D-3A426689EB41@me.com> (Craig H. Maynard's
	message of "Tue, 21 Nov 2023 19:28:36 -0500")
References: <FE2AD666-88DE-4F70-8D6D-3A426689EB41@me.com>
Date: Wed, 22 Nov 2023 10:08:51 +0900
Message-ID: <xmqqil5uegrg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B3C7E6F6-88D3-11EE-B840-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Craig H Maynard <chmaynard@me.com> writes:

> Recently I tried creating an orphan branch in an existing repo using git-checkout and git-switch. 
>
> Both commands have an --orphan option.
>
> The results were different:

This is one of the very much deliberate differences between "switch"
and "checkout" (there are others).

The "switch" command was introduced as an experiment to figure out a
better UI choices for one half of "checkout", which deals with
checking out a branch to a working tree (the other half being
"restore", which is about checking out files out of a tree-ish).
The initial round of "switch" proposed to go with the identical
semantics as "checkout" for the "--orphan" option [*1*], but during
review discussion, a concensus was reached that a better behaviour
for creating an entirely new history may be to start from void
[*2*], and that is what is in the experimental command you see.


[Reference]

*1* https://lore.kernel.org/git/20190130094831.10420-9-pclouds@gmail.com/

*2* https://lore.kernel.org/git/CABPp-BF3_p3+fmQcWYEu2z3J4FfPmDmiMyFiBRXyz8TxKLL7jA@mail.gmail.com/

