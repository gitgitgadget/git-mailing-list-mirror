Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB1DB2023D
	for <e@80x24.org>; Wed,  1 Mar 2017 12:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751845AbdCAMdV (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 07:33:21 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:42315 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751527AbdCAMdU (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 Mar 2017 07:33:20 -0500
X-AuditID: 12074411-4bfff700000005a9-2a-58b6bf255273
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 98.18.01449.52FB6B85; Wed,  1 Mar 2017 07:31:34 -0500 (EST)
Received: from [192.168.69.190] (p57907E3C.dip0.t-ipconnect.de [87.144.126.60])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v21CVTme008793
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 1 Mar 2017 07:31:30 -0500
Subject: Re: [PATCH v5 12/24] refs.c: kill register_ref_store(), add
 register_submodule_ref_store()
To:     Duy Nguyen <pclouds@gmail.com>
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-13-pclouds@gmail.com>
 <92ff53b6-8a85-9be8-e14f-18eb1fcaf732@alum.mit.edu>
 <CACsJy8BvKvo8_bRHH++dp53DaPbDVkKU0EUQC7ofYvBo+Tec0Q@mail.gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <f0821bd8-dda5-1b11-e66f-8fa4ab169778@alum.mit.edu>
Date:   Wed, 1 Mar 2017 13:31:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8BvKvo8_bRHH++dp53DaPbDVkKU0EUQC7ofYvBo+Tec0Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqKu2f1uEwbvbrBZdV7qZLBp6rzBb
        9C/vYrNY8vA1s0X3lLeMFjOvWlts3tzO4sDusXPWXXaPDx/jPBZsKvXoaj/C5nHxkrLH/qXb
        2Dw+b5ILYI/isklJzcksSy3St0vgyvh+bClbwVOuirdNm5kaGE9zdDFyckgImEg8md7D1MXI
        xSEksINJYkrjEkYI5xyTRNf+L+wgVcICqRJnXn9mArFFBJQk3nRsY4Yo6mWSeLD6IjuIwyww
        i0ni4t5FbCBVbAK6Eot6msE6eAXsJU6ensMIYrMIqEj8e/2ZFcQWFQiRmLPwASNEjaDEyZlP
        WEBsToFAialts8DmMAuoS/yZd4kZwpaX2P52DvMERv5ZSFpmISmbhaRsASPzKka5xJzSXN3c
        xMyc4tRk3eLkxLy81CJdU73czBK91JTSTYyQgBfcwTjjpNwhRgEORiUe3ozOrRFCrIllxZW5
        hxglOZiURHl3r9oWIcSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEN6AFKMebklhZlVqUD5OS5mBR
        EuflW6LuJySQnliSmp2aWpBaBJOV4eBQkuB9uReoUbAoNT21Ii0zpwQhzcTBCTKcB2i40j6Q
        4cUFibnFmekQ+VOMilLivF9BmgVAEhmleXC9sIT0ilEc6BVh3lsgVTzAZAbX/QpoMBPQ4Bcq
        W0EGlyQipKQaGLX8BJ1tLiz+ZVgf6ZYjcFHoTPTqy/uXiVsf0VV1nuc8T4Pt4mQmzgi90xzb
        zVU8/rPF13jdXKJfl8CuyvVk+6G4At6m5TMeMz54xdaR4VW5on79r5ZD2heFSrb/XKV2kGXK
        XL0i7pq1tf6Cq4M3mv79Krqtn1v4alniMh2XF5ztF07XaPJZKbEUZyQaajEXFScCAD5QH4Aj
        AwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/01/2017 01:00 PM, Duy Nguyen wrote:
> On Wed, Mar 1, 2017 at 1:03 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>>  struct ref_store *get_ref_store(const char *submodule)
>>>  {
>>>       struct strbuf submodule_sb = STRBUF_INIT;
>>> @@ -1480,6 +1479,9 @@ struct ref_store *get_ref_store(const char *submodule)
>>>       if (is_nonbare_repository_dir(&submodule_sb))
>>>               refs = ref_store_init(submodule);
>>>       strbuf_release(&submodule_sb);
>>> +
>>> +     if (refs)
>>
>> I think `refs` should always be non-NULL here for the same reason.
> 
> That's true if is_nonbar_repo... returns true. If it's false (e.g.
> uninitialized submodule) then refs remains NULL from before (I didn't
> know about this until I hit a segfault in rev-list in another series)

Oh, yes, true.

But given that, I think the code would be clearer if the two calls were
in the same if; i.e.,

 	refs = lookup_submodule_ref_store(submodule);
 	if (refs)
 		return refs;

 	strbuf_addstr(&submodule_sb, submodule);
 	if (is_nonbare_repository_dir(&submodule_sb)) {
 		refs = ref_store_init(submodule);
		register_submodule_ref_store(refs, submodule);
	}
 	strbuf_release(&submodule_sb);

 	return refs;

or even the `if (!is_nonbare_repository_dir(...)) goto cleanup;` pattern
to make it clearer that this is an error return.

Michael

