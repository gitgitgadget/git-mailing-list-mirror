Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11CBD1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 13:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752241AbeCUNYO (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 09:24:14 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:37791 "EHLO
        mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752206AbeCUNYI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 09:24:08 -0400
Received: by mail-qk0-f175.google.com with SMTP id w6so5354966qkb.4
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 06:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eQuUZ9VCsKNoGazpQVwPnFoPeUXewSNlC67+u41AD94=;
        b=Rg8SRKQHZDiWU6vf4Ku3N1umDR90UfoVAoltERf9hfd3FZEgPOCyjlslo4Btqy0QAV
         0V78U0CIhM57PVlb0AfrjkQireDe62PNVeEdfijLYpy5xKXFGE9R41zl6H7GUMvb+nr8
         An7qnFkYXW+fR7/rsho2FrjNOPgWk2o/Gx/BwAQQSvdr7WM5pQO6P9p6YdVBW0fjCTzc
         umN1EK69e/HFZ9X03bGMsCtKGQywxFtfeiUlk5pYPTayKswoeiEmA93kToHv191umLsH
         ERbKl2Mnv95ZmJZ3y9g+YVXx+gG0gnl3M7ug5eYMcNcMrP8at5crVeUVeBAja56LsRgM
         p5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eQuUZ9VCsKNoGazpQVwPnFoPeUXewSNlC67+u41AD94=;
        b=nE+Xh9IS5uuk3mXaSrUw0EoSj+rBs9JF1KzsvNge7WBa3sMiY91P/pvvpCdqtxDhR6
         NcmztWW31t3uBPf05/emDsE7h6nAaF3hjsdVUtcLsBFftXqqa/RVDSNchacmwd5UsfuG
         s2ngZ4+tfyb2DFECK9d69o/6t55Z15Dc4Bj+XyN1PswuhU9xfxfhrpiVmF6WSNXQY85r
         YnHBLeeVqCm5oYO3swDj5MkziLlCuZ+Uq96QvPLGpOEFJ1VnA3fGyzzjoVHb3mnpGUoS
         DKxReuAWqH+dY6lDXKi3rdG2rdtQVYNS1BoGFSYxB+UJitogJ95uLk9+ykNknbfk53xW
         aOKQ==
X-Gm-Message-State: AElRT7HA1f5/krP/HFiWCeebNLY7BbdXi0T+WBv3omZ7v3o8GDmOTQct
        WuO6r9NFSk0+xlGdvsX2Juc=
X-Google-Smtp-Source: AG47ELv2ZguhtkNgcf9RzTJ/4t7eREIEOLij7xjB4uvEVBjE9N4JC7eserv8X6nz0DI7FGwzayrqmg==
X-Received: by 10.55.54.73 with SMTP id d70mr29571527qka.260.1521638647954;
        Wed, 21 Mar 2018 06:24:07 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:7958:a7a2:ce38:c953? ([2001:4898:8010:0:628e:a7a2:ce38:c953])
        by smtp.gmail.com with ESMTPSA id m127sm3076986qkd.90.2018.03.21.06.24.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Mar 2018 06:24:07 -0700 (PDT)
Subject: Re: [PATCH] sha1_name: use bsearch_hash() for abbreviations
To:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net
References: <20180320200325.168147-1-dstolee@microsoft.com>
 <20180320152505.bd66f0deaecf6d92fa6d62de@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3527bd3a-a899-a909-5fda-1d7abeb0e158@gmail.com>
Date:   Wed, 21 Mar 2018 09:24:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320152505.bd66f0deaecf6d92fa6d62de@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/20/2018 6:25 PM, Jonathan Tan wrote:
> On Tue, 20 Mar 2018 16:03:25 -0400
> Derrick Stolee <dstolee@microsoft.com> wrote:
>
>> This patch updates the abbreviation code to use bsearch_hash() as defined
>> in [1]. It gets a nice speedup since the old implementation did not use
>> the fanout table at all.
> You can refer to the patch as:
>
>    b4e00f7306a1 ("packfile: refactor hash search with fanout table",
>    2018-02-15)
>
> Also, might be worth noting that this patch builds on
> jt/binsearch-with-fanout.

Thanks. That commit is in master and v2.17.0-rc0, so hopefully it isn't 
difficult to apply the patch.

>
>> One caveat about the patch: there is a place where I cast a sha1 hash
>> into a struct object_id pointer. This is because the abbreviation code
>> still uses 'const unsigned char *' instead of structs. I wanted to avoid
>> a hashcpy() in these calls, but perhaps that is not too heavy a cost.
> I recall a discussion that there were alignment issues with doing this,
> but I might have be remembering wrongly - in my limited knowledge of C
> alignment, both "unsigned char *" and "struct object_id *" have the same
> constraints, but I'm not sure.

Adding Brian M. Carlson in the CC line for advice on how to do this 
translation between old sha1's and new object_ids. If it isn't safe, 
then we could do a hashcpy() until the translation makes it unnecessary.

I should have compared the two methods before sending the patch, but 
running the "git log --oneline --parents" test with a hashcpy() versus a 
cast has no measurable difference in performance for Linux. Probably 
best to do the safest thing here if there is no cost to perf.

>
>> +	const unsigned char *index_fanout = p->index_data;
> [snip]
>> +	return bsearch_hash(oid->hash, (const uint32_t*)index_fanout,
>> +			    index_lookup, index_lookup_width, result);
> This cast to "const uint32_t *" is safe, because p->index_data points to
> a mmap-ed region (which has very good alignment, as far as I know). I
> wonder if we should document alignment guarantees on p->index_data, and
> if yes, what guarantees to declare.

The existing application in find_pack_entry_one() [1] does similar 
pack-index arithmetic before calling. A similar amount of arithmetic and 
alignment concerns appear in the commit-graph patch. Where is the right 
place to declare these alignment requirements?

In v2, I'll have find_pack_entry_one() call bsearch_pack() so this logic 
is not duplicated.

Thanks,
-Stolee

[1] 
https://github.com/git/git/blob/c6284da4ff4afbde8211efe5d03f3604b1c6b9d6/packfile.c#L1721-L1749
     find_pack_entry_one() in packfile.c
