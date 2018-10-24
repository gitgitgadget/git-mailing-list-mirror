Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ADA21F453
	for <e@80x24.org>; Wed, 24 Oct 2018 03:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbeJXLgr (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 07:36:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45904 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbeJXLgr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 07:36:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id n5-v6so45382wrw.12
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 20:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Z3Tq27WfpeFHuKf5eNGKm8c+yzK8gDtFz7vvhjm3uSA=;
        b=oOnwAR4v6h50G/8US46b6XOxnp56nLrCvhbE3ygJdI4TwzR7f0uvrQtL2ZYQol7QpW
         HTdRcD/6xPH4W1M45O8dL0/fdEk0L9UwLF8rQH8U574180wogZ6aLvdK8BfodVhrj3B1
         Wh0kT0JXbc0WJ33V8RNAdYzTbZmiDuf52uSrd9j7BeBLTcSDG6pngfwLmn+fzkqiNc0f
         MyFAidkdDpjayhxJ9CtRcVUnU+9uS6nLuNF5Wz1MTQi8yldrHrfUMqmHaqLvXjDuIxrJ
         xf7DBEYjEyJsX0ptbeAyJ03hRGCb0kL5UorE1Mx3CdwkErc2cM486apl1fwb39sM/MnH
         CLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Z3Tq27WfpeFHuKf5eNGKm8c+yzK8gDtFz7vvhjm3uSA=;
        b=hXf2tbe71ENvbK+JAGyMBp4QfyKMq7iHftFS5M53mPSosOPnonz2IanTSp6YWEoQbP
         ZSalEV58Xsuaz2M5Rwx+NyMmbzzjaC128ZldeZ3qq2TrxDZ6jjuUEmo8iJC3/N0RoweJ
         PK+Kv5DHZWxSw5ZkH9+bCfHsFDpJjC0ir/V90FaOsFAexXE/gniaDAyhqVDx5WZdA+XX
         lBLEVTp8jGczRtLdlQJeaz9YzreklTdsd/Z2stjmBSr/wh6Iy71UbuzOn6D+hCBdjBIJ
         FNgk12HFBPoa3E1n/0rgr55/bk3NyoltqrNAImFYVRDs1yYIx7WLZDcc8HxyUbvuR74F
         UFyA==
X-Gm-Message-State: AGRZ1gJX6h0p4OYp2wDDIRWFz1rCKDeJYCbuqQDsezGMU3zJEpxtn2/L
        0JaHNm+P4IL0XHL56c8nQWI=
X-Google-Smtp-Source: AJdET5f6Ixm+seKwj2jXwrozO3JhRUfObGXKfYgmVf9inmNnWleZOg+q9xvzMRbAyVoWZWT/taoBXA==
X-Received: by 2002:a5d:45c6:: with SMTP id b6-v6mr759877wrs.296.1540350641321;
        Tue, 23 Oct 2018 20:10:41 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r134-v6sm1982099wmg.9.2018.10.23.20.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 20:10:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/3] gpg-interface.c: use flags to determine key/signer info presence
References: <20181022163821.23523-1-mgorny@gentoo.org>
        <20181023225605.GB6119@genre.crustytoothpaste.net>
Date:   Wed, 24 Oct 2018 12:10:39 +0900
In-Reply-To: <20181023225605.GB6119@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 23 Oct 2018 22:56:05 +0000")
Message-ID: <xmqqwoq8ox8w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Mon, Oct 22, 2018 at 06:38:19PM +0200, Michał Górny wrote:
>> Replace the logic used to determine whether key and signer information
>> is present to use explicit flags in sigcheck_gpg_status[] array.  This
>> is more future-proof, since it makes it possible to add additional
>> statuses without having to explicitly update the conditions.
>
> This series looks good to me.  I was going to ask after patch 2 whether
> you were printing the subkey or primary key fingerprint, and then you
> answered my question in patch 3.  Thanks for including both.

Yeah, this looks good to me too.  Thanks, both.
