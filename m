Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FE301F404
	for <e@80x24.org>; Wed, 28 Mar 2018 05:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750820AbeC1FUJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 01:20:09 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55184 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeC1FUI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 01:20:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id h76so2455584wme.4
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 22:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DhHlrJkWYSUFC12GU5sM45bvC8r7eazmjvtDSoRahDo=;
        b=NSMNphoXoUAeaA9hYdU30mvtK8W6/rOKefivCCy78EqK9fwUQfmW/Na5124MsSPNcJ
         y4Y57xapEe9QZBsLCMsFylxF5/hFEClaUysA1fISUwTJvjiTWvkfgvXruBJtGBIjD8Sn
         hzb+nvZfeJXseHveJLd0g0NupimGL3L1jkpEU2rkNB89vNt+pgExU55ads1qUyMmeay/
         TbxhpK8PETpp1iSS64WDS+e0BOdLzA0GEVpw8KbepaiNcTBP7Gu1qx4OgevST7DmnujB
         Bdr/Lq0sN9yZtnrXwjAQ+ZFqrBdczDDA8S1LUyxGW4HGs/g1lpH4lNnqpy72Q8wv7lFj
         kdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DhHlrJkWYSUFC12GU5sM45bvC8r7eazmjvtDSoRahDo=;
        b=BKbk7Y8lMo6m1jbnZhsby2F9r7+Tc0DdVDfIF8p/15HwjuLDId3a8w72fEdxjSB9lG
         SNir+jX/uhm8HQg880J0CKGE6FBHX17EAPLN4nVYLXiZOY4SJBS9ma0y9/ZFYg7hngBq
         Yvdq+cJsqDaGbp+jT/KDW2+gr8e22mtJE8csu/GPgaXlfte7ocrQByQgddHTyzidD0qy
         DIt8qvSFQU97qd4q34NeJZtuMXR4Px7wQqdjzAEbs7bpztYE8U1p6TaM4hlUbxv4DzxU
         uiDU+Z8cwxnNmSY+X0QUMZb74gYRXAL12YGkFdh6a/qnW04jZb9ZsF5eUQ05dgzteoOC
         K8jQ==
X-Gm-Message-State: AElRT7FCPlL/14g3QoD1mUEYMT28ZV73a9MyDrVkc4z9YlAgEc3V1QbF
        GL7QybCCXilzlk0cHme2aG8=
X-Google-Smtp-Source: AIpwx4+QToEtNT6KAZWaSmz9xvH/ylEDUpzmcGYm/b0ZtCEUcjK9cdCkExcPJppvRFTyBIhvioxFhw==
X-Received: by 10.28.91.79 with SMTP id p76mr1520951wmb.3.1522214406459;
        Tue, 27 Mar 2018 22:20:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h190sm4069234wmd.22.2018.03.27.22.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 22:20:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH v2] test_must_be_empty: simplify file existence check
References: <20180326124847.GA21993@sigill.intra.peff.net>
        <20180326131124.13003-1-szeder.dev@gmail.com>
        <xmqqd0zp9i0d.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 27 Mar 2018 22:20:05 -0700
In-Reply-To: <xmqqd0zp9i0d.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 27 Mar 2018 17:10:58 -0700")
Message-ID: <xmqqzi2s93p6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>  test_must_be_empty () {
>> -	if ! test -f "$1"
>> -	then
>> -		echo "'$1' is missing"
>> -		return 1
>> -	elif test -s "$1"
>> +	test_path_is_file "$1" &&
>> +	if test -s "$1"
>>  	then
>>  		echo "'$1' is not empty, it contains:"
>>  		cat "$1"
>
> "Just call it" is fine as an idea but
>
> 	A &&
> 	if B
> 	then
> 		...
> 	fi
>
> is somewhat questionable.  Shouldn't we make it
>
> 	if A && B
> 	then
> 		...
> 	fi
>
> instead?

Nah, you want to treat A's success as a condition *not* to enter the
"then" clause in this case, so my rewrite is bogus.  SOrry for the
noise.



