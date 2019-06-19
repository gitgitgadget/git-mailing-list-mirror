Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27F081F462
	for <e@80x24.org>; Wed, 19 Jun 2019 15:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfFSPRe (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 11:17:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57474 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSPRe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 11:17:34 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 22A30164ED6;
        Wed, 19 Jun 2019 11:17:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=szcwYyk9QY+Sa+PoEcehMSwayhA=; b=NfIKmC
        DFpJDWkbRu0fOa1NY3j/HRl4CidvY0dqLB3BF7k7vHqxylGu5QEcwTxbsunsQAI5
        Urf+Mm/2jaoeIsZcM5GUGbaGpTGipopM5GUoW4oPWQAgyfz2W6SQiEgrC+PbdjIB
        XPaYBKEpwA0Dcr8x9I912yqBbGcN55p+si9vE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XSxv+Ch32c+KQwrI8qrLO3qOpvNITEWR
        u6pF73LOBqfbvtSsYpZassdIvyn+jlmCrco8JSuq+ZAaQKDKAH6c2Ga5z1riz6MU
        t6V3ikZiqlmkTdpVtPROxNpLG45giW9I7mfjJ2DeauXcjJkpNXq7A3w77izvPWJa
        f4ZDrjQ7Jpw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 129C2164ED5;
        Wed, 19 Jun 2019 11:17:32 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D7DB164ED3;
        Wed, 19 Jun 2019 11:17:31 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] documentation: add tutorial for revision walking
References: <20190607010708.46654-1-emilyshaffer@google.com>
        <xmqqef41mbmd.fsf@gitster-ct.c.googlers.com>
        <20190617235053.GD100487@google.com>
Date:   Wed, 19 Jun 2019 08:17:29 -0700
In-Reply-To: <20190617235053.GD100487@google.com> (Emily Shaffer's message of
        "Mon, 17 Jun 2019 16:50:53 -0700")
Message-ID: <xmqq4l4lr4dy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5B65169C-92A5-11E9-8C1D-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> Maybe there's a case for storing them as a set of patch files that are
> revision-controlled somewhere within Documentation/? There was some
> discussion on the IRC a few weeks ago about trying to organize these
> tutorials into their own directory to form a sort of "Git Contribution
> 101" course, maybe it makes sense to store there?
>
>   Documentation/contributing/myfirstcontrib/MyFirstContrib.txt
>   Documentation/contributing/myfirstcontrib/sample/*.patch
>   Documentation/contributing/myfirstrevwalk/MyFirstRevWalk.txt
>   Documentation/contributing/myfirstrevwalk/sample/*.patch
>
> I don't love the idea of maintaining text patches with the expectation
> that they should cleanly apply always,...

Well, I actually think the above organization does match the intent
of the "My first contribution codelab" perfectly.  When the codebase,
the workflow used by the project, and/or the coding or documentation
guideline gets updated, the text that documents how to contribute to
the project as well as the sample patches must be updated to match
the updated reality.

I agree with you that maintaining the *.patch files to always
cleanly apply is less than ideal.  A topic to update the sample
patches and tutorial text may be competing with another topic that
updates the very API the tutorials are teaching, and the sample
patches may not apply cleanly when two topics are merged together,
even if the "update sample patches and tutorial text" topic does
update them to match the API at the tip of the topic branch itself.
One thing we _could_ do is to pin the target version of the codebase
for the sake of tutorial.  IOW, the sample/*.patch may not apply
cleanly to the version of the tree these patches were taken from,
but would always apply cleanly to the most recent released version
before the last update to the tutorial, or something like that.

Also having to review the patch to sample/*.patch files will be
unpleasant.
