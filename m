Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9648B1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 18:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965995AbeF0SxY (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 14:53:24 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52686 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965942AbeF0SxX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 14:53:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id e69-v6so4033856wme.2
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 11:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dtU1C2rPxTGrLjKllvKJNgBIWvOM/aEC8F1SM2s/COY=;
        b=iObSnNxuXFaz3Yk0LosBvZFSlCUtC9ZRyQlwRndQKDU4NIRQXGTaRKDD7TuxxYxZyq
         6g6ESXtM8sY+ABC125TXAqI0uBNmDB0rkB+UO135Mc8prPxlp+1Gc0bURTmyXfmAR5EI
         Np4bSWQdD9EqU4kynp0P/u5IYHUx1SFbg2rP52i0J+kBBcAtDEM3nTRZgc2EWYpVsfJF
         TdALvpDfPAHaRS4Rfh09tgBdBVoP48NwrMYLYn7h+eKDDqAgyQyQ1O2znPTTg1ezmPoX
         u6BGou3jBpD9EyDtk26Hxc8CIkxfXPVqnny/jooPZ+d0ntC92bKkqTapom8cNR0AmnkT
         rewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dtU1C2rPxTGrLjKllvKJNgBIWvOM/aEC8F1SM2s/COY=;
        b=eEnEqNjpm/fbJ0x/8i7WXmiMXjfSRksTPAqSu+Mp+0qlwwUiW9reJrMn8G8I6XllBp
         Rhg5Ekdu2FJ3ggxWmKz7i3qgcQIm1bWxxJvhUyE3v3itTwhqobP5xBzHhK9UXhFUjwMs
         /Yy7PTY01KQo6pBvnyo5OdLgxuHKMtabM8DZyWagb6NsBRLidPcF8OkaLdcZeCxCiRcw
         yF+fDCFHASSCW3EVb1no5LhdcAehG3/BZb0Fi05GpZeHG4AZRgx3m1JiPlvyhYYCI2UU
         cvfieYzu7oo2fbzmjok+S6r76z/VwxAEGpxqrF7mUklEbJY8fOkcsx28TBqZE3Zp1jW1
         G4Jg==
X-Gm-Message-State: APt69E2XOee0JBo6jk3NghwAtCopuUAw6lWFRgK4vnzVTYkpvojt+4DF
        MczqbzPgoBLYJGMNUbw8uDSjBaRe
X-Google-Smtp-Source: AAOMgpeMnl9Zi7PzCJhN7wOsKQ2AincFYKlGHTxDIjBWV2c4+oJxnXc+Rhsmh+3njO/qxDpmPCYflA==
X-Received: by 2002:a1c:6485:: with SMTP id y127-v6mr2584777wmb.38.1530125602285;
        Wed, 27 Jun 2018 11:53:22 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 17-v6sm2859429wms.27.2018.06.27.11.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 11:53:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, sbeller@google.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v5 2/8] upload-pack: implement ref-in-want
References: <20180625185332.164142-1-bmwill@google.com>
        <20180626205438.110764-1-bmwill@google.com>
        <20180626205438.110764-3-bmwill@google.com>
        <xmqqsh59i6jx.fsf@gitster-ct.c.googlers.com>
        <20180627180557.GG19910@google.com>
Date:   Wed, 27 Jun 2018 11:53:21 -0700
In-Reply-To: <20180627180557.GG19910@google.com> (Brandon Williams's message
        of "Wed, 27 Jun 2018 11:05:57 -0700")
Message-ID: <xmqq7emkf4da.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

>> > +	* The server SHOULD NOT send any refs which were not requested
>> > +	  using 'want-ref' lines and a client MUST ignore refs which
>> > +	  weren't requested.
>> 
>> Just being curious, but the above feels the other way around.  Why
>> are we being more lenient to writers of broken server than writers
>> of broken clients?  The number of installations they need to take
>> back and replace is certainly lower for the former, which means
>> that, if exchanges of unsoliclited refs are unwanted, clients should
>> notice and barf (or warn) if the server misbehaves, and the server
>> should be forbidden from sending unsolicited refs, no?
>
> Ok so should I change the server part to "MUST NOT" and the client part
> to "SHOULD"?  And I can add code to die when we see refs that weren't
> requested, but i feel like if we add an ability to request a pattern in
> the future this will completely change, which is why I currently have a
> client just ignoring anything else.

I did not have enough information to give an answer to "should I do
X?"; that is why I asked these questions prefixed with "Just being
curious".  I do not quite get a good feeling that I now know enough
to answer, still, but let me try.

If we anticipate backward incompatible changes between this early
WIP stage and the final completed protocol, it would be GOOD to make
sure that an early WIP clients/servers fail when seeing the other
side gives them something they do not understand, no?

So...
