Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6595910E4
	for <git@vger.kernel.org>; Fri, 30 May 2025 13:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748610925; cv=none; b=o+/AneMnx1LecMjwD4WFQOBtKMDNQy6gN2nCHojE958LB9avz10K8gLf9M0C4Pk83SvFaxBPzQjNq2R3vhutkyBM/335UFPGkxt0dLXHCodI31DQkc/HQkgCCBk7W3Qrc+sNLJRDsIy7iuP75zZ1d0znkCgazNhzVoCzDU2sLhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748610925; c=relaxed/simple;
	bh=OstQ2ul5T5DozJPD9DI6b6Vp1ejv/6SwQ7cQ88fMiaA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gJuMUsoIXjlTwpMFXSkuB2i/YuQjYG1zrgE6Y+TrJ6JeJAMJTwb8pJDLJ1yn9BcSkcBnfoyw6Z6AaToyRwyJG7lyFcz1aijDzdVVuIvpl7XRE/S6/RpfRyyuFd7Q1C+qjxKuwNWeaLvYqJ6/zyQIMdsFu8+d5lL6YEquqt2tXfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VhwG7AWQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GDTBwI3z; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VhwG7AWQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GDTBwI3z"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 3F05E1140177;
	Fri, 30 May 2025 09:15:22 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 30 May 2025 09:15:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748610922; x=1748697322; bh=Z8gD2sUGYX
	M8zXnQLW1RrZCkGgChohGi+lfTPS63nBs=; b=VhwG7AWQcoI+BbPKFTiRzZa6Dc
	uBXLM6rhSTiL92OpcPCX9URsjnAIACKcoVVKQHimR9u3hSe0TzFDoqE99U4Y2904
	Os/H3uIdJKPmJ8MpdU1lV7DL4xqNwJQ2d5lEf3aIKfg1lEAD62rmfQfEuvVpPXzq
	B7TiYeqtkhQYcGqvQTHAFDFU3yh1jsLowTRD6+qpGHbdAO4PkmjN2smvLoFIP+Uy
	k9RFXfSyLtAEIGilYgpQyaMmUxeLhx+WE2e95jpAq4iT8NbwKiZCwsaCjIstr3G1
	l6FkD5RJyX5QFRdQcZn5RpOsk0E0mrzFnck+m98bt+cw5hB6A8zRWeGkRC1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748610922; x=1748697322; bh=Z8gD2sUGYXM8zXnQLW1RrZCkGgChohGi+lf
	TPS63nBs=; b=GDTBwI3zpgLy/NSKwW+xkCjClLaAFHfiKI9YEpgJPG1LgUBLe3g
	P+ldWEGWtGiQ7gU7p2vEf39CGNlt1I/O2BaKnIxN5WNNuxmXL+Wgdddul+AB3sO+
	qmouqB6zMo6MYuLtHl2ihW1PmyjLmJQJHRALnO+LeR9ZpIFz4YYL9PNjPlj3gH8k
	IGqz4oWK55+49L1QBr9C+aKJO5zUmrKNEbxJ18NM/yX0X6WbjYgCnNozxAIYv+M5
	Z2/uWPo18aFrxCw3VcM5Q6uRs7eUPWZP5HepXxomD82o25gKYO26qFfV+Uy2lM/+
	Uvbd8s/TO55KQ3bVLGjq4YPzkK2FA2sJzmQ==
X-ME-Sender: <xms:aa85aFJWiKGVDN_YlXL-r_9xFeCGJ4cbFepnC6EcgQKODJkoZTodFw>
    <xme:aa85aBKJKDyrtrrMkdz01jv1jsnXGbrAwWXXmdj3Jb-12itDrnVjmHC-bsAVvNgaS
    ZuK7FDwe-MhreMRBg>
