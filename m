From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] option-strings: use OPT_FILENAME
Date: Mon, 23 Feb 2015 11:08:49 -0800
Message-ID: <xmqqfv9wtpha.fsf@gitster.dls.corp.google.com>
References: <20150223144214.GA31624@peff.net>
	<3af5c93959b22dc327d7fb3974d36764906c2969.1424707497.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eQ==?= =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?= Duy 
	<pclouds@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 23 20:08:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPyNF-0003NV-P0
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 20:08:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbbBWTIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 14:08:52 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52948 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752076AbbBWTIw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 14:08:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 63A3139212;
	Mon, 23 Feb 2015 14:08:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ha9UJUCGyV/mY3w9sf2fHaPACi0=; b=IDhrlG
	vZfiG/BEu69bJnt4r7xZ43+YAFuiMpya4afOdltvAtXgIFfbWhxJFFHq07bF4CT8
	4MaxGyl4StnpFBaVOmqxqaqObcdoT7DKMJYjlkCV4Yop3P5B7/nbYsVEfQrBahpY
	q1FY5pWC/otf5QLghJucFy0EB4eRtW678oTsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ghoEs0RDpkz5XZqnRr4mSDGHCggrOUuV
	l5kP7XHGFuAy4tx1Aaeq4241P1F8f2Jr0BiB3PkLAgm2UnLbgAJCnQnBfiFOVIL1
	mVTXYY/iVYNXf1Mg37KJHxq11X8nIbV7uq/atCpfwlHIN2PlFa/G+Yto6clnA4fp
	Q4U+bpPbaQ0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 39AB739210;
	Mon, 23 Feb 2015 14:08:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A7F413920F;
	Mon, 23 Feb 2015 14:08:50 -0500 (EST)
In-Reply-To: <3af5c93959b22dc327d7fb3974d36764906c2969.1424707497.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Mon, 23 Feb 2015 17:17:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 66C7044C-BB8F-11E4-B6CD-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264286>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Some commands use OPT_STRING to specify a <file> argument. Let them use
> OPT_FILENAME so that they can profit from path prefixing.

If the existing code that takes string actually already works
correctly, they must be doing the necessary prefixing on their own,
but I do not see in this patch a hunk that removes such a custom
prefixing.  Puzzled...

It may be that some of them do not work correctly from subdirectory
and this change fixes bugs, but are all of them like that, or is
this patch fixing some of them while breaking some others?
>
>  archive.c             | 2 +-
>  builtin/archive.c     | 2 +-
>  builtin/blame.c       | 4 ++--
>  builtin/config.c      | 2 +-
>  builtin/fast-export.c | 4 ++--
>  builtin/hash-object.c | 2 +-
>  builtin/ls-files.c    | 2 +-
>  7 files changed, 9 insertions(+), 9 deletions(-)
