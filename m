Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D909C433B4
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 05:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 509F2611C2
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 05:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbhDKFtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 01:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhDKFtB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 01:49:01 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE85C06138B
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 22:48:45 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so5273786pjv.1
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 22:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w4GfXx3dlpTnHYasLvTfVzsLxam/8peD3GV0/GPcBw0=;
        b=mXLVl5CWIektvbyA0EZwRAMS7YxX5D6pXTMafSTUKpZiwnQr2K7yZGMqmWk0u/KJ9D
         GkleNpRGBFKCDciaf35XRKzITGrWvjTsOsoPgTnN5s82hu6nRgqcpgYvq/QmtTPTVzfr
         l7/RooxfNbzohwgjSuB7oU5Y4YJf4SuwyuWaEA67jgwFl3uKAe7l8v4j328r3rWF4fsx
         dmXfFs/VBhR0KnYL8Vl3RevheP8ptZJEYip/VRfs6L9BUHpUF+YwCs409IE73jQrq/gR
         chCOEWcSukhRnmd5RPwVXs0sm0kOPesTKeDxijcKBFMfb77SKds00s9xo5MQ9lKybUy+
         tz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w4GfXx3dlpTnHYasLvTfVzsLxam/8peD3GV0/GPcBw0=;
        b=BxbtoAZLzEmA4gx04qWrmoahVBegSHjXhEfxDCYu9+G0osgNkyU9HJ09ipmZ9e4B4s
         KtgD3U0cNtFrenWUeeKrOx6c3hjs6EE1f4W+p4GRPsXNFXL0kQjM44hPOVYXs7UGww6K
         Wxli0lFA8DHimVm0+lyVzCDBHL4lEP56OjgtyFQjR3CoPhOV2WuqOvnxmAJ7C2/j3S2q
         ReGCVuAN7GIHo3HujXFa6KBUH+3x+BMaxS4YkxyzzD85QN6Me1FUpDw0TC55nEG8oXQp
         EXTKZ96I+dLZ7owA1/4IWCyaypVibUxRo6oZ4ZxBp/9wmula1mzTGzws5GK2gRYLIa1r
         H+Uw==
X-Gm-Message-State: AOAM533gICBMbndj1UDQfgqe+ViAydGRCncEPV1FnjVYvB9/Zu4j4fxM
        +HPtTQBfC71qBNdp1/KxcYoxgjWtaVA=
X-Google-Smtp-Source: ABdhPJwd3BIky7hXikpGPf/in31K9tJ2r4CRxima2W0y7A+QtjBU95Sp6fAFy+MvtTS4RDsWMR0i2g==
X-Received: by 2002:a17:902:f552:b029:e9:220d:bc35 with SMTP id h18-20020a170902f552b02900e9220dbc35mr20187253plf.47.1618120124764;
        Sat, 10 Apr 2021 22:48:44 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-77.three.co.id. [223.255.225.77])
        by smtp.gmail.com with ESMTPSA id fa6sm6739345pjb.2.2021.04.10.22.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Apr 2021 22:48:44 -0700 (PDT)
Subject: Re: [PATCH] send-email: clarify SMTP encryption settings
To:     Junio C Hamano <gitster@pobox.com>, Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
References: <20210409211812.3869-1-sir@cmpwn.com> <xmqqlf9rklkb.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <f347c0bf-b08e-34d7-e1ae-796a3e619b8c@gmail.com>
Date:   Sun, 11 Apr 2021 12:48:40 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqlf9rklkb.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/04/21 07.52, Junio C Hamano wrote:
> Isn't SMTPS (running SMTP over SSL encrypted connection) the one
> that was once deprecated until it got resurrected)?
> 
> STARTTLS is not all that SMTP specific---POP and IMAP can also start
> in cleartext and upgrade with STARTTLS the same way, no?

Wikipedia entry on Opportunistic TLS [1] said that STARTTLS is not specific
to SMTP, but also to various protocols:
> The STARTTLS command for IMAP and POP3 is defined in RFC 2595, for SMTP in RFC 3207, for XMPP in RFC 6120 and for NNTP in RFC 4642. For IRC, the IRCv3 Working Group has defined the STARTTLS extension. FTP uses the command "AUTH TLS" defined in RFC 4217 and LDAP defines a protocol extension OID in RFC 2830. HTTP uses upgrade header. 

[1]: https://en.wikipedia.org/wiki/Opportunistic_TLS

-- 
An old man doll... just what I always wanted! - Clara
