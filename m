Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2177A205F4
	for <e@80x24.org>; Sun,  1 Jan 2017 08:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753230AbdAAIps (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jan 2017 03:45:48 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:53539 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750845AbdAAIpr (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Jan 2017 03:45:47 -0500
X-AuditID: 12074412-5ddff700000009b5-a6-5868c1b8ae30
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 23.42.02485.8B1C8685; Sun,  1 Jan 2017 03:45:46 -0500 (EST)
Received: from [192.168.69.190] (p57906284.dip0.t-ipconnect.de [87.144.98.132])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v018jh3G021942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sun, 1 Jan 2017 03:45:44 -0500
Subject: Re: [PATCH v3 11/23] log_ref_setup(): separate code for create vs
 non-create
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
 <d9f96df1bb2d5b9a95388da04b770ea9f317c491.1483153436.git.mhagger@alum.mit.edu>
 <xmqqful34fww.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        David Turner <novalis@novalis.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <544457a2-5226-feea-1a32-74dd58233df8@alum.mit.edu>
Date:   Sun, 1 Jan 2017 09:45:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqqful34fww.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsUixO6iqLvrYEaEwawzUhZdV7qZLBp6rzBb
        LHn4mtniR0sPswOLR1f7ETaPZ717GD0uXlL2+LxJLoAlissmJTUnsyy1SN8ugSvj9oOFTAXd
        bBVHWnewNTAuZuli5OSQEDCRWPd2FWMXIxeHkMBlRom/DSvZIJxzTBJPFk4CqxIWCJf4cLuf
        FcQWEVCTmNh2CCwuJLCTUeLN9woQm1kgXuLvikNgNWwCuhKLepqZQGxeAXuJExfPgtksAioS
        Hw9tALNFBUIkLs85ygZRIyhxcuYTsJmcAtYSE1b1s0PM1JPYcf0XK4QtL7H97RzmCYz8s5C0
        zEJSNgtJ2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFumZ6uZkleqkppZsYIWErtINx/Um5
        Q4wCHIxKPLwNv9MjhFgTy4orcw8xSnIwKYnyJmzIiBDiS8pPqcxILM6ILyrNSS0+xCjBwawk
        wqu7FyjHm5JYWZValA+TkuZgURLn/blY3U9IID2xJDU7NbUgtQgmK8PBoSTBu/IAUKNgUWp6
        akVaZk4JQpqJgxNkOA/QcAeQGt7igsTc4sx0iPwpRl2OA+9XPGUSYsnLz0uVEuedCFIkAFKU
        UZoHNweWbl4xigO9Jcz7AKSKB5iq4Ca9AlrCBLTka1w6yJKSRISUVAPjXlPtdLe9d+s+6LXe
        OMA44WTNtllnj+uuEIr8cEnh6LvIhJbldXOPLdz6rPTpHyZxpv/nmGI+CLVP3yEkrPBW1OJE
        5Bem7wz/NzUzf9tiVHvuqEv3PqFw+30FIb5LRJT+HY7Ysaf/2bKHZgkF97503tsYJdpx9s3P
        1ef8rFYvenf9UtBWpeqZC5VYijMSDbWYi4oTAahWb0ISAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/01/2017 04:28 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> +			if (errno == ENOENT || errno == EISDIR) {
>> +				/*
>> +				 * The logfile doesn't already exist,
>> +				 * but that is not an error; it only
>> +				 * means that we won't write log
>> +				 * entries to it.
>> +				 */
>> +			} else {
> 
> It may be valid C, but an
> 
> 	{
> 		/*
> 		 * an empty block without any statement,
> 		 * not even a null statement.
> 		 */
> 	}
> 
> always makes me a bit nervous.  Have a line with a semicolon without
> anything else (other than the indent) at the end and it will read
> nicer, at least to me.

That's a form of superstition that I haven't encountered before ;-) but
I'll change it.

Michael

