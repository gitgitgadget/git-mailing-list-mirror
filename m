Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E8071FA21
	for <e@80x24.org>; Tue, 10 Oct 2017 09:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755805AbdJJJti convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 10 Oct 2017 05:49:38 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:47737 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbdJJJti (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 05:49:38 -0400
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Tue, 10 Oct 2017 11:49:36 +0200
  id 0000000000000049.0000000059DC97B0.00001F89
Date:   Tue, 10 Oct 2017 11:49:36 +0200
From:   Simon Ruderich <simon@ruderich.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] write_entry: fix leak when retrying delayed filter
Message-ID: <20171010094936.aivd63uispx6hks7@ruderich.org>
References: <20171009174715.a6wziu6w535u6rd2@sigill.intra.peff.net>
 <20171009174824.tt5tpxdvcvzbyvnl@sigill.intra.peff.net>
 <xmqq7ew3swhi.fsf@gitster.mtv.corp.google.com>
 <20171010092319.ugim7ww7t6ks2vqf@ruderich.org>
 <20171010092543.e4dh2lo4sj3w6w7j@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20171010092543.e4dh2lo4sj3w6w7j@sigill.intra.peff.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2017 at 05:25:43AM -0400, Jeff King wrote:
> On Tue, Oct 10, 2017 at 11:23:19AM +0200, Simon Ruderich wrote:
>> On Tue, Oct 10, 2017 at 09:00:09AM +0900, Junio C Hamano wrote:
>>>> --- a/entry.c
>>>> +++ b/entry.c
>>>> @@ -283,6 +283,7 @@ static int write_entry(struct cache_entry *ce,
>>>>  			if (dco && dco->state != CE_NO_DELAY) {
>>>>  				/* Do not send the blob in case of a retry. */
>>>>  				if (dco->state == CE_RETRY) {
>>>> +					free(new);
>>>>  					new = NULL;
>>>>  					size = 0;
>>>>  				}
>>
>> FREE_AND_NULL(new)?
>
> Ah, yeah, I forgot we had that now. It would work here, but note that
> this code ends up going away later in the series.

Ah sorry, missed that. Then never mind.

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
