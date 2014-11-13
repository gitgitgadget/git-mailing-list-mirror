From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git checkout $tree -- $path always rewrites files
Date: Thu, 13 Nov 2014 11:15:27 -0800
Message-ID: <xmqqbnoa29ps.fsf@gitster.dls.corp.google.com>
References: <20141107081324.GA19845@peff.net>
	<xmqqegtfgcfx.fsf@gitster.dls.corp.google.com>
	<20141107191745.GB5695@peff.net>
	<CANiSa6hufp=80TaesNpo1CxCbwVq3LPXvYaUSbcmzPE5pj_GGw@mail.gmail.com>
	<CANiSa6ggX-DJSXLzjYwv1K2nF1ZrpJ3bHvPjh6gFnqSLQaqZFQ@mail.gmail.com>
	<CAPc5daWdzrHr8Rdksr3HycMRQu0=Ji7h=BPYjzZj7MH6Ko0VgQ@mail.gmail.com>
	<20141108083040.GA15833@peff.net>
	<xmqqbnoge1ci.fsf@gitster.dls.corp.google.com>
	<20141113183033.GA24107@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 13 20:15:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xozrn-0007hY-07
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 20:15:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933902AbaKMTPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 14:15:35 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57277 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933587AbaKMTPe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 14:15:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 64E041D2CC;
	Thu, 13 Nov 2014 14:15:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VRMXjfqU/J0w69goSWOSdnfRRJs=; b=DCHWIR
	aRDcYRNUx2KP8RlC4LkFXSk3E2atHbdXChsOBphqoMApPnaDUCLFJ9tS0gk6eLyD
	gNdcR3K14F215PEOaQJt/woS45vA1/gpJYAHhuc/dog7Nn1G8wyG1VKykkcO+oQ2
	w3vkXp/WVyZ5TNQ2EXRa8OKFlCQI5b+HfvGi8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cB700WYavIquhOL1NeASqc9I1eF5hBly
	Fb9PT4fkDqMPxlAIONEnTk2SDx27YJ2wznz+CkWHrW3pDBfOfcuwbI8nqPhzsXVA
	gv5xw5pUIY2eYj8S/ypcYghVK3DFYw47i4Ifeb8nZHY8GGbvV0LETMLbw1mbXAGM
	gdjmAEW/jxA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C9C91D2CB;
	Thu, 13 Nov 2014 14:15:33 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E647C1D2B9;
	Thu, 13 Nov 2014 14:15:28 -0500 (EST)
In-Reply-To: <20141113183033.GA24107@peff.net> (Jeff King's message of "Thu,
	13 Nov 2014 13:30:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6E057B06-6B69-11E4-8765-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Nov 09, 2014 at 09:21:49AM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > On Fri, Nov 07, 2014 at 11:35:59PM -0800, Junio C Hamano wrote:
>> >
>> >> I think that has direct linkage; what you have in mind I think is
>> >> http://thread.gmane.org/gmane.comp.version-control.git/234903/focus=234935
>> >
>> > Thanks for that link.
>> 
>> It was one of the items in the "git blame leftover bits" list
>> (websearch for that exact phrase), so I didn't have to do any
>> digging just for this thread ;-)
>> 
>> But I made a huge typo above.  s/I think/I do not think/;
>
> Oh. That might explain some of my confusion. :)

Yeah, tells me to never type on a tablet X-<.

>> I'd prefer that these two to be treated separately.
>
> Yeah, that makes sense after reading your emails. What I was really
> unclear on was whether the handling of deletion was a bug or a design
> choice, and it is the latter (if it were the former, we would not need a
> transition plan :) ).

Yeah, I think we agree to refrain from saying if that design choice
was a good one or bad one at least for now.

> Subject: checkout $tree: do not throw away unchanged index entries
>
> When we "git checkout $tree", we pull paths from $tree into
> the index, and then check the resulting entries out to the
> worktree. Our method for the first step is rather
> heavy-handed, though; it clobbers the entire existing index
> entry, even if the content is the same. This means we lose
> our stat information, leading checkout_entry to later
> rewrite the entire file with identical content.
>
> Instead, let's see if we have the identical entry already in
> the index, in which case we leave it in place. That lets
> checkout_entry do the right thing. Our tests cover two
> interesting cases:
>
>   1. We make sure that a file which has no changes is not
>      rewritten.
>
>   2. We make sure that we do update a file that is unchanged
>      in the index (versus $tree), but has working tree
>      changes. We keep the old index entry, and
>      checkout_entry is able to realize that our stat
>      information is out of date.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Note that the test refreshes the index manually (because we are tweaking
> the timestamp of file2). In normal use this should not be necessary
> (i.e., your entries should generally be uptodate). I did wonder if
> checkout should be refreshing the index itself, but it would a bunch of
> extra lstats in the common case.
>
>  builtin/checkout.c        | 31 +++++++++++++++++++++++++------
>  t/t2022-checkout-paths.sh | 17 +++++++++++++++++
>  2 files changed, 42 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 5410dac..67cab4e 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -65,21 +65,40 @@ static int post_checkout_hook(struct commit *old, struct commit *new,
>  static int update_some(const unsigned char *sha1, const char *base, int baselen,
>  		const char *pathname, unsigned mode, int stage, void *context)
>  {
> ...
>  }

Makes sense, including the use of strbuf (otherwise you would
allocate ce and then discard when it turns out that it is not
needed, which is probably with the same allocation pressure, but
looks uglier).

> diff --git a/t/t2022-checkout-paths.sh b/t/t2022-checkout-paths.sh
> index 8e3545d..f46d049 100755
> --- a/t/t2022-checkout-paths.sh
> +++ b/t/t2022-checkout-paths.sh
> @@ -61,4 +61,21 @@ test_expect_success 'do not touch unmerged entries matching $path but not in $tr
>  	test_cmp expect.next0 actual.next0
>  '
>  
> +test_expect_success 'do not touch files that are already up-to-date' '
> +	git reset --hard &&
> +	echo one >file1 &&
> +	echo two >file2 &&
> +	git add file1 file2 &&
> +	git commit -m base &&
> +	echo modified >file1 &&
> +	test-chmtime =1000000000 file2 &&

Is the idea behind the hardcoded timestamp that this is sufficiently
old (Sep 2001) that we will not get in trouble comparing with the
real timestamp we get from the filesystem (which will definitely newer
than that anyway) no matter when we run this test (unless you have a
time-machine, that is)?

> +	git update-index -q --refresh &&
> +	git checkout HEAD -- file1 file2 &&
> +	echo one >expect &&
> +	test_cmp expect file1 &&
> +	echo "1000000000	file2" >expect &&
> +	test-chmtime -v +0 file2 >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
