Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E50FC1F404
	for <e@80x24.org>; Fri, 23 Mar 2018 21:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751677AbeCWVBi (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 17:01:38 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35210 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751288AbeCWVBh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 17:01:37 -0400
Received: by mail-wm0-f41.google.com with SMTP id r82so5844960wme.0
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 14:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Xrq+r2770c7K0wEiyIJQOm6yrnDLqDhRsBNtBSf4hkU=;
        b=JpogDqQjJZtlTsH9QO1Nk2mDyLTf1CY0B/U/l4DaiJob70ZlTLyBDUuHKiucFho4DX
         tLvE7zKCAVZCse31kM7FFNNWnJVDd3ZKWnu4MqgfQQQLRB3BtNn6WeQwF4mqgKvkKlxU
         CB1u3ftmHbnQe859LbZhDUu4QQUF8aQb0500bJduf/ee61UWauor3Bvz/b8lfbqIY4+S
         Dhj5IkgWhcxz1ydOcy0JfgtynrMQp9j1eVPeIsqYzZlOwjKwiM+RGPSa7s0BJ5NPooWZ
         5oQnlvekLHa5qA5v5gO8LmIc+i4Pt5gXPcmdWdvHDD0BCx+mRTYKMCh3qLIbCeSJHTcd
         0Rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Xrq+r2770c7K0wEiyIJQOm6yrnDLqDhRsBNtBSf4hkU=;
        b=g43YE5QQ+tDaMF9Z28cbzu+ZfXYozdZcBCbz6pts+yEfKiJ5tx0l0hl4xWzYvAkbLa
         VIy/3nfhxpS11/0mNgjWYwsTbGzDEiA3+XesUeBedb8ryGeew2g2yV9mkxa1Dufl5P72
         GSGRrOoQw2y/vopHDDA3CfbOpUcF0uiqQCTKkwBR6hNp0BePIvQf1DbgBVt74q/OjZ0W
         Xpnj5R9N5/x/F0XObbjJHiizo3l/W/sYnHKl/QYpHWvj+TPfAK/zWS2CfcwNi91aXzAj
         2ZNspeFopST1No4eLmHn/qoG7fVz7eE+5yMiN2Na+uWWB6/LGzUknuBHYnlqRMgiKwng
         2Zcw==
X-Gm-Message-State: AElRT7GgcOoRkqsZDMqRmI+EY4bocr6nHWKyM73syqWLACFCZmiEjtZq
        TXFjMPgEByaw+4fjpGA2+Sg=
X-Google-Smtp-Source: AG47ELteSWTrX+yvIl/mnknp6WTI1IqhUHK3L8BhEDWV1o70ntlCCUNhq+17QFCcWcOK0OG4alfpEw==
X-Received: by 10.28.64.131 with SMTP id n125mr10511881wma.140.1521838896263;
        Fri, 23 Mar 2018 14:01:36 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w18sm5852875wra.25.2018.03.23.14.01.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Mar 2018 14:01:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Wink Saville <wink@saville.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v4] rebase: Update invocation of rebase dot-sourced scripts
References: <cover.1521779249.git.wink@saville.com>
        <ed4cfdc9f31b920eae5055c3b080e2ca5b2f6e42.1521779249.git.wink@saville.com>
        <CAPig+cQG16AhLPMeOFAw1GF81oXivFSDHvQ5B8kX20YGAT_BxQ@mail.gmail.com>
Date:   Fri, 23 Mar 2018 14:01:33 -0700
In-Reply-To: <CAPig+cQG16AhLPMeOFAw1GF81oXivFSDHvQ5B8kX20YGAT_BxQ@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 23 Mar 2018 02:26:55 -0400")
Message-ID: <xmqqbmfeik0i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> When it was discovered that some shell implementations
> ...
> ECANTPARSE: This paragraph is grammatically corrupt.
>
> ECANTPARSE: Grammatically corrupt.
> ...
> (despite the run-on sentence in the first paragraph and the apparent
> incorrect explanation of top-level "return" misbehavior -- the in-code
> comment says top-level "return" was essentially a no-op in broken
> shells, whereas he said it exited the shell).

My bad, almost entirely.  Sorry.
