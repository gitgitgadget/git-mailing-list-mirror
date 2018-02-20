Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2346D1F404
	for <e@80x24.org>; Tue, 20 Feb 2018 19:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751678AbeBTTDZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 14:03:25 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44926 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeBTTDY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 14:03:24 -0500
Received: by mail-wr0-f196.google.com with SMTP id v65so17380775wrc.11
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 11:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NFbmvjfzgnOsR1DuKzXkIhuauHN1mf86ut0B6t/rhk0=;
        b=uVqWNOT8snKD93lBS3cp8ltKWeLPKPEofu6en4ns6SA89ZhtMua5+J4Hm72qCREq2w
         vONEckneL+H3dh6ZmO/AZoY/f8o2YwRuxLfOgMfx60h8TFYzZgApWofLXExVPdQHTMRu
         Qn/JCO2Q7ZRdVsvLtMHbXnoF95k8jdd/xCNwMRoVF14rOd9bvc5MxTk0mwyZUIdi/3CL
         9NcvhXRjTpEDDtIQjQJPJnB0cYnSNVnn78Mwl1YQIX1xNt6Nt+hUt1w5hyqq7uQ37PRw
         HK0SEHQHhSbUCB+nw3TvxMwfGEujN9I7oCIwQXGUkrQbIuIFqJ/j/w4I88xKH6fDg2Ie
         V7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NFbmvjfzgnOsR1DuKzXkIhuauHN1mf86ut0B6t/rhk0=;
        b=L9zkiSjB1qZpIzlIgDZUInj5Ubdiyh2/UFq2cBpLlBsj7mqhnWQouCiTzwlo9PLLUb
         ImO4drVCV7IHmyqPOnWSobLdHHLB0S8kIz3s3ZqekH6qKfve9cVSdSA2/uifMDIPtbg2
         rX/QsbkUIK4t4Z2G8B6LB+veP5dikLZnCNyJi2f88yiWeQenscwJODKOrI367LdusQUh
         mX1Ktj0wOJct9BtlJ46MwuQlNufSoojTdD5V4El281OMN/HHyDa21JwfXWfo7a+TTQiQ
         TAAf8KV0uCgwy6XGpMuVNUh2FhB7ObOuqEO790J6Edj6judRQiMloP5yWPQQ52m+WdGG
         av+A==
X-Gm-Message-State: APf1xPDm9cyaSc6lVOdeQ6VTBoMxXfQU74o5G3d88bRi+00+6yYAhUhX
        uuythOBKZiQtNwuO/6jA7KOYxhlj
X-Google-Smtp-Source: AH8x226TwxxW85+tbh/qDFuK4lMvTprwIvBuM0q8e62hf0Do/egB/i7uXO16NhUg/1pT/7Mzo8T8jA==
X-Received: by 10.28.109.148 with SMTP id b20mr39637wmi.92.1519153402828;
        Tue, 20 Feb 2018 11:03:22 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l9sm45737379wrl.1.2018.02.20.11.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 11:03:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com, pclouds@gmail.com,
        sunshine@sunshineco.com
Subject: Re: [PATCHv2 00/16] Moving global state into the repository object (part 1)
References: <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com>
        <20180216174626.24677-1-sbeller@google.com>
        <20180216223404.GD216564@aiede.svl.corp.google.com>
Date:   Tue, 20 Feb 2018 11:03:21 -0800
In-Reply-To: <20180216223404.GD216564@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Fri, 16 Feb 2018 14:34:04 -0800")
Message-ID: <xmqq371v4h6u.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> For what it's worth, I think I prefer v1.  I put some comments on why
> on patch 0 of v1 and would be interested in your thoughts on them
> (e.g. as a reply to that).  I also think that even if we want to
> switch to a style that passes around object_store separately from
> repository, it is easier to do the migration in two steps: first get
> rid of hidden dependencies on the_repository, then do the (simpler)
> automatic migration from
>
>  f(the_repository)
>
> to
>
>  f(the_repository->object_store)
>
> *afterwards*.
>
> Thoughts?

Are we envisioning the future in which one repository has more than
one object-store (I am counting an object store and its alternates
that are pointed by its $GIT_OBJECT_DIRECTORY/info/alternates as a
single logical "object store")?  If not, doing f(the_repository)
migration, stopping there without f(the_repository->object_store)
may perfectly be adequate, I would think.


