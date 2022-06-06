Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88432C433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 13:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238107AbiFFNAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 09:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238085AbiFFNAu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 09:00:50 -0400
X-Greylist: delayed 4090 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Jun 2022 06:00:47 PDT
Received: from fallback24.mail.ru (fallback24.m.smailru.net [94.100.187.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3437895B6
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 06:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=bXuJhfnzoRku1rIu4i48essYEECRkD2z7vAUH3TbXu8=;
        t=1654520447;x=1655125847; 
        b=r/sJYvPiBsrUcX7aNbCUcVJbXIGypqgV54v0ZQ9IImVlRUNDRwExFZDyiZXZQGABjkvrR9b8g7CHY7EQFossolqids1TMEFOoSlVQjCU3+iz8HfIqgJMTFqREBS5BpSdxnnbPLjw3c26+dmmVUN0yaW24SrJvFJe7/yiN1VoYA4=;
Received: from [10.161.64.55] (port=36788 helo=smtp47.i.mail.ru)
        by fallback24.m.smailru.net with esmtp (envelope-from <kostix@bswap.ru>)
        id 1nyBHa-0002gt-He
        for git@vger.kernel.org; Mon, 06 Jun 2022 14:52:30 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=bXuJhfnzoRku1rIu4i48essYEECRkD2z7vAUH3TbXu8=;
        t=1654516350;x=1655121750; 
        b=cv6OKbkhmH2rHT0TKkAE+kJMTFtk5bTwHeMbX2uQjkASNTScgpeh9Qkd89z1X0rtm/TiP+fv9Q4mVsO8YnHeMKREW3sQEPR60mTtfpJ9IT4k6M8NM9nRV9Ic6EUDLFjSEwWFxqTTV5z4l1FbZi4LyZyicvg82YDLOcRsiCcyBZo=;
Received: by smtp47.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1nyBHN-0006jI-8i; Mon, 06 Jun 2022 14:52:17 +0300
Date:   Mon, 6 Jun 2022 14:52:15 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Aman <amanmatreja@gmail.com>
Cc:     Konstantin Khomoutov <kostix@bswap.ru>,
        Git List <git@vger.kernel.org>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Philip Oakley <philipoakley@iee.email>,
        "git-vger@eldondev.com" <git-vger@eldondev.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: About GIT Internals
Message-ID: <20220606115215.mxzney54vf6vkzlp@carbon>
References: <Yo68+kjAeP6tnduW@invalid>
 <8adba93c-7671-30d8-5a4c-4ad6e1084a22@iee.email>
 <CACMKQb3exv13sYN5uEP_AG-JYu1rmVj4HDxjdw8_Y-+maJPwGg@mail.gmail.com>
 <0201db28-d788-4458-e31d-c6cdedf5c9cf@iee.email>
 <AS8PR02MB730274D473C2BC3846D9FA3F9CDD9@AS8PR02MB7302.eurprd02.prod.outlook.com>
 <20220530115339.3torgv5c2zw75okg@carbon>
 <220530.8635gr2jsh.gmgdl@evledraar.gmail.com>
 <CACMKQb3_j+iFcf5trZEcWoU7vAsscKv+_sLaEqg_qfazBPTo+Q@mail.gmail.com>
 <20220603152301.olqbjtt5j2kqyc3e@carbon>
 <CACMKQb3gYwdyfRSLWO4FWb6+Kxrk-WURpLayrgFsszCKMhWONw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACMKQb3gYwdyfRSLWO4FWb6+Kxrk-WURpLayrgFsszCKMhWONw@mail.gmail.com>
X-4EC0790: 10
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9A866A199C4CD7E1071F787FD1D87DD886398D2FD36F3E881182A05F5380850403A6ECD1C412B796DCA23F410DA1F40B988CFC0C2CEF4B98C8A955B2C0A71D532
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7C6068CE86C2B75F5EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063764BF1E09E94CC6278638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D821F479D8B039C87A60D5840A5FA2CFAF117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCAA867293B0326636D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BAA867293B0326636D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE7B96B19DC4093321BA3038C0950A5D36C8A9BA7A39EFB766EC990983EF5C0329BA3038C0950A5D36D5E8D9A59859A8B66BE5EE18F29CA0AD76E601842F6C81A1F004C906525384307823802FF610243DF43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7C0B02670E5FEECA50C4224003CC83647689D4C264860C145E
X-8FC586DF: 6EFBBC1D9D64D975
X-C1DE0DAB: 0D63561A33F958A58FACC0FBEDD08242AC8D22C8DF9EC337B15138517FA22759D59269BC5F550898D99A6476B3ADF6B4886A5961035A09600383DAD389E261318FB05168BE4CE3AF
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D341E2D05735FCBECD15493CEAE77A4268BBCCE7B8DADABB637195C07D20954A5F84D0D285C1ABB98871D7E09C32AA3244CCBFAC73693D2DD43FCB07A6E29ECD39839C99C45E8D137E9DCA3B3C10BC03908
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojw5CbW4eaNzKrSij60N94QA==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138AA166814859802FDCD23CC95BF1600EEB8B74781E454743313BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4445B90D6AFEE871F1973D077709BB0EEC17AA2DC2E79E9E0049FFFDB7839CE9E5177C668B5065447D61C860E4F5945DBA49AF979572C8BEE1340588E1D0E269E
X-7FA49CB5: 0D63561A33F958A5BFB7C5AA6D56B6AA0030E3835C3A5B9BD9D64188493B19988941B15DA834481FA18204E546F3947CD2AC72D04CD5349BF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637545B104AF56618B9389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F790063776C4598447C51BFFD81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636AAAE862A0553A39223F8577A6DFFEA7CDE4CAE6281C7766143847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A5BFB7C5AA6D56B6AA0030E3835C3A5B9BEF3138A2B5A90F09D59269BC5F550898D99A6476B3ADF6B4886A5961035A09600383DAD389E261318FB05168BE4CE3AF
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojw5CbW4eaNzJmJ+TmUGHfDg==
X-Mailru-MI: 8000000000000800
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 04, 2022 at 08:54:10PM +0530, Aman wrote:

[...]
> > If you do also understand the latter - that is, understanding that Git is an
> > assortment of CLI tools combined into two layers called "plumbing" and
> > "porcelain", - then you should have no difficulty starting to read the code:
> > basically locate the source code of the entry point Git binary (which is,
> > well, "git", or "git.exe" on Windows) and start reading it.

(I have reversed the order of your questions below so that my comments follow
logically one after another.)

> What do you mean by the "entry point" of the git binary?

Well, porcelain Git commands (those supposed to be used by users to carry out
their day-to-day tasks) are all implemented as subcommands of a single
executable image file called "git" on all supported platforms (except Windows,
where it's called "git.exe"): for instance, you run "git init" to initialize a
repository, and your OS looks up the executable image file named "git"
somewhere in the list of directories containing such files (it's usually
contained in the environment variable named "PATH"), executes it and passes it
a single command-line argument - "init". The rest of the commands works the
same way. Therefore, that binary named "git" is an entry point of the Git
software package: the execution of most Git commands starts there (not *all*
Git commands, but let's not touch this yet).

> How do I do that?

Well, basically that's out of the scope of this list, but let's try...

Git is a complex software package mostly written in C (and POSIX shell).
As many F/OSS projects written in C, it has a top-level Makefile which is a
file supposed to be processed by GNU Make; this file contains a set of rules
for generating files from other files (compiling C source code into object
files and linking those into libraries and executable image files is exactly
this - generating files from other files). So usually you start from reading
the Makefile to find where the binary file of interest is generated, and from
which source files.

The problem is that Git's Makefile is *complex.*
So let's save you some headache and cut straight to the point: of the top
interest to you are the two files: git.c and common-main.c. The former is
exactly what implements that top-level entry point program, "git", while the
latter implements the function called "main" which is an entry point to any
program written in C which is supposed to be runnable standalone (as opposed
to becoming a library); the object file generated when compiling common-main.c
is linked to every other compiled code implementing Git commands, its main()
calls cmd_main() which is supposed to be implemented in the code of those
commands.

The rest is basically just usual C stuff - source files and header files.
If you're not familiar with these basics, then, I'm afraid, Git may be not the
best project to dive into.

In any case, I find the idea proposed by Junio elsewhere in this thread to be
very smart: it should be quite enlightening to read the "early" Git code to
make yourself accustomed to its overal architecture before moving on to its
present - much more complicated - implementation which nevertheless still
maintains the same architecture.

