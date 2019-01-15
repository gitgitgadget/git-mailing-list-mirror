Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2532A1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 18:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388942AbfAOSoj (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 13:44:39 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36894 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388939AbfAOSoi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 13:44:38 -0500
Received: by mail-wr1-f65.google.com with SMTP id s12so4187627wrt.4
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 10:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=P0WQ9n3ISncO35TfDdOc9wETb7Xx+UX14Z0COGeIXzA=;
        b=epWHZeMLgdPhxFpS4aZCyXh4Q0gx+WUAGRX9OvpikQvJFmV5bTindr2XTyV5Q2skcc
         4P8KfvX8WnNI2caxAAlq48a+P10i58mQVEuorPPy4LY+/gdBXgODkOqLAHvm4btiCtlf
         /vYViF0L9IeFoHch37/KW+tqqO0cgsTIuYobXxB+lS/t6LVzrKMgxrwtN6dcb0oj00gf
         Tlfh8pAeKxMA02JVtN/xhFJvGrVUXiZ642dOy2kKb6/UbPjCRF8xU5qHWjH/PgQx1cR6
         JonsCIPeQo1Q5sR+TCaRBqSwnpFYq8gZ6I0/lhsbJnFrqtihUyEfnE6mxIwZIp/UOuxC
         Pyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=P0WQ9n3ISncO35TfDdOc9wETb7Xx+UX14Z0COGeIXzA=;
        b=FkQ6fAKpgCq8i0ac3FEYdfnAKzIPN0cpCkYRhj3pAk+rOZ6+h5DXE2JgYDFofqlAUy
         V1WbEzhT2Ewyz8cSrkbPimzS9bCuVprxZ4rGNJvcF9LlBTE7UXuLSwbh565C3hCPPp8b
         AqsvAP8H8cp0KMAtLyhMMe+Yl2tYBkdrOMtxfAUWVpDt0mGuRAKsFYvh/yBKtnspRVsr
         jT//rn9VG7JIB4hK6cJIVF4Map88HLyj1Knj2KRHjTHP/ecY7osI4x+lEJ17P25McRZ1
         VmvLiTBEqEsyrj7uOv/i3+pWNdxpy94gwY7xofOC7+Y1Iu4x+D7w/Vp7D87Xj5JO8Yny
         K9RA==
X-Gm-Message-State: AJcUukdB8Qm9tO5qZ14a91wKmL4fMKM6SfKymkw2UppVDOdxiRN9TfjA
        ZZTNHB/T59YiRGNyT8WBBjA=
X-Google-Smtp-Source: ALg8bN5nMWLWaW3IRuVlwvBS8MOKf/iMUzVwCKGbBrRfyc18QHrAnHvW4QX/yOg2Ud0R1QT9YylduQ==
X-Received: by 2002:adf:f1cb:: with SMTP id z11mr4266346wro.35.1547577876466;
        Tue, 15 Jan 2019 10:44:36 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j14sm61462491wrv.96.2019.01.15.10.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 10:44:35 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>,
        Masaya Suzuki <masayasuzuki@google.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH v2 0/2] Accept error packets in any context
References: <reply-to=20181127045301.103807-1-masayasuzuki@google.com>
        <20181229211915.161686-1-masayasuzuki@google.com>
        <xmqqef9tfikg.fsf@gitster-ct.c.googlers.com>
        <20190115014348.GM162110@google.com>
        <20190115014950.GN162110@google.com>
Date:   Tue, 15 Jan 2019 10:44:35 -0800
In-Reply-To: <20190115014950.GN162110@google.com> (Jonathan Nieder's message
        of "Mon, 14 Jan 2019 17:49:50 -0800")
Message-ID: <xmqqimypsquk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> It's handled fine by the merge 7be333a6362882e8ffceef3de830dbbfafe99995
> (Merge branch 'js/smart-http-detect-remote-error' into pu, 2019-01-11),
> though.  So I think what is in "pu" is okay, without shooting any series
> down.

Yeah, I think I wiggled that topic branch after getting a
clarification from Masaya on what is going on, so what's on 'pu'
should be in a good shape.


