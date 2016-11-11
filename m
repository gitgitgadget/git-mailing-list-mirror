Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71666203E2
	for <e@80x24.org>; Fri, 11 Nov 2016 21:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964798AbcKKVHl (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 16:07:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53798 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934770AbcKKVHk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 16:07:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD4794D975;
        Fri, 11 Nov 2016 16:07:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TuUME9zo+vrFo/O6TekcWx9KImE=; b=iOtgRg
        I6kLrapdm1rIKLynJjAXBXDQUC5nEt5O3YQpGD39yv5p36U2MRSf2eGWmgL4nB2Z
        CwdjuNB/m1WMdMc218tjbAalv+G8uLOFmuFfLw5qcYcDfochkFou8t+u4kHCNPSM
        VuTu1gkF4fFAD+yBI5ftWpFK0x3amz+rlHvSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y9vMD50tQ9KN+sHjcz3WPAzYf9m4hnu+
        HDPqVxNrMq/PU5oar6pDyHDYmu7zPa1P8oeyzB/pAlG9dPtuixhoMfmT3x5xV2rb
        CgjxOTWTIFtoB/BfznmwrRLUZXExt0eryXqHvmgW4pZvZUFIUMbt89tYHXombb8Z
        J4AOnJbd8So=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A48FC4D974;
        Fri, 11 Nov 2016 16:07:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D1184D973;
        Fri, 11 Nov 2016 16:07:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: 2.11.0-rc1 will not be tagged for a few days
References: <xmqqk2cgc95m.fsf@gitster.mtv.corp.google.com>
        <xmqqoa1n57u4.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1611111711210.3746@virtualbox>
        <4FF1825D-F699-4532-9B53-A673DFF00D8B@gmail.com>
        <89DB812E-EC29-4D12-97EA-6E8FF6F86FE5@gmail.com>
        <C3840B91-58E2-4563-9597-5EE514D97CC1@gmail.com>
        <e0785e35-b43d-37ed-598d-b458daf3c355@kdbg.org>
        <xmqq1syh3fjx.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 11 Nov 2016 13:07:37 -0800
In-Reply-To: <xmqq1syh3fjx.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 11 Nov 2016 12:52:18 -0800")
Message-ID: <xmqqr36h209y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E010D52E-A852-11E6-90CE-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> OK, then let's have
>
> 	filter_git () {
> 		rm -f rot13-filter.log &&
> 		git "$@"
>                 ...
>
> and call that -rc1.

That is, to queue this on top of ls/filter-process and merge it
down.

-- >8 --
Subject: t0021: remove debugging cruft

The redirection of the standard error stream to a temporary file is
a leftover cruft during debugging.  Remove it.

Besides, it is reported by folks on the Windows that the test is
flaky with this redirection; somebody gets confused and this
merely-redirected-to file gets marked as delete-pending by git.exe
and makes it finish with a non-zero exit status when "git checkout"
finishes.  Windows folks may want to figure that one out, but for
the purpose of this test, it shouldn't become a show-stopper.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0021-conversion.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index cb72fa49de..5ce2535017 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -27,8 +27,7 @@ file_size () {
 
 filter_git () {
 	rm -f rot13-filter.log &&
-	git "$@" 2>git-stderr.log &&
-	rm -f git-stderr.log
+	git "$@"
 }
 
 # Compare two files and ensure that `clean` and `smudge` respectively are
