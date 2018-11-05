Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ABC31F453
	for <e@80x24.org>; Mon,  5 Nov 2018 05:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbeKEOcS (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 09:32:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37897 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbeKEOcS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 09:32:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id l2-v6so6703385wmh.3
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 21:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IytKblb91tzKEK9ARQmeoSkaZtWtyjQMyvYi1SX/71M=;
        b=aBcMQR/5MdGWrOsQGocjEz8if/wuWB91jfp49e7sdW0P016k4AMNjyIaHXAtL7CJ0q
         ckAJX/r7riFh1rZeVx3rQMv8tXv4nT7sfdC1q2BryJqJklToVLN+TkVz2hySJOsAFJTe
         gGKfO5yEV17XMI0NW71u2udFwaSQWslGTYw5hSaSieASLq1QWzCLGUICJGwc3JDBqolx
         WGYcL5YyV7XpIaRw+EclE5H/bLlQtxSL8JAkSV+U4sSrG9xAbbMEBP1lTlLCenRcKXfO
         NWhIR+r403d0Qm9P1KIiwobsLq3YeO4M8AC6SLNWkdVxbsQtB2BPqUhnlsRJD0s/BMfW
         X0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IytKblb91tzKEK9ARQmeoSkaZtWtyjQMyvYi1SX/71M=;
        b=EXYbdB68h8HFTu3Ngi88IyONx6fFWv5QXB2FR7MAr0ql4vxjrCRggvbjdG7Kc9b5Qt
         wUscckfNxrGh8dDCqdlVuC+HO4VL24H7XowI+y0/VFnJVX30N7JBO0TjfUQ63u9z7jVM
         2YwLtNBhnwQ02P1zbWjQS+W1ggwz1gSAm6Cj6z6LiOTUoKkGlzeSlK4Mt1dWzcjQN8r+
         DAmf7+PJY+4JijLgnyHx8CjReHs3T4APXACefHCwLZJJyrS7/Orq+l6ujj52bvcYeDzl
         CVYOZmdwjopNMzXY2t1WcpXZiSCtdDSDzg3Itz61UmdeNzJoK29fm55WaP2F7bloAbNX
         MMWQ==
X-Gm-Message-State: AGRZ1gL/1oDL4cS6cYiktPQQtpKljup748C2R5vyRVlqFF7uH2SUMqTG
        OvtkvN4J47EHnIQZlyiBKfs=
X-Google-Smtp-Source: AJdET5dShIBu3Bi1Qz8yGhIVaH11TA/6DyvIv6DjY49RT1ZruTBJ4Y7suCsSxokmwSdPb2MiE19+xw==
X-Received: by 2002:a1c:9182:: with SMTP id t124-v6mr4669877wmd.8.1541394867629;
        Sun, 04 Nov 2018 21:14:27 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j40-v6sm13459288wre.48.2018.11.04.21.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 21:14:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>
Subject: Re: [PATCH v2 2/5] pretty: allow showing specific trailers
References: <20181028125025.30952-1-anders@0x63.nu>
        <20181104152232.20671-1-anders@0x63.nu>
        <20181104152232.20671-3-anders@0x63.nu>
Date:   Mon, 05 Nov 2018 14:14:26 +0900
In-Reply-To: <20181104152232.20671-3-anders@0x63.nu> (Anders Waldenborg's
        message of "Sun, 4 Nov 2018 16:22:29 +0100")
Message-ID: <xmqqzhuohzrh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anders Waldenborg <anders@0x63.nu> writes:

> +				else if (skip_prefix(arg, "key=", &arg)) {
> +					const char *end = arg + strcspn(arg, ",)");
> +
> +					if (opts.filter_key)
> +						free(opts.filter_key);

Call the free() unconditionally, cf. contrib/coccinelle/free.cocci.
