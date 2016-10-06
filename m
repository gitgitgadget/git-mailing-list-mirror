Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5C5C207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 18:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933284AbcJFSmi (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 14:42:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54602 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751569AbcJFSmh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 14:42:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A3B41432DC;
        Thu,  6 Oct 2016 14:42:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bTM3np8zxl7t
        KekggL52P4sMVMA=; b=WcZhSsLI+P+g38uNXcPIh5rYeBS9dC3WMKoYAhH0cbuK
        FY5uxOeN44RSK5bYcD6fcMfhctuKQ3T5maeUb83UwtgpTWaXobCiGDkWT8c7oAcw
        MXgUKtnvsbBKCTIf+tziENxkkTrEockQ3vt2EVSXCdRJIuOLHtkZ6B3BvGv9MZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=TkvRKW
        gUOVCp3QphVFnNrSQgPWLhvE5sSe77wYbTQqwC/B0eoZD29pYXM3pAuohE4AlbSh
        Vor6sTC2BSdUUI/Bm+yJMgNicp4OmBwNk8d0KdBo90vkWoG8s+0OTJL3qa0Ijjmx
        G8DtAJkx0FPPg4PsQ8pskAnkxWY1WfgkYR9fo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9AA6B432D9;
        Thu,  6 Oct 2016 14:42:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0FC3E432D7;
        Thu,  6 Oct 2016 14:42:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
References: <20161006114124.4966-1-pclouds@gmail.com>
Date:   Thu, 06 Oct 2016 11:42:33 -0700
In-Reply-To: <20161006114124.4966-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Thu, 6 Oct 2016 18:41:24 +0700")
Message-ID: <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A5C4B752-8BF4-11E6-B8AE-F99D12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Throwing something at the mailing list to see if anybody is
> interested.
>
> Current '!' aliases move cwd to $GIT_WORK_TREE first, which could make
> handling path arguments hard because they are relative to the original
> cwd. We set GIT_PREFIX to work around it, but I still think it's more
> natural to keep cwd where it is.
>
> We have a way to do that now after 441981b (git: simplify environment
> save/restore logic - 2016-01-26). It's just a matter of choosing the
> right syntax. I'm going with '!!'. I'm not very happy with it. But I
> do like this type of alias.

I do not know why you are not happy with the syntax, but I
personally think it brilliant, both the idea and the preliminary
clean-up that made this possible with a simple patch like this.


> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---
>  git.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/git.c b/git.c
> index 296857a..4c1dcf4 100644
> --- a/git.c
> +++ b/git.c
> @@ -252,6 +252,10 @@ static int handle_alias(int *argcp, const char ***=
argv)
> =20
>  			alias_string++;
>  			commit_pager_choice();
> +			if (*alias_string =3D=3D '!') {
> +				keep_cwd =3D 0;
> +				alias_string++;
> +			}
>  			restore_env(keep_cwd);
> =20
>  			child.use_shell =3D 1;
