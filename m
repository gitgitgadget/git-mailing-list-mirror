Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C26C001DE
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 10:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjGQKpB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jul 2023 06:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjGQKo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 06:44:58 -0400
X-Greylist: delayed 5162 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Jul 2023 03:44:55 PDT
Received: from fallback13.i.mail.ru (fallback13.i.mail.ru [79.137.243.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40255BC
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 03:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=itf5I5Kcc6Vn4P6wF7ob93TpOtax7HZGSkZeIrKZOZQ=;
        t=1689590695;x=1689680695; 
        b=z0dDlx1p1vPjxjrpd28RBpE7JmD8vUP4uae6IUS5z6vO+9v11uWYWVsLPbkBCigDLjnMaetMeysd52uHGTTG5oZkJHjucK/uqqUfGzttB6zeO0dXuIAq+tzW//txULku/z2oDi1GZ/jeG2LrvzFoeGmmXhWPAnCVtbVajBCdgac=;
Received: from [10.12.4.3] (port=39186 helo=smtp17.i.mail.ru)
        by fallback13.i.mail.ru with esmtp (envelope-from <kostix@bswap.ru>)
        id 1qLKNX-00H8tQ-Si
        for git@vger.kernel.org; Mon, 17 Jul 2023 12:18:52 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=itf5I5Kcc6Vn4P6wF7ob93TpOtax7HZGSkZeIrKZOZQ=;
        t=1689585531;x=1689675531; 
        b=QNbfBBvJKttvzX6DHYr+UMC5tIFQ8flCUSbu9PYx/o08xQ8wz+QQiiV57CIgzOlnK8kZSHLKdy9QBfQcovsMHBlq9o2pi2P0C2VIORRN2iYLP+nC8Jy5+LhoxUIe45xx6gZa+2Sn12JyoGUTwe2GFPyZq4HyFO+Ebc9eGMXArco=;
Received: by smtp17.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1qLKNV-00BcGl-6e
        for git@vger.kernel.org; Mon, 17 Jul 2023 12:18:49 +0300
Date:   Mon, 17 Jul 2023 12:18:49 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Pressing Ctrl-C during 'git checkout <branch-name>' messes up
 the repository
Message-ID: <20230717091849.z7bvqbygbpg4sluk@carbon>
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLM4sTUjBQt4QMfG@tapette.crustytoothpaste.net>
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD97569A0FE902DCB3DF525A235365A19A2D5B01E069C4E5BA91867C24CE74E72BB5FE18E9CBFBE7C0706B0421BEA6BF00343494BB7A5806D9EC32D41E6A220F2D23555984C5E13135E
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7CC84CC3AD347B910EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637F97367C191A19EB28638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8060B97767C5BA1A24135F824BCD7A705117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCECADA55FE5B58BB7A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520D1AC325EA934333D2CC0D3CB04F14752D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEB28585415E75ADA91B780A39BCC1DD35D8FC6C240DEA76429C9F4D5AE37F343AA9539A8B242431040A6AB1C7CE11FEE3AD74539164518AE5302FCEF25BFAB345C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CA9FF340AA05FB58C2E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F3695E42C86E34F97089D37D7C0E48F6C5571747095F342E88FB05168BE4CE3AF
X-C1DE0DAB: 0D63561A33F958A5109DAFC2413E8B178E5515F32847B1200EB34946ED51F3D4F87CCE6106E1FC07E67D4AC08A07B9B06A1CB4668A9CA5FACB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADBF74143AD284FC7177DD89D51EBB7742DC8270968E61249B1004E42C50DC4CA955A7F0CF078B5EC49A30900B95165D34103A2CD2CFC42C67D53AD1E5288C2240C980D909D9D038772A96386DCCDD36C96C8DD1CF14462D5C1D7E09C32AA3244CC23853DF56BEB3A92215BD1B32F9759AA995755A1445935EBC4AF6B5DE6957CB5DA084F8E80FEBD3B644FBF139BB3089A015563ECF9503F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXhVwZTQ6J0dsT5ANq37bP/v
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD13864A9E5F77FC4695AB51E3CE7A4C85322976AF1CB91E68A8113BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4C299D5088EBD47D40426EC7804F4619439C9C9D55C0BCB21049FFFDB7839CE9E09B1352F0AAE3DBBE6A2E9E837EA8C94B6644FD69C99A007166DD8BA2504F4F5
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdojJHpMQNyvt36WLvZ4sU1Q==
X-Mailru-MI: C000000000000800
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I would disagree here.  When the user has hit Ctrl-C, they want to
> interrupt the operation.  That's literally why a SIGINT (interrupt)
> signal is sent.

Just a fun remark: that "INT" in SIGINT stands for "INTeractive attention",
and IIUC, relabeling it as a request for interruption in the public
consciousness is likely the result of that signal having been left in its
default disposition in most of the software which was in use then, which
naturally made the signal work as a termination signal ;-)

