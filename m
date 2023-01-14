Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED27FC46467
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 16:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjANQPb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 11:15:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjANQPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 11:15:25 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D107A5D3
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 08:15:22 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id q64so25268411pjq.4
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 08:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ElcWcGRhGZJ4Co2IYZomAd/mhAJGwBm82udjGQnvkuM=;
        b=PPGatMTps+dCwoSEEaIoc1wwVaQ9HC9ZnFHaoicMeUsi1j5lfh1oGvUJs8MbWSmg1V
         i7DgTb4/PS7jq1xFMoZbrkIpsQ7JK7pNqXJF1TtZukInEQjHuaArilCOxBXXabtvpzsD
         JqjbmSwg2mjVIENlHgotXfrdBBRAvQxXjmNKMMs+KPjOfshuTXk/wk/+unJ60BAyS9tC
         DnmuQsYPIMykj9D4dVszxTZkwJuETFFck240eDAOO24a+FPfnvECj3KyYkOOlOjTbbPN
         2SThQS5W2Jp/LPwtrGLT1rJx7PBm1B+BoiepytwBz1YvTUiKphSdnnE3j2Zy+XMS1fqu
         7mpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ElcWcGRhGZJ4Co2IYZomAd/mhAJGwBm82udjGQnvkuM=;
        b=AdZjW1sh1V5lStKS9W7E3Kb8335vSXy8ESasg945rkOUXZzcPlH9oIIPeZmT3Xu0PS
         30cu5e6EixFBsroeR5mcOTsRTBUHs3yjJv1N0c23ZcqMhjCG09ARdC5tpXnlAw0qSOAX
         YKHdx2QswnqJuVfXNIKU/P2AA6xd/Unv6ppTvyFYV5EDJIq8sw25ZQP1bSz2yjrjguWC
         Nl2LPr2oEznx/aqHvCvasRtnn0UaisCKAy7sGvZmQiq8CiHkO0+T2P9pbP81LWATWi9q
         BW2EXrBP7pTRx20CU5F1yTaZUlKLCv+BPu5SpSdRfY1Vn7bwOxXbokyiKrdAOSidFWJ+
         V8Jw==
X-Gm-Message-State: AFqh2kpb/To34tXr1l6L9VypLtz+XyjF2v+JHlHWJsOUE9BPQZ7cNXfr
        24a9AP1TVJk8WSnRmQ60ifFpo3Ct7Gg=
X-Google-Smtp-Source: AMrXdXsu0cPeFdhulFHDwFCIMZxF69grdXxi+qGPIUx4fo3ZO6en/n75KZwYmIRjtjL56fZycbPHsg==
X-Received: by 2002:a17:902:d101:b0:194:880c:26e1 with SMTP id w1-20020a170902d10100b00194880c26e1mr386982plw.4.1673712921606;
        Sat, 14 Jan 2023 08:15:21 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c1-20020a170903234100b0017f48a9e2d6sm16031303plh.292.2023.01.14.08.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 08:15:21 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
Subject: Re: [PATCH] ci: do not die on deprecated-declarations warning
References: <xmqqv8l9n5fj.fsf@gitster.g>
        <Y8LAim4D3g6qnZdq@coredump.intra.peff.net>
Date:   Sat, 14 Jan 2023 08:15:21 -0800
In-Reply-To: <Y8LAim4D3g6qnZdq@coredump.intra.peff.net> (Jeff King's message
        of "Sat, 14 Jan 2023 09:47:38 -0500")
Message-ID: <xmqqv8l9ks86.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +DEVELOPER_CFLAGS += -Wno-error=deprecated-declarations
>
> That's a pretty broad hammer. And I think it may stomp on the hack to
> rely on deprecated() in the UNUSED macro.
>
> As Ramsay suggested, we could probably use CURL_DISABLE_DEPRECATION to
> limit this just to the problematic case.

Yeah, I like that approach.

But not this one ...

> +	CURL_IGNORE_DEPRECATION(
> +		curl_easy_setopt(result, CURLOPT_REDIR_PROTOCOLS,
> +				 get_curl_allowed_protocols(0));
> +		curl_easy_setopt(result, CURLOPT_PROTOCOLS,
> +				 get_curl_allowed_protocols(-1));
> +	)
>
> though I think that was introduced only in 7.87.0 along with the
> deprecation warnings themselves, so we'd need to have a fallback like:
>
>   #ifndef CURL_IGNORE_DEPRECATION(x)
>   #define CURL_IGNORE_DEPRECATION(x) x
>   #endif

... as much.
