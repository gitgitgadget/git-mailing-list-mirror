From: Michael Adam <obnox@samba.org>
Subject: Re: [PATCH] contrib/hooks/post-receive-email: send individual mails to recipients
Date: Wed, 12 Nov 2008 23:21:23 +0100
Organization: SerNet GmbH, Goettingen, Germany
Message-ID: <E1L0O5U-00CBIw-3Y@intern.SerNet.DE>
References: <E1L0ITB-00Bv9t-72@intern.SerNet.DE> <7vfxlwq1gn.fsf@gitster.siamese.dyndns.org> <E1L0Jyh-00Bzdi-7r@intern.SerNet.DE> <7v3ahwq043.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 23:22:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0O6n-00018I-5c
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 23:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755374AbYKLWVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 17:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755360AbYKLWVd
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 17:21:33 -0500
Received: from mail.SerNet.de ([193.175.80.2]:40542 "EHLO mail.SerNet.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486AbYKLWVc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 17:21:32 -0500
Received: from intern.SerNet.DE by mail.SerNet.DE
	with esmtp (Exim 4.63 #1)
	id 1L0O5U-0003PY-FA; Wed, 12 Nov 2008 23:21:24 +0100
Received: by intern.SerNet.DE
	id 1L0O5U-00CBIw-3Y; Wed, 12 Nov 2008 23:21:24 +0100
Received: from intern.SerNet.DE (localhost [127.0.0.1])
	by localhost (AvMailGate-2.1.4-7) id 2903386-YKl6pM;
	Wed, 12 Nov 2008 23:21:24 +0100 (CET)
Received: by intern.SerNet.DE
	id 1L0O5T-00CBIj-SY; Wed, 12 Nov 2008 23:21:23 +0100
Content-Disposition: inline
In-Reply-To: <7v3ahwq043.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100821>

Junio C Hamano wrote:
> Michael Adam <obnox@samba.org> writes:
> 
> > Junio C Hamano wrote:
> >> Michael Adam <obnox@samba.org> writes:
> >> 
> >> > This changes the behaviour of post-receive-email when a list of recipients
> >> > (separated by commas) is specified as hooks.mailinglist. With this modification,
> >> > an individual mail is sent out for each recipient entry in the list, instead
> >> > of sending a single mail with all the recipients in the "To: " field.
> >> 
> >> Why can that be an improvement?
> >
> > My use case is that I have a repository where I want to send
> > commit messages to an "official" mailing list and to a private
> > recipient list that might not want to be seen on the official
> > mailing list.
> 
> Ah.  What you want is a capability to add Bcc:, not a misfeature to run
> the log formatter repeatedly wasting cycles only to generate the same
> message contents.

The intent was to send out the mail not to a (large) list of
individual recipients but to some (few) mailing lists separately.
A Bcc would be a partial solution. I also thought about that, but
I did not like it since it might make those recipients in the bcc
field feel strange because they seem to be getting mail from a
list they might not be subscribed to. Group-replying to such
mails may also cause confusion...

Of course my patch could be optimized for not wasting cycles by
only running generate_email_header() multiple times and caching
the results of the log formatter and generate_email_footer().

But I understand that my problem is a very specific one and that
generally no benefit but only disadvantage is seen in the
modification I suggested.  --  Sorry for the noise. :-)

Cheers - Michael
