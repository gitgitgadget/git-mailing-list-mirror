Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEC8820404
	for <e@80x24.org>; Tue, 10 Oct 2017 09:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755257AbdJJJXV (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 05:23:21 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:43757 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbdJJJXV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 05:23:21 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Tue, 10 Oct 2017 11:23:18 +0200
  id 0000000000000049.0000000059DC9186.00006CBC
Date:   Tue, 10 Oct 2017 11:23:19 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] write_entry: fix leak when retrying delayed filter
Message-ID: <20171010092319.ugim7ww7t6ks2vqf@ruderich.org>
References: <20171009174715.a6wziu6w535u6rd2@sigill.intra.peff.net>
 <20171009174824.tt5tpxdvcvzbyvnl@sigill.intra.peff.net>
 <xmqq7ew3swhi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <xmqq7ew3swhi.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2017 at 09:00:09AM +0900, Junio C Hamano wrote:
>> --- a/entry.c
>> +++ b/entry.c
>> @@ -283,6 +283,7 @@ static int write_entry(struct cache_entry *ce,
>>  			if (dco && dco->state != CE_NO_DELAY) {
>>  				/* Do not send the blob in case of a retry. */
>>  				if (dco->state == CE_RETRY) {
>> +					free(new);
>>  					new = NULL;
>>  					size = 0;
>>  				}

FREE_AND_NULL(new)?

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
