Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65B961F461
	for <e@80x24.org>; Tue,  2 Jul 2019 17:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfGBRvW (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 13:51:22 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56101 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBRvW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 13:51:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0CDF773E02;
        Tue,  2 Jul 2019 13:51:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=43AQKpkguLDX4thwPVh3BP7Mz6k=; b=TCn5U6
        A5/lxYpahhXmngSP3fwiTttIQSNCF29NDF5cLecqatOnaDJ1Psb9Dbnr5yrgDaYv
        Ky7mnT2IPC/Wcu1O09XHoEYx83OcWk+6NKcizQYqsd3KRQHezBPSaFAtz2fqaWlZ
        ECdB/D89AQkNs4Olzk6T4Srrv5K1tkJKqQvsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gLlTLuQ340/7DWJ2dk6iRWUK/IJkbQPS
        RazSAAVZaZAsvmPE1n6rKUUNBM26P7n4Il+I4om+PbO9FArDlg7r5FjLONQ+cA6N
        BbgznkVKoWdU76i20sm1+OcWJ1qmwOzffxbw76sklxLLY6flXQgRKgrYyhRDF8ka
        z+3csIaHP+A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DDC7D73E01;
        Tue,  2 Jul 2019 13:51:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E26D973DF4;
        Tue,  2 Jul 2019 13:51:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        jacob.keller@gmail.com, martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCH v6 07/27] checkout: inform the user when removing branch state
References: <20190321131655.15249-1-pclouds@gmail.com>
        <20190329103919.15642-1-pclouds@gmail.com>
        <20190329103919.15642-8-pclouds@gmail.com>
        <20190702080611.GL21574@szeder.dev> <20190702090308.GA27775@ash>
Date:   Tue, 02 Jul 2019 10:51:13 -0700
In-Reply-To: <20190702090308.GA27775@ash> (Duy Nguyen's message of "Tue, 2 Jul
        2019 16:03:09 +0700")
Message-ID: <xmqqa7dw4966.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FD22373E-9CF1-11E9-8EA8-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> I agree, this is not "canceling". I think this series causes conflicts
> with pw/clean-sequencer-state-upon-final-commit and the warning is
> accidentally enabled (partly my fault since I named the argument
> "verbose").
>
> Junio, in this conflict resolution (merging nd/switch-and-restore to
> next), we should pass '0' instead of 'verbose' to
> sequencer_post_commit_cleanup().

Thanks for an update to the merge-fix.  What should the name of the
parameter to the sequencer_post_commit_cleanup() funcion be then,
though?  Perhaps we'd want an update after the topic graduates to
the 'master' branch.

>
> diff --cc builtin/commit.c
> index 1921401117,fa5982cc86..145d50caf0
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@@ -1658,7 -1666,8 +1658,7 @@@ int cmd_commit(int argc, const char **a
>   		die("%s", err.buf);
>   	}
>   
> - 	sequencer_post_commit_cleanup(the_repository);
>  -	unlink(git_path_cherry_pick_head(the_repository));
>  -	unlink(git_path_revert_head(the_repository));
> ++	sequencer_post_commit_cleanup(the_repository, verbose);
>   	unlink(git_path_merge_head(the_repository));
>   	unlink(git_path_merge_msg(the_repository));
>   	unlink(git_path_merge_mode(the_repository));
> --
> Duy
