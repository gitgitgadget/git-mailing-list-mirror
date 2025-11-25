Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10210329E5E
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764091123; cv=none; b=aRMm6/p5UV3AOX8r2XGgWByaiTEkzGBzmITITwRprgEtMgAs26pJl5gnfIpPBA1eTPnUdL/z59YgfzBS9EREbUI+NG9MgfjCODD4kurvOuf/mmfC5qWegyc4KxDacVkmq7byqWv0EIsmHdGCYfQwbTP4zoFWf74JPO38ss/J22w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764091123; c=relaxed/simple;
	bh=K/OjQLK/BPXS1XR6Qhu9nrm6GGwziMPUmHJfieFUqpU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SqyqlchzHMhW5cgbAMKHNKb8POlCE1bsX02aGzIvMmRccm0OvtjF8DdA8YxCYWCW4WXurDFYRuPn/alFJgEF+nzs2pZZiqWg5A7X7OjS+f8xnCcYfrmLs3nwxe5PRTxeIFiyAxLjvE9K/cKs1q3PS5PdJ57xGVxwdchX2+lzfbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=McUKYciE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nuA6al1X; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="McUKYciE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nuA6al1X"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 558541D0016F;
	Tue, 25 Nov 2025 12:18:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 25 Nov 2025 12:18:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1764091120;
	 x=1764177520; bh=/81ZH3JIbyP5vtrt/qG3RV/iOI2+boh2sq63FN6aR/g=; b=
	McUKYciELAsx7WqGMUee6MW8tckd9eyk9e1hng87nUBA1qEPr8hojusC/7z1DthX
	8hVEYP2HJaB8FDfzwCYMIBN0ZVZ8SJ4fe9B+OizEA8+JHPNFsAGx/numqVJTgtyP
	eyXm3EBO0/Ba6bE2FGBJXMYPUhUgylhog5gEqZQmGjeSlRmoNsMpVkANbhpZdkMK
	m6HECjyFNlortg2mx625QB1AcJSUmpshM6dF5FGjjxc5bHgtRs8c+wjz2Po9e3Ts
	pxWqTTEK7/XstRsligpBkoV8mi3+ycMM9hxGWRapR8FugogDNvINJunXLEVlr7+9
	+VMrUReS9kwD0e0D7dN0hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1764091120; x=
	1764177520; bh=/81ZH3JIbyP5vtrt/qG3RV/iOI2+boh2sq63FN6aR/g=; b=n
	uA6al1XLVXlgZXQrmAD6ROU9QsdhWbaHq3Scyp8GcyYdFFKT8aOCKOn22uV92tGK
	sxU3LbW0TE+udSS1Jzv0C12vAmxy1krP1Oj+Qnx6dn6b/RYYgOVaob823ksu0RRN
	O4To2IDyukpCIVjMS23Cyyy+AzPk1/n3JbYdvUrDsltLCj6uSxYbLtGMvblsz9pi
	szAU3KFsFgO2iIZysxNXeUTV+EeTFRVkSORLoAFOWgMLnsnsMypcqueshzidi9o4
	O3RbD5CyX5HsLOGpRB4c1w4Ne/+fCxM9FnEJc4uiZ7BkmFTm5tHHIjAiajSumF2L
	IUcllt9a7tY6wNNG4sdkg==
X-ME-Sender: <xms:7-Qlac_1X6HVYPPWC2_G15WuD0_Bc5omT4FLz0DsUWCmmhKEWr9h9A>
    <xme:7-QlacKaWbsTzKBjDPZAgY3KSeQbQ6ExQQ0mty9yyK4PxNSDUoIl6N_s2ELRFm_3g
    zMtAl9pd83a3pKG8L3Q2xRV7_rkfYdIFuf5eraZH2QKrkvzey-aoA>
X-ME-Received: <xmr:7-QlafY4h2Enkv8nLdGNrKucjt2rHrUj0vog59-ZKeXyNdx_lByj67RQPa0P-IPCjBKSnGKQL6MJ5FCjX5Ltd556tsn2DGf_ZI04>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvgedvtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkefotddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeetfeelheetvdeivdduleektddvgfehfeeutdfhkedtgfdvfefhfffhledt
    hfeltdenucffohhmrghinhephhgvrghrrdgttgenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:7-QlaWLIUsOxugHvMNhdnG8c-FP5q88VSDJyil1PehlooDk9HJpMHw>
    <xmx:7-QlaVDZAKvEvJOnUJmM-eUFSDfIlMqX8RfGmvUqLI27az--aImwKQ>
    <xmx:7-QlaTro61I5yRfMa1mPgDplhJLV-hFzvws6W95tCfYLVcyoAQftpA>
    <xmx:7-QlaYgGYRBEFtv2VdmIOODu-OaNJfOWB3uR_YFtfy9wpaAXhxY6nQ>
    <xmx:8OQlaYKLiQvl1-q8BUH1s3mZQqGQlO5ZBJDBx7HAaBrLJ-gHHNd32mR1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Nov 2025 12:18:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2025, #07; Sun, 23)
