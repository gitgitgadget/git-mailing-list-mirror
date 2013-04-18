From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 1/6] transport-helper: clarify *:* refspec
Date: Thu, 18 Apr 2013 10:45:31 +0100
Message-ID: <20130418094531.GU2278@serenity.lan>
References: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
 <1366258473-12841-2-git-send-email-felipe.contreras@gmail.com>
 <20130418082441.GR2278@serenity.lan>
 <CAMP44s0cJwHSJrWKkWAwKSv8OE=OqVRdKEtBNdAvQ7YAE5-JKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 11:45:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USlPe-0003QF-LY
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 11:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967162Ab3DRJpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 05:45:50 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:39080 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967049Ab3DRJpt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 05:45:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 0BB82866004;
	Thu, 18 Apr 2013 10:45:48 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y0nayJu5FrrS; Thu, 18 Apr 2013 10:45:46 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 8947ECDA596;
	Thu, 18 Apr 2013 10:45:45 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 7780C161E405;
	Thu, 18 Apr 2013 10:45:45 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VqYZEp5Z0raE; Thu, 18 Apr 2013 10:45:44 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id EE2AB161E413;
	Thu, 18 Apr 2013 10:45:33 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAMP44s0cJwHSJrWKkWAwKSv8OE=OqVRdKEtBNdAvQ7YAE5-JKw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221633>

On Thu, Apr 18, 2013 at 04:27:57AM -0500, Felipe Contreras wrote:
> On Thu, Apr 18, 2013 at 3:24 AM, John Keeping <john@keeping.me.uk> wrote:
> > On Wed, Apr 17, 2013 at 11:14:28PM -0500, Felipe Contreras wrote:
> >> diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
> >> index f506031..0c91aba 100644
> >> --- a/Documentation/gitremote-helpers.txt
> >> +++ b/Documentation/gitremote-helpers.txt
> >> @@ -174,8 +174,8 @@ ref.
> >>  This capability can be advertised multiple times.  The first
> >>  applicable refspec takes precedence.  The left-hand of refspecs
> >>  advertised with this capability must cover all refs reported by
> >> -the list command.  If a helper does not need a specific 'refspec'
> >> -capability then it should advertise `refspec *:*`.
> >> +the list command.  If no 'refspec' capability is advertised,
> >> +there is an implied `refspec *:*`.
> >
> > This is wrong.
> 
> It has been like that since v1.7.0.

That doesn't mean it's right.  I suspect that it was originally correct,
but then 'export' was added at which point this became stale.

> > As your later patch makes clearer, there is no implied
> > refspec for push - it only works for fetch.  I found the wording you've
> > reverted to extremely misleading.  How about something like this:
> >
> >     For historical reasons, 'import' treats the absence of a 'refspec'
> >     line as equivalent to `refspec *:*`; remote helpers should always
> >     specify an explicit refspec.
> 
> Maybe my version was "misleading" because it didn't mention it was for
> historical reasons, but yours is plain wrong; remote helpers might not
> be using 'import' or 'export' at all, so not all remote helpers should
> always specify an explicit refspec. And if the previous text "It is
> recommended that all importers providing the 'import' capability use
> this. It's mandatory for 'export'." does not convey the idea these
> remote helpers should always specify an explicit refspec, I don't know
> what it does.

I didn't say mine was correct, but there was a reason that I wanted to
change the existing text.  Just going back to what was there before is
not a good way to make things better.

In my copy of pu I don't see the text "It's mandatory for 'export'", it
just stops after "It is recommended that all importers providing the
'import' capability use this".  That paragraph also starts with "This
modifies the 'import' capability" making no mention of export.

Perhaps we need a slightly more extensive re-write of the documentation
for refspec to make it very clear where it applies and when it is
needed.
