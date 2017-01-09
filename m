Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F16D7205C9
	for <e@80x24.org>; Mon,  9 Jan 2017 03:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934256AbdAIDKo (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 22:10:44 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52809 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933873AbdAIDKn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 22:10:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E8A5E5F6FB;
        Sun,  8 Jan 2017 22:10:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=um5JfU3ucm5OHq54ILB3ExCfDpw=; b=lCZzAz
        RkuH1O/vo7oTkHvYP794gfJtBcKiJBRwZAPrMmVjHQRoRvUSenbKAV7b/AjLoyjE
        v5dcNAT1F7A+E1sUeLkPwSh0+tpoRByvR9FHXA9ybdbARjO3+woferHRGCCc3L7G
        8URTaqgGlwIKZ/mOjFBFuKiLzZDaR13sT2a4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q2bQ9nEdu977/qGKh/UAU5mG4+lN4jyU
        VMFzr2lkCGlDngfC50z2NTYhwvbJUqcdSNpeneQcytKn7GHv4gdF7fTIkdCqfDke
        /qf7u4h6f36jKBs0crJgJ4cs65wBKIT3Ek+4FhocAvkF99YYElUGODwt0esm9ts4
        B6EvVb4kYBQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF7E55F6F9;
        Sun,  8 Jan 2017 22:10:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 47A6A5F6F8;
        Sun,  8 Jan 2017 22:10:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Steven Penny <svnpenn@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Makefile: POSIX windres
References: <20170107214110.3124-1-svnpenn@gmail.com>
Date:   Sun, 08 Jan 2017 19:10:41 -0800
In-Reply-To: <20170107214110.3124-1-svnpenn@gmail.com> (Steven Penny's message
        of "Sat, 7 Jan 2017 15:41:10 -0600")
Message-ID: <xmqqtw99x70u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3467D2FA-D619-11E6-B58B-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Steven Penny <svnpenn@gmail.com> writes:

> When environment variable POSIXLY_CORRECT is set, the "input -o output" syntax
> is not supported.
>
> http://cygwin.com/ml/cygwin/2017-01/msg00036.html
>
> Signed-off-by: Steven Penny <svnpenn@gmail.com>
> ---

Who other than cygwin build uses this target?  Git for Windows?

Hannes, Dscho, is this change OK with you guys?
 
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index d861bd9..a2a1212 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1816,7 +1816,7 @@ $(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
>  git.res: git.rc GIT-VERSION-FILE
>  	$(QUIET_RC)$(RC) \
>  	  $(join -DMAJOR= -DMINOR=, $(wordlist 1,2,$(subst -, ,$(subst ., ,$(GIT_VERSION))))) \
> -	  -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" $< -o $@
> +	  -DGIT_VERSION="\\\"$(GIT_VERSION)\\\"" -i $< -o $@
>  
>  # This makes sure we depend on the NO_PERL setting itself.
>  $(SCRIPT_PERL_GEN): GIT-BUILD-OPTIONS
