From: Peter Wu <peter@lekensteyn.nl>
Subject: Re: Git compile warnings (under mac/clang)
Date: Thu, 22 Jan 2015 22:19:03 +0100
Message-ID: <8235317.pb98ayo4Kl@al>
References: <CAO2U3Qi6Xf1RrbxyVW3cHNe1-ZwxFHDVskGLZguWS=b38pgaXQ@mail.gmail.com> <CAGZ79kaFWL5HWdctLzTWf6D4nTP19sPZbcOg9fiRx7RQrWjY7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Michael Blume <blume.mike@gmail.com>, Johannes.Schindelin@gmx.de,
	eungjun.yi@navercorp.com, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 22:19:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEP9p-0005Fz-3U
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 22:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568AbbAVVTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 16:19:13 -0500
Received: from lekensteyn.nl ([178.21.112.251]:54182 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753247AbbAVVTM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 16:19:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2014-q3;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From; bh=SqtXGrrxVQ8oXecQIc5MZdfonjGps2eNXew+1ezrhrg=;
	b=hdJNFk4NxusAMo/EeUBRlRIUhV9Wk6xMMyk/nNK59y3ex0IBho+bTPHexGt982bGuqFIi/uRka4u+v1Og04aCMtl6cYa3fXWA2QjcvxALDbk/grfaaTG2kOG5SHf2aNezQrlD7yhuFMHLHoU+96uzxUg5xGbjQA4GCffx6khLmUjBdVOGEVTJw933nXeEu9bvqEXB5hm69nuadyEb0yqaqDeZhVd2xAv3RybvHioIRt/V0n2rlTxmsTSqGvee+1GXABVPhxD8bmil0QxN8gxSJ6RMjCTCVJGKV4xaauVXzhHNKkaJkVx2Do+J7yWd27fOT2rI0QSNu7OAFbG63SjtA==;
Received: by lekensteyn.nl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <peter@lekensteyn.nl>)
	id 1YEP9d-0002dN-8l; Thu, 22 Jan 2015 22:19:05 +0100
User-Agent: KMail/4.14.4 (Linux/3.18.1-1-ARCH; KDE/4.14.4; x86_64; ; )
In-Reply-To: <CAGZ79kaFWL5HWdctLzTWf6D4nTP19sPZbcOg9fiRx7RQrWjY7Q@mail.gmail.com>
X-Spam-Score: 0.0 (/)
X-Spam-Status: No, hits=0.0 required=5.0 tests=NO_RELAYS=-0.001,URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262871>

On Thursday 22 January 2015 11:59:54 Stefan Beller wrote:
> cc Johannes Schindelin <Johannes.Schindelin@gmx.de> who is working in
> the fsck at the moment
> cc Peter Wu <peter@lekensteyn.nl> who worked on builtin/remote.c a few weeks ago
> 
> I just compiled origin/pu to test and also found a problem (doesn't
> happen in origin/master):
> 
> http.c: In function 'get_preferred_languages':
> http.c:1020:2: warning: implicit declaration of function 'setlocale'
> [-Wimplicit-function-declaration]
>   retval = setlocale(LC_MESSAGES, NULL);
>   ^
> http.c:1020:21: error: 'LC_MESSAGES' undeclared (first use in this function)
>   retval = setlocale(LC_MESSAGES, NULL);
>                      ^
> http.c:1020:21: note: each undeclared identifier is reported only once
> for each function it appears in
> 
> so I cc Yi EungJun <eungjun.yi@navercorp.com> as well.
> 
> On Thu, Jan 22, 2015 at 11:43 AM, Michael Blume <blume.mike@gmail.com> wrote:
> > These are probably minor, I only bring them up because Git's build is
> > generally so quiet that it might be worth squashing these too.
> >
> >     CC fsck.o
> > fsck.c:110:38: warning: comparison of unsigned enum expression >= 0 is
> > always true [-Wtautological-compare]
> >         if (options->msg_severity && msg_id >= 0 && msg_id < FSCK_MSG_MAX)
> >                                      ~~~~~~ ^  ~
> > 1 warning generated.
> >     AR libgit.a
> > /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib:
> > file: libgit.a(gettext.o) has no symbols
> >     CC builtin/remote.o
> > builtin/remote.c:1572:5: warning: add explicit braces to avoid
> > dangling else [-Wdangling-else]
> >                                 else
> >                                 ^
> > builtin/remote.c:1580:5: warning: add explicit braces to avoid
> > dangling else [-Wdangling-else]
> >                                 else
> >                                 ^
> > 2 warnings generated.

Hi, these warnings were present in v3 of the git-remote patch. v4 was
proposed to overcome these issues, but I have yet to respond to Junio's
feedback at http://www.spinics.net/lists/git/msg243652.html
(Message-ID: <xmqqr3vx9ad5.fsf@gitster.dls.corp.google.com>)

(cc'ing Junio to let him know I am still alive :p)

I'll get back to this next week, had some other tasks to prepare for.

Kind regards,
Peter

> > (the warning about libgit.a(gettext.o) is probably because I'm
> > building with NO_GETTEXT -- I've never been able to get gettext to
> > work on my mac)
