Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F0AC1F454
	for <e@80x24.org>; Fri, 26 Oct 2018 01:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbeJZJts (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Oct 2018 05:49:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43167 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbeJZJtr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Oct 2018 05:49:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id t10-v6so11114302wrn.10
        for <git@vger.kernel.org>; Thu, 25 Oct 2018 18:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=l+S3JMtGUZziKUIDjvP5dOmt+jM2s/HoUSet82wa73c=;
        b=VnFXTAu/LW0wo/yBM3aCAVNZSFZKAsQUZ0nNjsvLFus2fU/MbPoRLK6YKVixkUf2hl
         RMb7rAVHjQnhczRL+Hu+pgP3g161MUMWohw3K0kQKByG5Ep7sRZiBvDJJlwaO/I2jJEu
         VZ8tlhTwEJ5U8OfDy/gp2gLJubcH6WeDKFNpGSRGC5uXa1QIGu8fkKrQPmbiM9ECUK13
         rrUe7RM5+I2vvenZH1xffmbxYDVxwewgGf8g/b75vmc8lsvWaj6pN2+5qJJko0t2czxT
         BdMyNmJ2Y3rcHwlOdKt9VtZalscU/vpOzTwty4dCjPnItV7HwzJTY+HX9pBNmLKGTVLw
         Yv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=l+S3JMtGUZziKUIDjvP5dOmt+jM2s/HoUSet82wa73c=;
        b=PKK8sJqrMriTUkxwfXrt1emBgAPTe9YsiLFZ0mMC4g3CSHK7eAlexPFkm3cgUVFgGA
         3pn4GMuTioBrI2q59lk1xM4jJKAodG4sdLh60gy6PxZjoItoGxak/fcv1NQIxGRaUqWF
         6imqoqiWby74NoTO9L/2yH4jy8tvBHIJXN9jWK2F9Rd+ox7fXguwCpMTBWsosVWvf9xv
         4vfUVb/j1mcRr00Db33HI6CY1YI4Q37lILiA5a3S9GvEn7t9lYpBMFl3QcbQBYKTd48n
         TfJV9XWuOuP+UMRBO7Mn+L315yyGvYrrRA7wymisOsUYycqGF29Uj0inzPh/PVyqkSHm
         ZNBg==
X-Gm-Message-State: AGRZ1gI9bsIlCNKxYafu6eTPEsDjTBrjMD1BX+jfhzJW6sKpHNnCM6W9
        Typ1R2KF7ZIGCWmWAO0vlfk=
X-Google-Smtp-Source: AJdET5dJ+NMj+rBAFFc5D05HFb6iEx25x/oay/mffkTcPh31tvuaL6axZkSFYamY2gryH1dGg7HmDg==
X-Received: by 2002:a5d:4a89:: with SMTP id o9-v6mr4046780wrq.132.1540516491006;
        Thu, 25 Oct 2018 18:14:51 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x8-v6sm20887352wrd.54.2018.10.25.18.14.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 18:14:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     steadmon@google.com, git@vger.kernel.org
Subject: Re: [PATCH v5] archive: initialize archivers earlier
References: <39a4e7bf8f3ebc5803393f357d1ee7dc9806252f.1540251936.git.steadmon@google.com>
        <c85673cee76c1c4a7e2b2a489d6139f5c89ba88c.1540499413.git.steadmon@google.com>
        <20181025211203.GA23050@sigill.intra.peff.net>
Date:   Fri, 26 Oct 2018 10:14:49 +0900
In-Reply-To: <20181025211203.GA23050@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 25 Oct 2018 17:12:04 -0400")
Message-ID: <xmqq5zxpfr06.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Oct 25, 2018 at 01:32:14PM -0700, steadmon@google.com wrote:
>
>> Initialize archivers as soon as possible when running git-archive.
>> Various non-obvious behavior depends on having the archivers
>> initialized, such as determining the desired archival format from the
>> provided filename.
>> 
>> Since 08716b3c11 ("archive: refactor file extension format-guessing",
>> 2011-06-21), archive_format_from_filename() has used the registered
>> archivers to match filenames (provided via --output) to archival
>> formats. However, when git-archive is executed with --remote, format
>> detection happens before the archivers have been registered. This causes
>> archives from remotes to always be generated as TAR files, regardless of
>> the actual filename (unless an explicit --format is provided).
>> 
>> This patch fixes that behavior; archival format is determined properly
>> from the output filename, even when --remote is used.
>
> Thanks, this version looks great to me!

To me too.  Thanks, both.
