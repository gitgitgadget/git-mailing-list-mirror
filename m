Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B3219E992
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 05:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751867635; cv=none; b=gkiyrwoGi0B6tRkJ88UUQ3kz5Q6PEIjoSMrf0Bbc5/qho94Wn2IJ32oc37QtnJeNZkEf7bZQS4LEZQYgYCMkosYRXKntI85MILvDxfKkI+pb0Ya3srAmqVcG2RY3ZeIaw0pYJstBKHSP92rhZlTKAjfn6Vxo4b0OIdOVgrz+q3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751867635; c=relaxed/simple;
	bh=4CQeX+ooaTE5w7hcI65ge600AJ3JIArdkF2JbZA8q1Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uXcT/BjzBZcab9XHCMdmsKE0+2nQU1KlifXt/hYntP1sQdxcfEq8wv2W1Bjo/dsGcvVvkeYbPi2E/uUZT+BvCui3Se3I/06v58bJbVf6Rifu9VERLHKH9o5U1TbVYuIihtciq2C0uN38xOcgK9fGNmRoHB2wtJlyNpsU9pnFlbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObNA3Xls; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObNA3Xls"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so2686306a12.3
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 22:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751867633; x=1752472433; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqoHUnZSv+ygoKB8HiEsBxYNE2//a+8HRKxHr+RZjcc=;
        b=ObNA3XlsKNW9fkfa0yiSpxIMVqKqAnBvMxSiXBniflctUjspZu4iGbRPettXw2zuBK
         Upk/sLJ6Fa2uhV7Z/EzU1ekCprrcqQftbn/W9OyEVdRmSRyz0onxLFlbg/q5eVO3nMnx
         O1EVWW2hmdNWF+VZVzUXqCl5raj3KLCA6UJC6tD7D+jUyqDv2rsn5zKFUANI6BZERSwN
         zblP3PvJUHldXGa0P2pW9tkrW3jkkn+8pZEmdcpWM4NdzPAy0ouFhSNjngAxhAx2wgXb
         B0S9ZIG24u9kVupCstfsfuDoMPk8Jz6/3OxOWor0PsDpbaGQvUKKG6wqt7GB/wIAklw9
         w2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751867633; x=1752472433;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KqoHUnZSv+ygoKB8HiEsBxYNE2//a+8HRKxHr+RZjcc=;
        b=Lofin/K3BvlhdwbSYkAEjt4D9WVQgH72d57Sraf28+bS2rZvQ+0q9su6paQFUfAUEg
         67AW2hTMxpKDcOqRrZGoXV9soyYAt8V7+UPgFVJL3ZzEtaVNL5wA9wUSgSiSbeeTfXIa
         4bd2O05MxDNwOhYXSpz4V998gl66WIscLeOvU+13ChWvxqISAxf2I4+CfG2QPSO0Vsh3
         V4ZJ3JiMBlCJi2E1Y/6IXWLqGsdGL64SUyzC8PgrKrlie9AqZuZCT0xGUuyCRCzSBq44
         gFe086z3x7/RSw3sJxb5BfI1r+oPqtvKt3GtKhy/D/Z02SIexLucXeZtV4XJzGbRf/Oz
         Mh2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyQtKHVm66AQhJBfz/qK0JZqdnIYVFLJtzyXexIYDaeU/kFkQwaXaa1XlfyyXxXzwJo78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8TAO58Rs7dprrZo2J7tF/5th/XMC9sfB0+XtYirOAFO5RfTWo
	Koru7Uc5LuLbLzb3pOyzkN/aw/QMex1TZNFUY2mGfjTA8C5sS9illBqC
X-Gm-Gg: ASbGncsuBzAjQp0H+IM36umqtwibmKeWBi4jlh1pr8vVScAwM8X29aKKsqtPz8+T7zR
	rBAivDqnMvXwHRQYwHqOfBMXAbk8D9nLNwbgglOm5gvuRnrPtlSZ46hHvEmYIVDAesPQTHNCuOt
	udZc7gXghGBMsmPX/IjGQTgNkVkBHGGnsj4i+XdB2gz2lcfTywxguu48CWmmQ33IXLPOPdfHCiI
	6gbJkA3TRSvjUbhRSL8kcYv4Twa1sH7iPvC3VKDt6Q5BK31dACPMlxs9MbGSC6AsnFOH0wAOyN9
	gImcN/kf13krPK5amjni6BJBn9RBSWOOCDJCbtMZSrCddu/PeO+ASynexwg3nLmhQYpu1ZCMki+
	et07czcIJwcFUHWeMH57t7f+VHCjSlHfdQBUmLg==