In-Reply-To: <CABPp-BGEg0PFoXWQYQZ2GpdxxBvz1KdgenLDsvb3bdrhALEd-A@mail.gmail.com>
	(Elijah Newren's message of "Mon, 24 Nov 2025 22:55:04 -0800")
References: <xmqq5xb0yqj9.fsf@gitster.g>
	<CABPp-BGEg0PFoXWQYQZ2GpdxxBvz1KdgenLDsvb3bdrhALEd-A@mail.gmail.com>
Date: Tue, 25 Nov 2025 09:18:38 -0800
Message-ID: <xmqqtsyirpxt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> I tried to take a look at some of the series whose status you were
> asking for feedback on (and just threw an extra comment on one that
> you didn't ask about).  Comments below...
>
> On Sun, Nov 23, 2025 at 8:59 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> * jc/optional-path (2025-11-20) 3 commits
>> ...
>>  Will merge to 'next'?
>>  source: <xmqqikf47ajk.fsf@gitster.g>
>
> This topic seems to be missing a squashed-in fix from
> xmqqy0o05nuy.fsf@gitster.g; should that be squashed in and then merge
> down to next?

Thanks for carefully checking.  The second patch with yesterday's
committer timestamp has the squash, so it seems that our mails
crossed ;-)

>> * js/ci-show-breakage-in-dockerized-jobs (2025-11-17) 1 commit
>> ...
>>  Will merge to 'next' after amending?
>>  cf. <xmqqpl9gike6.fsf@gitster.g>
>>  source: <pull.2003.git.1763399064983.gitgitgadget@gmail.com>
>
> I had a slight tweak for the wording of the first paragraph, which I
> just left as a comment on the patch.  Not sure that needs to hold it
> up, but maybe worth considering to include in your amending if
> Johannes is fine with it?

FWIW, I found the updated explanation you gave easier to read than
the original.  I still do not think of a reason why we want a more
conservative o+w when making things world-writable, other than the
case where there is a user in the same group as the owner of the
file that we specifically want to forbid touching it, but then I do
not have any idea who that special user in the same group would be.

>> * js/strip-scalar-too (2025-11-17) 1 commit
>>  - make strip: include `scalar`
>>
>>  "make strip" has been taught to strip "scalar" as well as "git".
>>
>>  Will merge to 'next'?
>>  cf. <xmqq7bvoiadg.fsf@gitster.g>
>>  source: <pull.2004.git.1763409086322.gitgitgadget@gmail.com>
>
> I'd kind of like to see a response to your suggested alternative.

I am OK if we applied the patch posted as-is, and left such a
clean-up as #leftoverbits.

>> * dw/config-global-list (2025-10-09) 4 commits
>> ...
>>  Comments?
>>  source: <pull.1938.git.1760058849.gitgitgadget@gmail.com>
>
> Perhaps mark this topic as expecting a re-roll?  (c.f.
> 20251122020047.GB3947@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net)

Great.  That's an awfully long message-id, by the way ;-)

>> * jc/submodule-add (2025-11-15) 1 commit
>>  - submodule add: sanity check existing .gitmodules
>>
>>  "git submodule add" to add a submodule under <name> segfaulted,
>>  when a submodule.<name>.something is already in .gitmodules file
>>  without defining where its submodule.<name>.path is, which has been
>>  corrected.
>>
>>  Comments?
>>  source: <xmqqv7jacvdq.fsf@gitster.g>
>
> Left a couple minor wording suggestions.

Thanks; amended.

>> * en/ort-rename-another-fix (2025-11-03) 3 commits
>>   (merged to 'next' on 2025-11-19 at 53d94af6b4)
>>  + merge-ort: fix failing merges in special corner case
>>  + merge-ort: remove debugging crud
>>  + t6429: update comment to mention correct tool
>>
>>  Yet another corner case fix around renames in the "ort" merge
>>  strategy.
>>
>>  Will merge to 'master'.
>>  source: <pull.1992.git.1762192908.gitgitgadget@gmail.com>
>
> A sidenote that probably doesn't matter since you've already marked it
> for merging down: this topic has been deployed at GitHub for just over
> a month without incident (whereas there were some problems prior to
> deploying these fixes, and those problems cleared up the minute that
> these changes were deployed).

Great to hear.

>> * cc/fast-import-strip-if-invalid (2025-11-16) 3 commits
>>  - fast-import: add 'strip-if-invalid' mode to --signed-commits=<mode>
>>  - commit: refactor verify_commit_buffer()
>>  - fast-import: refactor finalize_commit_buffer()
>>
>>  "git fast-import" learns "--strip-if-invalid" option to drop
>>  invalid cryptographic signature from objects.
>>
>>  Comments?
>>  source: <20251117043450.322644-1-christian.couder@gmail.com>
>
> I think this one is ready to merge down.
>
>> * en/xdiff-cleanup-2 (2025-11-18) 10 commits
>>  - xdiff: rename rindex -> reference_index
>>  - xdiff: change rindex from long to size_t in xdfile_t
>>  - xdiff: make xdfile_t.nreff a size_t instead of long
>>  - xdiff: make xdfile_t.nrec a size_t instead of long
>>  - xdiff: split xrecord_t.ha into line_hash and minimal_perfect_hash
>>  - xdiff: use unambiguous types in xdl_hash_record()
>>  - xdiff: use size_t for xrecord_t.size
>>  - xdiff: make xrecord_t.ptr a uint8_t instead of char
>>  - xdiff: use ptrdiff_t for dstart/dend
>>  - doc: define unambiguous type mappings across C and Rust
>>
>>  Code clean-up.
>>
>>  Will merge to 'next'?
>>  source: <pull.2070.v5.git.git.1763505262.gitgitgadget@gmail.com>
>
> I think so.  There are certainly additional cleanups needed, as this
> series makes clear, but that's clearly a bigger problem and the author
> has stated he plans to work on those but just needed to limit the
> series to some initial cleanup that wasn't too big to send to the
> list.  The series has gotten reviews from lots of folks, and I just
> looked over v5 and couldn't spot anything to call out.

Great, and thanks.
