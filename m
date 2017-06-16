Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54CFB20282
	for <e@80x24.org>; Fri, 16 Jun 2017 06:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752462AbdFPGnZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 02:43:25 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:51972 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752436AbdFPGnT (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Jun 2017 02:43:19 -0400
X-AuditID: 1207440c-631ff70000002ef9-dc-59437e0472fb
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 45.5E.12025.40E73495; Fri, 16 Jun 2017 02:43:18 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCABB.dip0.t-ipconnect.de [87.188.202.187])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5G6hAT9031919
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 16 Jun 2017 02:43:14 -0400
Subject: Re: [PATCH 04/28] packed_ref_store: move `packed_refs_lock` member
 here
To:     Stefan Beller <sbeller@google.com>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
 <eea8f3d25e9d3d3a0b63604338f10cfa658bbb43.1497534157.git.mhagger@alum.mit.edu>
 <CAGZ79ka3u_otP6M+oRBb4dQdMQx6kFHaXihLsBpM23gqzwqOGw@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <bf1fcee3-2f2f-b153-5774-dee5b2a2790d@alum.mit.edu>
Date:   Fri, 16 Jun 2017 08:43:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79ka3u_otP6M+oRBb4dQdMQx6kFHaXihLsBpM23gqzwqOGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqMtW5xxp0PxS3WLtsztMFs/Xn2C3
        6LrSzWTR0HuF2WLJw9fMFt1T3jJa/GjpYbbYvLmdxYHDY+esu+weCzaVenS1H2HzeNa7h9Hj
        4iVlj8+b5ALYorhsUlJzMstSi/TtErgyZsw8z1jwnbOi6d9htgbGV+xdjJwcEgImEmvfrWTr
        YuTiEBLYwSTx5vAbFpCEkMAFJon2uYwgtrBAkMS73ulMILaIgJrEzFWzoRrOM0rMXXiFCcRh
        FvjNJPHo+16wKjYBXYlFPc1gNq+AvcTDI9vAprIIqErcWDEdzBYViJB42LmLHaJGUOLkzCdg
        cU6BQIm9n1+ygdjMAuoSf+ZdYoaw5SW2v53DPIGRfxaSlllIymYhKVvAyLyKUS4xpzRXNzcx
        M6c4NVm3ODkxLy+1SNdQLzezRC81pXQTIyTkeXYwflsnc4hRgINRiYdXocEpUog1say4MvcQ
        oyQHk5IoL78cUIgvKT+lMiOxOCO+qDQntfgQowQHs5II7+dg50gh3pTEyqrUonyYlDQHi5I4
        r+oSdT8hgfTEktTs1NSC1CKYrAwHh5IEb0stUKNgUWp6akVaZk4JQpqJgxNkOA/QcP9KkOHF
        BYm5xZnpEPlTjIpS4rzBIM0CIImM0jy4XlhKesUoDvSKMO+xGqAqHmA6g+t+BTSYCWhw0AUH
        kMEliQgpqQbGlk9vpXTrzMVDzwud6l/5im1KQ4dZ0snjnHmeYnFn8hXWOvC5lAk+387Z2bH1
        6FqZWZbxnRcinv7fLn9puv6jjYXhJzvUV/2w9LHPlV61XYP52sJ/M6euSspTfaL9pru4Wsg3
        YUfS123nclWs50u1vX+h479T4iBT8PHZ/4PeT94eZhev/b5WiaU4I9FQi7moOBEA2d5b4SQD
        AAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/16/2017 07:39 AM, Stefan Beller wrote:
> On Thu, Jun 15, 2017 at 7:47 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> [...]
>> @@ -125,7 +125,7 @@ static void clear_packed_ref_cache(struct files_ref_store *refs)
>>         if (refs->packed_ref_store->cache) {
>>                 struct packed_ref_cache *packed_refs = refs->packed_ref_store->cache;
>>
>> -               if (is_lock_file_locked(&refs->packed_refs_lock))
>> +               if (is_lock_file_locked(&refs->packed_ref_store->lock))
> 
> I sort of stumble over the name due to singular/plural/genetive issues:
> The store contains multiple of "packed ref"(s) or the store is specialized in
> packed ref(s). On the other hand in English you seem to reference the
> specialisation of a store in singular: It's a "gun store" (not "guns store")
> or "furniture store" or "fresh fish store" (though that could be
> plural as well).
> 
> It just sounded odd to me. (though think of it as a minor nit)

I chose that name because it is a `ref_store`, with `packed_` being a
short prefix that tells what kind of `ref_store`.

The next question is, why `ref_store` as opposed to `refs_store`? To me
it sounds more natural in English for the reasons that you mentioned.

Michael

