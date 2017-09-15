Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 728B120281
	for <e@80x24.org>; Fri, 15 Sep 2017 20:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbdIOUwL (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 16:52:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63086 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751685AbdIOUwK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 16:52:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 506889A6F7;
        Fri, 15 Sep 2017 16:52:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iXP6cGmx83ZPB870UMxUQl03zpY=; b=sGX86l
        kHI4hjxTbmiiSpy2zV6jE6sDBzCgnV9pN1SpXOHAeS77hwTTJsm7vkTRiMcS+vB9
        DKzdnpLceqnV3VDsvpkYAq9K+pIniab7BUckSCqfE+h0bXUrcb8C2mANu994UAOs
        ptKut+hT4iZreY22BKW6nDuvCYQ8WPIGWGJwY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Yv1ts8d0X6ANrsI/Cg0rvfkNmH5oD35Q
        ZXdWBIFhwNv5QadnY32Pudlyvpp+QZ2SpqayanJ/qmDetn2SvLCL5/Towu6LQDbE
        QjwyKu7jTLWo/m3Pt4lwAuaZA8+XHu5a8jblWmEve1WNEUuRB9oq6akG/r0/06dq
        YTQedfKZn4g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 471EB9A6F5;
        Fri, 15 Sep 2017 16:52:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 99B209A6F4;
        Fri, 15 Sep 2017 16:52:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Commit dropped when swapping commits with rebase -i -p
References: <oo62vr$pvq$1@blaine.gmane.org>
        <CAN0heSqGfxrFTwuaxgppZTx+3U=g_Qs4PyaCBF6ddV_PbvdpTQ@mail.gmail.com>
        <CAHGBnuMC_10krsdZe2KiQ4jjiL43kogn--dWjPgca_p2xgmQMA@mail.gmail.com>
        <20170902000417.GE143138@aiede.mtv.corp.google.com>
        <a47058cc-8ffc-4484-c247-3c8d4f827c07@gmail.com>
Date:   Sat, 16 Sep 2017 05:52:07 +0900
In-Reply-To: <a47058cc-8ffc-4484-c247-3c8d4f827c07@gmail.com> (Sebastian
        Schuberth's message of "Mon, 11 Sep 2017 10:45:40 +0200")
Message-ID: <xmqqbmmbwuq0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD4FED2A-9A57-11E7-A517-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On 2017-09-02 02:04, Jonathan Nieder wrote:
>
>>> Anyway, this should really more explicitly say *what* you need to know
>>> about, that is, reordering commits does not work.
>> 
>> It tries to explain that, even with an example.  If you have ideas for
>> improving the wording, that would be welcome.
>
> As a first step, I indeed believe the wording must the stronger / clearer. How about this:
>
> From f69854ce7b9359603581317d152421ff6d89f345 Mon Sep 17 00:00:00 2001
> From: Sebastian Schuberth <sschuberth@gmail.com>
> Date: Mon, 11 Sep 2017 10:41:27 +0200
> Subject: [PATCH] docs: use a stronger wording when describing bugs with rebase -i -p
>
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  Documentation/git-rebase.txt | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 6805a74aec..ccd0a04d54 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -782,10 +782,11 @@ case" recovery too!
>  
>  BUGS
>  ----
> -The todo list presented by `--preserve-merges --interactive` does not
> -represent the topology of the revision graph.  Editing commits and
> -rewording their commit messages should work fine, but attempts to
> -reorder commits tend to produce counterintuitive results.
> +Be careful when combining the `-i` / `--interactive` and `-p` /
> +`--preserve-merges` options.  Reordering commits will drop commits from the
> +main line. This is because the todo list does not represent the topology of the
> +revision graph in this case.  However, editing commits and rewording their
> +commit messages 'should' work fine.
>  
>  For example, an attempt to rearrange
>  ------------


Anybody?  I personally feel that the updated text is not all that
stronger but it is clearer by clarifying what "counterintuitive
results" actually mean, but I am not the target audience this
paragraph is trying to help, nor I am the one who is making excuse
for a known bug, so...

