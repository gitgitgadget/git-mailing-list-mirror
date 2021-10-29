Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBF8C433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8665260FC0
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhJ2VqH convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 29 Oct 2021 17:46:07 -0400
Received: from elephants.elehost.com ([216.66.27.132]:35296 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhJ2VqG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:46:06 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 19TLhV8e075675
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 29 Oct 2021 17:43:32 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Jeff King'" <peff@peff.net>,
        "=?utf-8?Q?'Carlo_Marcelo_Arenas_Bel=C3=B3n'?=" <carenas@gmail.com>
Cc:     <git@vger.kernel.org>, <avarab@gmail.com>
References: <013a01d7cd092d91cb088b5610nexbridge.com> <20211029212705.31721-1-carenas@gmail.com> <YXxpjLhiguq4HY6g@coredump.intra.peff.net>
In-Reply-To: <YXxpjLhiguq4HY6g@coredump.intra.peff.net>
Subject: RE: [PATCH] wrapper: remove xunsetenv()
Date:   Fri, 29 Oct 2021 17:43:25 -0400
Organization: Nexbridge Inc.
Message-ID: <014901d7cd0e$042a3470$0c7e9d50$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGRg/VseL3IXeLBpvX00zE9WnaeNAD1p6jrAcPxd+qsYUcasA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 29, 2021 5:37 PM, Jeff King wrote:
> On Fri, Oct 29, 2021 at 02:27:05PM -0700, Carlo Marcelo Arenas Belón wrote:
> 
> > Platforms that are using the git compatibility layer for unsetenv use
> > void as a return value for unsetenv(), so any function that checks for
> > a return value will fail to build.
> 
> Good catch.
> 
> > Remove the unused wrapper function.
> 
> I don't mind removing this if nobody is using it, but doesn't your first paragraph
> argue that our definition of gitunsetenv() is just wrong?
> I.e., it should return an int, even if it is always "0"?
> 
> Or is it a portability question? I.e., are there platforms where
> unsetenv() also returns void, in which case we must make sure nobody ever
> looks at its return value (and xunsetenv() is therefore a wrong direction)?

At least on NonStop x86, it is 

       int unsetenv(const char *name);

--Randall

