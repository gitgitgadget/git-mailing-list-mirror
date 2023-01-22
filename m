Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E8CC25B4E
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 20:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjAVUpV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 15:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjAVUpT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 15:45:19 -0500
X-Greylist: delayed 712 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 22 Jan 2023 12:45:17 PST
Received: from fallback17.mail.ru (fallback17.m.smailru.net [94.100.176.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FD81A497
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 12:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:Message-ID:Reply-To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=+DCtQWc2oxzXs2SD6yGeqePBcvwc/nxJkkwO3Efd5MY=;
        t=1674420317;x=1674510317; 
        b=SV1MErid0Uf9uVGd0d0q1pkPNLPYdG4FDDo0QIHZVMMCX8njEFRGmTE/xQwv0kKM/EIzXLNSTSwuPNPXfk2TTyiJbgzGPyq4HKrZfwjQtK1b+Xii/MGn3OeTQiheWsRQwlTXmMKinWUrwFiyrUSb4xEZYooE6KlI7KzvuDeg5RW34Zajl8a3fr9mMO4wDWiIdB6dytOVEWWmo5DgRior/5a07yIkH3azS8NqFZP28Cr+DclI7M+YtgQMm/kQAsFrXEeNPHi3k79jisHbIbFSUw1aO9zPCK/gApiUKl52ecnT1HMbglDeMFH/C0gyzdrc4YiO7m0vVw289TzhYWujNg==;
Received: from [10.12.4.8] (port=58540 helo=smtp35.i.mail.ru)
        by fallback17.m.smailru.net with esmtp (envelope-from <andry@inbox.ru>)
        id 1pJh1n-0004Qq-CM
        for git@vger.kernel.org; Sun, 22 Jan 2023 23:33:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:Message-ID:Reply-To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=+DCtQWc2oxzXs2SD6yGeqePBcvwc/nxJkkwO3Efd5MY=;
        t=1674419603;x=1674509603; 
        b=MEYFxi73O2cYxZMte9akvVWnCkfkaRkBthsz0cgzBIKjZe4K4BS+ex0kr1z3OCMuBZKR30mEId1A7mSQWTZsHWGWt9KbLNrE9KxPWUyrn9uSh4hFx6dG4Ghoaf3See+9hp6H+yv7QFIOHatvIEUrO2rqCqhP4UxKOhlH48HJgZ7X/HFR+FN/uLuvDqm76fS4eump+ujN1nAzsB5KFLDWvGyafgpu+A99ScMyEanuZ+0lXdJ5yNYlqaslzF6jBVz549uG9Zb+Vb+jNE56c9DpgbLvtuxN7/5bbyWewm5W45iICpDUMzAEd/8iwkNWo1wrkuIizh6U3fq/ItWQoabSkw==;
Received: by smtp35.i.mail.ru with esmtpa (envelope-from <andry@inbox.ru>)
        id 1pJh1l-00DvdH-5s
        for git@vger.kernel.org; Sun, 22 Jan 2023 23:33:21 +0300
Date:   Sun, 22 Jan 2023 23:34:03 +0300
From:   Andry <andry@inbox.ru>
Reply-To: Andry <andry@inbox.ru>
Message-ID: <1716310675.20230122233403@inbox.ru>
To:     git@vger.kernel.org
Subject: nested submodules detection w/o .gitmodules file
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9A6D6F5724DD3A0B60E915A56FB921C50CC0C40CAEDEC64A7182A05F5380850407AF2B1BEEE89D7FCB9C8837751EF09586174DC6E931786C5DAAC0CD1E94C6010
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE70A3CDE5038248EB4EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006372A1456D053D20C618638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D84C276E346B39387749C6CBCE8BF5D3D26F9789CCF6C18C3F8528715B7D10C86859CC434672EE6371117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC2EE5AD8F952D28FBA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520C65AC60A1F0286FE6FD1C55BDD38FC3FD2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE0AC5B80A05675ACD302FCEF25BFAB3454AD6D5ED66289B52698AB9A7B718F8C46E0066C2D8992A16725E5C173C3A84C30F24D24DE464E81ABA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF17B107DEF921CE791DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3CCB7F3AE331DA89035872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A582E0704EBBEAB9D30DC5E040CAA6A817697E875720238A195A4FF58CDAEABE2AA132EA92956906CBEC0DA21D194D9A2C8151CC1E5A7F5336
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D344A2E3AE0A8792E6975551DD38E09551A6C87A469DB285F34459E3F3F54ADBC9613EAF68A3F16F5B91D7E09C32AA3244C0A16F1AB4728A153BFC2CFC75D9000B2B018FE5BB746DCD13EB3F6AD6EA9203E
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojrYIVAnYNYwBsMRHXt7/Vvg==
X-Mailru-Sender: DC3EB4EBD01594E4BED89F5F1533D14EB73B66207A112F32B9C8837751EF095851675C988997E3A058EE59803C9A990DFB559BB5D741EB96FE679880309AA8C36F53C80213D1719C67EA787935ED9F1B
X-Mras: Ok
X-174C08C4: 5188C02AEC42908C481ED7ADC579193296BBA28369E3F2D2713F3D5F7D406D31BCF678C7329BA986
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4FA133F958ACA88638D06B3AF3B1F633AEF73FFA2F90C641B049FFFDB7839CE9EAB1F03AB1C4AFD781F344B1B3E222B67E2F011EB41A8CD69952D011C65515723
X-7FA49CB5: 0D63561A33F958A5ACCFD0B410C4ADB6729071A0ADA1E1AFB8BAF7408F9A4BF2CACD7DF95DA8FC8BD5E8D9A59859A8B6F9238D9F5226D930CC7F00164DA146DAFE8445B8C89999728AA50765F7900637A8F87FB3013159CA389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8FDE5EAC6C5C309E2F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CFE4D9CDE3FF759CFBA3038C0950A5D36C8A9BA7A39EFB766EC990983EF5C032935872C767BF85DA227C277FBC8AE2E8B10408FBE725BD4E875ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojrYIVAnYNYwAPDrMOKOVTXQ==
X-Mailru-MI: 1000
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git,

I have a pretty long investigation has been started from usage 3dparty projects related directly or indirectly to the git submodules:

`svn externals replacement` : https://github.com/chronoxor/gil/issues/6
`svn complete replacement for externals` : https://github.com/dirk-thomas/vcstool/issues/243

And stumbled on this discussion:

`nested submodules detection w/o .gitmodules file` : https://github.com/gitextensions/gitextensions/discussions/10644 (https://github.com/gitextensions/gitextensions/issues/10642)

The main question here is that, could the git have has submodules without `.submodules` file?

If no, then all side projects which utilizes it's own input file for the externals may subsequentially fail:

https://github.com/chronoxor/gil
https://github.com/dirk-thomas/vcstool
https://github.com/ingydotnet/git-subrepo

If yes, then other projects which does rely on the `.submodules` would have not actual or even invalid state:

https://github.com/gitextensions/gitextensions

Or even the github itself: 

`Zip archive to include submodule` : https://github.com/dear-github/dear-github/issues/214

(`[PATCH] archive: add –recurse-submodules to git-archive command` : https://git.github.io/rev_news/2022/11/30/edition-93/, https://lore.kernel.org/git/pull.1359.git.git.1665597148042.gitgitgadget@gmail.com/)

Mine point here is that:

Git database is a primary storage. The `.gitmodules` file is not a primary storage, so can be in not an actual or desync state with the database.
And any application or a 3dparty project must read the database directly.

But another problem here is that the git still does not have a stable API for that.
For example, a submodule can be declared directly from the `.git/config` file in a working copy: 

https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt-init--ltpathgt82308203
https://git-scm.com/docs/gitsubmodules#_active_submodules

So, who is right and what is wrong here?

