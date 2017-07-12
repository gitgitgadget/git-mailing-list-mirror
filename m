Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B72220357
	for <e@80x24.org>; Wed, 12 Jul 2017 21:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754128AbdGLVkx (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 17:40:53 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34826 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753083AbdGLVkw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 17:40:52 -0400
Received: by mail-pf0-f194.google.com with SMTP id q85so4638500pfq.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 14:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TNtm2TknqjOkh2ct9jR2Q1hw3rojhTcdylZRJPPHHEQ=;
        b=mAlE50Vvq/huumX8jsWbHzhXhnNMcH4bcTeSs1n54YcsWcsFgpx3RpFjtUBlYB3iJo
         dVmMx5o7OQUJuOm9QqZVpJxOKPClg7IL/i+zgdiE1hYqBi4QI65m8U02ZG8lOZoIjTnW
         2Yu1A0LXEhSjIAV8MPsnemkHYvQEVoeDD76lllu3rA97K/pfXYAVOqhAZYv0awaHBXCz
         iu+cjS+ACFKVRW+354/k4gXoZSjU4+AjQrzJumk2UZPW93UPIm3MShh3/vFwG7LmOg50
         ME9O/0HyzLRCVhyS+gok7Wmk2i+wwOwZUaFItpy1us59tjzbRM//m/Tkf/HuqHXXW9n2
         /yQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TNtm2TknqjOkh2ct9jR2Q1hw3rojhTcdylZRJPPHHEQ=;
        b=k6xpNTAyltAGgz/5guEozfEYCKvwRgmfUs7x7JvqVNoiKTzK2u9t1VJqznkQJqPkXI
         U/6RDtzvzmoUx58H8CLSONZyUq8DcyMl4Ea/rLyAxwGVWBFYm+dvNj7UGsm50LobC7yJ
         cvQZnTPiKwTAXB9RdyxfMrjdppfQ91wAx7a/9G0HsQ28RXvdP8wHZsEFwGDPF8s7eS+L
         YBVH+baprCkc4a8UJsRK0c+pjRhYBkLCQmqoaoCUb1ENGa6CZ0DHbMUEBV/f73J6sYhS
         AiLaroVbZXy0Aa3duRnzxHjWYUDZ8XTs+hoQ8FhNhw+TJ9ND1VPfch61oS6HU3sA0/pb
         zlqg==
X-Gm-Message-State: AIVw1103QysDkGAgJ9594ZahCReXfdJvVh7CkqrVvn87AiWm4ar1tuve
        eoRNnK4uG8UbGpMbU7g=
X-Received: by 10.99.184.2 with SMTP id p2mr5868802pge.194.1499895651305;
        Wed, 12 Jul 2017 14:40:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8c0d:cddc:dbb9:7a95])
        by smtp.gmail.com with ESMTPSA id d70sm4870849pga.49.2017.07.12.14.40.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 14:40:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [PATCH 2/3] setup: have the_repository use the_index
References: <20170711220408.173269-1-bmwill@google.com>
        <20170711220408.173269-3-bmwill@google.com>
        <xmqqzica1pli.fsf@gitster.mtv.corp.google.com>
        <20170712180143.GD65927@google.com>
        <xmqqmv891jct.fsf@gitster.mtv.corp.google.com>
        <20170712213339.GI93855@aiede.mtv.corp.google.com>
Date:   Wed, 12 Jul 2017 14:40:49 -0700
In-Reply-To: <20170712213339.GI93855@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 12 Jul 2017 14:33:39 -0700")
Message-ID: <xmqqvamxz63i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>
> All that said, I don't have a strong opinion on this.  Both the 1-word
> approach (a pointer) and 24-word approach (embedding) are tolerable
> and there are reasons to prefer each.

I do not care too much about 24-word wastage.  If this were not "a
pointer pretending to be embedded object", the fix in 1/3 wouldn't
have been necessary.  I am worried about this being an invitations
for such unnecesasry bugs.
