Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4487A202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 04:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbdIVEGk (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 00:06:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59484 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750734AbdIVEGj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 00:06:39 -0400
X-Greylist: delayed 536 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Sep 2017 00:06:39 EDT
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CE26A78D0
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 23:57:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:from
        :subject:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=zQINPxdsZ34mVavEQXrINk5Gc
        WY=; b=H3XlaLDfj+EwAqp1xUU+eFRBz0ZPbW8EuCjsUuEcNlUa9nuRjOaTRJ5T9
        5UWfadPJ4EzRMRNnt7z6F8x8WHarrV+4JjVJg5dQZ3a00CmnSQXKvMAiHmTZ/sor
        OHFr/FFA0o0BCXiSD/LEfJq2Ga05w3j1QO+ApAmZy2i0s9j/fc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:from:subject
        :message-id:date:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=k+mJL17p1HtjoSnrfvx
        FCWbZSRrOj8QgVxIJenbWzOwq9m+Ab7ubdlPchfo7b8+bs1xcP9EYDMSrSxdH2yn
        et/QX3AZ2rs5sEg/LQqGEd7obPt+/BrbTdAldHYvHLJn3Vli/BQHHrk48QGMihS+
        YLLe5A4peC/K1XD9uUnv9bOY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54362A78CF
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 23:57:43 -0400 (EDT)
Received: from [192.168.1.4] (unknown [76.215.41.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A4EA1A78CE
        for <git@vger.kernel.org>; Thu, 21 Sep 2017 23:57:42 -0400 (EDT)
To:     git <git@vger.kernel.org>
From:   Daniel Santos <daniel.santos@pobox.com>
Subject: KDevelop developers obviously don't use git :(
Message-ID: <1469bc42-0a21-8cc4-f9bb-000c3737fe19@pobox.com>
Date:   Thu, 21 Sep 2017 23:03:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Pobox-Relay-ID: 2F45D0D8-9F4A-11E7-A785-FE4B1A68708C-06139138!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

https://bugs.kde.org/show_bug.cgi?id=3D379219

$ git push minor-rant-warning

KDevelop has a despicable habit of performing `git status --porcelain`
whenever it damn well pleases ... or rather when it sees an alteration.=C2=
=A0
This this breaks git rebase because it grabs the $*()&@#$ lock file,
often leading to catastrophic heart failure and sometimes really forcing
you to git rebase --abort and start over (at least, that's been my
solution when git rebase --continue complained that there was nothing to
commit and maybe I had forgotten to add something).

I have argued that they should at least verify that there isn't a
.git/rebase-merge directory present before doing that, but if I want to
prevent a heart attack, it looks like I'm going to have to fix this one
myself.=C2=A0 (Sorry for the rant!)

$ git reset minor-rant-warning~1

So first I need to inquire if there is a current mechanism to say "git
status, but please fail if you're busy with a non-atomic operation".=C2=A0=
 If
there is not one, then it would seem that there should be and how do I
go about requesting it?

Thanks,
Daniel


