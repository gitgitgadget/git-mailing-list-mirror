Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97408202DD
	for <e@80x24.org>; Fri, 20 Oct 2017 06:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751466AbdJTGSo (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Oct 2017 02:18:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52674 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751093AbdJTGSn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Oct 2017 02:18:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F9FFA3F9D;
        Fri, 20 Oct 2017 02:18:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TlRkXEE7RWT4L/Uv1Yy5fcrF9rI=; b=Z4PQDN
        Swx/uVg+hhHkjYXZ0eXNPDu2dWO14BlNU806Rs8uiOXA72ZTSggy+ji0OrpQcJtY
        02VF7ltCX9jDLFusUxCKyPCFG4xRosiyY8x6zMxdyY/Eyu7V+pGytT5LDXlcHIzH
        CRx23QgmYAOzvkCLr8LJptyGZAGVCJ/XGrLak=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pZ8aoBudCJN0N+C+CyAOCImARhts54YX
        1/7JnFY7o7dEPSVHC4lhg/kOKxNFGtoYQv4O1K+EYD05urcLeDTJMCJvxGVUeKL1
        nPFF1rkhiwLjKCTX3eh6bXw82CFxhoblENiM1wQ3/QXsg+GVnYRI5IU9VxNSqvem
        1V5Me/QzH2k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45D4EA3F9C;
        Fri, 20 Oct 2017 02:18:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A0528A3F9B;
        Fri, 20 Oct 2017 02:18:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Marius Paliga <marius.paliga@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, thais.dinizbraz@gmail.com
Subject: Re: [PATCH] builtin/push.c: add push.pushOption config
References: <xmqqmv4pl117.fsf@gitster.mtv.corp.google.com>
        <20171019174715.6577-1-marius.paliga@gmail.com>
        <CAGZ79kaSU+w0=zb61=5pEzhtd4U5Hzae4C2bUgpchNHAL_mzMA@mail.gmail.com>
        <xmqqbml2imrj.fsf@gitster.mtv.corp.google.com>
        <xmqq376eibrw.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 20 Oct 2017 15:18:36 +0900
In-Reply-To: <xmqq376eibrw.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 20 Oct 2017 15:17:07 +0900")
Message-ID: <xmqqy3o6gx4z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82663C10-B55E-11E7-81A9-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> We'd also want to document how push.pushOption works in
>>> Documentation/config.txt (that contains all the configs)
>>
>> Perhaps.
>
> Here is my attempt.

Another thing I noticed while we are around the area is that unlike
all other options in git-push.txt page, this one forgets to say it
always takes mandatory string.  Here is a possible fix.

 Documentation/git-push.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index aa78057dc5..a8504e0ae3 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -156,12 +156,12 @@ already exists on the remote side.
 	Either all refs are updated, or on error, no refs are updated.
 	If the server does not support atomic pushes the push will fail.
 
--o::
---push-option::
+-o <option>::
+--push-option=<option>::
 	Transmit the given string to the server, which passes them to
 	the pre-receive as well as the post-receive hook. The given string
 	must not contain a NUL or LF character.
-	When no `--push-option <option>` is given from the command
+	When no `--push-option=<option>` is given from the command
 	line, the values of configuration variable `push.pushOption`
 	are used instead.
 
