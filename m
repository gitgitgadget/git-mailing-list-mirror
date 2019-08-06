Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 325111F731
	for <e@80x24.org>; Tue,  6 Aug 2019 02:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbfHFCrl (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 22:47:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57363 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728870AbfHFCrl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 22:47:41 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 73D0A1513CF;
        Mon,  5 Aug 2019 22:47:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hCbIyMNGa8oO
        ef+94oKYmeQIhno=; b=idkJZNgb0ZEf/cCcu4x0EFAzEn1ymNN1ElZlOtk+CIvV
        Q6J75+s01ymUwuyj+A+nHApfKHxUM1dmBv4U+CAXt81OZ+dqwZ3shpO2ss7FXbK4
        /AMPm4LTGS2EThe7c2UPjPYG1sR9VDHEdIzJEqPolFWebzlTHF/OLDOqliH2hGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vj88q8
        5aZKw9A7Dv+MPbin3aeCdmrnU81WnUsYsUUF6UURD+j28gep10h2L9oBEvKj4s5o
        mCGQw6UwGFX+Ey7ZdEHv4FEz6ANNtsoNxgcEBPrqh7qyD28mJZPHQV4Q17Hc+vY4
        Bghr31sPTepLrFAQEAIZTrsyTC3WilMSGKoQU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B09C1513CE;
        Mon,  5 Aug 2019 22:47:40 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D6F181513CD;
        Mon,  5 Aug 2019 22:47:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Lukas Gross <lukasgross@u.northwestern.edu>, git@vger.kernel.org
Subject: Re: amend warnings with no changes staged
References: <CAOY1tUUmkRBEDkF3GiP45WSi50uUGBaamx9-PGej0Z-yt0ioPg@mail.gmail.com>
        <20190806013030.GA61803@google.com>
        <CAOY1tUVpeUftgHNuZg-2fMD9D+Qz08hfvRvQDe1f8+MV2xYv2w@mail.gmail.com>
        <20190806021618.GC61803@google.com>
Date:   Mon, 05 Aug 2019 19:47:38 -0700
In-Reply-To: <20190806021618.GC61803@google.com> (Jonathan Nieder's message of
        "Mon, 5 Aug 2019 19:16:18 -0700")
Message-ID: <xmqqtvavko1h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8E4F0832-B7F4-11E9-A5D8-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Lukas Gross wrote:
>
>> I had intended to stage commits but forgot to do so. Git responded
>> with a normal commit creation message, so I pushed to the remote to
>> begin a CI build. When the build failed for the same reason, I
>> realized I had forgotten to stage the changes. An additional line in
>> the response to the effect of =E2=80=9CWarning: did you mean to amend =
with no
>> changes?=E2=80=9D would be very helpful to shorten this feedback loop.
>
> On second thought:
>
> 	$ git commit --amend --no-edit
> 	[detached HEAD 33a3db8805] Git 2.23-rc1
> 	 Author: Junio C Hamano <gitster@pobox.com>
> 	 Date: Fri Aug 2 13:12:24 2019 -0700
> 	 2 files changed, 2 insertions(+), 1 deletion(-)
> 	$
>
> Some non-judgemental descriptive output like
>
> 	$ git commit --amend --no-edit
> 	No changes.
> 	$
>
> would address this case, without bothering people who are doing it
> intentionally.  So I think there's room for a simple improvement here.

I do that to refresh the committer timestamp.  Do I now have to say
something silly like

	$ GIT_EDITOR=3Dtrue git commit --amend

to defeat the above (mis)feature, or is there a cleaner workaround?

Obviously I'd prefer to see a solution that does not force existing
users to work around the new behaviour ;-)

> Care to take a stab at it?  builtin/commit.c would be the place to
> start.

I'd suggest not to start it before we know what we want.  I am not
yet convinced that "--amend --no-edit will become a no-op" is the
final solution we want.
