From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 17/19] Portable alloca for Git
Date: Wed, 9 Apr 2014 15:01:07 +0200
Message-ID: <CABPQNSbiyzGLC=Y1kiFPOc4WLWnu=ZpPd6aRwSBzBjZYEih5Tw@mail.gmail.com>
References: <cover.1393257006.git.kirr@mns.spb.ru> <f08867ee212e27074dbb4cbb06af408b16dba0a1.1393257006.git.kirr@mns.spb.ru>
 <CABPQNSaVQuXBEnSrs6hdHwEbaBKFr-NjKpuBRNnbkM+HtfJ4Ag@mail.gmail.com>
 <CABPQNSadTGfiue6G+6x7_o10Ri1E7D5vZFU=Cp8rAha+j9jwSA@mail.gmail.com>
 <20140228170012.GA5247@tugrik.mns.mnsspb.ru> <CABPQNSYnDjhxjpyZQkNP_qwect_tnPvJ_nEfGSq9qnYFMpehWg@mail.gmail.com>
 <20140305093151.GA3994@tugrik.mns.mnsspb.ru> <xmqq1txrp8ur.fsf@gitster.dls.corp.google.com>
 <20140327142250.GC17333@mini.zxlink> <20140409124827.GA24672@tugrik.mns.mnsspb.ru>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Gerrit Pape <pape@smarden.org>,
	Petr Salinger <Petr.Salinger@seznam.cz>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Schwinge <tschwinge@gnu.org>, kirr@navytux.spb.ru
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Wed Apr 09 15:01:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXs8Y-0004xj-Rt
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 15:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933113AbaDINBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2014 09:01:49 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:36385 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932748AbaDINBs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 09:01:48 -0400
Received: by mail-ie0-f182.google.com with SMTP id y20so2394509ier.27
        for <git@vger.kernel.org>; Wed, 09 Apr 2014 06:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=+G0HWVChzrSBRJq+wAPIKV5cN53MFjFqT8Ihu1puBR8=;
        b=u4R+JUQuycjQg3hYME6r/zIGFJKOgcZ5I22sUBXi3gH/EFIJYe1dXOB/0/i07el6Sy
         rV2ijvaYXO2SR6eyCjF9izYYUejx6Tel0J7hHHDl0kvpSK+NnmM2V7HdG/Up5F+l+9Lk
         2UsLPLc6e4Vn7IP8L1gZ7GAft+9xULk1OMNLiBevHas0eOtyaDJpy+1ehAX1/ebbH05P
         jAlFCkzu1KxKAGQ7v+IbKPr5CuYy6w8hsVxzAHkGX1umE0vtTbyHTuoxWw/ZRVaZ9KYW
         GrH/5PJv5Bp91e7/WD8ggVgeLtSeuelE2SCsYAXfKHeQayjNnwG5RNFrl5zkMBSuuyby
         b5SQ==
X-Received: by 10.43.94.9 with SMTP id bw9mr7479142icc.19.1397048507897; Wed,
 09 Apr 2014 06:01:47 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Wed, 9 Apr 2014 06:01:07 -0700 (PDT)
In-Reply-To: <20140409124827.GA24672@tugrik.mns.mnsspb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245974>

On Wed, Apr 9, 2014 at 2:48 PM, Kirill Smelkov <kirr@mns.spb.ru> wrote:
> On Thu, Mar 27, 2014 at 06:22:50PM +0400, Kirill Smelkov wrote:
>> On Mon, Mar 24, 2014 at 02:47:24PM -0700, Junio C Hamano wrote:
>> > Kirill Smelkov <kirr@mns.spb.ru> writes:
>> >
>> > > On Fri, Feb 28, 2014 at 06:19:58PM +0100, Erik Faye-Lund wrote:
>> > >> On Fri, Feb 28, 2014 at 6:00 PM, Kirill Smelkov <kirr@mns.spb.ru> wrote:
>> > >> ...
>> > >> > In fact that would be maybe preferred, for maintainers to enable alloca
>> > >> > with knowledge and testing, as one person can't have them all at hand.
>> > >>
>> > >> Yeah, you're probably right.
>> > >
>> > > Erik, the patch has been merged into pu today. Would you please
>> > > follow-up with tested MINGW change?
>> >
>> > Sooo.... I lost track but this discussion seems to have petered out
>> > around here.  I think the copy we have had for a while on 'pu' is
>> > basically sound, and can easily built on by platform folks by adding
>> > or removing the -DHAVE_ALLOCA_H from the Makefile.
>>
>> Yes, that is all correct - that version works and we can improve it in
>> the future with platform-specific follow-up patches, if needed.
>
> Junio, thanks for merging this and other diff-tree patches to next.  It
> so happened that I'm wrestling with MSysGit today, so please also find
> alloca-for-mingw patch attached below.
>
> Thanks,
> Kirill
>
> ---- 8< ----
> Subject: [PATCH] mingw: activate alloca
>
> Both MSVC and MINGW have alloca(3) definitions in malloc.h, so by moving
> win32-compat alloca.h from compat/vcbuild/include/ to compat/win32/ ,
> which is included by both MSVC and MINGW CFLAGS, we can make alloca()
> work on both those Windows environments.
>
> In MINGW, malloc.h has explicit check for GNUC and if it is so, defines
> alloca to __builtin_alloca, so it looks like we don't need to add any
> code to here-shipped alloca.h to get optimum performance.
>
> Compile-tested on Windows in MSysGit.
>
> Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>

Looks good to me!