X-Google-Smtp-Source: AGHT+IGK1/N7y2CpUwOhKG6ygrrGnNvWFfRSPbSbHCW7TV1FOv73OZU6rxFg6lX5xmC0sEOMHHroNw==
X-Received: by 2002:a17:90b:4ccc:b0:312:ea46:3e66 with SMTP id 98e67ed59e1d1-31aac4b2f34mr17699871a91.21.1751867633122;
        Sun, 06 Jul 2025 22:53:53 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-31a9cc4c8a5sm11363704a91.10.2025.07.06.22.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 22:53:52 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "Drew DeVault" <drew@ddevault.org>
Cc: "Aditya Garg" <gargaditya08@live.com>,  <git@vger.kernel.org>,  "Martin
 von Zweigbergk" <martinvonz@google.com>,  "Patrick Steinhardt"
 <ps@pks.im>,  "Andy Koppe" <andy.koppe@gmail.com>,  "Remo Senekowitsch"
 <remo@buenzli.dev>,  "Jeff King" <peff@peff.net>
Subject: Re: [PATCH v2 1/2] pretty: add X-Change-ID to mail formats
In-Reply-To: <xmqqfrf8ait6.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	06 Jul 2025 18:30:45 -0700")
References: <20250703113505.11889-1-drew@ddevault.org>
	<PN3PR01MB9597069B8CF014BFE01B53F3B84CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<DB4WQTRHWZN3.3VG20AZDK8VN@ddevault.org> <xmqqfrf8ait6.fsf@gitster.g>
Date: Sun, 06 Jul 2025 22:53:51 -0700
Message-ID: <xmqqfrf88s28.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

>> IMO the right way forward is to use a mail header.
>
> No.  In the change-id case, trailer is the right way to go.
> ...
> But after thinking thrice, we may find a set of good pieces of
> information that should be added as new commit header ...
> ... and there will be times when we need
> to convey them over e-mailed workflow to allow patch recipient not
> to lose such information.

Or a third-party software may add a new commit header without
gauging and waiting for the community consensus anyway, which may or
may not have much structural meaning, and then we may want to extract
that piece of information hidden in the commit header out, because
it was not written as trailer (in which case there wouldn't have
needed any extra effort to extract it in the first place).

This part can use a bit of clarification.

My endorsement below to use an extra e-mail header applies when some
commit objects ended up with extra non-standard headers holding
pieces of information that we want to send as part of a patch,
whether it is a good idea or a bad idea to place that particular
kind of information in a commit header.  And the question is "Now,
what is the best way to transfer it over a patched e-mail?"

If it were a good idea to place that particular kind of information
in a header, that is of course an effort worth investing in.

If it were a horrible idea to place it in a header, it still is
worth investing in an effort to give ourselves a way to salvage such
information out of the header, even though we wouldn't have needed
such extra tool if they didn't hide it in the header.

But once a generic mechanism is written, then Git does not have to
behave differently if an extra commit header is something a more
recent versions of Git tools started using after the idea gained
community consensus, or a third-party software unilaterally added
without gauging or waiting for community consensus.  The same single
mechanism can be used to extract the information and carry it in
e-mails, and mailinfo can be told to extract it out.  It can be left
up to the consumer after mailinfo disects the pieces of information
out of the e-mail.

> In such a case, I fully agree that embedding in an e-mail header
> would be the way to go.
>
> I would suggest a lot more generic implementation to solve it once
> and for all.  How about doing it more like this:
>
>    "git format-patch --extra-headers" grabs all extra headers
>    (i.e. those that are not the bog-standard "tree", "parent",
>    "author", "committer") and emit these
>
>     X-git-extra-commit-header: encoding=iso8859-1
>     X-git-extra-commit-header: frotz=nitfol
>
>    next to "Subject:", etc.
