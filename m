Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41DD30F87
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIY/1VKX"
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F71483E5
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 09:24:13 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c434c33ec0so29600815ad.3
        for <git@vger.kernel.org>; Mon, 16 Oct 2023 09:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697473453; x=1698078253; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2CeXMX78QxDgXMjLoYITLjuFNVJUXkbiWMaiYVbuMk=;
        b=BIY/1VKX5t0p/m2IgoD9K5aeZXyR0Hhc+OhIqf03XhE6Rez+Oig4Ht6QXXmlcdDn2+
         7rof4aBX7440jQZeQYou+xA6cEU34E6VkFDHep0psytp4uAAcfv/3+YD6C85TSjBheL7
         PfKNpgGSksKeujSx2+sO0434OvSVF79XBi6Hi5rRz9QU99RHqLmEP3rz1Vi9H4oBctn9
         lEAjJBFrNM0gaXKgeMMWV1aHoMu3jdT4/OKfQKJu6l8hzW8fPaWd6oC2tKQyuUS4ZfS4
         c5W6qb+5p6UzhSWysRQFEhFT3/BikLa/XiedbnQOoCmEnzBdKUZBpyxPByqaY2FmIe6U
         UXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697473453; x=1698078253;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k2CeXMX78QxDgXMjLoYITLjuFNVJUXkbiWMaiYVbuMk=;
        b=msamG4wloG1B4tb2laYXVLs+R+iVTax7i/HXWozm/Ur3iCU7RRTVQb3g75YgrKvvuf
         Kd3nJYcmr39CUKLMCxtk7Uw03++YMAyE4b3PdegWL6L9VDGJlJdJDH59/6Ui4gQJavF8
         +HnmorU/mw4U++hnNk9//zpWqT3vIEffMkl3jzgI+BCj91z371pXPHNHyDPJDfKqoI75
         vkLT9++4qSudIPPYGPb2fCVSX5OVJRjUbekAlRYj9+NYzi9uU1g8DLa0haKLefxWVKMp
         8H8BsDqFfUhS9r5KfNtSP2ywoQLUA9SnqBrjJ9W5Pe7143xg5qTUdXR+x/ML3Ho/JINC
         8CEg==
X-Gm-Message-State: AOJu0YzubTBF0l5yhfQ17l0aYXmYbdBdUK7Ij4r0mWf94Twyj2yKfqcV
	rvq7f94zcf+kfjVG0YOrahpGPAY9Aq0=
X-Google-Smtp-Source: AGHT+IHCxkpUfjeOhf0gLqqWDcssncdI2siNW9PNDZU6/QoUGtM0EmRg/U75/z6FJNSVfWDGeix8lQ==
X-Received: by 2002:a17:902:6f02:b0:1c5:cd1c:46f6 with SMTP id w2-20020a1709026f0200b001c5cd1c46f6mr25949718plk.24.1697473452779;
        Mon, 16 Oct 2023 09:24:12 -0700 (PDT)
Received: from localhost (120.153.125.34.bc.googleusercontent.com. [34.125.153.120])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902c70b00b001b0358848b0sm8786600plp.161.2023.10.16.09.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:24:12 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 0/3] rev-list: add support for commits in `--missing`
In-Reply-To: <20231016103830.56486-1-karthik.188@gmail.com> (Karthik Nayak's
	message of "Mon, 16 Oct 2023 12:38:27 +0200")
References: <20231009105528.17777-1-karthik.188@gmail.com>
	<20231016103830.56486-1-karthik.188@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 16 Oct 2023 09:24:11 -0700
Message-ID: <xmqqbkcyo7ro.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Karthik Nayak <karthik.188@gmail.com> writes:

> ... some extra checks here, especially because we don't want to
> allow missing commit's tree and parent to be parsed.

Good changes relative to the previous round.

A bad news is that with this series (especially [PATCH 3/3]) applied
on top of Patrick's "always make sure the commit we found from the
commit-graph at least exists" change, t5310 and t5320 seem to
consistently fail for me.  They pass with the first two steps
applied without [3/3] but that is to be expected as they are both
no-ops.

The change in 3/3 to list-objects.c::do_traverse() seems to be the
culprit.  Reverting that single hunk makes t5310 and t5320 pass
again.  What I find alarming is that two tests that are touched by
this series, t5318 and t6022, do not seem to fail with the hunk
reverted, which means the hunk has no meaningful test coverage for
the purpose of this series.

I didn't even try to understand what is going on, so there may be a
very good reason that the change must be there for do_traverse() to
work correctly.  I dunno.

>     +-	if (commit->object.flags & ADDED)
>     ++	if (commit->object.flags & ADDED || commit->object.flags & MISSING)

This and others are syntactically correct C, but some folks may find
it more readable to see each of the bitwise operations enclosed in a
pair of parentheses when combined by logical operations, i.e.,

	if ((commit->object.flags & ADDED) || (commit->object.flags & MISSING))

In this particular case, we can even say

		if (commit->object.flags & (ADDED | MISSING))

meaning, "if we have either the ADDED or the MISSING bit set", which
may make it even clearer.

Thanks.
