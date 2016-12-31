Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F16171FCA5
	for <e@80x24.org>; Sat, 31 Dec 2016 07:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbcLaHwh (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 02:52:37 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:44663 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752580AbcLaHwg (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 31 Dec 2016 02:52:36 -0500
X-AuditID: 12074412-5f5ff700000009b5-a7-586763c02313
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 05.4A.02485.0C367685; Sat, 31 Dec 2016 02:52:35 -0500 (EST)
Received: from [192.168.69.190] (p5B104C0E.dip0.t-ipconnect.de [91.16.76.14])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id uBV7qU4m022111
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Sat, 31 Dec 2016 02:52:31 -0500
Subject: Re: [PATCH v3 11/23] log_ref_setup(): separate code for create vs
 non-create
To:     Jeff King <peff@peff.net>
References: <cover.1483153436.git.mhagger@alum.mit.edu>
 <d9f96df1bb2d5b9a95388da04b770ea9f317c491.1483153436.git.mhagger@alum.mit.edu>
 <20161231062607.uxftwujophv37ymb@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        David Turner <novalis@novalis.org>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <2bd120b1-377a-0416-1591-1da4ab69d655@alum.mit.edu>
Date:   Sat, 31 Dec 2016 08:52:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161231062607.uxftwujophv37ymb@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsUixO6iqHs4OT3CYNZeKYuuK91MFg29V5gt
        ljx8zWzxo6WH2YHFo6v9CJvHs949jB4XLyl7fN4kF8ASxWWTkpqTWZZapG+XwJVx/IdgwVb2
        ikkXfBsYP7N2MXJySAiYSByb38XexcjFISRwmVGif/NHJpCEkMBZJon/W4xBbGGBcIkPt/vB
        GkQEZCW+H97ICNFwiFHi+Kd2dpAEs0CGRM+d32BFbAK6Eot6msEG8QrYS/TNeghWwyKgKrHj
        6gdGEFtUIETi8pyjbBA1ghInZz5hAbE5BVwknhy9yQYxU13iz7xLzBC2vMT2t3OYJzDyz0LS
        MgtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrp5WaW6KWmlG5ihISs0A7G9Sfl
        DjEKcDAq8fA+uJEWIcSaWFZcmXuIUZKDSUmU19IyNUKILyk/pTIjsTgjvqg0J7UY6HUOZiUR
        3uiE9Agh3pTEyqrUonyYlDQHi5I478/F6n5CAumJJanZqakFqUUwWRkODiUJ3vNJQI2CRanp
        qRVpmTklCGkmDk6Q4TxAw1mSQYYXFyTmFmemQ+RPMepyHHi/4imTEEtefl6qlDjvTJBBAiBF
        GaV5cHNgqeYVozjQW8K8U0CqeIBpCm7SK6AlTEBLvsaBLSlJREhJNTAGzj23aY9dxx4XRrlT
        Vy7pCmZoKti5bQo2/nfAfBq/9LLdh6wCl16ZVLDtwJ6G348zZ/8QsWv4wvei7dOXOStiPk9Z
        6Zx1zu1CjFLCI0mpS74m55QrewOWHLvZqmapvC7lYX79j93OYcFuv+6rqcW28BwQ9fxy+3n5
        7R3qeosENT6FPdjMJWOpxFKckWioxVxUnAgAdrbFkRADAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/31/2016 07:26 AM, Jeff King wrote:
> On Sat, Dec 31, 2016 at 04:12:51AM +0100, Michael Haggerty wrote:
>> [...]
>> -	adjust_shared_perm(logfile->buf);
>> -	close(logfd);
>> +	if (logfd >= 0) {
>> +		adjust_shared_perm(logfile->buf);
>> +		close(logfd);
>> +	}
>> +
> 
> Hmm. I would have thought in the existing-logfile case that we would not
> need to adjust_shared_perm(). But maybe we just do it anyway to pick up
> potentially-changed config.

I didn't change this aspect of the code's behavior (though I also found
it a bit surprising).

Another thing I considered was changing adjust_shared_perm() to adjust
the file's permissions through the open file descriptor using fchmod().
But that function has a bunch of callers, and I didn't want to have to
duplicate the code, nor did I have the energy to change all of its
callers (if that would even make sense for all callers, which I doubt).

> [...]

Michael

