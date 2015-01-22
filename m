From: Jeff King <peff@peff.net>
Subject: Re: Git compile warnings (under mac/clang)
Date: Thu, 22 Jan 2015 17:01:40 -0500
Message-ID: <20150122220140.GB6695@peff.net>
References: <CAO2U3Qi6Xf1RrbxyVW3cHNe1-ZwxFHDVskGLZguWS=b38pgaXQ@mail.gmail.com>
 <CAGZ79kaFWL5HWdctLzTWf6D4nTP19sPZbcOg9fiRx7RQrWjY7Q@mail.gmail.com>
 <b2cbad0d8e59a0c4eb0565608f3f90bc@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Michael Blume <blume.mike@gmail.com>, peter@lekensteyn.nl,
	eungjun.yi@navercorp.com, Git List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 22 23:01:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEPox-0005lM-E7
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 23:01:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbbAVWBo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 17:01:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:37566 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752855AbbAVWBm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 17:01:42 -0500
Received: (qmail 19612 invoked by uid 102); 22 Jan 2015 22:01:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jan 2015 16:01:42 -0600
Received: (qmail 14760 invoked by uid 107); 22 Jan 2015 22:02:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jan 2015 17:02:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jan 2015 17:01:40 -0500
Content-Disposition: inline
In-Reply-To: <b2cbad0d8e59a0c4eb0565608f3f90bc@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262875>

On Thu, Jan 22, 2015 at 10:20:01PM +0100, Johannes Schindelin wrote:

> On 2015-01-22 20:59, Stefan Beller wrote:
> > cc Johannes Schindelin <Johannes.Schindelin@gmx.de> who is working in
> > the fsck at the moment
> >
> > On Thu, Jan 22, 2015 at 11:43 AM, Michael Blume <blume.mike@gmail.com> wrote:
> >
> >>     CC fsck.o
> >> fsck.c:110:38: warning: comparison of unsigned enum expression >= 0 is
> >> always true [-Wtautological-compare]
> >>         if (options->msg_severity && msg_id >= 0 && msg_id < FSCK_MSG_MAX)
> >>                                      ~~~~~~ ^  ~
> 
> According to A2.5.4 of The C Programming Language 2nd edition:
> 
>     Identifiers declared as enumerators (see Par.A.8.4) are constants of type int.
> 
> Therefore, the warning is incorrect: any assumption about enum fsck_msg_id to be unsigned is false.

I'm not sure that made it to ANSI. C99 says (setion 6.7.2.2, paragraph
4):

  Each enumerated type shall be compatible with char, a signed integer
  type, or an unsigned integer type. The choice of type is
  implementation-defined, but shall be capable of representing the
  values of all the members of the enumeration.

I don't have a copy of C89, but this isn't mentioned in the (very
cursory) list of changes found in C99. Anyway, that's academic.

I think we dealt with a similar situation before, in
3ce3ffb840a1dfa7fcbafa9309fab37478605d08.

-Peff
