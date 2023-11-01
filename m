Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBFB10EE
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 03:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d8GA3a1D"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC8DA4
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 20:22:59 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A35931D6E97;
	Tue, 31 Oct 2023 23:22:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xbDi+saPISXTn24Okj4So5isxpgR+DLaAQtizO
	5lH1w=; b=d8GA3a1D2p2T0GzvADnZJiFV+1Dj/9fhUyxEBvMc2GGl+f/6lSgwiS
	ARI0D6qxsgth6ha2gsHVsUQXFIVgk4Z4CK1T4JthxycXvwAsKWUIX0tqk2n8xQ+m
	lQKaeG3nrlsXxCNPhofgjQZzhHLt/Ywh6WT3gm7aT5yA7KvX8p0sM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CA961D6E96;
	Tue, 31 Oct 2023 23:22:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0CD4E1D6E95;
	Tue, 31 Oct 2023 23:22:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Victoria Dye <vdye@github.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>,  Phillip Wood <phillip.wood123@gmail.com>,  Oswald
 Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [PATCH v4 0/8] ci: add GitLab CI definition
In-Reply-To: <8e4d111f-3982-4989-90b5-08377fe9c5fd@github.com> (Victoria Dye's
	message of "Tue, 31 Oct 2023 11:22:23 -0700")
References: <cover.1698305961.git.ps@pks.im> <cover.1698742590.git.ps@pks.im>
	<8e4d111f-3982-4989-90b5-08377fe9c5fd@github.com>
Date: Wed, 01 Nov 2023 12:22:56 +0900
Message-ID: <xmqqpm0uw41b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F44C0898-7865-11EE-94ED-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Victoria Dye <vdye@github.com> writes:

> As for adding the GitLab-specific stuff, I'm not opposed to having it in the
> main tree. For one, there doesn't seem to be a clean way to "move it into
> `contrib/`" - '.gitlab-ci.yml' must be at the root of the project [2], and
> moving the $GITLAB_CI conditions out of the 'ci/*.sh' files into dedicated
> scripts would likely result in a lot of duplicated code (which doesn't solve
> the maintenance burden issue this series intends to address).
>
> More generally, there are lots of open source projects that include CI
> configurations across different forges, _especially_ those that are
> officially mirrored across a bunch of them. As long as there are
> contributors with a vested interest in keeping the GitLab CI definition
> stable (and your cover letter indicates that there are), and the GitLab
> stuff doesn't negatively impact any other CI configurations, I think it
> warrants the same treatment as e.g. GitHub CI.

Thanks for expressing this so clearly.  I do prefer to add this as
the first class citizen (more generally, I do not want to add new
things to contrib/ at this point) if we are going to use it.

