Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9827F2079E
	for <e@80x24.org>; Wed, 23 Nov 2016 16:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756034AbcKWQwn (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 11:52:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59248 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755865AbcKWQwm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 11:52:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E36F3519E2;
        Wed, 23 Nov 2016 11:52:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lKFUn919+vrL
        ZZ45sQAiynST2zM=; b=wjvF7+fkA8xE0aOG0yPUf/2wKJxkbv3fAZ5gCv2Mgu9f
        O9OVdpltTSWyH19MSAGJ3JBCb5BvkRa6c/gUq2pANnIfRTiCXotDyVNys8deiKNH
        U4go96mcC86WMDsYQnOVutHBYblhzxbqPjnOXtIPr1qf+qJuRo6HKwIartZsn+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Jiaq8y
        vOSEIb0JfOfZt5ArU71ip2eYYGzPnZgf4e3wxA4zVuugYr5+3wEa8+EsQ5zzuOON
        BvsJDZ7zLoO1FwGmgTtn3S+DbfLJcLGsWCchulT1WC+1PdA9C8730tKA/OvwtnPW
        but43sPGTOQRHWaFueL2jEK/z/X/l7K8rQneo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D57BB519E1;
        Wed, 23 Nov 2016 11:52:41 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4673D519E0;
        Wed, 23 Nov 2016 11:52:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, rappazzo@gmail.com
Subject: Re: [PATCH 1/3] worktree.c: zero new 'struct worktree' on allocation
References: <20161122100046.8341-1-pclouds@gmail.com>
        <20161122100046.8341-2-pclouds@gmail.com>
Date:   Wed, 23 Nov 2016 08:52:39 -0800
In-Reply-To: <20161122100046.8341-2-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Tue, 22 Nov 2016 17:00:44 +0700")
Message-ID: <xmqq7f7unnoo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3F668962-B19D-11E6-987F-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This keeps things a bit simpler when we add more fields, knowing that
> default values are always zero.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---

Looks sensible.  Thanks.


>  worktree.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/worktree.c b/worktree.c
> index f7869f8..f7c1b5e 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -91,16 +91,11 @@ static struct worktree *get_main_worktree(void)
>  	if (parse_ref(path.buf, &head_ref, &is_detached) < 0)
>  		goto done;
> =20
> -	worktree =3D xmalloc(sizeof(struct worktree));
> +	worktree =3D xcalloc(1, sizeof(*worktree));
>  	worktree->path =3D strbuf_detach(&worktree_path, NULL);
> -	worktree->id =3D NULL;
>  	worktree->is_bare =3D is_bare;
> -	worktree->head_ref =3D NULL;
>  	worktree->is_detached =3D is_detached;
> -	worktree->is_current =3D 0;
>  	add_head_info(&head_ref, worktree);
> -	worktree->lock_reason =3D NULL;
> -	worktree->lock_reason_valid =3D 0;
> =20
>  done:
>  	strbuf_release(&path);
> @@ -138,16 +133,11 @@ static struct worktree *get_linked_worktree(const=
 char *id)
>  	if (parse_ref(path.buf, &head_ref, &is_detached) < 0)
>  		goto done;
> =20
> -	worktree =3D xmalloc(sizeof(struct worktree));
> +	worktree =3D xcalloc(1, sizeof(*worktree));
>  	worktree->path =3D strbuf_detach(&worktree_path, NULL);
>  	worktree->id =3D xstrdup(id);
> -	worktree->is_bare =3D 0;
> -	worktree->head_ref =3D NULL;
>  	worktree->is_detached =3D is_detached;
> -	worktree->is_current =3D 0;
>  	add_head_info(&head_ref, worktree);
> -	worktree->lock_reason =3D NULL;
> -	worktree->lock_reason_valid =3D 0;
> =20
>  done:
>  	strbuf_release(&path);
