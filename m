Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E20252018F
	for <e@80x24.org>; Wed, 13 Jul 2016 23:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbcGMXKI (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 19:10:08 -0400
Received: from contumacia.investici.org ([178.255.144.35]:64811 "EHLO
	contumacia.investici.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739AbcGMXKD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 19:10:03 -0400
X-Greylist: delayed 1975 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jul 2016 19:10:03 EDT
Received: from sabotaggio.investici.org (sabotaggio-vpn.investici.org [172.16.1.3])
	by contumacia.investici.org (Postfix) with ESMTP id D0250200325;
	Wed, 13 Jul 2016 22:36:52 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=cryptolab.net;
	s=stigmate; t=1468449412;
	bh=bMWTQfB89cC+pbcmykNPwer2QNowgbqIEHTczKJG+NQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gr8753R0+2cJR5bk/5Kpn5hT+HRpf1YxZgtlEivAIfzawT4Zir/ioulFdju8tp4HN
	 bjmRY10QSCJUHjQnEo3c/Nqjs4hzPt8HkxtFK/M6RUCpkVIXOC5SKVZv+rJcwbcioO
	 oaFKbCLRFDeCujNka6EQI2LAgDGXleWdLwexXoE4=
Received: from [91.121.170.222] (sabotaggio [91.121.170.222]) (Authenticated sender: ervion@cryptolab.net) by localhost (Postfix) with ESMTPA id 9B001280087;
	Wed, 13 Jul 2016 22:36:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:	Thu, 14 Jul 2016 01:36:52 +0300
From:	ervion <ervion@cryptolab.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git Mailing List <git@vger.kernel.org>, jch2355@gmail.com
Subject: Re: Https password present in git output
In-Reply-To: <CAPc5daXq-WBEYTyi2M7kMoZtQCYgucCRQ=GFVt8U_H_vRYyZPw@mail.gmail.com>
References: <2908abd39c722c080ec37a987a79e32f@cryptolab.net>
 <xmqqd1mh1kbd.fsf@gitster.mtv.corp.google.com>
 <CAPc5daXq-WBEYTyi2M7kMoZtQCYgucCRQ=GFVt8U_H_vRYyZPw@mail.gmail.com>
Message-ID: <2bd57007f21ab1154d3bcc1e9bc8664e@cryptolab.net>
X-Sender: ervion@cryptolab.net
User-Agent: Roundcube Webmail
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


I completely agree that it is not a head-on-fire kind of problem, there 
are ways to avoid it.
Simply nice to have.

It is in fact the case, that git fetch output is scrubbed, sorry I did 
not notice previously.
But (on my device: git version 2.9.0 arch linux) git push is not.
$ git push origin --all

Results in:
/---/
To https://username:password@domeen.com/git/repo.git
    xxxxxxx..zzzzzzz  master -> master

On 13.07.2016 21:16, Junio C Hamano wrote:
> On Wed, Jul 13, 2016 at 11:09 AM, Junio C Hamano <gitster@pobox.com> 
> wrote:
>> ervion <ervion@cryptolab.net> writes:
>> 
>>> Sometimes using ssh is not possible and saving https password in 
>>> plain
>>> text to disk may be desireable
>>> (in case of encrypted disk it would be equivalent security with
>>> caching password in memory).
>>> 
>>> One possibility for this in git is to save remote in the
>>> https://username:password@domain.com/repo.git format.
>> 
>> Wasn't netrc support added exactly because users do not want to do
>> this?
> 
> Interesting. Even with "auth in URL", I seem to get this:
> 
> $ git fetch -v -v https://gitster:pass@github.com/git/git  
> refs/tags/v2.9.1
> From https://github.com/git/git
>  * tag               v2.9.1     -> FETCH_HEAD
> 
> Notice that "From $URL" has the userinfo (3.2.1 in RFC 3986) scrubbed.
> 
> If you are seeing somewhere we forgot to scrub userinfo in a similar 
> way in
> the output, we should. Where do you see "present in git OUTPUT" as you
> said in the subject? What command with what options exactly and in what
> part of the output?
> 
> Thanks.
