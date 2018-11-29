Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BABB6211B4
	for <e@80x24.org>; Thu, 29 Nov 2018 06:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbeK2Reu (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 12:34:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52612 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727712AbeK2Ret (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 12:34:49 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2DDED12C411;
        Thu, 29 Nov 2018 01:30:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SEasVRzbiUJ+
        dtpQ6hcri8EgDaw=; b=eZCPS4i7oJxexXO6kTG9+8YrLa0HD9DBwmy3DJLhYkBU
        0ZqmuDVTAbSE18UirwQ/8FR2SX43ZTG8DjRFOSQevG+0qdx+sFsYUN7vqGmsrZDI
        L2H3MkmYhi+zJDbHs8KN/OeHGv1y0Cnvb/YtIi6OJlEZmKmkNhCSxZP7FwZIpoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=O4TZS3
        3H0J9HgD9AcpIHYyOz6zn6AqhkTKDPqhZHbPsTi2CIV3lFyQVTddandqICFV5tp+
        AUwd606rI05aTJNZxgC8q4kdTS/VtAXdj4R8ENaeuRTEG9JKWgEduBpndLPpLIEf
        BT02Sca6nblURaZ00fdySmar5zvR7ZgLGmquU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 270A712C410;
        Thu, 29 Nov 2018 01:30:32 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9A17A12C40F;
        Thu, 29 Nov 2018 01:30:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] transport-helper.c: do not translate a string twice
References: <20181126195756.15537-1-pclouds@gmail.com>
Date:   Thu, 29 Nov 2018 15:30:30 +0900
In-Reply-To: <20181126195756.15537-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 26 Nov 2018 20:57:56 +0100")
Message-ID: <xmqqo9a8o0op.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 45386094-F3A0-11E8-850E-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---
>  My bad.
>
>  transport-helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/transport-helper.c b/transport-helper.c
> index 7213fa0d32..bf225c698f 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -573,7 +573,7 @@ static int run_connect(struct transport *transport,=
 struct strbuf *cmdbuf)
>  			fprintf(stderr, "Debug: Falling back to dumb "
>  				"transport.\n");
>  	} else {
> -		die(_(_("unknown response to connect: %s")),
> +		die(_("unknown response to connect: %s"),
>  		    cmdbuf->buf);

Thanks.
