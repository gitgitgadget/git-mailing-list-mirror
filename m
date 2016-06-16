Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DE7B1FE4E
	for <e@80x24.org>; Thu, 16 Jun 2016 11:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbcFPLbA (ORCPT <rfc822;e@80x24.org>);
	Thu, 16 Jun 2016 07:31:00 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60078 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751490AbcFPLa7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jun 2016 07:30:59 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id CDB2820887;
	Thu, 16 Jun 2016 07:30:58 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute6.internal (MEProxy); Thu, 16 Jun 2016 07:30:58 -0400
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=EafcuO2ynHn2T/Cd+M5q3MhTaUQ=; b=Gg8u0C
	c63AWtH9NLPKMo4EHZKwHGtwKV+c4JHWgELawbFv9YzfEWTlEsvNXOzUZEGNFTSu
	CEI3nI/RIkD06aCp7JeahrWArSqMfphB8Kechm45GFAAbTGHxaBKiYHtqhlYXFoJ
	2TMIhjp+YF1d0kEVh6kgCBzUPQe1ED1RPzEQg=
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=EafcuO2ynHn2T/C
	d+M5q3MhTaUQ=; b=CUXBz0LdYHDrzFZLLinOFjKk/Kb/EM+r3IOAT3ukyxkAqSs
	jRkSYM4hqy+P+BsCVAWyCOe7DZrZTYxm6desa0pjfTDVEhUPrSLvwLxIvOkNi+1p
	GWgBmuwA4OFx4PhgORybqxE9aaIILgi1kBUCJ7RPUDI3YPcGY2C9mTj45Ajc=
X-Sasl-enc: pvLCMG25Uvk7HP9iviNVFpXi8X7SySkYBJNLoI7iBM4G 1466076658
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 27B2FF29FA;
	Thu, 16 Jun 2016 07:30:58 -0400 (EDT)
Subject: Re: [PATCHv3] gpg-interface: check gpg signature creation status
To:	Jeff King <peff@peff.net>
References: <26353a3d-e495-075f-4f84-b34a2420a6cf@drmicha.warpmail.net>
 <8e08b63b58302b6e7fe91f0dfb5b476781bfd37d.1465915311.git.git@drmicha.warpmail.net>
 <xmqq60tbaba5.fsf@gitster.mtv.corp.google.com>
 <20160614215019.GB22334@sigill.intra.peff.net>
 <20160614222633.GA32020@sigill.intra.peff.net>
 <xmqqporj72p4.fsf@gitster.mtv.corp.google.com>
 <20160615005614.GB32601@sigill.intra.peff.net>
 <75709ea6-b2bb-fddf-1175-cb8aae66629a@drmicha.warpmail.net>
 <20160616092535.GA29954@sigill.intra.peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	ZhenTian <loooseleaves@gmail.com>
From:	Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <0a9d4b3b-6fc9-a539-0256-3eb09c4791c0@drmicha.warpmail.net>
Date:	Thu, 16 Jun 2016 13:30:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <20160616092535.GA29954@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King venit, vidit, dixit 16.06.2016 11:25:
> On Wed, Jun 15, 2016 at 09:17:54AM +0200, Michael J Gruber wrote:
> 
>> As for the flexibility:
>> We do code specifically for gpg, which happens to work for gpg2 also.
>> The patch doesn't add any gpg ui requirements that we don't require
>> elsewhere already.
>> More flexibility requires a completely pluggable approach - gpgsm
>> already fails to meet the gpg command line ui.
> 
> Does it? I haven't run it in production, but I did some tests with gpgsm
> a few months ago and found it to be a drop-in replacement, at least with
> respect to git. Though I don't think that matters one way or the other
> for the current discussion; it _does_ do --status-fd.

You are right!

I solely trusted in the documentation rather than simply trying it out.
gpgsm even supports the undocumented short options.

Only the resulting header is different (plus the fact that I have to
turn of crl checks for whatever reason).

>> In any case, "status-fd" is *the* way to interface with gpg reliably
>> just like plumbing commands are *the* way to interface with git reliably.
> 
> Fair enough. I've generally found its exit code pretty reliable. It's
> unclear to me if the problem you saw was because gpg was exiting 0 but
> producing no signature, or if your debugging was masking its exit code.
> 
> Either way, I do not mind using --status-fd; it seems like it should be
> more robust in general. It's the tip commit in the series I'm about to
> post.
> 
>> As for the read locking:
>> I'm sorry I have no idea about that area at all. I thought that I'm
>> doing the same that we do for verify, but apparently not. My
>> strbuf_read-fu is not that strong either (read: copy&paste). I trust
>> your assessment completely, though.
> 
> Yeah, you're right that the deadlock thing is also a possibility on the
> verification side. I'm not sure whether it's possible to trigger in
> practice or not. See the analysis in the series.

With great admiration I've looked at your series which solves this
problem at the root. Way above my head (the solution, not the root,
fortunately).

>> As for the original problem:
>> That had a different cause, as we know now (rebase dropping signatures
>> without hint). I still think we should check gpg status codes properly.
> 
> Yep, I agree.
> 
> -Peff
> 

