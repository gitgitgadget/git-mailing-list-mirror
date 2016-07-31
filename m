Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 536D81F858
	for <e@80x24.org>; Sun, 31 Jul 2016 14:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796AbcGaOcS (ORCPT <rfc822;e@80x24.org>);
	Sun, 31 Jul 2016 10:32:18 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:36256 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965AbcGaObF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2016 10:31:05 -0400
Received: by mail-io0-f170.google.com with SMTP id b62so166758288iod.3
        for <git@vger.kernel.org>; Sun, 31 Jul 2016 07:31:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E8CRdC/yo7Z77+2XWRgkKbkn+a9aPJE4xh2T7rBQnM8=;
        b=G7R82sEErUZ895J3vxecojqTHB2UaO+sFuU+yJ5B41zbDAXhhCKlfp0RAlykO/QWPs
         iY8SW+aqPQ3uL7gfw4vtP5POhnozUSYDYBEd9UKHyoLj4u4iUB1Bw13TzEBoo7A+9OtN
         qev5W/cKTbQjLCpWZ/UOfHAGRPnDJg9V3mFE2dExhEuoepVOm2zfqu4j99QkYi7+Wf13
         M2W5tMjQ9L0eUl7kKpF8u7KwIYJv7pUoblbjG/+dZWW3oTlHzCZtSUrCX1Cf1eCfn9IG
         1wf2UzIhewWVK8smoegVDbnUA54cSy/vaCs6QrygVnKiIwhMwiKFEzUvgAIndNlpC3+w
         qM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E8CRdC/yo7Z77+2XWRgkKbkn+a9aPJE4xh2T7rBQnM8=;
        b=KfTEXoHTOZlKQi6esq6jK1rlISreh9qe07U7rEN/NWGjXsp9+kz4oPSpk6HdjQAUI4
         D5sv783z2wvOdBVoNx0KcdJPUZA0qo6ll0LD3B/gzTtiaBn+G1ZQ4Qe2rWStMrFwMLlJ
         euN0LyS9zSA5Q7BJWvgW/rLJU1yjT/y0S9/g+iV4tSQVi+CnmXZhtiid11s6YVzF7xox
         MT2ajgsgJeOgwabBIoKPvjHaWfPrU6YDmupZYAAA6KTofhg0WBftXp4NadlVrHIfSd6d
         f71eaRiqYKbP5FToYmXE53V2+NB5UDP8MSDi4YCdkkpUYiFSa9yNqSdDavqLrAAoC3Mp
         T8mA==
X-Gm-Message-State: AEkoouuUF4HS973fZsASo9MWpXktjarSdtd2IaJ6DJtVDAdBBmj9rm9twezz/xsowfP42PazJ8l4CWouWFZFjw==
X-Received: by 10.107.159.147 with SMTP id i141mr50366068ioe.29.1469975463662;
 Sun, 31 Jul 2016 07:31:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sun, 31 Jul 2016 07:30:34 -0700 (PDT)
In-Reply-To: <20160731010732.GA31840@whir>
References: <20160718223038.GA66056@plume> <20160730182005.14426-1-pclouds@gmail.com>
 <20160731001532.GA23146@starla> <20160731010732.GA31840@whir>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sun, 31 Jul 2016 16:30:34 +0200
Message-ID: <CACsJy8CfLYPT5hJRT1q6nCtjy0K6+nZWGV5G+d7u=ymuEZ85tg@mail.gmail.com>
Subject: Re: [PATCH] t7063: work around FreeBSD's lazy mtime update feature
To:	Eric Wong <e@80x24.org>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jul 31, 2016 at 3:07 AM, Eric Wong <e@80x24.org> wrote:
>> would be more to the point of what is going on, here.   But I
>> also wonder if untracked cache itself could/should be doing this
>> internally.
>
> Still wondering :>

There's nothing we can do besides maybe run a cron job executing
'sync' every second or so. We need to force mtime to be written down
close to.. you know.. mtime. By the time git is executed, it's already
late. You can execute 'sync' inside git then wait a couple seconds..
but that's just stupid. And removing the racy check is even more
dangerous, now you can get false output.
-- 
Duy
