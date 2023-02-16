Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62ADC636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 20:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjBPUFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 15:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjBPUFR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 15:05:17 -0500
X-Greylist: delayed 1969 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Feb 2023 12:05:05 PST
Received: from fallback17.mail.ru (fallback17.m.smailru.net [94.100.176.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE9B528B4
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 12:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=iAfpqW1a1yh+J3aYCKoRwVFDDRT/OBjOdjuryuXQZnM=;
        t=1676577905;x=1676667905; 
        b=ZxC9gafxMGZzA9kRpN21UNah/BnfzxMGDPBdjqL3Je84pbSsmh1S6WPmkNm1GqFd3Yq4TmLxEKEu2WBmNanaJ3G1qDgds8rlU0uqHi2BaqkI/VrfBJeXCVJ642s1lpehC6aJHSFEh60a16GUbKHr8ui7QYr7Wky+V0aJnzdbs3I=;
Received: from [10.12.4.12] (port=56760 helo=smtp37.i.mail.ru)
        by fallback17.m.smailru.net with esmtp (envelope-from <kostix@bswap.ru>)
        id 1pSjzJ-00058H-UX
        for git@vger.kernel.org; Thu, 16 Feb 2023 22:32:14 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=iAfpqW1a1yh+J3aYCKoRwVFDDRT/OBjOdjuryuXQZnM=;
        t=1676575933;x=1676665933; 
        b=QnkIdcQDhEjnxgeKr3xDXpsjhsjyFt98ldRRlnhfnJhq1IlqXSS8Ai5glD9c9cd8Hy5Opnzb136YpNlSr7iA0zvZ9/Ikw0V7ZLSL9XTa8kEGjtYRXtz0wXfWvqBEQh+2IDi0cK7kjBBDsgtugyqwpxmM0/xC3BPW45YWTDUiVuY=;
Received: by smtp37.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1pSjzG-00ChCC-Op
        for git@vger.kernel.org; Thu, 16 Feb 2023 22:32:11 +0300
Date:   Thu, 16 Feb 2023 22:32:10 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     git@vger.kernel.org
Subject: Re: [PATCH] branch: introduce --(no-)has-upstream and --(no-)gone
 options
Message-ID: <20230216193210.6yj24zhhdhoozpr3@carbon>
Mail-Followup-To: git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216041432.1668365-1-alexhenrie24@gmail.com>
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9806C989EC2150E3306C371BD2459F3C9654D0ADB2016EE03182A05F53808504052D9076ADF078A03CF8EABFDFDA630FC2DA389BB6A938153BDE14BC2A2D3EBCF
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE78E8764B5BC580342EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006374D0D183F14C070BA8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8FFF16F4D6087323EA359D2ED9217970D117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCE3B0F63F495E1F96A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735207B96B19DC409332128451B159A507268D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE902A1BE408319B2996C9B5BF839F39F6D8FC6C240DEA7642DBF02ECDB25306B2B78CF848AE20165D0A6AB1C7CE11FEE367F1C1C3ABB44F3A2D242C3BD2E3F4C6C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947C2FFDA4F57982C5F42E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F3695E42C86E34F97089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34697E0FA301E28215CC04E78B827778958A5C90B4838334B084A93A77B1BCC02976407C3EB29E16811D7E09C32AA3244C605AF2370D6A09FBE97C87C5CAE9CABC8894E9C85370243E3EB3F6AD6EA9203E
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXhdL5lYseEMohsVIT26txL3
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138E53D4D5AADCA4B84FD56B8A0A827246FA40AD7AC6ECEA9DF13BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B48F971C29D06D6C0B4F378AFA56BA89B98A44FD8F000020EA049FFFDB7839CE9EEEB0D775C03ED89C67AE3D788427EFC4676C8DECAAED4B869ADD2A52CC123C27
X-7FA49CB5: 0D63561A33F958A5220800C9DF1390737B9787A3DAD1B2A138C0633811441C1A8941B15DA834481FA18204E546F3947CD56D36E97F3F038CF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006370A2DD59B67EFEE27389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F7900637DDF5CD7B9F40093CD81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636AAAE862A0553A39223F8577A6DFFEA7C5E1C53F199C2BB95B5C8C57E37DE458BEDA766A37F9254B7
X-87b9d050: 1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojohRiI5imL4+EQEvd+TSAdw==
X-Mailru-MI: 800
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> GitHub and GitLab have features to create a branch using the web
> interface, then delete the branch after it is merged. That results in a
> lot of "gone" branches in my local clone, and I frequently find myself
> typing `git branch -v | grep gone`. I don't want `git branch --merged`
> because that would include branches that have been created for future
> work but do not yet have any commits.

Possibly a rather silly remark, but you could make a habit of periodically
running

  git remote prune <remotename>

or fetching with "--prune".

At my $dayjob, we use GitLab, and I routinely fetch with "--prune" because
most of the time there's no sense in seeing stale (merged in and deleted)
branches, and if it's really needed, their then-tips can be figured out from
the merged commits which have integrated those branches.

