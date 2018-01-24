Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 749AC1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 20:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932146AbeAXUwb (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 15:52:31 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36334 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbeAXUwa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 15:52:30 -0500
Received: by mail-pg0-f68.google.com with SMTP id k68so3556792pga.3
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 12:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=547NRZK2JLv8BxgoIi3BwJ5PT18XPXP9jhtaJqqXJYo=;
        b=uNv/kcXPM/b4AhVjf0VXz6jyqTdOe6FRP9ZIwgwshGAuwayKaxjJWcQsa5OTpE3yss
         A/o4hCs1ZquryK4oxGyCu81CfvcUc4ocG/MmoOjfsTd8EBwQ9mCani0BDC1n0F9vqcFF
         jRmIgP+K1mXXqRwi1F7vO5TJ5DoqzCDOvARiObBzYceARpiAGp+s+9k3oWxetadc+fjO
         gbex3COScClj7x9Ipf1Ku80t9Lywiv/Z/SrxgpkilMmsRrvsQ1Zw5Q9nHhbyn2Kn4A+5
         OsVDKgdrkVukpHDMznIA7PXYbnWmLBTv98L15aqNC5wJO/Wa2TERqLc7/DQBnhKY3+cI
         UfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=547NRZK2JLv8BxgoIi3BwJ5PT18XPXP9jhtaJqqXJYo=;
        b=lHHDD3w52Djjc6BxrhHoAGzG6S0wZeWu2g6DCjmc/f5At1fspUB7eU6fAjnO2CrJum
         5ohGnAYv6Ja1eJEaaKZBt+Njv6nsQLJEVG5V5dIbm3I4cY2YZUzbDukvdJayPzCCiOMX
         XZKWNiq/lVfO+dOEJcnm82G3pfEnsJTV3gj0yQnZXBUH+wFNwlyrUp4yBcDw/rh9/20+
         8tbk46k8UnupGvRr6cBuDXO5pDshzin8mEs/0KnmkxURnJXS4RFRxSCK1Z08j4lZ9kwz
         f+cfD9vovexpw4gSSMbxm0qY+RRu+tzYDT+nI3gC5CUBLvsP+FNpAOLYnV5rKsZyLlcl
         fnGg==
X-Gm-Message-State: AKwxyteAwarTEu5rnG8WKxoEA0jLfc+qmcDeLBt9fVoL2OrGpefcUeCa
        dPhLfdT3diDU5Wa0wVCwLSA=
X-Google-Smtp-Source: AH8x227bat94zURTIfsuhxJi67m3rf/Ro/Em43r22xv8QwzU6kxCiQ8u2kJoJ3Voekc0XMVyEyqrCg==
X-Received: by 2002:a17:902:7883:: with SMTP id q3-v6mr9297069pll.5.1516827149899;
        Wed, 24 Jan 2018 12:52:29 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:69e6:5f42:e334:a0e2])
        by smtp.gmail.com with ESMTPSA id 13sm11952813pfk.93.2018.01.24.12.52.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 12:52:29 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Michael Giuffrida <michaelpg@chromium.org>,
        Michael Schubert <mschub@elegosoft.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 11/11] fetch: add a --fetch-prune option and fetch.pruneTags config
References: <20180123221326.28495-1-avarab@gmail.com>
        <20180121000304.32323-1-avarab@gmail.com>
        <20180123221326.28495-12-avarab@gmail.com>
Date:   Wed, 24 Jan 2018 12:52:28 -0800
In-Reply-To: <20180123221326.28495-12-avarab@gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 23 Jan 2018 22:13:26 +0000")
Message-ID: <xmqqo9ljc73n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

>  git -C {} config --replace-all remote.origin.fetch "+refs/tags/*:refs/tags/*" "^\+*refs/tags/\*:refs/tags/\*$"

Shouldn't the last arg be

 '^+\*refs/tags/\*:refs/tags/\*$'

instead?
