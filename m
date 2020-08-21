Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13002C433E5
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E50D420656
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 17:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sTwbogk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgHURIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:08:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52451 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbgHUQRk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 12:17:40 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 36E42E267B;
        Fri, 21 Aug 2020 12:17:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tMsvfjzjjmwt6SRtLv2ednO9SzE=; b=sTwbog
        k3zNFZWygM3LmTjMRGvf+dVJw6NzrLMFTYKwiDLWF2kaHxQdlG7oA9VvN8SLvVc4
        TKcfpwCu8Nj7GCNV89SS2n8DgJJX8kbbbupD3XsVp1Ik6bx1lb9jTwD+e+kwgrno
        0SIgO768WxTNIWrWq9cOYSI8RBoHJrSNLtpII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gyQGG2YKeeXDUngo8AGi+vBq94ES2V0p
        H+FbfRQJBbcQQm1wLeev6V0xyp/smbTUtbktq2QphaATQjcMaQXSzWb0kq5ynuwa
        qiX491zAonkYu0xadOxwlhs364yY884dwRZJ1eplC1P2ytunov0E0JM+l7hZHCcX
        xRYfF1dpU/Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2FE86E267A;
        Fri, 21 Aug 2020 12:17:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 60DF9E2679;
        Fri, 21 Aug 2020 12:17:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Raymond E. Pasco" <ray@ameretat.dev>
Cc:     <git@vger.kernel.org>, "Phillip Wood" <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] git-apply.txt: update descriptions of --cached, --index
References: <C528Y3DXYRMW.22FBYW4FHMALJ@ziyou.local>
Date:   Fri, 21 Aug 2020 09:17:18 -0700
In-Reply-To: <C528Y3DXYRMW.22FBYW4FHMALJ@ziyou.local> (Raymond E. Pasco's
        message of "Thu, 20 Aug 2020 20:26:38 -0400")
Message-ID: <xmqqv9hc9do1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9EFEB98-E3C9-11EA-B1F8-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Raymond E. Pasco" <ray@ameretat.dev> writes:

> On Thu Aug 20, 2020 at 7:57 PM EDT, Junio C Hamano wrote:
>> I do not see why we want to stress the last part after ", even if".
>> The safety mechanism insists on the working tree file and the index
>> entry to be identical, and the location where in the file the
>> difference is, is irrelevant, whether it is outside the area the
>> incoming patch touches, or it overlaps.
>
> It's because this is the confusing part of the option - it's easy to
> grasp "apply the patch to both the working copy and the index", but
> that's not exactly what the option does, it applies only in the case of
> identical preimages (and therefore, identical postimages).

That's fair.  

Back when "git apply" was introduced, workflows to create partial
commits with "edit file; git add file; edit file; git commit" did
exist, but the safety certainly far predates the more aggressive
form of partial commits created by "add -p", "checkout -p",
etc. (which is natural, as "add -p" and friends have to use "apply"
as their implementation detail).  As "git apply --index" was created
primarily for preparing the index immediately followed by "git
commit" (as an implementation detail for "git applymbox", which was
"git am"'s precursor), it was one of the most obvious ways to avoid
the situation where _your_ work in progress in the working tree and
in the index gets mixed in the resulting commit made by applying
other's patch to insist that the index and the working tree contents
to match.  As you suggest, of course, if the user deliberately wants
to keep the index and the working tree to be different (e.g. changes
in the working tree wrt the index are outside the block of text that
is touched by any incoming patch), it is easy to bypass the safety
feature by applying to the index and to the working tree separately,
or just apply to the working tree and run another "add -p".

Having said that, I still think the half-sentence after "even if"
was of little value.  If we want to give the reason why, "even if
the patch may independently apply to the two, the two must be
identical" doesn't at all.  It complains that the description does
not explain why the two must be identical without addressing the
complaint the sentence itself raises.

And if we are not going to give why that must be so, "the index and
the working tree file must be identical" is much clearer without the
"even if" part.
