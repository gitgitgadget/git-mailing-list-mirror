From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH v4 2/2] interpret-trailers: add option for in-place
 editing
Date: Tue, 19 Jan 2016 09:28:28 +0100
Message-ID: <20160119082828.GE21205@distanz.ch>
References: <1452790676-11937-1-git-send-email-tklauser@distanz.ch>
 <1452790676-11937-3-git-send-email-tklauser@distanz.ch>
 <xmqqio2vki0i.fsf@gitster.mtv.corp.google.com>
 <CAPig+cRRdca7PfkqppY2X7KSFpHX0yH19fxRL+w_=u9vg7NV9A@mail.gmail.com>
 <CAPc5daWpnReWJzeTJjvZap78H0oZKG-YGEP19Neusyahu5A6cQ@mail.gmail.com>
 <CAPig+cQ5X7r22pXyCs_n+-mXK3Lzh1CpAMQ_PbuhLT4C3S+v1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 09:28:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLReY-0007vw-WC
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 09:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757309AbcASI2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 03:28:34 -0500
Received: from sym2.noone.org ([178.63.92.236]:33708 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786AbcASI2d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 03:28:33 -0500
Received: by sym2.noone.org (Postfix, from userid 1002)
	id 3pl36636rwzQWhG; Tue, 19 Jan 2016 09:28:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAPig+cQ5X7r22pXyCs_n+-mXK3Lzh1CpAMQ_PbuhLT4C3S+v1Q@mail.gmail.com>
X-Editor: Vi IMproved 7.3
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284351>

On 2016-01-18 at 23:13:22 +0100, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Jan 18, 2016 at 4:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > On Jan 18, 2016 13:11, "Eric Sunshine" <sunshine@sunshineco.com> wrote:
> >> On Thu, Jan 14, 2016 at 3:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >>> If for some reason interpret-trailers fails to fail, this would
> >>> leave an unreadable 'message' in the trash directory.  Maybe no
> >>> other tests that come after this one want to be able to read the
> >>> contents of the file right now, but this is an accident waiting to
> >>> happen:
> >>>
> >>>         cat basic_message >message &&
> >>> +       test_when_finished "chmod +r message" &&
> >>>         chmod -r message &&
> >>>         test_must_fail ... &&
> >>>         chmod +r message &&
> >>
> >> Don't forget to remove this (now unnecessary) "chmod +r" once you've
> >> added the 'test_when_finished "chmod +r"'.
> >>
> >>>         test_cmp ...
> >
> > It still is necessary for the test-cmp to work, no?
> 
> My bad. Ignore me.
> 
> By the way, isn't the:
> 
>     cat basic_message >message &&
> 
> in the above test just an unusual way to say:
> 
>     cp basic_message message &&
> 
> ?

Yes. I was following the other test cases which use cat to build more
complex messages.

I can change this as well along with the 'test_when_finished' fix.
