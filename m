Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A09A20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 08:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbeLMIRG (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 03:17:06 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35344 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbeLMIRG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 03:17:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so1005094wrb.2
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 00:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=65ZykWWZgjotvjmFcDgDlGvUQT0kOYP+XmUDP09EZDg=;
        b=fU68HNjuQWakY1uWkoU/Dw6yxYi+bSJrpT52SjmJZzW0nXDPWSdGR83yCDmRdfmW6e
         HkxcWcnEiEVR7NX2c4adQWICmpwFINNQ+v13Z+hR0aUZ+hT+2iizfH1dYpXbuzGEjwhW
         i9JV0pvB31Lm7NiaEylA3OYo174Z3+diIp2Br4cos3f7YcfqACJrfkH3LaM1mcLUWqN+
         mwnsdUbv22U65xKHKJjQ9c6eSi3yP66gEZrZbZJUiYOLRLHi0ORxfmMvNO4tba6ip3EH
         ZbNkOdEBMKoPf1yf076ciqI1SGq8IVeiAQVoeWhnwFBjieNr52kISLchpAMDtbm2MMai
         faFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=65ZykWWZgjotvjmFcDgDlGvUQT0kOYP+XmUDP09EZDg=;
        b=eEJYNmRts3Y0U3R3lQd8wu4OxOh32gUpFceLkg+gZ6BnZwWmrR4eB6EG00lNnIN/A3
         AAcuyj8qQsf46wMJUkkdRi98SHFUwrtII+txwHA0h4mPBtcWIZzSkCLjiJj/gnjDAxEq
         7KeW0tzXvA9Bq70ZoSMDjO8CyV+OgymF8rs1ZesnQGWQrLnTvvoCdSj1UEBBXXzzpbzD
         s3iO+JduwsdTfswNKzYE0JxGuBgmzK6gQe6zi76joNbGtRQ4UYxIewpRn1Pulc4+44ad
         iwV4+WZbQaC/0FnWUVuQF4bYe8bizVq+jFSpCuP/TRjuf5uG+cQcvzxgSQwHWn5xpBpL
         zX5Q==
X-Gm-Message-State: AA+aEWaW+oTamumrAUzsgBJCVTUBHYE1SHeUnNx1rxDpF7YaD3bY12sr
        NIuOHuL279wwXxcWZi+rXbo=
X-Google-Smtp-Source: AFSGD/XhmZJrm/zNpaAfVC4nowBMN+In0B02W0LwHGhzVyjOJ8LNcQpoY31U/Z/nUTDL49/fEaYLpQ==
X-Received: by 2002:adf:8001:: with SMTP id 1mr19223168wrk.23.1544689023233;
        Thu, 13 Dec 2018 00:17:03 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q185sm1485668wmg.14.2018.12.13.00.17.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 00:17:02 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] run-command: report exec failure
References: <xmqqd0q8liow.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1812111327460.43@tvgsbejvaqbjf.bet>
        <xmqqsgz4jkgl.fsf@gitster-ct.c.googlers.com>
        <xmqqbm5qioca.fsf_-_@gitster-ct.c.googlers.com>
        <20181213080825.GB12132@sigill.intra.peff.net>
Date:   Thu, 13 Dec 2018 17:17:02 +0900
In-Reply-To: <20181213080825.GB12132@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 13 Dec 2018 03:08:25 -0500")
Message-ID: <xmqqzht9et8h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Dec 13, 2018 at 03:36:53AM +0900, Junio C Hamano wrote:
>
>>  test_expect_success 'start_command reports ENOENT (slash)' '
>> -	test-tool run-command start-command-ENOENT ./does-not-exist
>> +	test-tool run-command start-command-ENOENT ./does-not-exist 2>err &&
>> +	test_i18ngrep "\./does-not-exist" err
>>  '
>
> I thought at first you could use "grep" here, since we know that the
> name of the file would appear untranslated. But I think the way
> GETTEXT_POISON works, it actually eats the whole string, including
> placeholders (which IMHO is a failing of GETTEXT_POISON, since no real
> translation would do that, but not worth caring too much about).

When Ævar's dynamic gettext poison topic was discussed, there was an
idea or two floated for a possible follow-up to introduce a true
"fake translation", replacing e with é, n with ñ, etc., while
keeping the printf formaters intact.  When that comes, we should be
able to use grep and that would make the result more robust than the
current test_i18ngrep that always pretends to have seen a match, but
that hasn't happened yet.

