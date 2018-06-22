Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9A3D1F516
	for <e@80x24.org>; Fri, 22 Jun 2018 22:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754451AbeFVW3H (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 18:29:07 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35092 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751377AbeFVW3H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 18:29:07 -0400
Received: by mail-pl0-f65.google.com with SMTP id k1-v6so4097987plt.2
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 15:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oxHjk3YCYEJI1aCh0Pfm6M0bam1aRU8m2FIhoQnzlY4=;
        b=STxCkmVkZxJyUBkWZ6M0W1ofRyKkEnaLTo3cmsxOKbBBYMpTHA+e0TlmMenaWhGeA5
         qDOrszF43/u77RJ4R7LI0+F0/o+Gnv9yhIwHVZ2AbJ8IvRo/diw8uqKHQAbc8a6+2DrE
         BRLkYSBizdX34i7bPDnvZsZRtAS3phuUo0db1oFsAL+1o1nKcBcsnwhXMNQ+ho8xn3dv
         c5005Y4tAu8qRD/6SMw/KvbZcjos5Jfa09WJbgLwagJcay8NaaX512iNjiIgCDySUz8s
         cLwQ5Ez1GsKHsdiVDf5ikpmKiq4eRs8YaalHapJXjSe4S9iKz7rCtETBpsVQW1oZVlpQ
         I/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oxHjk3YCYEJI1aCh0Pfm6M0bam1aRU8m2FIhoQnzlY4=;
        b=DW9CYCr4mR/n1an5GNkPp6r5UVaT6YKfJNu2R94350XIJH0+tIQ2Gj83HHSOmSN+DV
         qFudaxQlpnLNPsmq5mLzklXTa95ncVnQmxFB4aJSBQKvYaGNyXi0KPhqUYpdZLieiyKl
         7PankUdfJFnQo1OYV1dnfKOK/NQh7zdJ6MC2ZnstQC+lzhEjnsGM1OxkYTkSA5pYI+vn
         BWrqD/oBpji34NIqLf5Ii3BbxJdCoE4RAkNsaxjsnuIzwNzVTrSuXn2W57s36aqblqQz
         alAZX+ebjgKkW5cqBIQdklD+GgG175THYk7/hzwWbNwO3XDDwdKrX5I98MiDbyczc9Q8
         2U5w==
X-Gm-Message-State: APt69E0RfoEQDfawVYM5vriupqzgS7OIhpiQ4xbPzV2s8mZfQ36e65WN
        xnpvEZimfGIbVL1MqVuUDDM=
X-Google-Smtp-Source: ADUXVKLhN2DnQR86+JCkYGIfi4OyFp1JaQu58TugF/PGYM0tRqLCAXaFxFVei6VxHHuEHaDYBcOFEA==
X-Received: by 2002:a17:902:301:: with SMTP id 1-v6mr3336690pld.127.1529706546393;
        Fri, 22 Jun 2018 15:29:06 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id x5-v6sm12266082pfh.67.2018.06.22.15.29.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 15:29:05 -0700 (PDT)
Date:   Fri, 22 Jun 2018 15:29:04 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        avarab@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v2 8/8] fetch-pack: implement ref-in-want
Message-ID: <20180622222903.GK12013@aiede.svl.corp.google.com>
References: <20180605175144.4225-1-bmwill@google.com>
 <20180613213925.10560-1-bmwill@google.com>
 <20180613213925.10560-9-bmwill@google.com>
 <CAGZ79kZGV7NeYGpt=BJTASZYva3pyY-2CxMmDMXXxuZeg4sfjQ@mail.gmail.com>
 <20180614211842.GA68349@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614211842.GA68349@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:
> On 06/14, Stefan Beller wrote:
> > On Wed, Jun 13, 2018 at 2:39 PM Brandon Williams <bmwill@google.com> wrote:

>>> +               for (r = refs; r; r = r->next) {
>>> +                       if (!strcmp(end, r->name)) {
>>> +                               oidcpy(&r->old_oid, &oid);
>>> +                               break;
>>> +                       }
>>> +               }
>>
>> The server is documented as MUST NOT send additional refs,
>> which is fine here, as we'd have no way of storing them anyway.
>> Do we want to issue a warning, though?
>>
>>     if (!r) /* never break'd */
>>         warning ("server send unexpected line '%s'", reader.line);
>
> Depends, does this warning help out the end user or do you think it
> would confuse users to see this and still have their fetch succeed?

I think we'd want to error out instead of warning.  That keeps the
spec simple and that way, server implementors will notice early if
they are doing something that clients aren't going to understand
anyway, which would benefit users.

Thanks,
Jonathan
