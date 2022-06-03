Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDA8C43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 15:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343509AbiFCP5f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 11:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343554AbiFCP5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 11:57:25 -0400
X-Greylist: delayed 2052 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Jun 2022 08:57:22 PDT
Received: from fallback17.mail.ru (fallback17.m.smailru.net [94.100.176.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30C764F0
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 08:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=lwCrzCN0twOpKuDoR/Q0G045vlGZBk1pduyfYmViB9M=;
        t=1654271842;x=1654877242; 
        b=iJTDZKpHonV+tLfUgDI0qvWInz+IY0xL29v1zp6SVk9ayPXoNDxYp6ksGfCwmxzfx5aFGJofR70UjbBhteCS+xkHCDKBaCXLMjoEXl+odb7rKj5TSkqVOEn1g+xvMIvVkk6pihYlmmYRC2A3gsG+Esx4QWBtrePKDcQjVNGjx4M=;
Received: from [10.161.25.36] (port=41800 helo=smtp59.i.mail.ru)
        by fallback17.m.smailru.net with esmtp (envelope-from <kostix@bswap.ru>)
        id 1nx98m-0002fR-HN
        for git@vger.kernel.org; Fri, 03 Jun 2022 18:23:08 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=lwCrzCN0twOpKuDoR/Q0G045vlGZBk1pduyfYmViB9M=;
        t=1654269788;x=1654875188; 
        b=kObdi/XZ4VZEoyFq8ucFSzNW+Sxk+kLOqxPWRp4YtYM8Ogne0wcDeOKYNqX+8wh3OMaj8FUh1N0LW75CiVD98L329O5sAKC4DiIqRTU7sFlRhI2a1UZ1S/9HPHfXcF+jCIKMzlsWfEScYfh8ywFjliSrkzmd/Q/ryefBEtTCBDM=;
Received: by smtp59.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1nx98h-0008Dx-6c; Fri, 03 Jun 2022 18:23:03 +0300
Date:   Fri, 3 Jun 2022 18:23:01 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Aman <amanmatreja@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Konstantin Khomoutov <kostix@bswap.ru>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Philip Oakley <philipoakley@iee.email>,
        "git-vger@eldondev.com" <git-vger@eldondev.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: About GIT Internals
Message-ID: <20220603152301.olqbjtt5j2kqyc3e@carbon>
References: <CACMKQb0Mz4zBoSX2CdXkeF51z_mh3had7359J=LmXGzJM1WYLg@mail.gmail.com>
 <Yo68+kjAeP6tnduW@invalid>
 <8adba93c-7671-30d8-5a4c-4ad6e1084a22@iee.email>
 <CACMKQb3exv13sYN5uEP_AG-JYu1rmVj4HDxjdw8_Y-+maJPwGg@mail.gmail.com>
 <0201db28-d788-4458-e31d-c6cdedf5c9cf@iee.email>
 <AS8PR02MB730274D473C2BC3846D9FA3F9CDD9@AS8PR02MB7302.eurprd02.prod.outlook.com>
 <20220530115339.3torgv5c2zw75okg@carbon>
 <220530.8635gr2jsh.gmgdl@evledraar.gmail.com>
 <CACMKQb3_j+iFcf5trZEcWoU7vAsscKv+_sLaEqg_qfazBPTo+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACMKQb3_j+iFcf5trZEcWoU7vAsscKv+_sLaEqg_qfazBPTo+Q@mail.gmail.com>
X-4EC0790: 10
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9A866A199C4CD7E10667ED900E21AD17D8C41DC14F88CD986182A05F5380850405A6907B0A2555015B2D34DBF18561ADDFA7A511DFBC11233208E5BD72020EDD5
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7F9D3BE5B596754B8C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE78E8764B5BC580342EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38BEBC5CAB6D411FFA6D7FB4266B73DA564260108CD3D323CD7CC7F00164DA146DAFE8445B8C89999728AA50765F7900637F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C62E6B8B4347DBC1C2D242C3BD2E3F4C64AD6D5ED66289B52698AB9A7B718F8C46E0066C2D8992A16725E5C173C3A84C35FEE9FCEF790FECABA3038C0950A5D36B5C8C57E37DE458B0BC6067A898B09E46D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE73A6989AD488FD87D731C566533BA786AA5CC5B56E945C8DA
X-8FC586DF: 6EFBBC1D9D64D975
X-C1DE0DAB: 0D63561A33F958A5383EF56E1B8B8970D45B5A42F370F0E2F05C41F9B09504BED59269BC5F550898D99A6476B3ADF6B4886A5961035A09600383DAD389E261318FB05168BE4CE3AF
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D349C39CCCDAABCB54BAB5BFD54854E53736569AD4E51177E8750CE46BA0C2761276020987459D4CCC31D7E09C32AA3244C5CE8347CFAD00A7B99F8D479ADF1C693A8CE788DE6831205DCA3B3C10BC03908
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojZQX5hKFvZ7GeAr6MYo+Ofw==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138566A4C406A5227BB0BC57C6D2EDAA7AC5B78F42A239239D813BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: B8F34718100C35BD
X-77F55803: 6242723A09DB00B4445B90D6AFEE871F1973D077709BB0EE52432664B1655F32049FFFDB7839CE9E1E6B1F32EFEE76ADC6B3A949C67051DE83B6CDE968DA261DC47E706A01CBDD83
X-7FA49CB5: 0D63561A33F958A5234793AE342B862F4DC34152CAA8AD580994583CE6E504888941B15DA834481FA18204E546F3947C6633242DC0339950F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F79006375A3B25A3A11CE7E4389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F790063776C4598447C51BFFD81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636AAAE862A0553A39223F8577A6DFFEA7CE81301DE8022F8F643847C11F186F3C59DAA53EE0834AAEE
X-B7AD71C0: BCAA75B3C340DBBEEF3A853C90EA8D50F01536074D6990B7EE9D5CB6078CC77CF41FD44466650BF85FA128949B992996
X-C1DE0DAB: 0D63561A33F958A5234793AE342B862F4DC34152CAA8AD581367A9363CAC59A0D59269BC5F550898D99A6476B3ADF6B4886A5961035A09600383DAD389E261318FB05168BE4CE3AF
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojZQX5hKFvZ7HYqzabriWUBg==
X-Mailru-MI: 8001000000000800
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 03, 2022 at 05:48:14PM +0530, Aman wrote:

[...]
> Though I may understand the internal design and high-level
> implementation of GIT, I really want to know how it's implemented and
> was made, which means reading the SOURCE CODE.
> 
> 1. I don't know how absurd of a quest this is, please enlighten me.
> 2. How do I do it? Where do I start? It's such a BIG repository - and
> I am not guessing it's going to be easy.
> 3. Would someone advise, perhaps, to have a look at an older version
> of the source code? rather than the latest one, for some reason.

Well, depends on what you mean when talking about the two mentioned designs.
I mean, there's the design of the approach to manage data and there's the
design of the software package (which Git is).

If you do also understand the latter - that is, understanding that Git is an
assortment of CLI tools combined into two layers called "plumbing" and
"porcelain", - then you should have no difficulty starting to read the code:
basically locate the source code of the entry point Git binary (which is,
well, "git", or "git.exe" on Windows) and start reading it. You'll find it
parses its command-line arguments and calls out to other executable modules
which are parts of the Git software package to do heavy lifting.
You then read the source code of the packages of interest, and so on and so
on. I'm not sure there could be any other "guide" to read the source code.

If you're not familiar with the design of Git-as-a-software-package, it's
probably time to clone the Git repository and explore the contents of the
directory named "Documentation" there.

