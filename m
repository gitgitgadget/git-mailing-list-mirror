Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DE2C05027
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 11:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjBQLMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 06:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBQLMD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 06:12:03 -0500
X-Greylist: delayed 56341 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Feb 2023 03:11:15 PST
Received: from smtp53.i.mail.ru (smtp53.i.mail.ru [95.163.41.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347E465359
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 03:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Qaadr1cRq1x3IaaH4maowPGpJ2iGCESLG3SrsLjMa2g=;
        t=1676632275;x=1676722275; 
        b=yk86F6XeeIg0xhcUCzWLjyBrVRCNn0LsTEUlXasDffuMXBtvrBLn3eQnzKnPhtGbEjQyLtRAfIe10Sq3ozpWA1lZqGQMc1NlxekkGXkMGeom7bQzZ7PbBGlRu9ACVVojyM+KVHTP8tKm3jyde9Rxmt9CfvmCXgr8AGwvqRLyDC4=;
Received: by smtp53.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1pSydR-00B8kc-4K
        for git@vger.kernel.org; Fri, 17 Feb 2023 14:10:37 +0300
Date:   Fri, 17 Feb 2023 14:10:36 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     git@vger.kernel.org
Subject: Re: [PATCH] branch: introduce --(no-)has-upstream and --(no-)gone
 options
Message-ID: <20230217111036.yupfv4t6xn4xteah@carbon>
Mail-Followup-To: git@vger.kernel.org
References: <20230216193210.6yj24zhhdhoozpr3@carbon>
 <xmqq1qmpp7bh.fsf@gitster.g>
 <CAMMLpeQgxPCTsWGr58rutSDnRuGAGcTXTvHLcgWAfzZjZGxakg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMMLpeQgxPCTsWGr58rutSDnRuGAGcTXTvHLcgWAfzZjZGxakg@mail.gmail.com>
Authentication-Results: smtp53.i.mail.ru; auth=pass smtp.auth=kostix@bswap.ru smtp.mailfrom=kostix@bswap.ru
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD94A31EA4B0797EF2EE50B5111BED4E5A0F9C3BE6961C3C823182A05F5380850404C228DA9ACA6FE27AEC11ACB40B7B93F24D7FDDB1A6C563A718EE5BB137C1EBE8C0D03C56FB9B46D
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7370F4F695FFFC24BEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063745D431239A8C7DA08638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8359C46A004E1A337A471ABC88CC6294D117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC28EC0646CDFC9FDDA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520599709FD55CB46A628451B159A507268D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE902A1BE408319B294D0DA9BD313A0613D8FC6C240DEA7642DBF02ECDB25306B2B78CF848AE20165D0A6AB1C7CE11FEE367F1C1C3ABB44F3A6E0066C2D8992A16C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F7900637F765F39FA4E70FFE43847C11F186F3C59DAA53EE0834AAEE
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34B5900AD87B4159A42587019403841E4F5E5504534C91D5D90E48E2B6A6E29EC2D03A1AF28C0DA1451D7E09C32AA3244C8CBB7E80768F1CF4CC862761400563F555E75C8D0ED9F6EE3EB3F6AD6EA9203E
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojezPZE63HafhXD9K+91b9rA==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD1389EDEF2066472334ED1793038B8D551FC68345D57491366C813BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2023 at 08:12:08PM -0700, Alex Henrie wrote:


> > >> GitHub and GitLab have features to create a branch using the web
> > >> interface, then delete the branch after it is merged. That results in a
> > >> lot of "gone" branches in my local clone, and I frequently find myself
> > >> typing `git branch -v | grep gone`. I don't want `git branch --merged`
> > >> because that would include branches that have been created for future
> > >> work but do not yet have any commits.
> > >
> > > Possibly a rather silly remark, but you could make a habit of periodically
> > > running
> > >
> > >   git remote prune <remotename>
> > >
> > > or fetching with "--prune".
> >
> > Likely to be a silly question, but isn't doing that, to actively
> > remove the remote tracking branches that correspond to branches that
> > no longer exist at the remote, exactly what gives Alex many local
> > branches that are marked as "gone" (i.e. forked from some upstream
> > sometime in the past, but the upstream no longer exists)?
> 
> Yes, the branches are marked [gone] precisely because I configured
> fetch.prune to true. So fetching automatically deletes the local
> copies of the upstream branches, but the local branches that track
> them are still there.

Ah, thanks, I see now.

I have a habit of always checking out remote branches directly when doing any
work on them (they end up in a detached HEAD state), so I have sort of
automagically evaded your problem not being aware of the fact.

