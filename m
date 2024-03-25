Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692A0823DB
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 23:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711408560; cv=none; b=BmsWgm1iBMRYc8eQwSPcliCh9xNtWCZuXNM4TL/VYWGRMvJYsxojcYLbaDEwAmWWDZkhZ90AXAOJmNglfyFR+Bn4tq3q71Ty9rvgkoU8c0o609WzeXxWMjbmw2wM/zw9WWdGDKuUTJhEaEmdhvPyjsPLuO31ZGT8WzKe+5v7V24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711408560; c=relaxed/simple;
	bh=SC/XM7p1veQrPznIoCbzYxSRGbGCtnKwjwyeGKGslHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3OXG+PmCY+zE/yw18mkAGfsN3AQRJ7pq6r8OzHZOxtoGhIffxn70PHbTEcZFC0fg7yciFSwhUaWjQNUYYyflMi8CuOnH7U6MG9q8TZ01ob/TfUF81qiRvRtpys0/NP1X2tQlz+dYo6bqNkJbYnMWLDSK6CfIg0IApl6W1MjXP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDQ4wPi4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDQ4wPi4"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4148c743ae3so3632535e9.1
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 16:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711408556; x=1712013356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ehb+a+uWt7Omk8zuido7RVAeTYXA+Vzr4FzJETM8Sbg=;
        b=VDQ4wPi4av5Ch7lkkrNRt2sFhvxgivnlNEKTZNIi2l3cC0aYMN7Sh3M4k1b1Hi308C
         qTwR4z+VFamDb1kWcqgEdyWHHucalMm80tXQtokGHiFwpneeEcIYGu0zXEkYBaVn1uSI
         5wEI/0wLbBPt1pZBu4o1uoN+E6Ba+Ek9BAu/UTPW3ocolXmVYIApJBZEFKX5QuwUH9up
         BdGgFKjRFNhSc/qWkG7T6a42o25LdIGGfkV6Tp5ApAgcvMddRqcqyDpwSkL8WV2bNU0e
         wfxxORcZ9Wp6vLTsvjvcWyTXBHrCryGax+H005Z5R+UidpOU8W5nt06DizkqjvvRjqH+
         JXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711408556; x=1712013356;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ehb+a+uWt7Omk8zuido7RVAeTYXA+Vzr4FzJETM8Sbg=;
        b=UC9giKiyvngpYUZ5yf+sdJpd4VE0Bxrndb/8sk7LH6hHf8DSp5c9xssANHKCPSeU+7
         wZ5tOVi40Vcj9B3S/lsn2OhKSrLCbpNH8M+HYXqPDl5UdIx4SJoPbJMnCQTbfq5kw4lK
         2W2Jag91BStVP8qsYrfoESEkqmUxsZTOYjaumaVCPK0E8jT/l6xEfhkYDk4ft2a3weQ1
         jfsBbgQI61bqhui8WLTmgF4vjcbtpSWfYY5aUquX94+jxj0H9vJiykgYrAtwoLbWWPZp
         ASKTuP3K6UqoiVEzvLWcI+jMLBf9Y354qqt4CBA86a/pkqw62Gk+BwOMkqoD0BzOqRxM
         CySw==
X-Gm-Message-State: AOJu0YyxWssM1yKJme6itc9ItDCXAjoUJdImw/s0Z+/agcW/l9MFVnfT
	qtFPNhvKRiFkv1nuogRUDdJc/mVu7GzhkjmNAfWV2VhHpHx0Uq2aHrqhxXxs
X-Google-Smtp-Source: AGHT+IHs38YK8zWnnWxi0gIggQy02DyohZZjxGcu6sFKkdQIr+vTEgLYMhrJ+V+MvcuC+U9mbp7lcA==
X-Received: by 2002:a05:600c:3b98:b0:414:5e9b:804b with SMTP id n24-20020a05600c3b9800b004145e9b804bmr6435182wms.10.1711408556261;
        Mon, 25 Mar 2024 16:15:56 -0700 (PDT)
Received: from gmail.com (70.red-88-14-202.dynamicip.rima-tde.net. [88.14.202.70])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b0041330d49604sm9776832wmq.45.2024.03.25.16.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 16:15:55 -0700 (PDT)
Message-ID: <8dc0218b-914d-4a12-8136-45c6d62162a6@gmail.com>
Date: Tue, 26 Mar 2024 00:15:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] add-patch: introduce 'p' in interactive-patch
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <2c99dee8-fa6b-4f4f-93b4-3f7a8e0901f9@gmail.com>
 <fa64a975-40e4-40f2-bdcf-fd2da4fc506e@gmail.com> <xmqqcyrigfft.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqcyrigfft.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Mar 25, 2024 at 02:38:30PM -0700, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> > Shortly we're going make interactive-patch stop printing automatically
> > the hunk under certain circumstances.
> >
> > Let's introduce a new option to allow the user to explicitly request
> > the printing.
> 
> That is good, but ...
> 
> > Signed-off-by: Rubén Justo <rjusto@gmail.com>
> > ---
> >  add-patch.c                |  4 ++++
> >  t/t3701-add-interactive.sh | 22 +++++++++++-----------
> >  2 files changed, 15 insertions(+), 11 deletions(-)
> >
> > diff --git a/add-patch.c b/add-patch.c
> > index 68f525b35c..52be1ddb15 100644
> > --- a/add-patch.c
> > +++ b/add-patch.c
> > @@ -1388,6 +1388,7 @@ N_("j - leave this hunk undecided, see next undecided hunk\n"
> >     "/ - search for a hunk matching the given regex\n"
> >     "s - split the current hunk into smaller hunks\n"
> >     "e - manually edit the current hunk\n"
> > +   "p - print again the current hunk\n"
> >     "? - print help\n");
> >  
> >  static int patch_update_file(struct add_p_state *s,
> > @@ -1480,6 +1481,7 @@ static int patch_update_file(struct add_p_state *s,
> >  				permitted |= ALLOW_EDIT;
> >  				strbuf_addstr(&s->buf, ",e");
> >  			}
> > +			strbuf_addstr(&s->buf, ",p");
> >  		}
> >  		if (file_diff->deleted)
> >  			prompt_mode_type = PROMPT_DELETION;
> > @@ -1658,6 +1660,8 @@ static int patch_update_file(struct add_p_state *s,
> >  				hunk->use = USE_HUNK;
> >  				goto soft_increment;
> >  			}
> > +		} else if (s->answer.buf[0] == 'p') {
> > +			/* nothing to do */
> 
> This is not good.  If we are taking a new input, why doesn't the
> code already respond to it?  "Showing it again" should be a separate
> feature even if some other codepaths still do show when [2/2] would
> prevent them to show, no?

Doing nothing here produces, in the current implementation, the intended
printing.  Maybe the message needs to state so?

> Also, in addition to the changes to the patch to unbreak it, we'd
> need to update the git-add(1) manual page, especially its section on
> the interactive mode.  I think a single-line addition should suffice,
> but it has to be there, added by the same patch as the one that
> starts accepting 'p' and acting on that input.

Oh, of course.  I think this is the line needed:

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 14a371fff3..90b47927b2 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -348,6 +348,7 @@ patch::
        K - leave this hunk undecided, see previous hunk
        s - split the current hunk into smaller hunks
        e - manually edit the current hunk
+       p - print again the current hunk
        ? - print help
 +
 After deciding the fate for all hunks, if there is any hunk
