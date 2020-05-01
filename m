Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312FFC47253
	for <git@archiver.kernel.org>; Fri,  1 May 2020 09:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0517F20731
	for <git@archiver.kernel.org>; Fri,  1 May 2020 09:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="j/Pue2Jt";
	dkim=pass (1024-bit key) header.d=bswap.ru header.i=@bswap.ru header.b="j/Pue2Jt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgEAJor (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 05:44:47 -0400
Received: from fallback22.m.smailru.net ([94.100.176.132]:52496 "EHLO
        fallback22.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbgEAJoq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 05:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=K6Bixr0X6xoGMLCwuSE4HZFMku7ZkFf9C9F0HdtNzk0=;
        b=j/Pue2JtfO9DNc4AeZXnhdxqvCfItN6fbC9p0dwzUCclmCoUKHyHRKC7ZY7dQhyH5XpYJp/bYVzAE9GN9JnSWDeXbdnjMe8UYpJGvQaZTZx0LPcLXXW2yn1IjUUCf/2u6NgmexjYaWb8abt8c39DYH8cR49zNGWILmeHhx4LLcE=;
Received: from [10.161.64.40] (port=49176 helo=smtp32.i.mail.ru)
        by fallback22.m.smailru.net with esmtp (envelope-from <kostix@bswap.ru>)
        id 1jUSDr-0003kW-OL
        for git@vger.kernel.org; Fri, 01 May 2020 12:44:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=K6Bixr0X6xoGMLCwuSE4HZFMku7ZkFf9C9F0HdtNzk0=;
        b=j/Pue2JtfO9DNc4AeZXnhdxqvCfItN6fbC9p0dwzUCclmCoUKHyHRKC7ZY7dQhyH5XpYJp/bYVzAE9GN9JnSWDeXbdnjMe8UYpJGvQaZTZx0LPcLXXW2yn1IjUUCf/2u6NgmexjYaWb8abt8c39DYH8cR49zNGWILmeHhx4LLcE=;
Received: by smtp32.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1jUSDi-0003H1-Jr; Fri, 01 May 2020 12:44:35 +0300
Date:   Fri, 1 May 2020 12:44:32 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Konstantin Khomoutov <kostix@bswap.ru>,
        Taylor Blau <me@ttaylorr.com>, Ivan Tham <pickfire@riseup.net>,
        git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] branch: add '-' to delete previous branch
Message-ID: <20200501094432.u3bl24qou5sgbgxk@carbon>
References: <20200429130133.520981-1-pickfire@riseup.net>
 <877dxyo1k8.fsf@osv.gnss.ru>
 <20200429190013.GG83442@syl.local>
 <87v9likr5a.fsf@osv.gnss.ru>
 <20200429195745.GC3920@syl.local>
 <87imhihwbw.fsf@osv.gnss.ru>
 <20200430162753.pg6kpm6jlubotjlk@carbon>
 <xmqqbln8sqcv.fsf@gitster.c.googlers.com>
 <87zhas3teg.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhas3teg.fsf@osv.gnss.ru>
User-Agent: NeoMutt/20180716
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9790EF91ABD66AC662976824018CD7612B0713DC0AD2C6D15182A05F538085040172D47B0A7D347B34BE0A39537874B2DC05A9E5469859AB7696F816B37F85D26
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE75B37E0A1C175363BEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006377CC130305260E47D8638F802B75D45FF5571747095F342E8C7A0BC55FA0FE5FC6E55F2CEF2503A65D7E4B06C8DFB584F67F508F0C4A64A0C389733CBF5DBD5E913377AFFFEAFD269A417C69337E82CC2CC7F00164DA146DAFE8445B8C89999725571747095F342E8C26CFBAC0749D213D2E47CDBA5A9658359CC434672EE6371117882F4460429728AD0CFFFB425014E40A5AABA2AD371193AA81AA40904B5D9A18204E546F3947C093C2F12201C912A03F1AB874ED890284AD6D5ED66289B5218080C068C56568E6136E347CC761E07725E5C173C3A84C3F2BD4E76F41A0F79BA3038C0950A5D36B5C8C57E37DE458B0B4866841D68ED3522CA9DD8327EE4930A3850AC1BE2E7352B32DCB92A8600C6C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojIaSuz2sfv2L70OB+AV1x4g==
X-F696D7D5: uwmGpv6/CqPe1T0YOpivxURm/nfpkfGvOxbhitesVbf70OB+AV1x4g==
X-Mailru-Internal-Actual: A:0.98279495140259
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD13862E96FC9B9B72134D915542FA1B8355ED64735688E5EEC1013BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC67EA787935ED9F1B
X-Mras: Ok
X-7564579A: EEAE043A70213CC8
X-77F55803: E8DB3678F13EF3E07F9F52485CB584D7271FD7DF62800FDC5AC67BAF3AE583D3BC318AE69072582F9FB2786DE83D55116AC16E21F8E987A9
X-7FA49CB5: 0D63561A33F958A5AFD2D634C2E2D0E36BB3B9C9C42C0C0DD3D4CA45765CD8558941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249CB3CB8E9EF962DC476E601842F6C81A12EF20D2F80756B5FDA63EEEA5E5E9D6576E601842F6C81A127C277FBC8AE2E8BE270C32E94023BD73AA81AA40904B5D99449624AB7ADAF3726B9191E2D567F0E725E5C173C3A84C3AA8C68A3574AB3B435872C767BF85DA2F004C906525384306FED454B719173D6462275124DF8B9C9DE2850DD75B2526BE5BFE6E7EFDEDCD789D4C264860C145E
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojIaSuz2sfv2KQedFV6fmnWQ==
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C9005ECC5D0D0AB7E92B5892ABED457CDC841BC318AE69072582F3F17294BC1AFE60DFD27B1545737DED76F53C80213D1719CB3360D9C94DE366A1CC4A9B39F20364B73395D515EC5B64AAE208404248635DF
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 01, 2020 at 12:18:31PM +0300, Sergey Organov wrote:

[...]
> >> I would speculate that `git checkout -` may have learned about "-"
> >> simply from the `cd -` ...
> >
> > You do not have to speculate.  You only need to read what has been
> > already said in the thread ;-).
> 
> Should I expect "git checkout ~" to get me to my "home" branch then? ;-)

Heh, no you shouldn't: the '~' is expanded by the shell itself according
to its parameter expansion rules, so `cd` never sees the bare tilde
in this case ;-)

> Actually, that could be a good idea. I mean, to have "home" branch
> notion and a short-cut for it.

I have no say for the idea per se but you would have hard time using
bare tilda character for that precisely because of it being special to
Unix shells - you'd need to escape it all the time (though something
like unquoted @{~} would work just OK).

