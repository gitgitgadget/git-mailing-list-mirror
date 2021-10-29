Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797A9C433FE
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 15:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6234661165
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 15:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhJ2PDU convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 29 Oct 2021 11:03:20 -0400
Received: from elephants.elehost.com ([216.66.27.132]:51800 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhJ2PDT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 11:03:19 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 19TF0iEE062574
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 29 Oct 2021 11:00:44 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Alejandro Colomar \(man-pages\)'" <alx.manpages@gmail.com>,
        "'Theo de Raadt'" <deraadt@openbsd.org>
Cc:     "'Libc-alpha'" <libc-alpha@sourceware.org>,
        "'linux-man'" <linux-man@vger.kernel.org>, <git@vger.kernel.org>,
        <tech@openbsd.org>
References: <a0371f24-d8d3-07d9-83a3-00a4bf22c0f5@gmail.com> <73ac38a2-c287-4cc1-4e9c-0f9766ac4c0c@gmail.com> <00d501d7ccbe$0169c340$043d49c0$@nexbridge.com> <63238.1635515736@cvs.openbsd.org> <00e401d7cccf$ccde0d40$669a27c0$@nexbridge.com> <73029.1635517278@cvs.openbsd.org> <00e701d7ccd2$058b9070$10a2b150$@nexbridge.com> <326e75f9-f732-a7a8-22dc-5fc304601b39@gmail.com>
In-Reply-To: <326e75f9-f732-a7a8-22dc-5fc304601b39@gmail.com>
Subject: RE: Is getpass(3) really obsolete?
Date:   Fri, 29 Oct 2021 11:00:38 -0400
Organization: Nexbridge Inc.
Message-ID: <00f001d7ccd5$bf25e0f0$3d71a2d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIurXUz3siHir4QEPyFWZm7FNZOgwHZ6oOZAi9B6dkCYbJFUgFa6lunAtQjv/IBUmGaPwHl0Njgqs2+T+A=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On October 29, 2021 10:45 AM, Alejandro Colomar wrote:
> On 10/29/21 16:33, rsbecker@nexbridge.com wrote:
> > October 29, 2031 10:21 AM, Theo de Raadt will write:
> >> <rsbecker@nexbridge.com> wrote:
> >>
> >>>>> getpass() is obsolete in POSIX.2. However, some platforms still
> >>>>> are on
> >>> POSIX.1,
> >>>> so replacing it instead of providing a configure detection/switch
> >>>> for it
> >>> might
> >>>> cause issues.
> >>>>
> >>>>
> >>>> The community finally had the balls to get rid of gets(3).
> >>>>
> >>>> getpass(3) shares the same flaw, that the buffer size isn't passed.
> >>>> This has been an issue in the past, and incorrectly led to
> >>> readpassphrase(3)
> 
> That seems a good reason to keep the "Do not use it." note in the manual page.
> I think I'll add a recommendation for readpassphrase(3bsd) for the moment
> which is the only alternative available in Linux.
> 
> >>>>
> >>>> readpassphrase(3) has a few too many features/extensions for my
> >>>> taste, but
> >>> at
> >>>> least it is harder to abuse.
> >>>
> >>> readpassphrase is not generally supported. This will break builds on
> >>> many platforms.
> I found readpassphrase(3) in FreeBSD and OpenBSD.
> It is also present in libbsd(7), which is available in most Linux distributions.
> I also found it on a Mac that I have access.
> 
> NetBSD has getpass_r(3) instead.  It is not in any other system I have access.
> 
> 
> >>
> >> Of course moving forward takes a long time.  If a better API is supplied then
> >> there is a choice in 10 years.  If a better API is not supplied, then 10 years
> from
> >> now this conversation can get a reply.
> >
> > I checked the API 10 years from now (check the above date) at it's still not
> there 😉 In the meantime, compatibility is important. I checked the latest
> release (last week's) on my platform and readpassphrase() is not available. Let's
> please put a compatibility layer in.
> >
> libbsd(7) is probably the compatibility layer that you're looking for.
> What system are you on?
> 
> <https://libbsd.freedesktop.org/wiki/>

I am on two variants (x86 and ia64) of HPE NonStop with current operating systems - and I do the build/test for git and OpenSSL. getpass() an alias to getpass2() but the other procs are not present. If this is going into git, I would suggest putting something into compat.c to abstract out the call. If it's there, we can handle it on a platform-by-platform basis.

Thanks,
Randall

