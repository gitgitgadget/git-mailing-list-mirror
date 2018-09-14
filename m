Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71E9F1F404
	for <e@80x24.org>; Fri, 14 Sep 2018 21:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeIODK6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 23:10:58 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:34703 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbeIODK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 23:10:58 -0400
Received: by mail-wr1-f49.google.com with SMTP id g33-v6so11947324wrd.1
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 14:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rbRHO0q7imCApHsPNLGE5bfc+bzIF5CzrBC9SmBXNmw=;
        b=ITSa0pNQObwb2LDbW9CL47ezK2F+X1fHyogz+8EvmXqs1eY54M8oBeTjUbPoLd+QsZ
         kbVqkfFeqGwPM3I2pNtec8K8ej0YENk7tz77otbEFpotOTYOFTnWfaEnBkNi34f7elf9
         yradkowZ8bzJCVjC1LXZI+V3UAZxYeu87coIDyiHWw14Xmz/OVr+8h1O+vIci3+gxyeN
         vHC4VSn5WwrE8qNoSnLiiEqA0NqqdPAH5wmZfkP2l4Ev+HsVfZC4m1RykggifG7h1md9
         bmick/zQjCH32wygnEh8VP25wb13DMdkg26hiBVt886NashYZjVj4FDXmxBxDiQACYeT
         Q+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rbRHO0q7imCApHsPNLGE5bfc+bzIF5CzrBC9SmBXNmw=;
        b=LWoAoStY3PsKVekCniJ2T5Gt5R8Tj+hzrnlprA2VTHopbMkW+63DYiVry54AnisR2k
         1jYlXlR6mzbvZMp4brJSEOFJyGWU9411XwL4Ot/lNs+pWG8Nzvlga8L0v+1W8pPeNChW
         xE4G+qc/50GXbAyj3KwmHKEbPLVk1cxQYVXs24dcf9RsLKO9lM525zITaT1X9HS8zSTi
         Ckt/x8bTyiJK1m668QULxEP07mHv4HVIB7aF6TRyIZLq9pU5cliFT552N08Y5ZTEulzv
         lQDQcjuMiHWS5QDghhGxZxLusPIMjqLG3FUKhqZS39+CFJcXaZmBPOdyNRdSficASQd9
         gv9Q==
X-Gm-Message-State: APzg51CRuk8ZtAb5tG6THKNwrCgWQF36pitJfPsbTTmM6HEkHM9k376S
        8phjlY2Nghiilo3/gqmQLlQ=
X-Google-Smtp-Source: ANB0VdbPIlnlBUPP5sV3wmeDiz9uokyYJ5ov9GnZs8MEyQCoPOkNnx5Nsp26oHGhPHkaNYNKkfXZ4w==
X-Received: by 2002:adf:fd12:: with SMTP id e18-v6mr11834089wrr.280.1536962075613;
        Fri, 14 Sep 2018 14:54:35 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g7-v6sm7120660wrw.30.2018.09.14.14.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 14:54:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Ben Peart <benpeart@microsoft.com>,
        "peartben\@gmail.com" <peartben@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "t.gummerer\@gmail.com" <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 2/5] preload-index: teach GIT_FORCE_PRELOAD_TEST to take a boolean
References: <80988727-085f-cdd9-e5bb-a90a55e97024@gmail.com>
        <20180914201340.37400-1-benpeart@microsoft.com>
        <20180914201340.37400-3-benpeart@microsoft.com>
        <20180914205158.GC133420@aiede.svl.corp.google.com>
Date:   Fri, 14 Sep 2018 14:54:33 -0700
In-Reply-To: <20180914205158.GC133420@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Fri, 14 Sep 2018 13:51:58 -0700")
Message-ID: <xmqq36ubbv8m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Maybe something like:
>
> 	preload-index: use git_env_bool() not getenv() for customization
>
> 	GIT_FORCE_PRELOAD_TEST is only checked for presence by using getenv().
> 	Use git_env_bool() instead so that GIT_FORCE_PRELOAD_TEST=false can
> 	work as expected.

That is much better description.  Also

	$ cd t && GIT_FORCE_PRELOAD_TEST=t ./t0000-basic.sh

would have allowed us to enable the feature in the older world, but
I suspect it would instead fail the test, saying 't is not a bool
nor int'.

So strictly speaking, it is a backward incompatible change.  I am
not sure if I like it.

>> Teach GIT_FORCE_PRELOAD_TEST to take a boolean to turn on or off this test
>> feature instead of simply testing for existance.

s/existance/existence/?
