From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 4/4] Makefile: Don't pass $(ALL_CFLAGS) to the linker
Date: Sat, 26 Jun 2010 18:59:53 +0100
Message-ID: <4C264019.6030408@ramsay1.demon.co.uk>
References: <4C226520.5080009@ramsay1.demon.co.uk> <20100623210820.GA24242@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 26 20:02:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSZi5-0008P4-2f
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 20:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841Ab0FZSCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jun 2010 14:02:30 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:36262 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753824Ab0FZSC0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Jun 2010 14:02:26 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1OSZhx-0002DA-ni; Sat, 26 Jun 2010 18:02:26 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20100623210820.GA24242@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149765>

Jonathan Nieder wrote:
> Ramsay Jones wrote:
> 
>>     LINK : warning LNK4044: unrecognized option '/Zi'; ignored
>>
>> In order to suppress the warning, we refrain from passing the
>> $(ALL_CFLAGS) macro to the linker.
>>
>> Note that, should it be necessary in the future, an option
>> intended for both the (front-end) compiler and the linker can
>> be included in both CFLAGS and LDFLAGS.
> 
> I think traditionally CPPFLAGS is meant to be used for the purpose
> you are describing (see [1] for example).

Really? I thought that the general scheme was something like:

    - LDFLAGS is for options which only affects the operation of
      the linker (e.g. -L).
    - CPPFLAGS is for options which only affects the operation of
      the C pre-processor (e.g. -I, -D, -U)
    - CFLAGS is for options which only affects the operation of
      the compiler proper.

If an option affects multiple phases, then (one option) is to include
it into each of the above macros to which it applies.

In practice, of course, I've yet to see a Makefile which faithfully
implements the above scheme. ;-)

Also, the last time I was forced to use automake (yuck), I noticed that
it passed CPPFLAGS to the linker; I consider this to be a bug in
automake. :-P

[CFLAGS et. al. are also supposed to be user settable ...]

> I realize that the Makefile does not currently use the terms this way:
> making it consistent would require
> 
>  . s/BASIC_CFLAGS/BASIC_CPPFLAGS/, except that the
> 
> 	BASIC_CFLAGS += -Kthread
> 
>    settings should probably stay as-is
> 
>  . Windows BASIC_CFLAGS would probably need to be split:
> 
> 	BASIC_CFLAGS = -nologo
> 	BASIC_CPPFLAGS = -I. -I../zlib ... -DWIN32 ...
> 
>  . s/COMPAT_CFLAGS/COMPAT_CPPFLAGS
> 
> What do you think?

I think I am missing something, since I don't see how this relates to
my patch!

I'm sure the misunderstanding is mine; sorry to be so dense!

ATB,
Ramsay Jones
