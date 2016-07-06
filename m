Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4E192070C
	for <e@80x24.org>; Wed,  6 Jul 2016 15:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbcGFP0H (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 11:26:07 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:37119 "EHLO
	mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754573AbcGFP0F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jul 2016 11:26:05 -0400
Received: by mail-it0-f54.google.com with SMTP id f6so108512263ith.0
        for <git@vger.kernel.org>; Wed, 06 Jul 2016 08:25:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kfT+YqMUEcgNZKzFHVRH+WUlg+8Lih70KbOINnUB72o=;
        b=ndj6FjuK2FwzEEFGDmmTghpWFgoR10lrwTBjasiV2+O7KqWMkgG12BE2+L2aJmxG0u
         +TbC48ecN+5Ee2BkQDXzvTYh7wH0rHqwCzaBgAWSEim+EVdERjpiLQTlGOiyM2TBtwP0
         92eCwWYCwG+sX4k7fjieE4365cvIfSKj3f3JecZTdrtwRJFMeqB04ihEb5S7xprDAdUS
         cAT6PPWaabNU224/kjwSKRKHpMjiYENhpaOtOYOnY3czBGBaKrF4yBtvRio3fZVXLXJI
         ohnjcoTgJgF/wbplpMbnN7Pv3sLZx97rdcVDRNNUuh/dgUTczQyD5zPEpmQFSxyqSg6q
         MLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kfT+YqMUEcgNZKzFHVRH+WUlg+8Lih70KbOINnUB72o=;
        b=HfVvw2gqNb1g75UNYRxi723O8ODd2zzcej443I6PIpwxguWywtbDHRsAzqGG6XPEeO
         Ohsy7OYGWH+S+NInixy/gGkKPEzMD5EwzdyG/Bubxees35zyxFfEJPI8A8kFLJCV+0GU
         Tr0vTn8TL2g/P+UqH7C1m3YS41gPXxOlCC4Gfe3QhrNSCpprefsc0wxve2yk3bkamA6V
         0BiSt+4IrcnALbghWu6rHh8ajaMp2ep9fd0ycTSTKpGJY0M3av/6mXfRIU10PgzfZdE2
         /O4HsxrN7K6405RGJ9HYGfEu7horLC5FVmS19O+j8BVlYPFac3dZzQQ8h8Fjn2OLQmwC
         MQFg==
X-Gm-Message-State: ALyK8tJs1vJujT5mu/bE8m4YcWn//gZJFV9qAzaFf3kNE33TCOqo62fU3OwquT2DpnHsI6hpBJZuH3ZBwZaElg==
X-Received: by 10.36.33.22 with SMTP id e22mr20365248ita.42.1467818759302;
 Wed, 06 Jul 2016 08:25:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Wed, 6 Jul 2016 08:25:29 -0700 (PDT)
In-Reply-To: <577C17D4.6080708@kdbg.org>
References: <1466807902.28869.8.camel@gmail.com> <20160705170558.10906-1-pclouds@gmail.com>
 <20160705170558.10906-4-pclouds@gmail.com> <577C17D4.6080708@kdbg.org>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Wed, 6 Jul 2016 17:25:29 +0200
Message-ID: <CACsJy8ASYszXU-ErPas99EpW_J_E-FQVk197W7KqURJge_RBRQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] index-pack: correct "len" type in unpack_data()
To:	Johannes Sixt <j6t@kdbg.org>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Christoph Michelbach <michelbach94@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 5, 2016 at 10:25 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 05.07.2016 um 19:05 schrieb Nguyễn Thái Ngọc Duy:
>>
>> +                       die(Q_("premature end of pack file, %"PRIuMAX"
>> byte missing",
>> +                              "premature end of pack file, %"PRIuMAX"
>> bytes missing",
>
>
> I would be surprised if this form of translation worked...

What can I say, gettext is smart. In gc.c we already have this

die(_("gc is already running on machine '%s' pid %"PRIuMAX" (use
--force if not)"), name, (uintmax_t)pid);

and vi.po shows

#: builtin/gc.c:397
#, c-format
msgid ""
"gc is already running on machine '%s' pid %<PRIuMAX> (use --force if not)"
-- 
Duy
