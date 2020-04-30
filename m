Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB04C47253
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 16:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB09208C3
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 16:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="dpaqdpqP";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="dpaqdpqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgD3Q6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:58:13 -0400
Received: from fallback21.m.smailru.net ([94.100.176.131]:38568 "EHLO
        fallback21.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgD3Q6N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 12:58:13 -0400
X-Greylist: delayed 1816 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Apr 2020 12:58:12 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=mV3HFzoT2tKyLTXUOIvOZFe+Bgjo9wXU03t/HmpTjR4=;
        b=dpaqdpqPl+AcchdZxfl4Z7cx80xAEegvQ3zJDz33xd4zqVHePZyNn3plEy/4RBX+sGWoBeA5O8V/VR1xUPqC5CxRJrvUC1dYWqwZWnB3BxqAejQsifx2GGGyU5DqaXAX1m8W2zoZKDPC9hQt/G9xoP+ap5/20mBavnLq8MzZLac=;
Received: from [10.161.76.76] (port=55120 helo=smtp17.mail.ru)
        by fallback21.m.smailru.net with esmtp (envelope-from <kostix@bswap.ru>)
        id 1jUC2e-0000bl-Ot
        for git@vger.kernel.org; Thu, 30 Apr 2020 19:28:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=mV3HFzoT2tKyLTXUOIvOZFe+Bgjo9wXU03t/HmpTjR4=;
        b=dpaqdpqPl+AcchdZxfl4Z7cx80xAEegvQ3zJDz33xd4zqVHePZyNn3plEy/4RBX+sGWoBeA5O8V/VR1xUPqC5CxRJrvUC1dYWqwZWnB3BxqAejQsifx2GGGyU5DqaXAX1m8W2zoZKDPC9hQt/G9xoP+ap5/20mBavnLq8MzZLac=;
Received: by smtp17.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1jUC2U-0005RA-78; Thu, 30 Apr 2020 19:27:54 +0300
Date:   Thu, 30 Apr 2020 19:27:53 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Ivan Tham <pickfire@riseup.net>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] branch: add '-' to delete previous branch
Message-ID: <20200430162753.pg6kpm6jlubotjlk@carbon>
References: <20200429130133.520981-1-pickfire@riseup.net>
 <877dxyo1k8.fsf@osv.gnss.ru>
 <20200429190013.GG83442@syl.local>
 <87v9likr5a.fsf@osv.gnss.ru>
 <20200429195745.GC3920@syl.local>
 <87imhihwbw.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imhihwbw.fsf@osv.gnss.ru>
User-Agent: NeoMutt/20180716
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9790EF91ABD66AC66FDB4F9FBDAB8E28023E4317C076D1E3B182A05F5380850404FD9E91C941BFD3BF0BB64547F8BC8062E163373D3D0D52F99C1F36966C1135F
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7BA0D57D3459E5640EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637EF59B520676799BC8638F802B75D45FF5571747095F342E8C7A0BC55FA0FE5FC0B5686DD074936BFB4732F4C56BE221B13A1F893A984AFF2389733CBF5DBD5E913377AFFFEAFD269A417C69337E82CC2CC7F00164DA146DAFE8445B8C89999725571747095F342E8C26CFBAC0749D213D2E47CDBA5A9658359CC434672EE6371117882F4460429728AD0CFFFB425014E40A5AABA2AD371193AA81AA40904B5D9A18204E546F3947C4B6F6234D9065C97302FCEF25BFAB3454AD6D5ED66289B5218080C068C56568E6136E347CC761E07725E5C173C3A84C3E52EFDB9F8BB5AAABA3038C0950A5D36B5C8C57E37DE458B260C558C6AAB860222CA9DD8327EE4930A3850AC1BE2E7352B32DCB92A8600C6C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojCY6TNJh6RHlySqKYLeXtrA==
X-Mailru-Internal-Actual: A:0.97207550323879
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138D378B721D025185633F25F994A8B08D410741C0497523B7613BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC67EA787935ED9F1B
X-Mras: Ok
X-7564579A: EEAE043A70213CC8
X-77F55803: 669901E4625912A97F9F52485CB584D7271FD7DF62800FDCD27FDBD94D72892429687DAC6B9C0463B3AD319D32073B52914B5F6CBB272511
X-7FA49CB5: 0D63561A33F958A552F1ED8BCD4F7294DC81F3570D1C52B8F9DA6551D3D95D0D8941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C224937E7452263E0972376E601842F6C81A12EF20D2F80756B5FDA63EEEA5E5E9D6576E601842F6C81A127C277FBC8AE2E8B8FA608DA6CD568A33AA81AA40904B5D99449624AB7ADAF3726B9191E2D567F0E725E5C173C3A84C3AA8C68A3574AB3B435872C767BF85DA2F004C906525384306FED454B719173D6462275124DF8B9C9DE2850DD75B2526BE5BFE6E7EFDEDCD789D4C264860C145E
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojCY6TNJh6RHnmlC4KoIv7Mg==
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C9005B3CA2E2FD44993EC603E98068F85C7A529687DAC6B9C0463FB69FB06705AFC99FD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 11:26:59PM +0300, Sergey Organov wrote:

[...]
> >> > In my opinion, it is fairly clear that 'git branch -D -' means "delete
> >> > the last branch", and not "delete a list of branches from stdin.
> >>
> >> Honestly, I'd never guess it'd "delete the last branch". No way.
> >
> > I'm having trouble understanding why. This is how 'git checkout -'
> > behaves, so I have no idea why 'git branch' wouldn't work the same
> > way.
> 
> Well, if I knew 'git checkout -' does this, then yes, it'd be obvious.
> The problem is that I didn't. Well, then, as I said in my original
> reaction, I'm probably too late on this.
> 
> BTW, it was not that easy to find it in the "git help checkout" even
> when I was specifically looking for it.

I would speculate that `git checkout -` may have learned about "-"
simply from the `cd -` form of the standard Unix shell (also codified by
POSIX [1]) which behaved that way - change the current directory to the
previous one - since forever. ;-)

1. https://pubs.opengroup.org/onlinepubs/9699919799/utilities/cd.html

