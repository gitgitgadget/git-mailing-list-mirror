Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD8011F406
	for <e@80x24.org>; Tue,  9 Jan 2018 21:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753859AbeAIVnD (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 16:43:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63544 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753744AbeAIVm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 16:42:59 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45CD5CAD57;
        Tue,  9 Jan 2018 16:42:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fDEhN+N5WSbKBi83HFRsDA17WH4=; b=F4kksG
        KRsXznzT5cswHWt9vhYQhz9kQ75oVhl9eup69xVYV+0361HtFf3u79dO3iMR35o1
        KXeVx2yb8zOIpvMwRUfgOHQVRiOhCA+vAKTHcN+SE5UEkMye0x47rHG8/usNVom1
        rxR1P7Gqwpxh7HAcrKWGgdFCZsO0PHZTqMZSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vGLoenX4dWkwOTuFvOXtaHsmEAaCcan0
        eHlOD0iyhjkm3nymmEvf4n7NGWJFHgUBorFMjPTXw7FHElvx7zVDktYLoPJJZytj
        81mf1I1hqkH4uJVMR/qRmpTBgCWco+a0ENGWFdNhufMhYknkuA9DLORM2fvIwZRU
        wiKEhd+8XRQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C8F7CAD56;
        Tue,  9 Jan 2018 16:42:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AA81DCAD55;
        Tue,  9 Jan 2018 16:42:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, git-packagers@googlegroups.com,
        git-for-windows@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.16.0-rc1
References: <xmqqbmi7ano1.fsf@gitster.mtv.corp.google.com>
        <nycvar.QRO.7.76.6.1801061354430.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.1801062248160.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
Date:   Tue, 09 Jan 2018 13:42:57 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1801062248160.1337@wbunaarf-fpuvaqryva.tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Sat, 6 Jan 2018 23:01:22 +0100
        (STD)")
Message-ID: <xmqqy3l63dzy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0F2DC1E2-F586-11E7-8B88-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
> index f1678851de9..470107248eb 100644
> --- a/t/t0021/rot13-filter.pl
> +++ b/t/t0021/rot13-filter.pl
> @@ -31,7 +31,22 @@
>  #
>  
>  use 5.008;
> -use lib (split(/:/, $ENV{GITPERLLIB}));
> +sub gitperllib {
> +...
> +	if ($ENV{GITPERLLIB} =~ /;/) {
> +		return split(/;/, $ENV{GITPERLLIB});
> +	}
> +	return split(/:/, $ENV{GITPERLLIB});
> +}

This cannot be the whole story for a few reasons.

 - In t/test-lib.sh we see this:

   GITPERLLIB="$GIT_BUILD_DIR"/perl/blib/lib:"$GIT_BUILD_DIR"/perl/blib/arch/auto/Git
   export GITPERLLIB

   If this part wants to split with ';', then the joining needs to
   be done with ';' to match, no?

 - In addition to t0021, there are similar split with colon in 0202,
   9000 and 9700, yet I am getting the feeling that you observed the
   issue only in0021, to which I do not think of a good explanation
   why.

