Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 592001F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 23:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035163AbcIYXLu (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 19:11:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55938 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1035147AbcIYXLr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 19:11:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4611E40886;
        Sun, 25 Sep 2016 19:11:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fZcwNvCUqqzptU2Hr3YHz7/enMs=; b=cKynbL
        3To19aXnEvRqWtn8HQX/h8ZgYc3OAGLJMyHjMYA3p3lr5ojggVc2vYPnC1AVArzj
        UsmbfaDi9jk/gEjNrb4xIT9wuCYN9LG9FE86vykWbIdOyAWwK/sATNhkTrxhm5gO
        zAuW1dMXiImGo1cbTLCWlGKcXIH9CBuffcDhw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SIIy+AOKt8y4tixAc8IfzwXQHYRFn1Wd
        Hz/ySBZFLJXtajFPQZ4OzVSvONjCnx1+0/pP6nSK1YdDENRVnAuFvS/WS+x0Hwgb
        4jiBRYOOjXXl/9k+wgfH8W3IwaC+NqgHKPkzclR0qe5mt+jsdB83nF5pSKpPoEtG
        PKyl3IOBNiY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3BC4640885;
        Sun, 25 Sep 2016 19:11:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B16C640884;
        Sun, 25 Sep 2016 19:11:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 06/11] i18n: add--interactive: i18n of help_patch_cmd
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
        <1472646690-9699-7-git-send-email-vascomalmeida@sapo.pt>
Date:   Sun, 25 Sep 2016 16:11:43 -0700
In-Reply-To: <1472646690-9699-7-git-send-email-vascomalmeida@sapo.pt> (Vasco
        Almeida's message of "Wed, 31 Aug 2016 12:31:25 +0000")
Message-ID: <xmqq7f9zy3ps.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6DC51F2C-8375-11E6-8623-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Vasco Almeida <vascomalmeida@sapo.pt> writes:

>  sub help_patch_cmd {
> -	my $verb = lc $patch_mode_flavour{VERB};
> -	my $target = $patch_mode_flavour{TARGET};
> -	print colored $help_color, <<EOF ;
> -y - $verb this hunk$target
> -n - do not $verb this hunk$target
> -q - quit; do not $verb this hunk or any of the remaining ones
> -a - $verb this hunk and all later hunks in the file
> -d - do not $verb this hunk or any of the later hunks in the file
> -g - select a hunk to go to
> +	if ($patch_mode eq 'stage') {
> +		print colored $help_color, __(
> +"y - stage this hunk
> +n - do not stage this hunk
> +q - quit; do not stage this hunk or any of the remaining ones
> +a - stage this hunk and all later hunks in the file
> +d - do not stage this hunk or any of the later hunks in the file");
> +	} elsif ($patch_mode eq 'stash') {
> + ...
> +"\n";
>  }

The same "shouldn't this be done with a table not code?" comment
applies to this as well, though this is not as bad as the previous
one.
