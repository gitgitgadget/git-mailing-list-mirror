From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 2/2] send-email: introduce sendemail.smtpsslcertpath
Date: Sun, 7 Jul 2013 10:02:01 +0100
Message-ID: <20130707090200.GQ9161@serenity.lan>
References: <1373025947-26495-1-git-send-email-artagnon@gmail.com>
 <1373025947-26495-3-git-send-email-artagnon@gmail.com>
 <20130705124536.GU862789@vauxhall.crustytoothpaste.net>
 <7vobag7wl0.fsf@alter.siamese.dyndns.org>
 <20130705174730.GM9161@serenity.lan>
 <7vehbc7tcc.fsf@alter.siamese.dyndns.org>
 <20130705184333.GN9161@serenity.lan>
 <7v1u7c6w7z.fsf@alter.siamese.dyndns.org>
 <20130706114600.GP9161@serenity.lan>
 <7vppuv57ps.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 11:02:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvkrZ-0003ME-DL
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 11:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925Ab3GGJCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 05:02:15 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:33688 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788Ab3GGJCO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 05:02:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id E80246064FD;
	Sun,  7 Jul 2013 10:02:13 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IQwV0pgSHi3a; Sun,  7 Jul 2013 10:02:11 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 3D8296064C7;
	Sun,  7 Jul 2013 10:02:11 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 122CD161E472;
	Sun,  7 Jul 2013 10:02:11 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ifZpuxb1mRse; Sun,  7 Jul 2013 10:02:09 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 4CD33161E47E;
	Sun,  7 Jul 2013 10:02:02 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vppuv57ps.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229756>

On Sat, Jul 06, 2013 at 09:12:31PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > @@ -1096,19 +1101,18 @@ sub smtp_auth_maybe {
> >  # Helper to come up with SSL/TLS certification validation params
> >  # and warn when doing no verification
> >  sub ssl_verify_params {
> > -	use IO::Socket::SSL qw(SSL_VERIFY_PEER SSL_VERIFY_NONE);
> > -
> > -	if (!defined $smtp_ssl_cert_path) {
> > -		$smtp_ssl_cert_path = "/etc/ssl/certs";
> > +	if ($smtp_ssl_verify == 0) {
> > +		return (SSL_verify_mode => IO::Socket::SSL->SSL_VERIFY_NONE);
> 
> I do not see any "use IO::Socket::SSL" anywhere after applying this
> patch.  Is this expected to work?

I don't get any errors about unknown variables when running it.  Do we
get IO::Socket::SSL imported through Net::SMTP::SSL, which extends it?
