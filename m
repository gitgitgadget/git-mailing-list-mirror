Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B03421841
	for <e@80x24.org>; Mon, 30 Apr 2018 07:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752627AbeD3H4F (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 03:56:05 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37683 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbeD3H4E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 03:56:04 -0400
Received: by mail-wr0-f193.google.com with SMTP id c14-v6so7126046wrd.4
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 00:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZfFVP7ed5VW53gA7UqoWr5jM4LgByjz59hGSPDDx9S8=;
        b=Rbz52kEW5at3GjrKry5VxXMP1xOjHTS3M0pRXIXsxZ6YONaCFhHIJ4OAu+88fSXonp
         v7bdEvkpNmCvJZLxImvDcFupGYtT0Q7sOY8rYlXUgK1WXP2AJEapgWZGqUYkVGMlPXTE
         swWL50HU6BjaudDrX41FhzPhhYAhsKPlAaR3GZdvh1giili2AF7xtU7p8YYiT7EaxS+k
         C/jzaThnhLikSW6lhTolSpy6+gMDhfKtr8swR7MijV0K1Aldt275kksAasJ4wyJnJxFQ
         7jJdUCo4oPMLw+KlJVOr9+R47E8tRLEB8v+JNl5kU0jpQlsOi+a1Oxcboxa6eo+giwwI
         zhjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZfFVP7ed5VW53gA7UqoWr5jM4LgByjz59hGSPDDx9S8=;
        b=AynTccJBhCrZXQPsodVB/9SC/M3sUkg2g3N5Qi2gIbPKhF/mbTwtaRy7cIyWq978zj
         RhyJ1q6rJp/rdY5RST/rINOem/mmvjFagcsFCuNc9T+AiDvasxyIqV1ZgLFPLZfOBcyU
         /UOZECL8sda5cDNusM0PgW60oe/hcC557DA6Za+gB/Hpamz/PWWLWhImcKb8v0hCqL77
         B1/6Z3UARELQXcYIJ23i8+ysdnDVI32JZ3I1PCZVt9q4agiq6R13RUt2czDmGegI7mfk
         wabi2fOpMMmF8mF1L1xEMQu3+HWfQy768U0KD3ujSd2+gcPn4qw3qVrl7NjiHDaqLjqq
         cHuw==
X-Gm-Message-State: ALQs6tCqOxocA+Imulyb7YKdvpha/XFFyB+pmTNFmgiBVc0mmJTt8j7Q
        S1XxdVfALLB/lN+/z68qZ9+8B5y8
X-Google-Smtp-Source: AB8JxZpUWiN9SfH99BqlDcKCXXkhWM3T/RucFOUE7dNPXNHvZDa0q1zXEnS53u3kr0mswj/bu1JO1w==
X-Received: by 2002:adf:b90a:: with SMTP id k10-v6mr8943571wrf.283.1525074963264;
        Mon, 30 Apr 2018 00:56:03 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f10sm5707486wmc.0.2018.04.30.00.56.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Apr 2018 00:56:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, newren@gmail.com
Subject: Re: [PATCH v1 1/1] test: Correct detection of UTF8_NFD_TO_NFC for APFS
References: <CABPp-BHitvta8we8di-tFiNdVV7vXnMNAhiAs2=CrQc-gGuSJw@mail.gmail.com>
        <20180430063519.27122-1-tboegi@web.de>
Date:   Mon, 30 Apr 2018 16:56:02 +0900
In-Reply-To: <20180430063519.27122-1-tboegi@web.de> (tboegi@web.de's message
        of "Mon, 30 Apr 2018 08:35:19 +0200")
Message-ID: <xmqqvac9xh4d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten Bögershausen <tboegi@web.de>
>
> On HFS (which is the default Mac filesystem prior to High Sierra),
> unicode names are "decomposed" before recording.
> On APFS, which appears to be the new default filesystem in Mac OS High
> Sierra, filenames are recorded as specified by the user.
>
> APFS continues to allow the user to access it via any name
> that normalizes to the same thing.
>
> This difference causes t0050-filesystem.sh to fail two tests.
>
> Improve the test for a NFD/NFC in test-lib.sh:
> Test if the same file can be reached in pre- and decomposed unicode.
>
> Reported-By: Elijah Newren <newren@gmail.com>
> Signed-off-by: Torsten Bögershausen <tboegi@web.de>
> ---
>  t/test-lib.sh | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Thanks.  

Wouldn't it logically make more sense to check for the target being
an existing file with "-f"?  It is not an essential part of the test
for the target to be "readable", but "can be stat(2)ed with the
other UTF-8 representation" is.

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index ea2bbaaa7a..e206250d1b 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1106,12 +1106,7 @@ test_lazy_prereq UTF8_NFD_TO_NFC '
>  	auml=$(printf "\303\244")
>  	aumlcdiar=$(printf "\141\314\210")
>  	>"$auml" &&
> -	case "$(echo *)" in
> -	"$aumlcdiar")
> -		true ;;
> -	*)
> -		false ;;
> -	esac
> +	test -r "$aumlcdiar"
>  '
>  
>  test_lazy_prereq AUTOIDENT '
