Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EE5A2018A
	for <e@80x24.org>; Tue, 28 Jun 2016 17:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178AbcF1R6s (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 13:58:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64714 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752133AbcF1R6r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2016 13:58:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 442882516D;
	Tue, 28 Jun 2016 13:58:46 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2PUzUGZV0yjR
	n9gF1fPwbUwCJ9s=; b=big5DAxqaxkM4oAtJyx2QUvipG7cku11hUcyJ/VfOqBo
	jXQ0fQYxZ7t9V3TAaAPbkgQ6oRQdgaMNac/gt2LtKQ7uIHG7Iyf4RokaLN476qf6
	8hnpAKc097edTRyXVGq7vNv92pMzKEysDbMDnDPR5ucBMJaW/1NYtItbW8+LZo0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=tcJYKh
	Ct6bNGthtcgxSUxtCXDAKXGPe03tvy4et0e08QFQ4y6YVDniUE0RwPYs4hTsuHxz
	Z3fr7usD1uHaqpGuyAKeO7RlvRHoXXi4vp1mJoFficWTJwzmiyAHm6RHHNWvh6u9
	Kc/5ZzaEoeYWl9WzOquVIjfehjkYvClRx53u4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C9FC2516C;
	Tue, 28 Jun 2016 13:58:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B7CB22516B;
	Tue, 28 Jun 2016 13:58:45 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] connect: read $GIT_SSH_COMMAND from config file
References: <20160626111635.6809-1-pclouds@gmail.com>
	<20160627193322.GB10877@sigill.intra.peff.net>
	<vpqwpl9yal3.fsf@anie.imag.fr>
Date:	Tue, 28 Jun 2016 10:58:43 -0700
In-Reply-To: <vpqwpl9yal3.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	28 Jun 2016 10:35:52 +0200")
Message-ID: <xmqqtwgd8ab0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F5449E76-3D59-11E6-8F9D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Jeff King <peff@peff.net> writes:
>
>> On Sun, Jun 26, 2016 at 01:16:35PM +0200, Nguyễn Thái Ngọc Duy wrote:
>>
>>> +	use the specified command instead of 'ssh' when they need to
>>> +	connect to a remote system. The command is in the same form as
>>> +	'GIT_SSH_COMMAND' environment variable and is overriden when
>>> +	the environment variable is set.
>>
>> Probably s/'GIT_SSH_COMMAND'/the &/.
>
> I think so. I'd write either "same form as `GIT_SSH_COMMAND`" or "same
> form as the `GIT_SSH_COMMAND` environment variable`.

Let's then squash this in.

 Documentation/config.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index bd32069..fe7c9c4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -444,11 +444,11 @@ This is useful for excluding servers inside a firewall from
 proxy use, while defaulting to a common proxy for external domains.
 
 core.sshCommand::
-	If this variable is set then 'git fetch' and 'git push' will
-	use the specified command instead of 'ssh' when they need to
+	If this variable is set, `git fetch` and `git push` will
+	use the specified command instead of `ssh` when they need to
 	connect to a remote system. The command is in the same form as
-	'GIT_SSH_COMMAND' environment variable and is overriden when
-	the environment variable is set.
+	the `GIT_SSH_COMMAND` environment variable and is overriden
+	when the environment variable is set.
 
 core.ignoreStat::
 	If true, Git will avoid using lstat() calls to detect if files have
