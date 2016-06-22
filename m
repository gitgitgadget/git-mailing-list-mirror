Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5428F20189
	for <e@80x24.org>; Wed, 22 Jun 2016 18:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbcFVSiZ (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 14:38:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50072 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750957AbcFVSiY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 14:38:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E494265E1;
	Wed, 22 Jun 2016 14:38:18 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x436DWjwvrhLfTpqbmE0Ildzwbo=; b=NBBP0b
	BhOMPCQ2t6lx0Y1SFuuUwsj8hQMi6jJVeQGLLLfjHZytwmzSaLapx0s+1ipDp1PQ
	NkbeIKto4aZSWlFjRYF02OCCAklBm6ViqM/spDNxSqQiW757YTGF7MGW2M+G5NBJ
	BcmgpTjYfineTJNZdi2Ji3Eecubf8VrXpM6I4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L7quEfvNBzhhvPH65D9ZojBROi6WDa7C
	eajWbmiY0iWniaIK2ihrgD5+0q8Qdxb+pgWu6x7NsrQXnVLHF4wja6GbTsU2DBN/
	KFVSlJi/Jq/mhOSxmRYC4oPufS/4jgC/bGwEAcpFfBSuowF8A9CV+tQAduWMvZ8/
	cR0byUNlupQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5728D265E0;
	Wed, 22 Jun 2016 14:38:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D6BCF265DF;
	Wed, 22 Jun 2016 14:38:17 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Andrew Oakley <aoakley@roku.com>
Cc:	<git@vger.kernel.org>, <larsxschneider@gmail.com>,
	<luke@diamand.org>
Subject: Re: [PATCH 1/1] git-p4: correct hasBranchPrefix verbose output
References: <xmqqbn2uqufj.fsf@gitster.mtv.corp.google.com>
	<1466587571-18532-1-git-send-email-aoakley@roku.com>
Date:	Wed, 22 Jun 2016 11:38:15 -0700
In-Reply-To: <1466587571-18532-1-git-send-email-aoakley@roku.com> (Andrew
	Oakley's message of "Wed, 22 Jun 2016 10:26:11 +0100")
Message-ID: <xmqqd1n9m5m0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CAF504C-38A8-11E6-8609-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Andrew Oakley <aoakley@roku.com> writes:

> The logic here was inverted, you got a message saying the file is
> ignored for each file that is not ignored.
>
> Signed-off-by: Andrew Oakley <aoakley@roku.com>
> ---

Thanks.

>  git-p4.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-p4.py b/git-p4.py
> index b6593cf..b123aa2 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2674,7 +2674,7 @@ class P4Sync(Command, P4UserMap):
>              return True
>          hasPrefix = [p for p in self.branchPrefixes
>                          if p4PathStartsWith(path, p)]
> -        if hasPrefix and self.verbose:
> +        if not hasPrefix and self.verbose:
>              print('Ignoring file outside of prefix: {0}'.format(path))
>          return hasPrefix
