From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] diff.c: associate a flag with each pattern and use
 it for compiling regex
Date: Wed, 17 Sep 2008 21:14:27 -0700
Message-ID: <7vod2m1464.fsf@gitster.siamese.dyndns.org>
References: <7v3ak06jzj.fsf@gitster.siamese.dyndns.org>
 <GZAEBf1BcP9-dznrIesxaE4Rb8bim6DpwDWCb9yWl99UVoQC9Dog0A@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Boyd Lynn Gerber <gerberb@zenez.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Sep 18 06:17:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgAxZ-0007dT-0G
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 06:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbYIREOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 00:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbYIREOj
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 00:14:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49813 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbYIREOi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 00:14:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A2BFC62C17;
	Thu, 18 Sep 2008 00:14:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 92EF262C10; Thu, 18 Sep 2008 00:14:29 -0400 (EDT)
In-Reply-To: <GZAEBf1BcP9-dznrIesxaE4Rb8bim6DpwDWCb9yWl99UVoQC9Dog0A@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Wed, 17 Sep 2008 19:10:02 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4EBADA48-8538-11DD-9E1D-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96157>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> This is in preparation for allowing extended regular expression patterns.
> ...
> @@ -100,10 +100,11 @@ static int parse_lldiff_command(const char *var, const char *ep, const char *val
>  static struct funcname_pattern {
>  	char *name;
>  	char *pattern;
> +	int cflags;

What does "C" stand for?
