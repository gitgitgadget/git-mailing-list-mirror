From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] Re: [PATCH 14/14] MINGW: config.mak.uname: auto-detect
 MinGW build from compiler
Date: Thu, 9 Oct 2014 09:38:31 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1410090936381.990@s15462909.onlinehome-server.info>
References: <1412791267-13356-1-git-send-email-marat@slonopotamus.org> <1412791267-13356-15-git-send-email-marat@slonopotamus.org> <xmqqoatm8irn.fsf@gitster.dls.corp.google.com> <20141009050318.GA17479@seldon> <xmqqzjd57l32.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 09:38:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xc8J5-00050o-7u
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 09:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbaJIHig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2014 03:38:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:53599 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750967AbaJIHif (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 03:38:35 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx002) with ESMTPSA (Nemesis) id 0Lxxw4-1YEn0u1Dme-015HMz;
 Thu, 09 Oct 2014 09:38:32 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqzjd57l32.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:1nMLIlRM/d0hC95RCA7CkUUpFQQPHi5eksWU7xUTDhmrz0ZIv1o
 tKmy4IdsZIP9E8rze2nMENT8C5s5lw411WMiUbDyJbiourGGnWeWi9JrQ+PHa2fCaKmaIP9
 K2rp/6hWY31E0MBUCTcdHlnyLxpqev/0SHpX8/wVZWTBiO/+WHIDB7PFevw8qFaq4Iju7u0
 ySpw0zjlW8+YvKewohF9Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 9 Oct 2014, Junio C Hamano wrote:

> Marat Radchenko <marat@slonopotamus.org> writes:
> 
> > On Wed, Oct 08, 2014 at 12:26:52PM -0700, Junio C Hamano wrote:
> > ...
> >> What I am wondering is if it is a better solution to make it easier
> >> to allow somebody who is cross compiling to express "Mr.  Makefile,
> >> we know better than you and want you to do a MINGW build for us
> >> without checking with `uname -?` yourself", i.e.
> >> 
> >> 	$ make uname_O=MINGW uname_S=MINGW
> >> 
> >> which would hopefully allow cross-compilation into other
> >> environments, not just MINGW.
> >
> > So, do you really want this patch to be changed from 5-liner into
> > a full-blow system detection rewrite based on `cc -dumpmachine`
> > instead of `uname`?
> 
> No, and I do not quite see why you even need to look at -dumbmachine

Nice Freudian ;-)

> output when your goal is to make this command line
> 
> >> 	$ make uname_O=MINGW uname_S=MINGW
> 
> work sensibly.  Wouldn't it be more like a series of
> 
> 	ifndef uname_O
>         uname_O := $(shell uname -o)
> 	endif
> 
> or something like that?

Or uname_O ?= $(shell uname -o)

To clarify: it would be enough to look at CROSS_COMPILE to determine
whether we're cross-compiling for MinGW.

The output of -dumpmachine is still needed for the correct CFLAGS/LDFLAGS.

Ciao,
Dscho
