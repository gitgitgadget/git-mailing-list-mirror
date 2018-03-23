Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BADAD1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752271AbeCWRTi (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:19:38 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:55859 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752259AbeCWRTg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:19:36 -0400
Received: by mail-wm0-f49.google.com with SMTP id t7so4888721wmh.5
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PYHM+Qbdpkhb5LyVDmsmy19Lyk0qXumn3stN3fxbdVk=;
        b=qhf7xajNM8j3zCPT0ZJjenFC7NhRY+5UfvlYV0jg8Pmw2+lGjlX3fA4fBHyMDxp1YW
         2Qi1kbyGAplJSrabjxKy6GvnSV4oTwk/FKXK+UX4hVF8a+Nc57Lb+rN3jbHY4NtP8OGw
         8mJUp5rdwe45w54NsjbcQwf3Kc3DxRqAdfLnqvhJOvWk6NQktKiR0wVJDzOdXWy6QPow
         mT52vblbdCPPfhS/fALIfc/uDtmcC7s+D4u0OSV70Tj+pwR8jvl6xgexk0U1C+pkz/of
         s8m7VvF4ocxSssyQBv27k9mWqqx2dVMm5xVmB3a4mJTzINbr7gJwsbCjL7WjnjFYVJEr
         3ZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PYHM+Qbdpkhb5LyVDmsmy19Lyk0qXumn3stN3fxbdVk=;
        b=jLEKr5I+Ya+OVLVBMUerLotcBWSzmEbbUH8yLNrAmXx0pu2wyTB+vW99yEGmbzZa7F
         DrE6SSjoeiaE1jcSjWWpSa6xVArlWLVEpZCrTLh4xxaYc3UOukLtytAa66UXg9GjIxDj
         H++YaCSxNEo019zauGPphKuohalBjGAZscotoVsEPWCImCt8W5wLNIrxNKK8zhqkNTEx
         7/AVysFSswA3Bk009e1GayBWVpIWvoU0SsRR3oqlBzRnoTnZXYjzuJXFiqUxvIWCmFEn
         gT4uedP+pdg30a/pMRuKH5iSufO7OxgA7fZ7Xd3rPuF7lTELdhzJNlHP53/5hegLLa0F
         XXiw==
X-Gm-Message-State: AElRT7FO3C0Ie1KY3N0hBY2PlfYjNcqz6UMlNeMo+IRIVAejMXlcQb9j
        Mdm+gkBq3SymK0sMyn4Yy1Q=
X-Google-Smtp-Source: AG47ELsXeswPfclsle0kmAlEd0e2leidSgkXyBi4uKbS6DQQYb2TRCs4cDIP2ik67FMniAjqNiR6Bw==
X-Received: by 10.28.153.75 with SMTP id b72mr9772172wme.127.1521825574483;
        Fri, 23 Mar 2018 10:19:34 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 104sm9117730wrl.26.2018.03.23.10.19.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 10:19:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jameson Miller <jamill@microsoft.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 3/5] fast-import: update pool_* functions to work on local pool
References: <20180321164152.204869-1-jamill@microsoft.com>
        <20180323144408.213145-4-jamill@microsoft.com>
Date:   Fri, 23 Mar 2018 10:19:33 -0700
In-Reply-To: <20180323144408.213145-4-jamill@microsoft.com> (Jameson Miller's
        message of "Fri, 23 Mar 2018 10:44:06 -0400")
Message-ID: <xmqqfu4qk8uy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jameson Miller <jamill@microsoft.com> writes:

> Update memory pool functions to work on a passed in mem_pool instead of
> the global mem_pool type. This is in preparation for making the memory
> pool logic reusable.

This should be part of 2/5; the same comments to 2/5 I just sent out
would still apply to a patch that is a combined result between 2/5
and 3/5.

Also, if mem_pool_alloc_block() etc. are the desired final names,
using them from the beginning would make the result easier to read
through (both during review and later "log -p").

Thanks.  This round, especially 2/5 (with anticipation of 3/5
already in reader's head), was easier to grok than the previous.

