Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C123264DD
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 22:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774476721; cv=none; b=V76xMXEgc7w3vfxKwSGMPVd6829ulslI2vsg6DONh0Vgw+rWzY/4pNyfHI3gAw02IqeQr0epEE2gha1OswZXSsR+48yZmELtdhweXuk+90GsTet72+OS9y9RY2uDBFiXb2yfV0Da2PGYP9GRzt6NjHKMDlpsMJckybAzbkYAWP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774476721; c=relaxed/simple;
	bh=1J/MMpoU1P0YE7SQR/Os+wuqIY2VekMy5sHb5hjMZOE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j0rSxgq6Ba1HpL1ckugHCLYsl+kU5e7Ksb4X8oBDQRdODe1dIiR4+uzfPODaJN06LeVeC+xntuuprgWNxhedgw4u7oSaE8OwutsBOnTkj1Up7aQN5Nf+hIo8cB+LsJfMM1LNSzLQU8CZiWHHEyL8ayrdLjBjaixOWL3zdpVC4xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MYWPMy/w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aLxKM67A; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MYWPMy/w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aLxKM67A"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 61EC7EC0181;
	Wed, 25 Mar 2026 18:11:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Wed, 25 Mar 2026 18:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774476719; x=1774563119; bh=x7ufXG5Vu1
	Sw0bD4njQ/GQ4dPmp0I+AvLDMSEq5caDM=; b=MYWPMy/w2kIGUVXLcoec+5A6+c
	3y8TVqOnZD8D8bsPzU0SIkpn1H8iz0GP2X30EhDP+lRKBnMi1GOZ/UsFUIZb0eaQ
	k6VerIBHWSnF2PYFSq9QgoFw4yzr49RPsdR6XykDk220fCpaQY38JZ9UiNnnW2Z+
	eQF12IW5yILqAJEMZnh3W2A5ffV7yLj1xrrFgO+LwfmnszjfwDg5Y1SVgRyjCVtH
	gkYNG85TaESGBZrR1tsZfSaDJxbw7qrd0ndD9vfMDeXYou5UUeisx4K/2AlZZMVR
	Ua9jcf3v1gf8BorcMEzukZf1kF238xvdv3NrMqBsrG1jS18OcFutV5Gdas9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774476719; x=1774563119; bh=x7ufXG5Vu1Sw0bD4njQ/GQ4dPmp0I+AvLDM
	SEq5caDM=; b=aLxKM67ARvPcVUoFRP7QcuefoUns7vk5ITyn2rswPFe48XIFoZ1
	lxrvLvGivBIakr3W9QRpqPYCLWWiyfVqwzItvspQija8mQu3FAEAb4gC4pt9WwvA
	2niuuxFRjw1w8QNOBFT6sIDMNn7WY3VLpmK8gxv7aw1mjhU2GROZxbWwexhtPzoY
	2UHCsSUzszZOKyGUnKawQi3GWvEzGLSy9XhMEu5dxxbByNWEcx5a5jJweYQjbMvq
	rnIEznVT1Zv0zlqJou5dFOInKRPgDDfVwPi5SnkQMDdHfnx17gQQlAN3G615ILea
	s4mP5VDoui1vuWmTs9CEJ8nbRdrOjBl+zlg==
X-ME-Sender: <xms:r13EaQ1ZVYk8ijZ0ionIjG6gCHeJjluK6BG2-IXQPveXa9QgyHJC4A>
    <xme:r13EaTSpxke8yVqWZ-S9PkfQHiF3-fA9EhRa8nxeGl5hwCMCYVss8ZRCaA8n2hhIL
    mePBXFTjvI8Uf42RyjZFofMeoFHXbak2kcpSfq4CkPgLBqc-cggBis>
X-ME-Received: <xmr:r13EaUeFBalJlLYXqisZsjuzozy6IiqyeN9x5roNj7ledzr3enyNO3VAp8QVmGrr7gvCPss47hA_nNo4Ux1pxrVSnBKoMoegXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdehieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgrsghl
    ohhoshgrsggrthgvrhhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggv
    rhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtoheprgihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hsihguughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomhdprhgtphhtthho
    pegthhgrnhgurhgrphhrrghtrghpfeehudelsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epjheitheskhgusghgrdhorhhg
X-ME-Proxy: <xmx:r13EaUcPBL_BrNQr1vR3Lq2x_JQYowAsrgsLiIuAs8R9DszW0UErLg>
    <xmx:r13Eae2ONplPV8DhFyHYZvWkKyjXV14-4CfLMQEuyb-Rhs6ilWgzRw>
    <xmx:r13Eac-bBIAbtrL7FwNsRj6BCZHcpjKKKkbggOw-ZXyh2eusyaBgpQ>
    <xmx:r13EaT5skZqDdcqOCOk97yqqUnKpOM4HbVL7VPKlTScOTVZKBrJ-qQ>
    <xmx:r13EaSksmLJgNNQxncGe_FH6IDlwKYPbDfcXiFvzrYikZMffwDYEcFkS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 18:11:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  karthik.188@gmail.com,  jltobler@gmail.com,  ayu.chandekar@gmail.com,
  siddharthasthana31@gmail.com,  chandrapratap3519@gmail.com,
  j6t@kdbg.org,  szeder.dev@gmail.com
