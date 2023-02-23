Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FE0C636D6
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 03:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbjBWDUI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 22:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjBWDUF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 22:20:05 -0500
Received: from smtp16.i.mail.ru (smtp16.i.mail.ru [95.163.41.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8090231E30
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 19:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail4;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:To:Message-ID:Reply-To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=bivggzPj/64qGm+9huC7/55+dmOeUi+8WoxkhGUbCf0=;
        t=1677122400;x=1677212400; 
        b=qZOIKFf+0S+vpLKKgxCAaTWvTuZiIZD8Ip15Fu1l2BCxUgwAWyikmoVmWDJZyJqnzjvnoR1NWTgCm3/cr0aNT/3U2fa0wfsKcxwepqkpqnzlGIs/CLZyCbww12EXPZeO+YfMO9zWrFi0Wg7kr3iaufc9B4CAkyl41gc/N3TQ/cmAml9vi05dAYn9SXl3o5WPdiyilPFBFZKNEov8WSfS3ru8UuRz2JcqDcTHMtKSmLrjdqAa4/BNlS6WWUwwPAJYzZAI9hsZHABbJmtt9nFwtEDG+kHGJy4CzuQtWTsbimDU2qj46NwwVcv8OtiGx/zrpZ8JJ9IxzM2kRycNd5vEcw==;
Received: by smtp16.i.mail.ru with esmtpa (envelope-from <andry@inbox.ru>)
        id 1pV29E-009ad5-V8
        for git@vger.kernel.org; Thu, 23 Feb 2023 06:19:57 +0300
Date:   Thu, 23 Feb 2023 06:21:01 +0300
From:   Andry <andry@inbox.ru>
Reply-To: Andry <andry@inbox.ru>
Message-ID: <942870379.20230223062101@inbox.ru>
To:     git@vger.kernel.org
Subject: Get rid of `warning: refs/remotes/origin/master usually tracks 
  refs/heads/master, not refs/remotes/origin/master`
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp16.i.mail.ru; auth=pass smtp.auth=andry@inbox.ru smtp.mailfrom=andry@inbox.ru
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD9806C989EC2150E33C13C456498AA74328729F4FEF7F411FF182A05F538085040FEF8086DA0A194B646304ADED9E0A50AAE46356B713B88A64082BD11F6E1FF0A
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE72F22E6DC541F75D9EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006375448D590B04CE87D8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D89342F3AFD5E3E3DA10CB685C5EC079F06F9789CCF6C18C3F8528715B7D10C86878DA827A17800CE78C592797616C97AB9FA2833FD35BB23D9E625A9149C048EEC8105B04EFE076286FD1C55BDD38FC3FD2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BF9A01DE6F10AE89AA471835C12D1D977C4224003CC836476EB9C4185024447017B076A6E789B0E975F5C1EE8F4F765FC3B9A64F0CD80A8333AA81AA40904B5D9CF19DD082D7633A078D18283394535A93AA81AA40904B5D98AA50765F79006375908BCD2CB23604ED81D268191BDAD3D3666184CF4C3C14F3FC91FA280E0CE3D1A620F70A64A45A98AA50765F79006372E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F890A246B268E114E42539A7722CA490CB5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A59BF989632FC4DC818DDA5F708276A55E3D34361A363287CB4EAF44D9B582CE87C8A4C02DF684249C2E763F503762DF50375C7842B4748C21
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D3441661D6226BE8C317A3613A770DE38B05A26026E72A354A9A8494D159FEEC2FF9DACA88A0298A1CE1D7E09C32AA3244C53472296C22FE35B88E559205DDDDAC63C6EB905E3A8056B3EB3F6AD6EA9203E
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXiy5l4lFtfQQ73pR38zstB4
X-Mailru-Sender: DC3EB4EBD01594E4BED89F5F1533D14ECC84A2B3D8F0749B46304ADED9E0A50AAB37CED9C72D1F6058EE59803C9A990DFB559BB5D741EB96FE679880309AA8C36F53C80213D1719C67EA787935ED9F1B
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Git,

Found this issue and could find a solution.

Repro steps:

1. create a simple repo with only the master branch.
2. `git pull origin *:*` to allocate all refs (no warnings)

If try to mirror the repo into the same remote:

1. `git push origin --mirror`

Then the remote counter part falls into the mirror state and reports the warning:

1. `git pull origin *:*`

```
warning: refs/remotes/origin/master usually tracks refs/heads/master, not refs/remotes/origin/master
Already up to date.
```

Tried to delete all refs in the local and remote. But didn't work. Somehow the remove remember the state.

Is there a way to unmirror the remote repository back?

