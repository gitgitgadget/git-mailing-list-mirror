Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7E561F424
	for <e@80x24.org>; Tue, 24 Apr 2018 18:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbeDXSQT (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 14:16:19 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:46362 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbeDXSQT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 14:16:19 -0400
Received: by mail-pf0-f179.google.com with SMTP id h69so12943925pfe.13
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 11:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ea1yeVV50/GBGtO72LWp9ud2Zt1sbnw/+DlbYhotkQ=;
        b=tNJLvlegPClX0mE2EHs8qTWq0IGydhhqobJwyyQcdczKXToJxw9NKyGCURG+WmuxWJ
         0kz1jU4p+GrZvaU7iH6UjFzwgyINiDoNl6CZLyZ8hyKbVlUYJA5kAu4iSbawWv5zeAUY
         MDHbO1ZGh1stKe9m1hQufv8ISghS4EwwKaXwqP3CTnriSariQxpMErzTQH1ktrzlD4lT
         R2xkoxVA24xakcPkegEJwSIWOyuFkVkHqJuOANXHuTBkUeM/TLWB/7BiUhEI1IX8COz+
         /2u/ofVQROX5AcZVY8ZhtidaDq9qrFvfFXoMm8R48EWy75c5vj64ZeII7Q5qxtMKpxlY
         koXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ea1yeVV50/GBGtO72LWp9ud2Zt1sbnw/+DlbYhotkQ=;
        b=Gac4OL8L/fvCJ4RUQe/ImL5GesXcZ8+YjaOuNA4S5CwnOimYYfi+DIMPbOUBqXQEWY
         P4SIBwaG/remPurCePoRV5mzzwK8mfrSu2UlqmAbDDANHMv3Ut3pHhqokrWHwlY2DRjW
         ipJ+/wkp94eDRk5dQeXnQZ/4dPukj9ddzphiXr5+Vm4vzyOp4xFQYwmbBU0jo9c7ISYh
         eczTjXLYmh9FYPQEd1WwLCMaCRAEsz2YdHkCVcVS3BWbyVPOW77j0YfWvODXkR2Vkr5d
         MHxzLI96IBG+S9TNELJb12gl+n//V+TmZov6uzQreX9gjKFf9NecHapKZw6BQOnjBKa3
         l+fQ==
X-Gm-Message-State: ALQs6tB5HnVq/DHVMtmlPYWWv9WFRnbUwH9kvJhr/KwQiPPfF6+xa3E8
        la0mZ8vFFqamTKcakbft39BKfA==
X-Google-Smtp-Source: AIpwx4/vYmY0Sw0bLHGLqTWkatLVy81xblNbCq04RwPUHbasknNyNB6CLwhINMKqjuCS/vjIz3g1yw==
X-Received: by 2002:a17:902:96a:: with SMTP id 97-v6mr26441592plm.266.1524593778480;
        Tue, 24 Apr 2018 11:16:18 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id g64sm37237530pfd.75.2018.04.24.11.16.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 11:16:17 -0700 (PDT)
Date:   Tue, 24 Apr 2018 11:16:16 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/9] packfile: add repository argument to
 packed_object_info
Message-Id: <20180424111616.bc81c1d16f1c511a497891ed@google.com>
In-Reply-To: <20180423234327.250484-6-sbeller@google.com>
References: <20180423234327.250484-1-sbeller@google.com>
        <20180423234327.250484-6-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 23 Apr 2018 16:43:23 -0700
Stefan Beller <sbeller@google.com> wrote:

> diff --git a/sha1_file.c b/sha1_file.c
> index 93f25c6c6a..b292e04fd3 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1307,7 +1307,8 @@ int oid_object_info_extended_the_repository(const struct object_id *oid, struct
>  		 * information below, so return early.
>  		 */
>  		return 0;
> -	rtype = packed_object_info(e.p, e.offset, oi);
> +
> +	rtype = packed_object_info(the_repository, e.p, e.offset, oi);

Extra blank line introduced.
