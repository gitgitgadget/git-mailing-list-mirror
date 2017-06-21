Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BCD120401
	for <e@80x24.org>; Wed, 21 Jun 2017 21:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752304AbdFUVwe (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 17:52:34 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36284 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752225AbdFUVwd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 17:52:33 -0400
Received: by mail-pf0-f193.google.com with SMTP id y7so33072601pfd.3
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 14:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GXauLoIhODXELpmqVJvKfVYpU1Fkfr64cvZF0WmIg70=;
        b=E4JuETaXEwAfF0gxmagMzOxNrXaa86YqYd88qviwO5jEkQVDxbxDO5ZrfWjpN9SuYc
         X+WWHJAVqRddEPhj5aCDRPLMu9ruSFJ4Xghz3Yzv62hTx0s442EVmcyPYBmP+0JMPT70
         rPfJc95G6uRJ5crWpYQRIlMEY/zLxmEGuaIj7d9yW32Zew055Y5b7xg6kE8vD3bhAzb7
         haQ2GCfcPQknGRVkTbWYHu/NsOiKcrH4l8sXlC7g8gUq2yYBYkqYsF7p4+oqFATw52Gr
         aABQInEm8Wrye4mxwmwoBx4h7dIyKjCNTWOiWh0noHJ6dmxuq22RfH6zj6SBsG8mTjwv
         mNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GXauLoIhODXELpmqVJvKfVYpU1Fkfr64cvZF0WmIg70=;
        b=kfVPT65tk8HIdDi3zGNtOUiSOMxUO8gDK+20/JuD2lgFNx2/u+Y+6mo6y6EfMIy5Bz
         q+PdmxU6/Nx2JtwA7KktelfWirI0nK+dvFg/35L10dsQjOxw2wH3qCdoBizQoVHK5cW7
         1VTi9seC5/prGXQLSxk4nWR038nooYDdKDdcwwkWeeiFOylpJdbxLqEyfcFdmcs4iMaf
         I6fy9Og+h0fXKi1uw/uq8FniTNwOHmWMvP4VxpP00Zbt2NBZGlmMg4jyYeK9+FR6vEns
         +b25v9vc2gx5O7mmImNmcKwjsPTfSU7tb3BX9c7T2PBcix0e4K1zDS9Z/zAcDGvN2dow
         E2eQ==
X-Gm-Message-State: AKS2vOyiOyssxfxiz0esV4Q3rwOZQLQperL8b5Yuj64b/wzBZWgOC6KE
        Q8RfpEinAug1fA==
X-Received: by 10.84.230.134 with SMTP id e6mr43421490plk.256.1498081953082;
        Wed, 21 Jun 2017 14:52:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id f10sm19309523pfd.69.2017.06.21.14.52.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 14:52:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 04/26] diff.c: introduce emit_diff_symbol
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
        <20170620024816.20021-1-sbeller@google.com>
        <20170620024816.20021-5-sbeller@google.com>
        <xmqq7f05p1z7.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYUpJxX-wBU=ALPgJwVaA8h_iJRtAu3T7p4J7qmy=U4dg@mail.gmail.com>
        <20170621214551.GE53348@google.com>
Date:   Wed, 21 Jun 2017 14:52:31 -0700
In-Reply-To: <20170621214551.GE53348@google.com> (Brandon Williams's message
        of "Wed, 21 Jun 2017 14:45:51 -0700")
Message-ID: <xmqqlgolm2jk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> I don't think this is strictly enforced.  If you look at grep.h:197 the
> enum 'grep_source_type' has a trailing comma.

OK, so we now know that at least since e1327023 ("grep: refactor the
concept of "grep source" into an object", 2012-02-02) we haven't
heard from anybody whose compiler fails to grok this.

Perhaps we should start pushing for C99 features?
