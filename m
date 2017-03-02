Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E92141F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 13:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752773AbdCBNPA (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 08:15:00 -0500
Received: from mail-oi0-f46.google.com ([209.85.218.46]:36597 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbdCBNO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 08:14:57 -0500
Received: by mail-oi0-f46.google.com with SMTP id f192so38750013oic.3
        for <git@vger.kernel.org>; Thu, 02 Mar 2017 05:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CA2kp5b3rcGJkBNP/lYMy6nolMVXUF6dBMMfD3PlLs0=;
        b=uGwraFwv03HWBOv8uBQae/XmIUwoRAxD4fY0nIfG2KWUw0ocAj1mWYVRpD8MfoQVP6
         3jPe9oNMg3Z/kvxSfUmPwOuhxjhCJYZA9WtnnfEi9BaC9SW9rbPXL0mpgz4UOYJSlBWI
         70EE7RP/1nG++Kskbj9oMEVywjeGd0GumKbqAabcB0uZ6EUW7f2dXmTxxVUMpAxkJmj9
         u4GA8HhKs7kWS6FMZtLBbb1BXDNIcNxQJaJ26KdEIuDNO34p7NP0VsEhGhsTgI6HWzRk
         pPfl1XjC2UErwAssVZTDAWmQRclkyDNl+Haure3lXDt+qvupBkryS6P/NoIHawUVUnWH
         H9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CA2kp5b3rcGJkBNP/lYMy6nolMVXUF6dBMMfD3PlLs0=;
        b=Bu+xxfj2KvYy/6RNRupvGanvpyNwaa/ECzPwJbIMr4aIqtDlOhLKxE6eiUrsUotBtu
         k0hO89+6yQkwmAiAaanWzrqxRgApmI3xXuDgB3OhL7QU3CAYxpG7IBY0p2R/ZaPLo0jI
         Q3t/WOlq7Fq5zQgsgnyyAL3jm8xGBdmx91MlVFUraILynb+KOuJ0GAezH+GjQO5u5u20
         C22wuR83RaLU/rQ4g6ns4s4UnZmvp1Yih5CSofkxlGtWe+nW0qtNBBCicq8YjwseghnG
         gPFvyDRxIpbFWJ0tI0EWODTkkMPNDmcVYA140Q6CbT7wUytRzFSv0sYuEHlh2qmNXDIF
         4g6A==
X-Gm-Message-State: AMke39lr98cslWcOmc1B6P/4RyVUhpDygNRNdEQX8blmPVjZb08DIX/gM5UZhoLeg8EOCq2TuDTqx9We7xYQ1Q==
X-Received: by 10.202.181.135 with SMTP id e129mr6720344oif.124.1488458621987;
 Thu, 02 Mar 2017 04:43:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Thu, 2 Mar 2017 04:43:11 -0800 (PST)
In-Reply-To: <5c4a292e-ab86-ffe0-ba8d-c0fe1b527ec1@alum.mit.edu>
References: <20170218133303.3682-1-pclouds@gmail.com> <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-9-pclouds@gmail.com> <5c4a292e-ab86-ffe0-ba8d-c0fe1b527ec1@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 2 Mar 2017 19:43:11 +0700
Message-ID: <CACsJy8DhMdtzmK6-1MmTKf_SpyeR23CJ0kU=LGHOsMXw+90yBw@mail.gmail.com>
Subject: Re: [PATCH v5 08/24] files-backend: remove the use of git_path()
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2017 at 12:50 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> @@ -995,7 +998,11 @@ static struct ref_store *files_ref_store_create(const char *submodule)
>>               return ref_store;
>>       }
>>
>> -     refs->packed_refs_path = git_pathdup("packed-refs");
>> +     refs->gitdir = xstrdup(gitdir);
>> +     get_common_dir_noenv(&sb, gitdir);
>> +     refs->gitcommondir = strbuf_detach(&sb, NULL);
>> +     strbuf_addf(&sb, "%s/packed-refs", refs->gitcommondir);
>> +     refs->packed_refs_path = strbuf_detach(&sb, NULL);
>
> `git_path()` and friends avoid adding an extra `/` if `git_dir()`
> already ends in a slash or if it is the empty string. Here you don't
> have that functionality. Is that intentional?

Kind of. I noticed that behavior but the thinking was, this $GIT_DIR
thing is going to get replaced soon anyway, and because the the uses
of these paths are very clear (in three groups) that avoiding
redundant slashes does not buy us anything extra, it's just more code.
-- 
Duy