X-ME-Received: <xmr:aa85aNvgYPj3eraskBg1mT2ImN4q-8fuU0QgQLRRihREtR4ppEYsCJfi-sDFOGtnlbeDqSc2J9C_QvJ4YXkIXg3p876yB488UATISw0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvleduudculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefh
    tedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileffudenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopeehtddvtddvgeeffedttdeh
    ieesshhmrghilhdrnhhjuhdrvgguuhdrtghnpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:aa85aGbrC0TpNXyCnwUlCnsNMeHgI9jRdJcRS1sNIAbuHTbKDGfh_Q>
    <xmx:aa85aMai3GB0taTgLNquY82rULDHeLy6fNhsK2l77kj3eusQOGKE3Q>
    <xmx:aa85aKDOnbsRP4t-Tj7qfHUSL3qe92MnvoIGdtAxWTAdR6qFLF-fkA>
    <xmx:aa85aKZL8lfXTVNRgFE_SDs_M5NMoNJdYpmUJxM9713xUSL3M9iH_w>
    <xmx:aq85aJCSJAfBtvCutrLr1oC9XXael3TuALKQ77hu1XF1qx6H-Qbb1b4b>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 09:15:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Lidong
 Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v3 2/2] BUG(): remove leading underscore of the format
 string
In-Reply-To: <e1f84c111f6b4b5d34201ee8858a8007ea898222.1748569955.git.gitgitgadget@gmail.com>
	(Lidong Yan via GitGitGadget's message of "Fri, 30 May 2025 01:52:35
	+0000")
References: <pull.1964.v2.git.git.1748168353204.gitgitgadget@gmail.com>
	<pull.1964.v3.git.git.1748569955.gitgitgadget@gmail.com>
	<e1f84c111f6b4b5d34201ee8858a8007ea898222.1748569955.git.gitgitgadget@gmail.com>
Date: Fri, 30 May 2025 06:15:19 -0700
Message-ID: <xmqqbjragryw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>
> BUG() is not end-user facing but programmer facing, and we do not
> use _("...") in them. I searched all `BUG(_` pattern and replace
> them with `BUG(`

The first sentence is good.  We'd write the second sentence more
like

	Replace all occurrences of BUG(_("..."), ...) with
	BUG("...", ...).

I.e. you instruct somebody sitting in front of the keyboard who is
modifying the code for you what to do in imperative mood.

The changes themselves look good to me.

Thanks.

> Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
> ---
>  builtin/mktag.c     | 2 +-
>  builtin/worktree.c  | 2 +-
>  pack-bitmap-write.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/mktag.c b/builtin/mktag.c
> index 7ac11c46d53f..1b1dc0263e18 100644
> --- a/builtin/mktag.c
> +++ b/builtin/mktag.c
> @@ -41,7 +41,7 @@ static int mktag_fsck_error_func(struct fsck_options *o UNUSED,
>  		fprintf_ln(stderr, _("error: tag input does not pass fsck: %s"), message);
>  		return 1;
>  	default:
> -		BUG(_("%d (FSCK_IGNORE?) should never trigger this callback"),
> +		BUG("%d (FSCK_IGNORE?) should never trigger this callback",
>  		    msg_type);
>  	}
>  }
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 88a36ea9f867..2dceeeed8bd0 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -621,7 +621,7 @@ static void print_preparing_worktree_line(int detach,
>  		else {
>  			struct commit *commit = lookup_commit_reference_by_name(branch);
>  			if (!commit)
> -				BUG(_("unreachable: invalid reference: %s"), branch);
> +				BUG("unreachable: invalid reference: %s", branch);
>  			fprintf_ln(stderr, _("Preparing worktree (detached HEAD %s)"),
>  				  repo_find_unique_abbrev(the_repository, &commit->object.oid, DEFAULT_ABBREV));
>  		}
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index 7f400ee01213..56960e6ad760 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -1087,7 +1087,7 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
>  					 oid_access);
>  
>  		if (commit_pos < 0)
> -			BUG(_("trying to write commit not in index"));
> +			BUG("trying to write commit not in index");
>  		stored->commit_pos = commit_pos + base_objects;
>  	}
