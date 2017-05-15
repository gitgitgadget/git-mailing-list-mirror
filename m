Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47A95201A4
	for <e@80x24.org>; Mon, 15 May 2017 03:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756789AbdEOD7v (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 May 2017 23:59:51 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34963 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754028AbdEOD7u (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 May 2017 23:59:50 -0400
Received: by mail-pg0-f65.google.com with SMTP id i63so15282554pgd.2
        for <git@vger.kernel.org>; Sun, 14 May 2017 20:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hnwH5f7xrLH0KMPQzk9BFWDD712cImXbmoJJwWtOZwQ=;
        b=R0O/6zzzdczXF5yDIQa9HJRa2ax9xkr8hUeWQQvZ4EDLWNEF/d4/VfKy6STJU37J+c
         33aQXUgcfEjzg09dydYUGUevH9BY3k4amOeAPH380K0/LZP4aGr15nvwcU8Xps3it5H5
         Xgw7vtcmYxx7AzmxgbnGd69oCscdnp36lRMcY19lO1VHMkOzT+KVJuFPliibZW7v0Al9
         bY7wo+oEd9JOqtvKUyjM6QyCDFuysCXvxnFUwmFKG2oSRc9s0+rphqrRu735wlA0H7Ts
         AxfdPeWZZXPjISJzbAfIcn5fe0qm3tCmPjGOyHA//cIolfM9NxxU6w+C/IDFc0E7N6I9
         QNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hnwH5f7xrLH0KMPQzk9BFWDD712cImXbmoJJwWtOZwQ=;
        b=bGYGOFCzx1UCj3VvQxnHsnhPBUtKfdsXv3yi/q0ARuEX9LtrASH1n7jnIKGaZq8ZaW
         67Ixi7I09uWTp8RtiwviE8trV6Rdazd78nrw6KmZue1Wi6iSbJRbChpvOqK7ZkAfyqen
         fX451aSq02QapeT1G6il74z0/PXZ51PjPmhJwtfIEJUTMgyTiXMOHNWkcmnfWoJmrNAJ
         WkIvwsca2ysU6tpl7lRD3kzoMv5M/8wWbiWaZlRNwRmatbTYUlGyqCVppL4VW4dczwxi
         P+hA1+CRUAxUC8IusPLKz+tTLdF65CDofCAda9ZWslxMtnGnh5wowrSuFguTN8bzxWHQ
         AsXg==
X-Gm-Message-State: AODbwcBHBVoHpkMh7MXn1wm9VOwhPgI+CEUivZRftxUnyevZ5bESIu6c
        WSkbR1hKQhEJNQ==
X-Received: by 10.98.223.195 with SMTP id d64mr4026595pfl.226.1494820788641;
        Sun, 14 May 2017 20:59:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b170:f9ed:5f25:7ab5])
        by smtp.gmail.com with ESMTPSA id f24sm16004242pfk.66.2017.05.14.20.59.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 14 May 2017 20:59:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     xiaoqiang zhao <zxq_yx_007@163.com>
Cc:     git@vger.kernel.org, viktorin@rehivetech.com, mst@kernel.org,
        pbonzini@redhat.com, mina86@mina86.com, artagnon@gmail.com,
        avarab@gmail.com
Subject: Re: [PATCH v4] send-email: --batch-size to work around some SMTP server limit
References: <20170513015726.20281-1-zxq_yx_007@163.com>
Date:   Mon, 15 May 2017 12:59:47 +0900
In-Reply-To: <20170513015726.20281-1-zxq_yx_007@163.com> (xiaoqiang zhao's
        message of "Sat, 13 May 2017 09:57:26 +0800")
Message-ID: <xmqqfug6wz0s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

xiaoqiang zhao <zxq_yx_007@163.com> writes:

> Some email servers (e.g. smtp.163.com) limit the number emails to be
> sent per session(connection) and this will lead to a faliure when
> sending many messages.
>
> Teach send-email to disconnect after sending a number of messages
> (configurable via the --batch-size=<num> option), wait for a few
> seconds (configurable via the --relogin-delay=<seconds> option) and
> reconnect, to work around such a limit.
>
> Also add this two configure option for git config command.

s/configure/configuration/; "for git config command" is better left
unsaid (too obvious).

> Note:
>    Re-authentication will happen every $<batch-size> messages, so it
> will be much more acceptable if you use some form of credential helper
> (e.g. the 'sendemail.smtppass' config option), otherwise you will have
> to retype password every time when asked.

I think this deserves to be in the end-user documentation (i.e. the
part of your patch that updates Documentation/git-send-email.txt).

Other than that, looking good ;-)

Thanks.

> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
> ---
>  contrib/completion/git-completion.bash |  2 ++
>  git-send-email.perl                    | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+)

