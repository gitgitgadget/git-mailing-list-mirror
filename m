Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB18E1F51C
	for <e@80x24.org>; Wed, 23 May 2018 03:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753684AbeEWDTH (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 23:19:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38134 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753520AbeEWDTG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 23:19:06 -0400
Received: by mail-wm0-f65.google.com with SMTP id m129-v6so4985019wmb.3
        for <git@vger.kernel.org>; Tue, 22 May 2018 20:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=VIN6TJZUhGoqyRNKxcRmKwRyXy2zYqyW1mJD9Fv+6mc=;
        b=HRnmdeffL0tQcFhuA1lMqLJjOZMonjDfy7KhW4bKYNcoBD35P1p0uZDQ6USm9o3cvJ
         ZoMP5IhQdU7ntbIzcqq4ap+MzEK/o/tngrdt7mPC9WYfjuZ1A/jwOMTXGtM9fgEVVSHU
         QSaL87RkuNSOAK9M5SYWbSUKyaZ1heuShf2uvLfnSJp4/nibbDq9kIN14+VvoM4oIhLA
         qPOGum/chgt1J5flkDKV4fopfN1tTGum3f6kdm8JnArTxKavde2+jsvBuD89h1EijtUo
         5zZYNjOriBNI2W9zoM19W51iycnK/zaS/bQCmrxESQy+9EgUaiuZYcyb4s5iDuKAzW/K
         M3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=VIN6TJZUhGoqyRNKxcRmKwRyXy2zYqyW1mJD9Fv+6mc=;
        b=fOB7SkSd+RC+MU/gw89Vw2mr123L5G6JhVqpfSey0VkJbwKCDEj+5Vrmg1bRyoqqmq
         t3QjlbTbmS+g5TSvfIjJ9C3KYNWusMCVDGCMk1cWt0X19sL980+QRB1TNBAuDhgOnJ6L
         6JABljjqjUHYXh2ReShoRFDSdK8x8DAICSEmMg8rJQaARzfRIaMz7JDpF2/FfhsslhG0
         WXmhwI6G/aRgyMNwqNUxV+WiMsmyEeMUlXwJ/IiDFttlaoZz4fSESpbKasm7NuRM9wAo
         Lf3PfGQhQGwQ5LERb4kBmNgMkjumcV2YDr5hAfU9ZJTiSU6DmbLKs8x8E7avR3+fiJLI
         97Yw==
X-Gm-Message-State: ALKqPwf4DnNHEB15xaRnE7ZtmxOYf0DpLzcUJSYSNn+ktaX9PnYw8wxA
        nduZgM3uKKN/JX+EgsmO2Bo=
X-Google-Smtp-Source: AB8JxZrYVXw0bWkVVdJEq1G9JQVeTFL9kq1WtDjvlr8Du/6Rx+CfbINhO1daqoufEmQeSCuaZqiqGA==
X-Received: by 2002:a1c:8b88:: with SMTP id n130-v6mr2701361wmd.8.1527045545517;
        Tue, 22 May 2018 20:19:05 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j8-v6sm35839729wra.58.2018.05.22.20.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 May 2018 20:19:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, pclouds@gmail.com, ao2@ao2.it,
        bmwill@google.com, git@vger.kernel.org
Subject: Re: Why do we have both x*() and *_or_die() for "do or die"?
References: <CACsJy8A8WZ-Gqe2Y-whJmbADrt+gZjLZ7MTwCtdnK7JDnEdtog@mail.gmail.com>
        <20180516222118.233868-1-sbeller@google.com>
        <20180516222118.233868-3-sbeller@google.com>
        <874liz8tsi.fsf@evledraar.gmail.com>
Date:   Wed, 23 May 2018 12:19:04 +0900
In-Reply-To: <874liz8tsi.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 22 May 2018 19:49:33 +0200")
Message-ID: <xmqq4lizvz2v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Just a side-question unrelated to this patch per-se, why do we have both
> x*() and *_or_die() functions in the codebase? I can't find any pattern
> for one or the other.

My understanding is that x*() were meant for system library
functions.  read-index-or-die should never be x-read-index.

Quite honestly, read-index should probably have designed to die from
the beginning, with read-index-gently as a variant to report an
error instead of dying.
