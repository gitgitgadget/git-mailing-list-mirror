Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8F4C83001
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 00:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BFD0206D4
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 00:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6Cx27si"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgD1Axh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 20:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726263AbgD1Axg (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 20:53:36 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76F7C03C1A8
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 17:53:36 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so7654612plo.7
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 17:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dgpR7Oqr7mq+YUSvKj//FDTUQmR3YTJQYR5miQQ96p4=;
        b=n6Cx27siypZQWBgkyQ6wpBnsXzvR409smnLvs3D764aKuyA+Ittr8CQ316J5AWB1qc
         /hMpjJ9WviCPpEmfRJXwQRIra52UDEIoiRE/Asa0zbLLIDZulVKux6SvCOIf6RGNWGdx
         kTmPul+25nv0bPQb4M7vKEWoeeoqL+osgs3mCXIRoK2xH3FdoQNwcPLPCTiRKHpZ7HS9
         ufEeeceJnBcP1hj7IdlwMPVjjhR7iQ91nX+zirRUXyt/s92mQQGGhqHGTquE1vv82rJF
         DCElbJve8QdhlTyNtHlx0sIbDOaUGGruJQOn7fvCGKYE12o4j1Xwnd2ZT/RQ2q1bodDi
         CLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dgpR7Oqr7mq+YUSvKj//FDTUQmR3YTJQYR5miQQ96p4=;
        b=RPj77QU1MBIeZxb86ATs6Uy+tkbO9/AY0J9i9eLp0a8gDDTwaM1pD8X2ezQtUIUR3E
         nCFADpLqYIfLLIqrkl8zcNmcEyT1EOMEENb2KfZn3RbXCMyh2GkUaQwdfUdQiXYbRgoP
         /fhvsk0EAE5L85jCPA8c2RR3cNos9QeXovgxvs3EhxwWv+BO/AvSjaybCNAu3XtOOG64
         +mjG0HHKu5iLdw0EOiLV1oX79LzZF/6yHHXuTIopqwWadk7MwF/r/VoAw3BX11pqz/F2
         hIQE+k//Y1DzqkjEmCX2vPEUm51P4fFeFu1GGJWsf+CteIWQaZdmBTVGX5NjoIFPJUtF
         1CTQ==
X-Gm-Message-State: AGi0PubrFwLa6NEYFXE7nF9DHCXXnt9sWiGPIiyBY50kQoDDwou64u9a
        +oV7eZ2x4TBid7T+/o6W1ZksejgE
X-Google-Smtp-Source: APiQypKS9yqMK2pEOInGtj0+7ZHcmYUDXNVkh0rnmIZuoNSKGaoWqzjsltGiXf4VPh8qSRIAfMnw9g==
X-Received: by 2002:a17:902:b206:: with SMTP id t6mr26268123plr.270.1588035216193;
        Mon, 27 Apr 2020 17:53:36 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id t15sm11442577pgv.61.2020.04.27.17.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 17:53:35 -0700 (PDT)
Date:   Mon, 27 Apr 2020 17:53:33 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 1/3] fetch-pack: return enum from process_acks()
Message-ID: <20200428005333.GE36078@google.com>
References: <cover.1587775989.git.jonathantanmy@google.com>
 <cover.1588031728.git.jonathantanmy@google.com>
 <f0cfbc03c27658e54a73c46570c5153961ed85b6.1588031728.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0cfbc03c27658e54a73c46570c5153961ed85b6.1588031728.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> process_acks() returns 0, 1, or 2, depending on whether "ready" was
> received and if not, whether at least one commit was found to be common.
> Replace these magic numbers with a documented enum.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  fetch-pack.c | 35 ++++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)

Yay!

> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1268,9 +1268,29 @@ static int process_section_header(struct packet_reader *reader,
>  	return ret;
>  }
>  
> -static int process_acks(struct fetch_negotiator *negotiator,
> -			struct packet_reader *reader,
> -			struct oidset *common)
> +enum common_found {
> +	/*
> +	 * No commit was found to be possessed by both the client and the
> +	 * server, and "ready" was not received.
> +	 */
> +	NO_COMMON_FOUND,
> +
> +	/*
> +	 * At least one commit was found to be possessed by both the client and
> +	 * the server, and "ready" was not received.
> +	 */
> +	COMMON_FOUND,
> +
> +	/*
> +	 * "ready" was received, indicating that the server is ready to send
> +	 * the packfile without any further negotiation.
> +	 */
> +	READY
> +};
> +
> +static enum common_found process_acks(struct fetch_negotiator *negotiator,
> +				      struct packet_reader *reader,
> +				      struct oidset *common)

Thanks for the clear comments.

>  {
>  	/* received */
>  	int received_ready = 0;
> @@ -1320,7 +1340,8 @@ static int process_acks(struct fetch_negotiator *negotiator,
>  		die(_("expected no other sections to be sent after no 'ready'"));
>  
>  	/* return 0 if no common, 1 if there are common, or 2 if ready */

This comment can be removed now, which is a nice bonus.

> -	return received_ready ? 2 : (received_ack ? 1 : 0);
> +	return received_ready ? READY :
> +		(received_ack ? COMMON_FOUND : NO_COMMON_FOUND);
>  }
>  
>  static void receive_shallow_info(struct fetch_pack_args *args,
> @@ -1508,13 +1529,13 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  		case FETCH_PROCESS_ACKS:
>  			/* Process ACKs/NAKs */
>  			switch (process_acks(negotiator, &reader, &common)) {
> -			case 2:
> +			case READY:
>  				state = FETCH_GET_PACK;
>  				break;
> -			case 1:
> +			case COMMON_FOUND:
>  				in_vain = 0;
>  				/* fallthrough */
> -			default:
> +			case NO_COMMON_FOUND:
>  				state = FETCH_SEND_REQUEST;
>  				break;
>  			}

With the extraneous comment removed,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

diff --git i/fetch-pack.c w/fetch-pack.c
index 45547a621e6..7b0eef98db5 100644
--- i/fetch-pack.c
+++ w/fetch-pack.c
@@ -1339,7 +1339,6 @@ static enum common_found process_acks(struct fetch_negotiator *negotiator,
 	if (!received_ready && reader->status != PACKET_READ_FLUSH)
 		die(_("expected no other sections to be sent after no 'ready'"));
 
-	/* return 0 if no common, 1 if there are common, or 2 if ready */
 	return received_ready ? READY :
 		(received_ack ? COMMON_FOUND : NO_COMMON_FOUND);
 }
