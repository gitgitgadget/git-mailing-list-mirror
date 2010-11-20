From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] git-send-email.perl: Deduplicate "to:" and "cc:"
 entries with names
Date: Sat, 20 Nov 2010 13:01:17 -0800
Message-ID: <1290286877.31117.15.camel@Joe-Laptop>
References: <1290272809.27951.30.camel@Joe-Laptop>
	 <m2mxp3zr88.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Nov 20 22:01:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJuYo-0002eT-Os
	for gcvg-git-2@lo.gmane.org; Sat, 20 Nov 2010 22:01:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752849Ab0KTVBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 16:01:19 -0500
Received: from mail.perches.com ([173.55.12.10]:1598 "EHLO mail.perches.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752193Ab0KTVBS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 16:01:18 -0500
Received: from [192.168.1.156] (unknown [192.168.1.156])
	by mail.perches.com (Postfix) with ESMTP id 1EA1624368;
	Sat, 20 Nov 2010 13:01:17 -0800 (PST)
In-Reply-To: <m2mxp3zr88.fsf@igel.home>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161843>

On Sat, 2010-11-20 at 21:15 +0100, Andreas Schwab wrote:
> Joe Perches <joe@perches.com> writes:
> > diff --git a/git-send-email.perl b/git-send-email.perl
> > index f68ed5a..1ae5fbf 100755
> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -960,7 +960,7 @@ sub maildomain {
> >  sub send_message {
> >  	my @recipients = unique_email_list(@to);
> >  	@cc = (grep { my $cc = extract_valid_address($_);
> > -		      not grep { $cc eq $_ } @recipients
> > +		      not grep { $cc eq $_ || $_ =~ /<${cc}>$/ } @recipients
>                                                     /<\Q${cc}\E>$/

Why are \Q and \E useful here?
extract_valid_address provides an unadorned email address.
I've now tested with and without, both seem to work properly.
