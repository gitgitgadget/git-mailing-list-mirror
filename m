Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C27C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E625207D3
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JSyLsGzn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgEUSYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 14:24:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52632 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbgEUSYh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 14:24:37 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B2CDCBC923;
        Thu, 21 May 2020 14:24:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=MgLcyKg05aOr
        Y0aEN68EoRdkRXY=; b=JSyLsGznVMAh99+ayEU7IE2wZ0B8+3iBC6K8mEQnGnl7
        QeDPvEy7NXZC9CyQlciL59Esmal3oL6eVy/HYFJl1MTpNEoY36pRUtu0gDbwmZ4f
        C8t8tzGqlV0Cp/7o9tseQ7GvH2M7Bo01hPhG0RB99gCvu7QgjTUE8MYu8DFm9To=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QNrx6v
        ImSChIO/JL2Wmxw+01w5S9C0+gmryc2bJHQOKPDgB09iKP+yXDLCZWMBClMTU6wz
        zsCoxIbG5Hyi1b3HjGEYpF6rVYt8A4Kpbrb4UjpHzsgmPk3fE1UIk8fhPQIPEXvP
        3XrBW6LKmISAf9S5UDxGUVESg+RMwlpdoVbe0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AA1D6BC922;
        Thu, 21 May 2020 14:24:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EFFB9BC91C;
        Thu, 21 May 2020 14:24:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] completion: fix completing stashes with "show -p"
References: <20200521142156.4717-1-ville.skytta@iki.fi>
Date:   Thu, 21 May 2020 11:24:32 -0700
In-Reply-To: <20200521142156.4717-1-ville.skytta@iki.fi> ("Ville
 =?utf-8?Q?Skytt=C3=A4=22's?=
        message of "Thu, 21 May 2020 17:21:56 +0300")
Message-ID: <xmqqo8qhrvrz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 51E7FEAA-9B90-11EA-A560-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ville Skytt=C3=A4 <ville.skytta@iki.fi> writes:

> Regression in df70b190bdd2add42a906819f9d41dbf91cf0809

That's not very helpful to readers.

Something like this?  I am merely guessing why you thought this
change is a good one, but that is what the proposed log message
is supposed to do.

    df70b190 (completion: make stash -p and alias for stash push -p,
    2018-04-20) wanted to make sure "git stash -p <TAB>" offers the same
    completion as "git stash push -p <TAB>", but it did so by forcing
    the $subcommand to be "push" whenever then "-p" option is found on
    the command line. =20

    This harms any subcommand that can take the "-p" option---even when
    the subcommand is explicitly given, e.g. "git stash show -p", the
    code added by the change would overwrite the $subcommand the user
    gave us.

    Fix it by making sure that the defaulting to "push" happens only
    when there is no $subcommand given yet.

Thanks.

>
> Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
> ---
>  contrib/completion/git-completion.bash | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
> index 70ad04e1b2..8dc4ad0e0d 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2782,7 +2782,7 @@ _git_stash ()
>  	local save_opts=3D'--all --keep-index --no-keep-index --quiet --patch=
 --include-untracked'
>  	local subcommands=3D'push list show apply clear drop pop create branc=
h'
>  	local subcommand=3D"$(__git_find_on_cmdline "$subcommands save")"
> -	if [ -n "$(__git_find_on_cmdline "-p")" ]; then
> +	if [ -z "$subcommand" -a -n "$(__git_find_on_cmdline "-p")" ]; then
>  		subcommand=3D"push"
>  	fi
>  	if [ -z "$subcommand" ]; then
