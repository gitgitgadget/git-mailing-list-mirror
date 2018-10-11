Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 076AA1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 22:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbeJLFke (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 01:40:34 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:53251 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeJLFke (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 01:40:34 -0400
Received: by mail-yb1-f201.google.com with SMTP id t15-v6so5185307ybl.20
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 15:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XoFF+s3QQH7UcgK5WQMJWp6FVcLPKTMk+Vg9HZojQ2k=;
        b=h4jQnbZdv6kCMnkq0FkxXBSWev16mjfkNOcHwf+o28LnH7v6pd1nmJjc1CmtMKlth1
         Ihe8JiIpt9R/pURdb9k1xDGyUL3ldkNThIHh51H5x1zRXW2TIoCAKE32DDY3tidk653D
         z0Az/WfCk5knl+/hL9u9R2fhvBiI6gyIQn41rDlQ244C5B0sEnMY6GcXZlwD6tl8exyh
         kzJEGBmtaIrkSfx7bdBSYaxVoOSpNLSPXqYgOXA5QFgVw3jMSoKM6UIV8FMIiPV2WOj5
         HP3ARy1O56CFaHLp9Awiqy5br332+2Dxo7vgdbjmMATk7t38P0IYspYeqQRmYbajV1nX
         Gy7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XoFF+s3QQH7UcgK5WQMJWp6FVcLPKTMk+Vg9HZojQ2k=;
        b=Rek1PhCZm8JEME7UHPDGkCFivrwjH2rr9pm0iPQ89MTKXFENVvZDK80Y+ITcd6jSay
         IO1HMSyvDczmRLhCCXFAAdn54ul8LrLqz+42Wy0uwQy/xLjwe0XjXHsUQaAQC/oAzEnK
         mj8n48kfUjC+6dmkG8pwHPlR05qVZYAhnSNG0xa8CXS5ylG4CfT+aAgXNqyt0HhObAwH
         EECeVG3dEtB+VTkeGNxID+Fkhjds76hJELFfYJIKD4ECB7mflvvzXff/OSYakDD7eiya
         7Uw6eyP65Ch/CDLeoOK3ovBmHdWyGy5vg/v+KoXA/eO3Z6E6lMmaUjYPTwqx2Ci4vk9b
         nxuA==
X-Gm-Message-State: ABuFfogXkW03/7fd9a/tWYxgr5bSQpcMD60Ot30gS9ftmY4GqKa/fmLl
        Vt/B6Mr9f5tsKBo9mT03cW3SNL0qE0nvQHLzB9xS
X-Google-Smtp-Source: ACcGV61cOAS1f9QKs08xHdvEfRsjzvvSKN+4eihlHhF/pIVMJcI2y/rwnCBEQSOy7VuX1dbdy0IaZwFsjyyIi/XA/eSC
X-Received: by 2002:a25:1f86:: with SMTP id f128-v6mr1840116ybf.64.1539295878792;
 Thu, 11 Oct 2018 15:11:18 -0700 (PDT)
Date:   Thu, 11 Oct 2018 15:11:14 -0700
In-Reply-To: <20181011211754.31369-6-sbeller@google.com>
Message-Id: <20181011221114.186377-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181011211754.31369-6-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 05/19] object: parse_object to honor its repository argument
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> In 8e4b0b6047 (object.c: allow parse_object to handle
> arbitrary repositories, 2018-06-28), we forgot to pass the
> repository down to the read_object_file.

[snip]

> @@ -270,7 +270,7 @@ struct object *parse_object(struct repository *r, const struct object_id *oid)
>  		return lookup_object(r, oid->hash);
>  	}
>  
> -	buffer = read_object_file(oid, &type, &size);
> +	buffer = repo_read_object_file(r, oid, &type, &size);

There is still the matter of the 2 invocations of has_object_file()
earlier in this function. The first one probably can be replaced with
oid_object_info_extended() (see the definition of
has_sha1_file_with_flags() to see how to do it), and the second one
looks redundant to me and can be removed. Apart from that, I don't see
any other invocations that need to be converted, so parse_object() will
indeed fully honor its repository argument.
