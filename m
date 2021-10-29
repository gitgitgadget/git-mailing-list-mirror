Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBF0C433FE
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 14:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DA2160F23
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 14:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhJ2OUr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 10:20:47 -0400
Received: from elephants.elehost.com ([216.66.27.132]:27329 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhJ2OUq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 10:20:46 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 19TEIADa061257
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 29 Oct 2021 10:18:10 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Theo de Raadt'" <deraadt@openbsd.org>
Cc:     "'Alejandro Colomar \(man-pages\)'" <alx.manpages@gmail.com>,
        "'Libc-alpha'" <libc-alpha@sourceware.org>,
        "'linux-man'" <linux-man@vger.kernel.org>, <git@vger.kernel.org>,
        <tech@openbsd.org>
References: <a0371f24-d8d3-07d9-83a3-00a4bf22c0f5@gmail.com> <73ac38a2-c287-4cc1-4e9c-0f9766ac4c0c@gmail.com> <00d501d7ccbe$0169c340$043d49c0$@nexbridge.com> <63238.1635515736@cvs.openbsd.org>
In-Reply-To: <63238.1635515736@cvs.openbsd.org>
Subject: RE: Is getpass(3) really obsolete?
Date:   Fri, 29 Oct 2021 10:18:04 -0400
Organization: Nexbridge Inc.
Message-ID: <00e401d7cccf$ccde0d40$669a27c0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIurXUz3siHir4QEPyFWZm7FNZOgwHZ6oOZAi9B6dkCYbJFUqsI7XnA
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 29, 2021 9:56 AM, Theo de Raadt wrote:
> Subject: Re: Is getpass(3) really obsolete?
> <rsbecker@nexbridge.com> wrote:
> 
> > On October 29, 2021 7:29 AM, Alejandro Colomar wrote:
> > > On 10/29/21 13:15, Alejandro Colomar wrote:
> > > > Hi,
> > > >
> > > > As the manual pages says, SUSv2 marked it as LEGACY, and POSIX
> > > > doesn't have it at all.  The manual page goes further and says
> > > > "This function is obsolete. Do not use it." in its first lines.
> > > >
> > > > But, glibc doesn't seem to have deprecated this function at all.
> > > > And it seems to be the most portable way to get a password, even
> > > > if it's not in POSIX.
> > > >
> > > > BSDs have readpassphrase(3), but glibc doesn't, so unless you
> > > > recommend
> > >
> > > OpenBSD also marks getpass(3) as obsolete and recommends
> > > readpassphrase(3):
> > > <https://man.openbsd.org/getpass>
> > >
> > > > using readpassphrase(3) from libbsd, or plan to add it to glibc, I
> > > > think
> > > > getpass(3) should be the recommended function in Linux, and
> > > > therefore we should remove the hard words against it.
> > > >
> > > > As a real example, git(1) uses getpass(3).
> > > > <https://github.com/git/git/blob/master/compat/terminal.c>
> > > >
> > > > What are your thoughts?
> >
> > getpass() is obsolete in POSIX.2. However, some platforms still are on
POSIX.1,
> so replacing it instead of providing a configure detection/switch for it
might
> cause issues.
> 
> 
> The community finally had the balls to get rid of gets(3).
> 
> getpass(3) shares the same flaw, that the buffer size isn't passed.
> This has been an issue in the past, and incorrectly led to
readpassphrase(3)
> 
> readpassphrase(3) has a few too many features/extensions for my taste, but
at
> least it is harder to abuse.

readpassphrase is not generally supported. This will break builds on many
platforms.

