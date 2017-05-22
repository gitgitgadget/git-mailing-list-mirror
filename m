Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 571E320281
	for <e@80x24.org>; Mon, 22 May 2017 08:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbdEVIsj (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 04:48:39 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:34546 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbdEVIsi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 04:48:38 -0400
Received: by mail-pf0-f177.google.com with SMTP id 9so75866137pfj.1
        for <git@vger.kernel.org>; Mon, 22 May 2017 01:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=82RTH9774sFAXZ9aVzgHafJNLif85uLlxBGsCWRqoIQ=;
        b=DTFzPY32oFnVrMzDP/nY+C5bOdF9gvJcbtAaXkQxwvXhMcvI0Lt15ue2IaIk6JSBT3
         76stmy/nLOoNdXFrrV+3+2mt6+L4BI6y/Yb+TQyEbiEFqJP7nJUjID3/FjseKXDmGaIi
         jCOH8SRHpIwmXAYSsyzD5Ya1H236XOWmTQSAYiZnv5IFShqHjXPJe4+9cOnnO7xzmuuE
         byrdcmnOXhCMkxNjeq3FKcX+uWv5G4btf/sfTZ7iQ170vED6n4txw9lB/QtuvNQNEZ8g
         DYdMGJXkxpaj/T3+xGDMKfrkLxuyxmlyjHSdcblmyhCxs4nRgVYuzbc/z5PtRiisKYZX
         mrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=82RTH9774sFAXZ9aVzgHafJNLif85uLlxBGsCWRqoIQ=;
        b=OIgtya9J2wPJtRnrDhXqWh2+NJE8J113AfYjoInRHXMsBxCorvypbpnlmaDkBaGe8E
         yBf/DhzKpprSPx6mms/ItmC2O1UDDXL+DZMKjiz6/GWc5A7JUUX+Uj+XUbjwdAgiWrlk
         oz0CP//dspxt55nbnivXp4y8oqL2JoH0CW/Ppc4zDiDbEgFbvOSXJvFkSm9LL5ubgx1t
         2SpILP9Cy2Tl7stWykXOXzDwQEx2sEbNik+3a97x1MzUz1askDh//YmWm8vCtf0NWjPD
         tteShxSoGy3WybW8HK4+BjwlX29YgFlKDW8MdSpKnt3uqUlNJOTk+rH/NPzDlEqKd/c1
         2wbQ==
X-Gm-Message-State: AODbwcAxmkaD+RbaO/qhx7fefa07fNzB339yBQIefamAp0MqGToY8ci1
        t6r+OpxVYzusaQ==
X-Received: by 10.99.172.9 with SMTP id v9mr24200817pge.60.1495442917361;
        Mon, 22 May 2017 01:48:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4439:f55c:c49b:d0dc])
        by smtp.gmail.com with ESMTPSA id b65sm6669934pfl.48.2017.05.22.01.48.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 01:48:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>,
        Michael Kebe <michael.kebe@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 2/2] sha1dc: optionally use sha1collisiondetection as a submodule
References: <20170520115429.12289-1-avarab@gmail.com>
        <xmqqpof3srw4.fsf@gitster.mtv.corp.google.com>
        <20170520115429.12289-3-avarab@gmail.com>
        <xmqqtw4dptek.fsf@gitster.mtv.corp.google.com>
        <xmqq7f19ppy6.fsf@gitster.mtv.corp.google.com>
        <CACBZZX52etn7jjT13tDfiQL2ondBAK8G7MuLvG5bmm8Fmn-FwQ@mail.gmail.com>
Date:   Mon, 22 May 2017 17:48:33 +0900
In-Reply-To: <CACBZZX52etn7jjT13tDfiQL2ondBAK8G7MuLvG5bmm8Fmn-FwQ@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 22 May
 2017 10:27:33
        +0200")
Message-ID: <xmqqfufxnuou.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I thought this should have something like this:
> ...
> the right thing, even though this is set unconditionally. There must
> be some Makefile magic I'm missing here.

The magic you are missing is that to ifdef in $(MAKE), a variable
that is not mentioned (undefined) and set to empty string are both
the same.  You'll fall into its else clause.

> But in any case it would make sense to squash something like this into
> your patch:
>
> diff --git a/Makefile b/Makefile
> index 8d33936a12..4d9c49ae17 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -148,7 +148,8 @@ all::
>  # sha1collisiondetection shipped as a submodule instead of the
>  # non-submodule copy in sha1dc/. This is an experimental option used
>  # by the git project to migrate to using sha1collisiondetection as a
> -# submodule.
> +# submodule. Supplied implicitly if the sha1collisiondetection/
> +# directory is found to be populated.

Yeah, if it is populated, defaults to true, if it is not, defaults
to false.  Either case can be overriden from the command line or
config.mak
