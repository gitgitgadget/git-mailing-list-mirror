Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vzpbUTm5"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B96EE8
	for <git@vger.kernel.org>; Wed, 13 Dec 2023 07:15:35 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C42461C7AB4;
	Wed, 13 Dec 2023 10:15:34 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=g9f1rryM5Heml9bTbSj4RE9ID6GOW6LJLqHekA
	Uw0MU=; b=vzpbUTm5k4xCWW/rFWehfYwnjBkPqviTsLSbZxUeYGoxyTXIkQ8POb
	b5FTCHBTl9Y79Y/qQJuQ03o/zPsn70XRd48WYKuB03Mijyzkx6RdbaxOgQAOpNvm
	WINEup6AGYvuvO12g5p8U1Z+eU79QnBMrecOe+tDMR577Yc2si/DM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BCC801C7AB1;
	Wed, 13 Dec 2023 10:15:34 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2AA631C7AB0;
	Wed, 13 Dec 2023 10:15:34 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,  git@vger.kernel.org,
  Taylor Blau <me@ttaylorr.com>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/4] wt-status: read HEAD and ORIG_HEAD via the refdb
In-Reply-To: <ZXlfeWtDgr1GQFCL@tanuki> (Patrick Steinhardt's message of "Wed,
	13 Dec 2023 08:38:33 +0100")
References: <cover.1701243201.git.ps@pks.im> <cover.1702365291.git.ps@pks.im>
	<1db3eb3945432964aabe1c559db4c3ac251e83fd.1702365291.git.ps@pks.im>
	<xmqqle9zqidj.fsf@gitster.g>
	<ac84b1b9-2381-406a-b459-6728bf9f8704@ramsayjones.plus.com>
	<xmqq34w7os53.fsf@gitster.g> <ZXlfeWtDgr1GQFCL@tanuki>
Date: Wed, 13 Dec 2023 07:15:33 -0800
Message-ID: <xmqqmsuennfu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7647A62E-99CA-11EE-B2BB-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> Me neither, but once you start thinking about getting rid of the
>> need to use one-file-per-ref filesystem, being able to maintain all
>> refs, including the pseudo refs, in one r/w store backend, becomes a
>> very tempting goal.  From that point of view, I do not have problem
>> with the idea to move _all_ pseudorefs to reftable.
>
> Yes, we're in agreement.
>
>> But I do have reservations on what Patrick, and the code he
>> inherited from Han-Wen, calls "special refs" (which is not defined
>> in the glossary at all), namely, refs.c:is_special_ref() and its
>> callers.
>
> I do not want to add "special refs" to the glossary because ultimately
> they should go away, with two exceptions: FETCH_HEAD and MERGE_HEAD.
> Once we're there we can of course discuss whether we want to explicitly
> point them out in the glossary and give them a special name.

OK, I somehow got a (wrong) impression that you are very close to
the finish line.  If the intention is to leave many others still in
the "special" category (for only the reasons of inertia), with a
vision that some selected few must remain "special" with their own
good reasons, then I am perfectly fine.

Thanks.
