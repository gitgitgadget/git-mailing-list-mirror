From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git interpret-trailers with multiple keys
Date: Mon, 11 Apr 2016 09:09:48 +0200
Message-ID: <vpqegac7hab.fsf@anie.imag.fr>
References: <20160406191054-mutt-send-email-mst@redhat.com>
	<vpqlh4qbrnt.fsf@anie.imag.fr>
	<20160406201509-mutt-send-email-mst@redhat.com>
	<xmqq1t6iy6p9.fsf@gitster.mtv.corp.google.com>
	<20160406212940-mutt-send-email-mst@redhat.com>
	<CAP8UFD0Pw+yhO1jZTAbMkZ5d-usu3rx5N0Se=PNL=N7DD-BPcA@mail.gmail.com>
	<20160410182750-mutt-send-email-mst@redhat.com>
	<CAP8UFD1hSg9RXLavzQgff-QioVU28_ZYhrfAvrhzNe8zXwwv5w@mail.gmail.com>
	<20160410203556-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 09:10:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apVzI-00078k-B3
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 09:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbcDKHKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 03:10:07 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60781 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515AbcDKHKG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 03:10:06 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u3B79mjW030522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 11 Apr 2016 09:09:48 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u3B79mET022500;
	Mon, 11 Apr 2016 09:09:48 +0200
In-Reply-To: <20160410203556-mutt-send-email-mst@redhat.com> (Michael S.
	Tsirkin's message of "Sun, 10 Apr 2016 20:43:01 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 11 Apr 2016 09:09:48 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u3B79mjW030522
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1460963390.8565@Bj3RtF6Jg1FHYJNJzKI1Uw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291205>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Sun, Apr 10, 2016 at 06:57:53PM +0200, Christian Couder wrote:
>> What I meant is that we could create new options called maybe
>> trailer.autocommands and trailer.<token>.autocommands that default to
>> 'true' and if 'false' the command would not be run automatically and
>> the corresponding trailer would not be added.
>
> I don't think it has to do with commands.
> For example, if we add "value" it should behave the same.
>
> So I think a better name is "ifnotlisted", with values "add"
> and "donothing".

Having a negation in the variable name feels wrong. When the token is
listed on the command-line and ifnotlisted=donothing, I have to apply a
double-negation to guess what would happen (=> "if listed then do
something").

I agree that having such variable would be a good thing. It would solve
your issue (i.e. "How to I configure a token for quick use from the
command-line without applying it unconditionally"), and allow full
backward compatibility.

I'd call the option "apply" or perhaps "run", with values 1/true/always
= default = current behavior, or "auto" = "apply when asked from the
command-line". I'm wondering whether other values could make sense (not
to implement it right now, but to keep the design open to further
extensions): perhaps apply=ifauthor could mean "apply this trailer to
patches I'm the author of" for example.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
