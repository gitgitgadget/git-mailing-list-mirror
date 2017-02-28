Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2585202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 21:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752147AbdB1Vmy (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 16:42:54 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35944 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752485AbdB1Vmr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 16:42:47 -0500
Received: by mail-pf0-f194.google.com with SMTP id j5so1862764pfb.3
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 13:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=z/zIyCzN8FvRUqM2OhmhTUE+iAFPXiurHX4r7T5mboM=;
        b=ExMaAw9nX2SvAVomX7ZIJCJI9f1itJZADmu+jSVMzIcZ1BN4Bl/NHRuGPEyvYBGH9Y
         NagBiAmjCPsSE/ZmyRcLMs5aoTc5DtTvqONR6934jMr+XIbL0odbRQhGSfLR+bcv4ADL
         1I1TRDh6/GqOwPHe+Gqw16ICzUSWoweLi0LkLoinN+Nd43+XhCH4m2238djCra0KJMDg
         alDWFZmWK7X5s8e3FyEBqA0vid1D56bHDPHKa9qROCSheN42rYOro+k1rtjs5tYoNIzJ
         naY72PdvClx3hhQo3KB5HezKoH+6z1p8p9fQDkkmhnCAbMDAOi3lxiTm8kApCx4sIkWw
         wkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=z/zIyCzN8FvRUqM2OhmhTUE+iAFPXiurHX4r7T5mboM=;
        b=ev0KCbtVIV32PuYDLSKlMy7rLAeeqcLkOBwsBKVXce9GnRg70u08mW9y3wERg+s8ny
         Yiq74D3356Xi8WibCywZL+hqY2wBAeOrN+ELKtfFOQbmIbBOuK/DiiF3y2awyZfxXjTx
         9muE0cJb9oMVu1XfW4twWI9wGqnWfpQcm94EpSN/mGefabPqlEAycoVi1qmxUakwp9TT
         pR5qm4QlQIXduhNINI9Gac7lKf7Osn9vq0gUxn41YGPX491oEHfnw3b/y3BMl9nwb/OO
         /ut9emz3rQ2L1nCj6dvU9maPUqvLuPE+0f3kTjvDgEp7lugNK6chsBtDZ1Iwbi5xmahe
         ihcg==
X-Gm-Message-State: AMke39lOEAJ67VosDAwUBlu+ErcmbfYb8kFhkXgMXo6t4s9fVBAWwxWvJyIbKsZeF9PwQg==
X-Received: by 10.99.37.199 with SMTP id l190mr4849064pgl.86.1488318165906;
        Tue, 28 Feb 2017 13:42:45 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:e0d7:55f8:67f2:62dd])
        by smtp.gmail.com with ESMTPSA id t22sm6005275pfa.114.2017.02.28.13.42.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Feb 2017 13:42:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, peartben@gmail.com,
        benpeart@microsoft.com
Subject: Re: [PATCH 1/3] revision: unify {tree,blob}_objects in rev_info
References: <cover.1487984670.git.jonathantanmy@google.com>
        <cover.1487984670.git.jonathantanmy@google.com>
        <06a84f8c77924b275606384ead8bb2fd7d75f7b6.1487984670.git.jonathantanmy@google.com>
Date:   Tue, 28 Feb 2017 13:42:44 -0800
In-Reply-To: <06a84f8c77924b275606384ead8bb2fd7d75f7b6.1487984670.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 24 Feb 2017 17:18:36 -0800")
Message-ID: <xmqq1suij8kr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> It could be argued that in the future, Git might need to distinguish
> tree_objects from blob_objects - in particular, a user might want
> rev-list to print the trees but not the blobs. 

That was exactly why these bits were originally made to "appear
independent but in practice nobody sets only one and leaves others
off".  

And it didn't happen in the past 10 years, which tells us that we
should take this patch.

Thanks.

