From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/6] t1500: avoid setting environment variables outside
 of tests
Date: Tue, 10 May 2016 16:41:59 -0400
Message-ID: <20160510204159.GA19958@sigill.intra.peff.net>
References: <20160510052055.32924-1-sunshine@sunshineco.com>
 <20160510052055.32924-6-sunshine@sunshineco.com>
 <20160510183955.GA16211@sigill.intra.peff.net>
 <CAPig+cRR49iJOkaLfynkvch4zUHVkpcJwVah0rvaEOeR7aY2Nw@mail.gmail.com>
 <CAPig+cTtU9_3=2eu0boaPbXKXh2gngEe7byDpJuSFAR4rcbrMA@mail.gmail.com>
 <CAPig+cQ0jEt10p--K8jNrFBi21PkmFXuHpUPewuOWrpx+3Ma7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 10 22:42:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0ETo-0006Mo-Qp
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 22:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482AbcEJUmE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 16:42:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:37245 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751466AbcEJUmD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 16:42:03 -0400
Received: (qmail 27992 invoked by uid 102); 10 May 2016 20:42:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 May 2016 16:42:02 -0400
Received: (qmail 1202 invoked by uid 107); 10 May 2016 20:42:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 May 2016 16:42:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 May 2016 16:41:59 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cQ0jEt10p--K8jNrFBi21PkmFXuHpUPewuOWrpx+3Ma7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294188>

On Tue, May 10, 2016 at 03:59:42PM -0400, Eric Sunshine wrote:

> On Tue, May 10, 2016 at 3:48 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > Actually, I think we can have improved encapsulation and maintain
> > readability like this:
> >
> >     case "$1" in
> >     ...
> >     -g) env="$2"; shift;  shift ;;
> >     ...
> >     esac
> >
> >     ...
> >     test_expect_success "..." '
> >         if test -n "$env"
> >         do
> >             test_when_finished "unset GIT_DIR"
> >             GIT_DIR="$env"
> >             export GIT_DIR
> >         fi
> >         ...
> >     '
> 
> At this point, I'd also rename 'env' to 'gitdir' to be more meaningful.

Yeah, I like this even better. As much as I enjoy eval tricks, I think
this case is more readable with the condition written out.

-Peff
