Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F7141FA14
	for <e@80x24.org>; Sun, 16 Apr 2017 04:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbdDPEov (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 00:44:51 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:65404 "EHLO
        alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750928AbdDPEou (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 16 Apr 2017 00:44:50 -0400
X-AuditID: 1207440c-abdff70000002e8f-27-58f2f6bdacde
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 7E.00.11919.DB6F2F85; Sun, 16 Apr 2017 00:44:48 -0400 (EDT)
Received: from [192.168.69.190] (p5B1058DF.dip0.t-ipconnect.de [91.16.88.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v3G4ihuA021112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 16 Apr 2017 00:44:44 -0400
Subject: Re: [PATCH v2 04/20] refs_verify_refname_available(): implement once
 for all backends
To:     Duy Nguyen <pclouds@gmail.com>
References: <cover.1490966385.git.mhagger@alum.mit.edu>
 <22abd274bfdada94b3654a811ee209822640765f.1490966385.git.mhagger@alum.mit.edu>
 <CACsJy8CZwPN06Q4OFmbjh8iCigZbrTUGU20hmxNCDRiAbB+KVA@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>,
        Git Mailing List <git@vger.kernel.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <b9383ff6-10ce-cbb5-8f55-6d5f32361c10@alum.mit.edu>
Date:   Sun, 16 Apr 2017 06:44:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8CZwPN06Q4OFmbjh8iCigZbrTUGU20hmxNCDRiAbB+KVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1D3w7VOEwefD5hZrn91hsui60s1k
        0dB7hdliycPXzBbdU94yWvxo6WG22Ly5ncWB3WPnrLvsHgs2lXp0tR9h83jWu4fR4+IlZY/P
        m+QC2KK4bFJSczLLUov07RK4Mrpa9zMWvOSpePxnLnMD4wrOLkZODgkBE4mJ6z6wdzFycQgJ
        7GCSuHthIjOEc45J4uOcXiaQKmGBBIn/O5aygtgiAkoSbzq2QRWdZ5T48ncyE4jDLDCRSeLE
        l4dgHWwCuhKLeprBbF4Be4nJ53+wgdgsAqoSO/5+BIuLCoRIzFn4gBGiRlDi5MwnLCA2p0Cg
        xMuZO8FsZgF1iT/zLjFD2PIS29/OYZ7AyD8LScssJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqs
        W5ycmJeXWqRrqJebWaKXmlK6iRES6jw7GL+tkznEKMDBqMTDa+H/KUKINbGsuDL3EKMkB5OS
        KK9rzMcIIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8P04DlfOmJFZWpRblw6SkOViUxHlVl6j7
        CQmkJ5akZqemFqQWwWRlODiUJHhvfgVqFCxKTU+tSMvMKUFIM3FwggznARr+FqSGt7ggMbc4
        Mx0if4pRUUqc9/YXoIQASCKjNA+uF5aKXjGKA70izNsJ0s4DTGNw3a+ABjMBDWaY/AFkcEki
        QkqqgbFdLqo+vvOvy5Hr7KEN1068/dmZ3+tVfdL5vNFa21MObkx697S+bze6HcGX8Uo9VWV+
        ypeb045pVT9yyLWIOXPy3vTVsSu+2Gzf+8bV54us++aKZ9YMfBcXhCmqyf9SWqGzyqToY+ss
        /se2kt0RalsMrEOiTcN+bJFp++mSH2Kve+DK8czCo0osxRmJhlrMRcWJAHI6bWcgAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/07/2017 01:20 PM, Duy Nguyen wrote:
> On Fri, Mar 31, 2017 at 9:11 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> It turns out that we can now implement
>> `refs_verify_refname_available()` based on the other virtual
>> functions, so there is no need for it to be defined at the backend
>> level. Instead, define it once in `refs.c` and remove the
>> `files_backend` definition.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  refs.c               | 85 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>>  refs.h               |  2 +-
>>  refs/files-backend.c | 39 +++++-------------------
> 
> Much appreciated. This will make future backends simpler to implement as well.
> 
>> +       iter = refs_ref_iterator_begin(refs, dirname.buf, 0,
>> +                                      DO_FOR_EACH_INCLUDE_BROKEN);
>> +       while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
>> +               if (skip &&
>> +                   string_list_has_string(skip, iter->refname))
>> +                       continue;
>> +
>> +               strbuf_addf(err, "'%s' exists; cannot create '%s'",
>> +                           iter->refname, refname);
>> +               ok = ref_iterator_abort(iter);
> 
> Saving the return code in "ok" seems redundant because you don't use
> it. Or did you want to check that ok == ITER_DONE or die() too?

True, setting `ok` here is redundant. I don't think there's much point
worrying about whether `ref_iterator_abort()` fails here, since we've
already gotten the information that we require.

I'll remove it.

Thanks,
Michael

