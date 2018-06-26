Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51C9D1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 21:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752113AbeFZVmg (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 17:42:36 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:35444 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751616AbeFZVmf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 17:42:35 -0400
Received: by mail-wr0-f177.google.com with SMTP id c13-v6so8706015wrq.2
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 14:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MjS9kc2TztTjZ/V6mmdUrsbFVHBqX/JbWm9nGqbOPk0=;
        b=Pno0PP0JJQXVYx8hfhq+dASeIEk0BL5lQXvAB4OyGpTbMULNOSPaf0+SW1kbQW1mZq
         6QsCd+WkVFTv0K85HSgKBP1gitJvo6xXxvey7SOpLFe4CPojaa9t9p+XPZra7GyELaE4
         tm1+s3xH/4Lp1Rn0guVn8PkNMLEPvwajGwm9Rp9IrM0ZAaNOb1FJNo0Vov3sCQHFop7B
         2Dxxu81Bswx9DxtcKwyqY2l4mWJju41fNJ14s9BmdE6eG32bXA7CFD520+gMFAGivLm9
         I3U4jUDCAuu7s9RBP6liV4AqiyNoQK8x1XZ2DDKGbkBt0L9/AILi82kkkCXWRq9/ENVA
         MmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MjS9kc2TztTjZ/V6mmdUrsbFVHBqX/JbWm9nGqbOPk0=;
        b=rK9S1WVUzKJcmbSNoOjxmI/LEH+U/AI59aprHyu6VOCQ23WV3hTFtCEkJiS0pPd7vO
         u6dIjIFxeiIab8K94DdF1ulUgWkO4r6Bp5DAn4dJdw6/hbjG/7bfwrtbbOxA9vZa9xXM
         z+/YCAECXvyMqefnQjjDETrO/VgctkK7+tAPyhCAnuwkGqrn7i61/VKfBes+AkjsKc+3
         A5RuDOFXll023rJlCRpye6MeQEv0Iie3pZfRy6a+RWzfqIYLSwM+k6frN5UV3zr/mJqD
         cYShO7O1TOkjAGhsBteBSvUAXIS68LHLwWV6p+CmAYWpxR4LKonvNtoJhE4uWsD37hgf
         YJow==
X-Gm-Message-State: APt69E335zetNaTnMV2ldxxNl/PO3UDH34dC8TJNodKvqs4Dam/xGoqq
        LOz6Fsr7cZijcVGIthXUVM8=
X-Google-Smtp-Source: AAOMgpdxTY7g/om9V7rbj7xZT8mnorO+O8uaFaqinV2JgnX7KJUsGra3ga+Jg5OSGgo54/Ic4A5veQ==
X-Received: by 2002:adf:f98a:: with SMTP id f10-v6mr2825245wrr.105.1530049354204;
        Tue, 26 Jun 2018 14:42:34 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j10-v6sm3590179wrr.47.2018.06.26.14.42.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 14:42:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, sbeller@google.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v5 7/8] fetch-pack: put shallow info in output parameter
References: <20180625185332.164142-1-bmwill@google.com>
        <20180626205438.110764-1-bmwill@google.com>
        <20180626205438.110764-8-bmwill@google.com>
Date:   Tue, 26 Jun 2018 14:42:33 -0700
In-Reply-To: <20180626205438.110764-8-bmwill@google.com> (Brandon Williams's
        message of "Tue, 26 Jun 2018 13:54:37 -0700")
Message-ID: <xmqqfu19i5rq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Expand the transport fetch method signature, by adding an output
> parameter, to allow transports to return information about the refs they
> have fetched.  Then communicate shallow status information through this
> mechanism instead of by modifying the input list of refs.

Makes sense.  Would this mechanism also allow us to be more explicit
about the "tag following"?

