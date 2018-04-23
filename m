Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 741C21F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932745AbeDWXlM (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:41:12 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46127 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932697AbeDWXlK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 19:41:10 -0400
Received: by mail-wr0-f194.google.com with SMTP id d1-v6so45658490wrj.13
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 16:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=9kDC4rkHYyGldvtSnm9RYJ8Qs/K3bFDWKB9WpOPYZus=;
        b=XsvrIj0k+88dK4jwPytB3qHFov2bsvh4QH3eTB7rWQEp64iJIID4y4R1qM+tr4L16A
         9iCJPE3oGA0J9/XJoWYjBagDZHAObJYf0Y8WwaLyobb4HgoIcpmzmbhoxco9BAc3FOeT
         3q4JoBdx6S8QTYmwM89fczCy8zbeqkl2iF5N4qmdq0ifaXbPjTqRAsU1IC59XmyoBLRZ
         2f6oxr7EMMOiOhmSKxLFZcD18kUwdQmgqPp7x1tcQsSqxZfwpk9H27joF+I/h19yCgoK
         g+L1YB9vIjdfRIE2mF1ydko3JmERFN2AWEE7uPNybBEYBhXAaZ2ykORtPFE6ssFC1XOI
         eldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=9kDC4rkHYyGldvtSnm9RYJ8Qs/K3bFDWKB9WpOPYZus=;
        b=WZL5WtoN8Gz0V2Ef4oyj8of07+qVhoJnmLrqGZXWWXsNAvmr8QLcqZXBADnlj3hWjb
         dbIZ0BGzingD8pXd8DcPExjz+po7SCu5+831pvSAg3q+H8VghYe6cunqWth/D2Nkedtt
         iYuS5StWgUtQ5SL2ag1qmoQEo86rrGTZoWjQW3uOaw2lsZqlKE3whw54uIfHBAXldXxh
         vSzzUWBMAeFt5s9M82YEjF+34s3ZQO0PhPQotC17mQ1j02ORmh/e3ycopPy7MK9BByCX
         S4HEHoaRIeJ5lJquFiOb+TggPMIGCVM3r/0uw8NsW+muqrFbmfn6aH7txb6mTmaCi5mQ
         qPAg==
X-Gm-Message-State: ALQs6tAILdH4ciWJ+GkpediYm9F2UotI2eHWqtk/bGhBvXPo9kxQblmC
        Frj7pj4aSHL97bU5tKWjFaE=
X-Google-Smtp-Source: AIpwx4/8jRoVe59YAW78xe+2PSFbbM/Li3WwjL5YOrUdbkVLZr6HCYsnSDSORQ1jAD1iUSjvHx9Uzw==
X-Received: by 2002:adf:8466:: with SMTP id 93-v6mr17279839wrf.189.1524526868617;
        Mon, 23 Apr 2018 16:41:08 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 55-v6sm28848585wrw.52.2018.04.23.16.41.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 16:41:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robin H. Johnson" <robbat2@gentoo.org>
Cc:     =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
References: <20180413170129.15310-1-mgorny@gentoo.org>
        <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
Date:   Tue, 24 Apr 2018 08:41:07 +0900
In-Reply-To: <robbat2-20180423T200557-844830385Z@orbis-terrarum.net> (Robin
        H. Johnson's message of "Mon, 23 Apr 2018 20:07:04 +0000")
Message-ID: <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robin H. Johnson" <robbat2@gentoo.org> writes:

> On Fri, Apr 13, 2018 at 07:01:29PM +0200, Michał Górny wrote:
>> Currently git does not control mtimes of files being checked out.  This
>> means that the only assumption you could make is that all files created
>> or modified within a single checkout action will have mtime between
>> start time and end time of this checkout.  The relations between mtimes
>> of different files depend on the order in which they are checked out,
>> filesystem speed and timestamp precision.
>> ...
> Junio: ping for review or inclusion of this patch?

I personally did not think this is a good idea and not worth any
code contamination with calls to utime().  Is there anybody sane who
thought this was a good idea in the discussion thread?

