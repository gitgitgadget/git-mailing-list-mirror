Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64BDB1F462
	for <e@80x24.org>; Tue, 30 Jul 2019 20:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfG3U0u (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 16:26:50 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:39620 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfG3U0t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 16:26:49 -0400
Received: by mail-wm1-f47.google.com with SMTP id u25so47416620wmc.4
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 13:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XGO7UZ8RPiC/LsERnSig1TCWUc7LpWnA4eH+I3/DvYc=;
        b=V6jzbQ7Hvb7fPvwpbPtsfpjDwax9L7kFPNKtvQsVWSE9DMP7WoQ7ppsfWOBw/+COsb
         8UCPJNJrXlq6V7m8ysDS9fuZmt84jJ/Y7q3UrP4dViUwcWJGjaympamN9ON6o/ED6oso
         MnXXIcqKCQnQ8KFTjfgkdMgIV6KMCRPxbYMFH2YcY3jQ9JyUDAo9fArMlxC9UHSUeukk
         3MSnDxNaLaRR+789ui/2mBOumIjxB9Mnj5dFfBtuQLOHJWB+YE72iqZgfI+hbLUbB1Nk
         rXweesB49U1dsTmdVgzT4zeciIT+R6bacdHSOAT/dZyS0n3rJreY0SjYWAkKS6hoKrQ+
         GVQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XGO7UZ8RPiC/LsERnSig1TCWUc7LpWnA4eH+I3/DvYc=;
        b=Mf4J+EGA3fB88brdzwdWPgaXnMDK0aZMqGRFHFpMPV3+zCpoUrwMM9ce2/iIUDahN9
         cnfSxo7Js7UK0c83ZWdevNwZ3xVikio5CwZdExP5AyzMjYeL2bHl9koE5G7p/lAZmgjM
         x8VK9w4tFgtdhmywy+dn3Su2SXCTdk9e1RUk/bS2VYjVNI/OSanVtR0+3ahpJnyWFiD4
         hsetotdroa86YRJnbQGFLO7/y5vF0Wd9zUsNPrPpPtRy00hUXSquiwax9zQQ0HZ0brqQ
         ljntCxFUPcgwtyIUr4zscKTAuHG9N86UxQ+NVll8XuXEY06HDF3S6zcaArFTnWMAEDvg
         PxaA==
X-Gm-Message-State: APjAAAXpS+2DlhJGeI591y5YLE5DXXojjKc9DbCSlXnf7xcJWsS2NpUF
        /RUgRys2NsdCnI9xpjxd9Jac5Hyxrvm4VGzyYZUoANgKaf+UjNfp52NlXtcxYh+SbxpvvQ6qCJ/
        SJB9osrnVPpvFCidws7896wEfmB3sQ+wcjjLJe8Dfx2z00I903WOh/Xl9KzlWBAWsxY8HEl7dMp
        wuXonnwRrMfw==
X-Google-Smtp-Source: APXvYqyXKjeI/3IN61C3CI4MKSr9elL1W3c/OAeAQHKMwnkiRQ7XtP9xVdtv7kLVvq4kC8ZqDrRh5w==
X-Received: by 2002:a7b:c74a:: with SMTP id w10mr101261854wmk.99.1564518407593;
        Tue, 30 Jul 2019 13:26:47 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id v204sm70267768wma.20.2019.07.30.13.26.46
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 13:26:47 -0700 (PDT)
Subject: Re: [PATCHv2] send-email: Ask if a patch should be sent twice
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>
References: <20190730162624.9226-1-dima@arista.com>
 <20190730191907.GQ20404@szeder.dev>
 <xmqqy30fs4cs.fsf@gitster-ct.c.googlers.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <cd0b46f6-0151-94f2-973f-7ebb2203b8a3@arista.com>
Date:   Tue, 30 Jul 2019 21:26:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <xmqqy30fs4cs.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/30/19 8:35 PM, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
>> On Tue, Jul 30, 2019 at 05:26:24PM +0100, Dmitry Safonov wrote:
>>> +	if (@dupes) {
>>> +		printf(__("Patches specified several times: \n"));
>>
>> Is this message translated?  (I don't know what __("<str>") does in
>> Perl.)  If it is, then ...
> 
> That's not "in Perl" per-se, but what our own Git::I18N gives us.
> 
>>> +test_expect_success $PREREQ 'ask confirmation for double-send' '
>>> +	clean_fake_sendmail &&
>>> +	echo y | \
>>> +		GIT_SEND_EMAIL_NOTTY=1 \
>>> +		git send-email --from=author@example.com \
>>> +			--to=nobody@example.com \
>>> +			--smtp-server="$(pwd)/fake.sendmail" \
>>> +			--validate \
>>> +			$patches $patches $patches \
>>> +			>stdout &&
>>> +	! grep "Patches specified several times: " stdout
>>
>> ... this here should be 'test_i18ngrep' instead of plain old 'grep'.
> 
> Yup.  Thanks for carefully reading the patch(es), as always.

Thanks for spotting, will fix in v3.

-- 
          Dmitry
