From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] gitweb.cgi: Customization
Date: Wed, 2 Aug 2006 19:13:11 +0200
Message-ID: <E1G8KHP-0004j5-4P@moooo.ath.cx>
References: <20060801225352.26998.qmail@web31801.mail.mud.yahoo.com> <7v8xm8xbaa.fsf@assigned-by-dhcp.cox.net> <1154535801.19994.15.camel@cashmere.sps.mot.com> <20060802165333.GA22726@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 02 19:13:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8KHV-0004qt-Uy
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 19:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWHBRNO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Aug 2006 13:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWHBRNO
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Aug 2006 13:13:14 -0400
Received: from moooo.ath.cx ([85.116.203.178]:4583 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751008AbWHBRNN (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Aug 2006 13:13:13 -0400
To: Jeff King <peff@peff.net>
Mail-Followup-To: Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060802165333.GA22726@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24658>

Jeff King <peff@peff.net> wrote:
> On Wed, Aug 02, 2006 at 11:23:22AM -0500, Jon Loeliger wrote:
> Why don't we have sensible compile-time defaults that can be overridden
> by a run-time config file like every other sane program? For those who
> are opposed to the run-time config, they can simply not have a config
> file.
> 
> See the (completely untested) patch below. Obviously the config file
> name has to be set at build time. However, since it is interpolated by
> perl, you can do clever things like:
>   /etc/gitweb/$ENV{MY_VIRTUAL_HOST}.pl
I like this (it is quite similar to my suggestions :)).

> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -66,6 +66,9 @@ # file to use for guessing MIME types be
>  # (relative to the current git repository)
>  our $mimetypes_file = undef;
>  
> +our $GITWEB_CONFIG = "@@GITWEB_CONFIG@@";
> +require $GITWEB_CONFIG if -e $GITWEB_CONFIG;
> +
>  # input validation and dispatch
>  our $action = $cgi->param('a');
>  if (defined $action) {
The only other thing to change is to move the mkdir($git_temp) and
qx($GIT --version) below this line.
