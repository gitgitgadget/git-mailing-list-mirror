Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E474C3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 14:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E1CC2072E
	for <git@archiver.kernel.org>; Sat,  2 May 2020 14:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgEBO7R convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 2 May 2020 10:59:17 -0400
Received: from elephants.elehost.com ([216.66.27.132]:52550 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgEBO7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 10:59:16 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 042Ex2e4005736
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 2 May 2020 10:59:03 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Sibi Siddharthan'" <sibisiddharthan.github@gmail.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
Cc:     "'Jeff King'" <peff@peff.net>,
        "'Danh Doan'" <congdanhqx@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>,
        "'Sibi Siddharthan via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com> <xmqqv9lod85m.fsf@gitster.c.googlers.com> <CAKiG+9V_nZUXf2a689vZ54rG+xTCFMGcJe_7Av-khaxxuijERg@mail.gmail.com> <xmqq8sikblv2.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet> <20200427200852.GC1728884@coredump.intra.peff.net> <20200427201228.GD1728884@coredump.intra.peff.net> <20200428135222.GB31366@danh.dev> <20200428210750.GE4000@coredump.intra.peff.net> <CAKiG+9U2Eg5yvT4XjgpMUXu4OV-8JF9Hp_ou_P6twxfqJ1tEYA@mail.gmail.com> <nycvar.QRO.7.76.6.2005012130010.18039@tvgsbejvaqbjf.bet> <CAKiG+9UvnLtF7eS9FsPLyRR4ZPNSnakZwyYy3dO7WoAnRpvoMA@mail.gmail.com>
In-Reply-To: <CAKiG+9UvnLtF7eS9FsPLyRR4ZPNSnakZwyYy3dO7WoAnRpvoMA@mail.gmail.com>
Subject: RE: [PATCH 0/8] CMake build system for git
Date:   Sat, 2 May 2020 10:58:57 -0400
Message-ID: <04eb01d62092$3865fb90$a931f2b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIJYRHyQ1C8LhW18tSt1A8NYmssxgIMvlsFAl1C5c8CWGEsHAGNGc14AVFkj6UCyyeDkAH1pLQ9AazbvdcCD3jpegF5aEVjAkqaxvunf1Em0A==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On May 2, 2020 10:32 AM, Sibi Siddharthan Wrote:
> On Sat, May 2, 2020 at 1:02 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Wed, 29 Apr 2020, Sibi Siddharthan wrote:
> >
> > > Adding the CMake script to contrib/buildsystem is a good option.
> >
> > I'd actually prefer it to live in a different subdirectory: what is in
> > contrib/buildsystem/ uses the technique of running `make` in a dry-run
> > mode, parsing the output, and then generating project files. But that
> > is not what CMakeLists.txt is about.
> >
> > How about contrib/cmake/?
> >
> 
> The CMakeLists.txt will be non-functional if it in any other directory except
> the root source directory. To help users we can, add some instructions in
> INSTALL on how to use the script.
> OR
> create a dummy CMakeLists.txt in the root directory which just says
> `message("Copy and Replace the CMakeLists from `whatever-folder` to
> here")` along with some instructions if necessary. This is what LLVM does for
> autoconf.
> > > Is there any changes (apart from the CMakeLists.txt critique and)
> > > that I have to do on my part?
> >
> > No, I think that's it!
> >
> > Thanks,
> > Dscho
> >
> > >
> > > Thank You,
> > > Sibi Siddharthan
> > >
> > > On Wed, Apr 29, 2020 at 2:37 AM Jeff King <peff@peff.net> wrote:
> > > >
> > > > On Tue, Apr 28, 2020 at 08:52:37PM +0700, Danh Doan wrote:
> > > >
> > > > > On 2020-04-27 16:12:28-0400, Jeff King <peff@peff.net> wrote:
> > > > > > On Mon, Apr 27, 2020 at 04:08:52PM -0400, Jeff King wrote:
> > > > > >
> > > > > > > Skimming the patches, I do wish I didn't see so much
> > > > > > > repetition with the existing Makefile. I know that some of
> > > > > > > the logic will just have to be ported manually, but surely
> > > > > > > we could be pulling things like the list of libgit_SOURCES from the
> Makefile as the single source of truth?
> > > > > >
> > > > > > Thinking I surely couldn't be the only one to think of this, I
> > > > > > dug further into some of the sub-threads. And indeed, it seems
> > > > > > like you are on the same page here.
> > > > > >
> > > > > > IMHO it is worth making the cmake file depend as much as
> > > > > > possible on what's in the Makefile.
> > > > >
> > > > > Please correct me if I were wrong (I recall this from my memory
> > > > > without checking anything).
> > > > >
> > > > > The worst thing about CMake is we can't override (Make's)
> > > > > variable in Makefile generated by CMake.
> > > >
> > > > I really don't know enough about cmake to say one way or the
> > > > other. I can well believe there are parts of the Makefile that
> > > > will need to be manually translated, and that it may not ever hit full
> parity.
> > > >
> > > > But as long as it just a tool for people using Visual Studio, and
> > > > if they are happier being able to use that tool, even with a few
> > > > deficiencies, then it may still be worth doing.
> > > >
> > > > -Peff
> > >

Just a head's up that neither the HPE NonStop OSS nor IBM z/OS USS platforms currently have any support for CMake nor do I expect any support in the foreseeable future. We are seeing very strong adoption rates on both platforms (sorry, cannot share statistics at this time).

Regards,
Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.



