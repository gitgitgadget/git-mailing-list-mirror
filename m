From: perryh@pluto.rain.com (Perry Hutchison)
Subject: Re: [PATCH] help: ensure that common-cmds.h is only included by
 help.c
Date: Sun, 14 Sep 2014 00:55:41 -0700
Message-ID: <541549fd.u4o+i0ruC2hh0cGO%perryh@pluto.rain.com>
References: <1410657073-3089-1-git-send-email-davvid@gmail.com>
 <5414f6b2.XwoOyI03zlXiZ3ds%perryh@pluto.rain.com>
 <CAPc5daXDCAi3eP3YmXfcO+9ncN8=b6tCGUFUxwKE=MuRBuXvEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, davvid@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 14 10:12:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XT4v0-0007kl-4l
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 10:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbaINIMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 04:12:16 -0400
Received: from agora.rdrop.com ([199.26.172.34]:4031 "EHLO agora.rdrop.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752434AbaINIMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 04:12:12 -0400
Received: from agora.rdrop.com (66@localhost [127.0.0.1])
	by agora.rdrop.com (8.13.1/8.12.7) with ESMTP id s8E8Bv1w090237
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Sep 2014 01:11:57 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: (from uucp@localhost)
	by agora.rdrop.com (8.13.1/8.14.2/Submit) with UUCP id s8E8Bv5j090236;
	Sun, 14 Sep 2014 01:11:57 -0700 (PDT)
	(envelope-from perryh@pluto.rain.com)
Received: from fbsd81 by pluto.rain.com (4.1/SMI-4.1-pluto-M2060407)
	id AA29320; Sun, 14 Sep 14 00:55:38 PDT
In-Reply-To: <CAPc5daXDCAi3eP3YmXfcO+9ncN8=b6tCGUFUxwKE=MuRBuXvEg@mail.gmail.com>
User-Agent: nail 11.25 7/29/05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257003>

Junio C Hamano <gitster@pobox.com> wrote:
> On Sat, Sep 13, 2014 at 7:00 PM, Perry Hutchison <perryh@pluto.rain.com> wrote:
> > David Aguilar <davvid@gmail.com> wrote:
> >> Add a #ifndef guard to ensure that common-cmds.h can only
> >> be included by help.c.
> >
> > ... If these definitions are intended to be private to help.c,
> > why not put them there and eliminate common-cmds.h entirely?
>
> Have you studied where common-cmds.h comes from?

Not when I wrote that :)

> After you have done so, would you make the same suggestion?

Yes, as a matter of using C in a conventional and non-hackish
manner.  The normal and expected purpose of .h files is to share
definitions among compilation units.  If certain definitions are
-- by design -- intended to be used in only a single compilation
unit, they should not be put in a .h file; that only encourages
other programmers who come along later to use those definitions
in an incorrect way.

If it's too much trouble to have the auto-generation mechanism 
insert the definitions into help.c where they belong, at least
name the auto-generated file something else, like commands-auto.res
or command-list.txt.  A #include file's name does not _have_ to
end in .h, and avoiding the .h convention in a case such as this
would make it blatantly obvious that something unconventional is
being done.
