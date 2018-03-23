Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5083E1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 22:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbeCWWWN (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 18:22:13 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37539 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751899AbeCWWWM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 18:22:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id 139so6078301wmn.2
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 15:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gYQC+fqR3cPxFWsDq9ZSKcunsJ9elxENDppfkcjPYCs=;
        b=Kle8d/JEAFtpYyxmVimATL7fuCuLDe/a4hdHJaW02W818PYZY2rATFiRCHlTEFUAis
         t1UCEUzc5e5TPG6vjg+nDyR5B9yVVmABFzo4qucLhRgPIjEV0ygbBmMJ42eEI+PIHORn
         dNuZ5D8A/EzdPavWFSOMNHCJBtNlI24BOG6T8U0weUNI+Us6lJQefG2ZvemfA/UGWk+x
         82i6XLShMcjtU5Py+5rY275BpxTzXeI7xgxuqxF8Q0qY1nVLSOII8/w0Y3KVyEEkf3sZ
         Znk+gUDnlH7hLQWJN0bU9NPyrF8swbTU/4dQnR9YgsE43WQHWcjmy//izkMYOhjEXRZq
         MPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gYQC+fqR3cPxFWsDq9ZSKcunsJ9elxENDppfkcjPYCs=;
        b=CFuatPbep6/fGzcKD3tNSta8VdXWFNMxhFAHqdZBVEyEAOhxuw07rTP7+Mpq+kZ/nm
         ENU0TfnG6NMF8ZkulFENq54IrA3aFkJsyRV7d4+TmGANWAvfnngIM5/mSn+6m70E+Gyb
         rbvL1s+mIwlc06cAMQcrst/+EX6eWkE2RurjxDjBwMW5ightQThLw+BL7U006Vh22fq0
         EJAMqS1WcTI+3PKZuze9cUWjD0z1f9k0iJ2+8m2ly3uVRUus4vC9VH57oKFyPCYx7zx9
         Y7lNLwyoaz2jiel4hMDpuVGu1/j2NTHHEP/A4GTTWE2/v0iyuB12k1LMijLoPzMfOeP1
         hUqQ==
X-Gm-Message-State: AElRT7GxFsBvbHmAHXtfBDcWPIzxzF1b43XGu7b5CO1ve1B11WuM/McV
        mc1IctvzpUwmC/6GvkZQTxs=
X-Google-Smtp-Source: AIpwx4+9a1SGo2QUUHnrMmxvCDz6d4lwhpfYmL3ZFzKdr5mOFMT1nbS+G1FF4dFo/6LcphGRFv/9KQ==
X-Received: by 10.28.137.147 with SMTP id l141mr352805wmd.141.1521843731060;
        Fri, 23 Mar 2018 15:22:11 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 124sm9147161wmv.19.2018.03.23.15.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 15:22:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wink Saville <wink@saville.com>
Cc:     git@vger.kernel.org, gister@pobox.com, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [RFC PATCH v5 4/8] Extract functions out of git_rebase__interactive
References: <cover.1521839546.git.wink@saville.com>
        <cover.1521779249.git.wink@saville.com>
        <cover.1521839546.git.wink@saville.com>
        <baf0d9bab81bb3a80d0428c4aaa33cf32b3823e4.1521839546.git.wink@saville.com>
Date:   Fri, 23 Mar 2018 15:22:09 -0700
In-Reply-To: <baf0d9bab81bb3a80d0428c4aaa33cf32b3823e4.1521839546.git.wink@saville.com>
        (Wink Saville's message of "Fri, 23 Mar 2018 14:25:25 -0700")
Message-ID: <xmqqin9mh1pq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wink Saville <wink@saville.com> writes:

> The extracted functions are:
>   - initiate_action
>   - setup_reflog_action
>   - init_basic_state
>   - init_revisions_and_shortrevisions
>   - complete_action
>
> Used by git_rebase__interactive
>
> Signed-off-by: Wink Saville <wink@saville.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---

I checked the correspondence of lines between the verison before and
after the patch, and did not spot anything suspicious.  The fact
that we do not use "local" and stick to POSIX shell helps a bit, as
we do not have to worry about "does this $variable in the split-out
function refer to the same data as the original?" ;-)

Will queue.
