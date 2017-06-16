Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F23D620282
	for <e@80x24.org>; Fri, 16 Jun 2017 06:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbdFPGql (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 02:46:41 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:55651 "EHLO
        alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751879AbdFPGqk (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Jun 2017 02:46:40 -0400
X-AuditID: 12074411-f47ff70000007ac9-df-59437ecde6c9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 03.43.31433.DCE73495; Fri, 16 Jun 2017 02:46:38 -0400 (EDT)
Received: from [192.168.69.190] (p57BCCABB.dip0.t-ipconnect.de [87.188.202.187])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v5G6kYnY032017
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Fri, 16 Jun 2017 02:46:35 -0400
Subject: Re: [PATCH 15/28] packed_peel_ref(): new function, extracted from
 `files_peel_ref()`
To:     Stefan Beller <sbeller@google.com>
References: <cover.1497534157.git.mhagger@alum.mit.edu>
 <f9c4c47e52c076c42896d22d89591a93163afda3.1497534157.git.mhagger@alum.mit.edu>
 <CAGZ79kbeJk5PmJVdLva-VauLPa4MbQdNRWfQmyHtVqVa3JDL+A@mail.gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <db616bc6-4d31-6f7c-4862-9161f4bb36ce@alum.mit.edu>
Date:   Fri, 16 Jun 2017 08:46:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kbeJk5PmJVdLva-VauLPa4MbQdNRWfQmyHtVqVa3JDL+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsUixO6iqHuuzjnSYPYLdYu1z+4wWTxff4Ld
        outKN5NFQ+8VZoslD18zW3RPecto8aOlh9li8+Z2FgcOj52z7rJ7LNhU6tHVfoTN41nvHkaP
        i5eUPT5vkgtgi+KySUnNySxLLdK3S+DKWPp8NVvBNdaKW582sjcwHmTpYuTkkBAwkZiy8CtT
        FyMXh5DADiaJB28/sEA4F5gkzrybxQhSJSwQL3Fn6hImEFtEQE1i5qrZbBBF5xklnj5azAzi
        MAv8ZpJ49H0vWBWbgK7Eop5mMJtXwF5iyup5YJNYBFQlTsxvZAOxRQUiJB527mKHqBGUODnz
        CdhNnAKBEg0fjoLZzALqEn/mXWKGsOUltr+dwzyBkX8WkpZZSMpmISlbwMi8ilEuMac0Vzc3
        MTOnODVZtzg5MS8vtUjXVC83s0QvNaV0EyMk6AV3MM44KXeIUYCDUYmHtyHLOVKINbGsuDL3
        EKMkB5OSKC+/nFOkEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHez8FA5bwpiZVVqUX5MClpDhYl
        cV6+Jep+QgLpiSWp2ampBalFMFkZDg4lCd4/tUCNgkWp6akVaZk5JQhpJg5OkOE8QMMvgNTw
        Fhck5hZnpkPkTzHqcjR92PKFSYglLz8vVUqcNxikSACkKKM0D24OLFm9YhQHekuYVwWYuoR4
        gIkObtIroCVMQEuCLjiALClJREhJNTA6R1zf5lA/VTDy9uVZvhcn9ntsNpE894gxU2uHvMIC
        kdY5HEWzWH9fmDh5+p6lr8PNXvZqO5ydwZUbsmHt2UkOU/1MjryNnfuXT2DT+SqR3JSZAjvs
        QpoKUguuO2/6nzJ9+n074YVnfTUve3RLeojoHPqg49fofy9rUzzrJNmaRy/02ZZosU1XYinO
        SDTUYi4qTgQAMX1/gjEDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/16/2017 07:42 AM, Stefan Beller wrote:
> On Thu, Jun 15, 2017 at 7:47 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> This will later become a method of `packed_ref_store`.
> 
> Also while touching it, maybe rename sha1 to object_hash
> (not saying object_id as that would be confusing with the actual
> oid struct), maybe?

Hmmm, my impression was that most of the `unsigned char *` hashes are
still called sha1, and they are renamed to `oid` at the moment that they
are converted to `struct object_id *`. I only see two instances of the
string "object_hash" in the code:

$ git grep object_hash
object.c:static void grow_object_hash(void)
object.c:               grow_object_hash();

Michael

