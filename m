Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291BDC433EF
	for <git@archiver.kernel.org>; Mon,  7 Feb 2022 14:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390951AbiBGO1p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 09:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390928AbiBGOFU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 09:05:20 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AF0C043181
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 06:05:19 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id w11so25024572wra.4
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 06:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=29n9RdbKCYMsc1yV5FhTzLhlqPFMZGPFpaC83hguj+w=;
        b=JRonOvJfu/nvQWdOgS0CpTPRkFSphX6DdsRTZcJYQZJ+bxECyq4I99MdqP3VWCg1X9
         jP5VAVazySc1PTpuqEpifRXvuYkz/iIY6iifc9SgkR3GtVHmn/clEjQMxQeGwJsbqa5q
         lEAUIM41o+glrnDklTsXpqMatD4IHkUe0ZMw/Az3ItL1KVUHjKR/3HatKRKSfqOYLSpR
         Rnmy1V30BKUwHZv9S4bcZ8YCvpb5jzEmmW3H6bfDGrVz2u+0EHOhiI2tnwMCh0w5c+LT
         8PEv4SnoZsfVQeH6JjueV66SSUEeTy/LIg0XYzfhy/cacNDF26Ei0HoS23ILxC1Xcqak
         cZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=29n9RdbKCYMsc1yV5FhTzLhlqPFMZGPFpaC83hguj+w=;
        b=ubCG2tIzds3O0LY+jwp3wQAXhls2Y4kgpj0+h0SJzsKnDo3olJeVbEkZtWhziPjosf
         pWApy5QMpdD4Ezq6gjy0K4cwDRgt9eokK0NsmmC91kbLSzRBW2FDzjsLJwHaxkDZmDyn
         6XV5TG8b69VZW3VdxufFAqTz/NMAU/g2SSJXwLkjkRKVt7bPIloB8J3m9wgt3xMQp9uR
         AvTHhHtyPZiN0/m7brXZEZe1W6pk0a/e88JTb8wUs363gfAGvAVZ6qQ0AW+Mwx39GW7Y
         YfDNU2iuwSqKEm7NjAaEs5F/bG7VQpGHQi49dP+QRdBA5OzzswzH5/+v45GMlGmrL72M
         m7nQ==
X-Gm-Message-State: AOAM533EMH8iCA8B6TwCwNnswANDQpR3xUFcbNuez8G18i0tIq9Fa6pR
        wqyF1ngb18ESK7wVUAF4Hs+uwCweunk=
X-Google-Smtp-Source: ABdhPJzPJiZoBbu5XARMynHehh8Ip+c2g1Gl7PN3O1cY3HWEuQpI2AuBzDZ7nykJIHvlDqU8hdyhWg==
X-Received: by 2002:a05:6000:1548:: with SMTP id 8mr9979096wry.242.1644242718082;
        Mon, 07 Feb 2022 06:05:18 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id d7sm3470212wrw.98.2022.02.07.06.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 06:05:17 -0800 (PST)
Message-ID: <e557db22-038b-cb78-9518-3873d7d69ee8@gmail.com>
Date:   Mon, 7 Feb 2022 14:05:16 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: git-checkout doesn't seem to respect config from include.path
Content-Language: en-US
To:     Greg Hurrell <greg@hurrell.net>, phillip.wood@dunelm.org.uk,
        git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
References: <ee1dd453-e698-440a-911b-d14389e33715@beta.fastmail.com>
 <0b8222c2-7337-7e8f-33d1-7926462daac1@gmail.com>
 <3f1972f3-c764-41e9-9853-8f1c303d4f6b@beta.fastmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <3f1972f3-c764-41e9-9853-8f1c303d4f6b@beta.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Greg

On 03/02/2022 17:39, Greg Hurrell wrote:
> On Thu, Feb 3, 2022, at 4:54 PM, Phillip Wood wrote:
>> Hi Greg
>>
>> On 02/02/2022 16:04, Greg Hurrell wrote:
>>
>>> `git config --get merge.conflictStyle` correctly reports that my setting is
>>> "diff3" on such machines, and `git config --get-all merge.conflictStyle`
>>> shows:
>>>
>>>       diff3
>>>       zdiff3
>>>
>>> In other words, it knows that I have multiple values set, but it uses
>>> a last-one-wins policy.
>>>
>>> However, when I try to run a command like `git checkout -b something`,
>>> Git dies with:
>>>
>>>       fatal: unknown style 'zdiff3' given for 'merge.conflictstyle'
>>
>> I think what is happening is that git parses each line of the config
>> file as it reads it so the old version of git sees "zdiff3" and errors
>> out before it reads the include line.
> 
> That gave me the idea of moving the `include.path` setting higher up in
> the file, to see if `git checkout` would consult that value first, but
> it doesn't work; `git config merge.conflictStyle` shows the value from
> the file indicated in `include.path`, but a command like `git checkout`
> still dies based on the value in ~/.gitconfig.

Yes, you need to move the "zdiff3" setting into an include file that is 
only read by recent versions of git.

> Overall this points to the general problem that it is not only hard to
> make a single config that works on different machines, but it's hard to
> make a _combination_ of files that works on different machines.

If you make sure that you are only including files containing recent 
config keys on machines running recent git versions then it should work 
but arranging for that to happen is not necessarily easy

Best Wishes

Phillip

> For now, I think my workaround is going to be templating out
> machine-specific files.
> 
> Greg
> 

