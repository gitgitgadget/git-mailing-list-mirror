Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 638002036B
	for <e@80x24.org>; Wed,  4 Oct 2017 02:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751505AbdJDCJx (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 22:09:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57073 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751117AbdJDCJw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 22:09:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 68E409ECDB;
        Tue,  3 Oct 2017 22:09:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7aSm6kVyOc+m4IPLNEuni7AXdNI=; b=rQiRwc
        VhjHHlQ3S4c10Br+c/ruO59hLQOnjFWJc9v2lnTK2tWEyAWfdhtzIkadoN34Nydy
        vuHViQa+lMZ1cLeGKXvXDzKAbnqiLci2ivEOJHXiTl+fu7h0+hqhExq8A0fVN+pv
        IhX/dd0/s9R/tAepJum8t694wQy7huJnTnH+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H4OSwRGr+UBNCP30XIR6Pu5kyfHOmoLa
        GLEiJ7YngGgrGoH5GrGBjLq5dRrdgEbs+tAyzYcakkySdPG3FFzhA0bwHmUlWo63
        l2vW5XhBP4k1jQC1uKh7QYcB0bjX1qiNiQ7wBqt+/Ed/Lvkpjt6HJKmlh6XZVfG8
        Q4BG6g9lK+c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 607D89ECDA;
        Tue,  3 Oct 2017 22:09:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C17D49ECD7;
        Tue,  3 Oct 2017 22:09:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        "David.Turner\@twosigma.com" <David.Turner@twosigma.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "christian.couder\@gmail.com" <christian.couder@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "johannes.schindelin\@gmx.de" <johannes.schindelin@gmx.de>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v8 00/12] Fast git status via a file system watcher
References: <20170919192744.19224-1-benpeart@microsoft.com>
        <20170922163548.11288-1-benpeart@microsoft.com>
        <xmqq7ewiz1mz.fsf@gitster.mtv.corp.google.com>
        <MWHPR21MB0478B8D1C5442B2FCE1ED465F47E0@MWHPR21MB0478.namprd21.prod.outlook.com>
        <xmqqk20fuvg7.fsf@gitster.mtv.corp.google.com>
        <fd972756-4ad3-4b96-23d0-e2c9e59189d1@gmail.com>
Date:   Wed, 04 Oct 2017 11:09:50 +0900
In-Reply-To: <fd972756-4ad3-4b96-23d0-e2c9e59189d1@gmail.com> (Ben Peart's
        message of "Tue, 3 Oct 2017 15:48:06 -0400")
Message-ID: <xmqqzi97fytt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B47CB8C-A8A9-11E7-A1DD-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> Well, rats. I found one more issue that applies to two of the
> commits. Can you squash this in as well or do you want it in some
> other form?

Rats indeed.  Let's go incremental as promised, perhaps like this
(but please supply a better description if you have one).

-- >8 --
From: Ben Peart <benpeart@microsoft.com>
Subject: fsmonitor: MINGW support for watchman integration

Instead of just taking $ENV{'PWD'}, use the same logic that converts
PWD to $git_work_tree on MSYS_NT in the watchman integration hook
script also on MINGW.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7519/fsmonitor-watchman                 | 2 +-
 templates/hooks--fsmonitor-watchman.sample | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7519/fsmonitor-watchman b/t/t7519/fsmonitor-watchman
index 7ceb32dc18..cca3d71e90 100755
--- a/t/t7519/fsmonitor-watchman
+++ b/t/t7519/fsmonitor-watchman
@@ -36,7 +36,7 @@ my $system = `uname -s`;
 $system =~ s/[\r\n]+//g;
 my $git_work_tree;
 
-if ($system =~ m/^MSYS_NT/) {
+if ($system =~ m/^MSYS_NT/ || $system =~ m/^MINGW/) {
 	$git_work_tree = `cygpath -aw "\$PWD"`;
 	$git_work_tree =~ s/[\r\n]+//g;
 	$git_work_tree =~ s,\\,/,g;
diff --git a/templates/hooks--fsmonitor-watchman.sample b/templates/hooks--fsmonitor-watchman.sample
index 870a59d237..c68038ef00 100755
--- a/templates/hooks--fsmonitor-watchman.sample
+++ b/templates/hooks--fsmonitor-watchman.sample
@@ -35,7 +35,7 @@ my $system = `uname -s`;
 $system =~ s/[\r\n]+//g;
 my $git_work_tree;
 
-if ($system =~ m/^MSYS_NT/) {
+if ($system =~ m/^MSYS_NT/ || $system =~ m/^MINGW/) {
 	$git_work_tree = `cygpath -aw "\$PWD"`;
 	$git_work_tree =~ s/[\r\n]+//g;
 	$git_work_tree =~ s,\\,/,g;

