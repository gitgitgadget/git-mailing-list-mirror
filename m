Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA9AB1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 19:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbeGQTr1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 15:47:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37658 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729743AbeGQTr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 15:47:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id q10-v6so2292487wrd.4
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 12:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UHoUMSMZiNFXTBH/0INOlCtJCZqf3HxDOVbf9eaEIZ4=;
        b=nqMawV6KnN89hJaJ008PlR4Lv9Qv9KSimXpzkGIkijj1vQDSR7EcPeQtDgEgX04QhI
         5hhrbQ9z1bTS8RNY3A4DZJnGDLViP5Dis/vV63+LGpxsQQpNfJdXv0OsHCsyCt7aJdhx
         MHPRpcKwgPHAamWMLjb6hvKLr/DmPKwAeGnA6jEkx4Byio915g37jg+H3lOPbKD+wUKO
         Gmar3fOKiDo7jQZ//BPwT8el4zu8UEdkrChoTwJtOdUfoMrFrf25Vvh/JIMGFrY+oIAp
         Fm+NeSetnHjvDKcdzRZFS4flHYfLXyY21yrp51ep1ouLYxgpm4OouKIixQowL6zkop+2
         aHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UHoUMSMZiNFXTBH/0INOlCtJCZqf3HxDOVbf9eaEIZ4=;
        b=KVMFmYlk8MUnsX9miVC0INIC6EIAMUdpcQkyORlpIgfYOGFjDIJeg+GXUkQnjOCsC6
         jlgJk8oPw+nwrf0TPQU2zzVNyT06PL2cdxrBJARdQVR1rJCDPpMxkAVjjJf2xQEVicnM
         3Qan8fpg+VF0fwn5ptW3L1bfY0rQbCJ9nhSaJITtu3dxYPF+jo5mpWYCCYUJt9dkJgFn
         32sbul+HTWEApZYtnMltULSNt3Mpm8Ivb0aJ7Wag2yqzyJoJerHVSx5ExuofmI60iYOd
         1Hf4uExx8L5pTdF74oEP/ZwnCTkQVZ+OJiRIBMblaokOowESy/MR49yeo6qwnmSlblWr
         3aEg==
X-Gm-Message-State: AOUpUlElqXe+oSRkvMgl9iZHiRmpN2bdTSpD/hXJclHY+xHohrnedbZ8
        RTA5cgBnYW/LRnW8HJA+3f8=
X-Google-Smtp-Source: AAOMgpclsXSUbk4E+lDV8DoT77+UBYdfS905UtDDJi6oXXeYTyMiuftLRkYA9/0X3E/2MZ+0hI4vIA==
X-Received: by 2002:adf:deca:: with SMTP id i10-v6mr2156612wrn.163.1531854804647;
        Tue, 17 Jul 2018 12:13:24 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m4-v6sm4123796wrv.71.2018.07.17.12.13.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 12:13:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 5/6] sha1-name: Teach `get_oid_with_context[_1]()` to be gentle
References: <cover.1531778417.git.ungureanupaulsebastian@gmail.com>
        <dc1abfca46cd536f060b9097b9f2d1a64988f932.1531778417.git.ungureanupaulsebastian@gmail.com>
Date:   Tue, 17 Jul 2018 12:13:23 -0700
In-Reply-To: <dc1abfca46cd536f060b9097b9f2d1a64988f932.1531778417.git.ungureanupaulsebastian@gmail.com>
        (Paul-Sebastian Ungureanu's message of "Tue, 17 Jul 2018 15:06:35
        +0300")
Message-ID: <xmqqefg1oeuk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:

> @@ -1769,7 +1831,8 @@ void maybe_die_on_misspelt_object_name(const char *name, const char *prefix)
>  
>  int get_oid_with_context(const char *str, unsigned flags, struct object_id *oid, struct object_context *oc)
>  {
> -	if (flags & GET_OID_FOLLOW_SYMLINKS && flags & GET_OID_ONLY_TO_DIE)
> +	if (flags & (GET_OID_FOLLOW_SYMLINKS | GET_OID_GENTLY) &&
> +	    flags & GET_OID_ONLY_TO_DIE)
>  		BUG("incompatible flags for get_sha1_with_context");
>  	return get_oid_with_context_1(str, flags, NULL, oid, oc);
>  }

This points us back to "only-to-die" which was "gently" before
2e83b66c ("fix overslow :/no-such-string-ever-existed diagnostics",
2011-05-10).  I think we have to keep them both, as only-to-die
means more than just being not gentle, and we cannot revert the
renaming s/!gently/only-to-die/ done by 2e83b66c and teach GENTLY to
more codepaths, I think.  But I might be mistaken and we may be able
to get rid of only-to-die at the end of this series.  I dunno.

In any case, what's the reason why this new "gentle" option is
incompatible with "only-to-die"?