Subject: Re: [GSoC PATCH v5 1/2] graph: add --graph-lane-limit option
In-Reply-To: <20260325174401.217577-2-pabloosabaterr@gmail.com> (Pablo
	Sabater's message of "Wed, 25 Mar 2026 18:44:00 +0100")
References: <20260323215935.74486-1-pabloosabaterr@gmail.com>
	<20260325174401.217577-1-pabloosabaterr@gmail.com>
	<20260325174401.217577-2-pabloosabaterr@gmail.com>
Date: Wed, 25 Mar 2026 15:11:57 -0700
Message-ID: <xmqqh5q3sgnm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> +static int graph_needs_truncation(struct git_graph *graph, int lane)
> +{
> +	int max = graph->revs->graph_max_lanes;
> +	/*
> +	 * Ignore values <= 0, meaning no limit.
> +	 */
> +	return max > 0 && lane >= max;
> +}

Make a mental note that this helper function works on number of
lanes, not display columns (which is roughly twice the number of
lanes).

> @@ -696,6 +705,18 @@ static void graph_update_columns(struct git_graph *graph)
>  		}
>  	}
>  
> +	/*
> +	 * If graph_max_lanes is set, cap the padding from the branches
> +	 */
> +	if (graph->revs->graph_max_lanes > 0) {
> +		/*
> +		 * width of "| " per lanes plus truncation mark "~ ".
> +		 */
> +		int max_columns_width = graph->revs->graph_max_lanes * 2 + 2;
> +		if (graph->width > max_columns_width)
> +			graph->width = max_columns_width;
> +	}
> +
>  	/*
>  	 * Shrink mapping_size to be the minimum necessary
>  	 */
> @@ -846,6 +867,10 @@ static void graph_output_padding_line(struct git_graph *graph,
>  	 * Output a padding row, that leaves all branch lines unchanged
>  	 */
>  	for (i = 0; i < graph->num_new_columns; i++) {
> +		if (graph_needs_truncation(graph, i)) {
> +			graph_line_addstr(line, "~ ");
> +			break;
> +		}

And that mental note helps to convince us this loop makes sense, as
it increments 'i' one by one ;-)

> @@ -903,6 +928,9 @@ static void graph_output_pre_commit_line(struct git_graph *graph,
>  			seen_this = 1;
>  			graph_line_write_column(line, col, '|');
>  			graph_line_addchars(line, ' ', graph->expansion_row);
> +		} else if (seen_this && graph_needs_truncation(graph, i)) {
> +			graph_line_addstr(line, "~ ");
> +			break;
>  		} else if (seen_this && (graph->expansion_row == 0)) {
>  			/*
>  			 * This is the first line of the pre-commit output.
> @@ -994,6 +1022,12 @@ static void graph_draw_octopus_merge(struct git_graph *graph, struct graph_line
>  		col = &graph->new_columns[j];
>  
>  		graph_line_write_column(line, col, '-');

And here, 'j' comes from graph->mapping[] array.  Does that count in
display columns or lanes?

> +		if (graph_needs_truncation(graph, j / 2 + i)) {

This makes it look as if 'j' counts in columns and needs to be
divided by 2 to make it comparable to lanes.

> +			graph_line_addstr(line, "~ ");
> +			break;
> +		}
> +
>  		graph_line_write_column(line, col, (i == dashed_parents - 1) ? '.' : '-');
>  	}
>  

> +	if (graph->num_parents > 1) {
> +		if (!graph_needs_truncation(graph, graph->commit_index)) {
> +			graph_update_state(graph, GRAPH_POST_MERGE);
> +		} else {
> +			struct commit_list *first_parent = first_interesting_parent(graph);
> +			int first_parent_col = graph_find_new_column_by_commit(graph, first_parent->item);

Are we sure that first_interesting_parent() will always give us a
non-NULL pointer?

Can we use a bit shorter identifier names to deal with these overly
long lines?  The lifetime of these two variables is very short so they
do not have to be so descriptive.

			struct commit *p = first_interesting_parent(graph)->item;
			int lane = graph_find_new_column_by_commit(graph, p);

> +			if (!graph_needs_truncation(graph, first_parent_col))
> +				graph_update_state(graph, GRAPH_POST_MERGE);
> +			else if (graph_is_mapping_correct(graph))
> +				graph_update_state(graph, GRAPH_PADDING);
> +			else
> +				graph_update_state(graph, GRAPH_COLLAPSING);
> +		}
> +	} else if (graph_is_mapping_correct(graph))

