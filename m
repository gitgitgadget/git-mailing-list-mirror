From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help: warn if specified 'man.viewer' is unsupported,
 instead of erroring out
Date: Wed, 12 Mar 2008 23:22:09 -0700
Message-ID: <7vzlt3ywha.fsf@gitster.siamese.dyndns.org>
References: <20080313071040.bbf5528b.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pascal Obry <pascal@obry.net>, Xavier Maillard <xma@gnu.org>,
	=?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEIs?=@a-sasl-fastnet.sasl.smtp.pobox.com,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Mar 13 07:23:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZgqF-000883-RJ
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 07:23:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbYCMGWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 02:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752175AbYCMGWY
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 02:22:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40520 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbYCMGWX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 02:22:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6980E1BB1;
	Thu, 13 Mar 2008 02:22:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A17861BAF; Thu, 13 Mar 2008 02:22:17 -0400 (EDT)
In-Reply-To: <20080313071040.bbf5528b.chriscool@tuxfamily.org> (Christian
 Couder's message of "Thu, 13 Mar 2008 07:10:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77039>

Christian Couder <chriscool@tuxfamily.org> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  help.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> 	This was suggested by Xavier Maillard.
>
> diff --git a/help.c b/help.c
> index 5da8c9c..ecaca77 100644
> --- a/help.c
> +++ b/help.c
> @@ -139,7 +139,7 @@ static int add_man_viewer(const char *value)
>  	else if (!strcasecmp(value, "konqueror"))
>  		do_add_man_viewer(exec_man_konqueror);
>  	else
> -		return error("'%s': unsupported man viewer.", value);
> +		warning("'%s': unsupported man viewer.", value);
>  
>  	return 0;
>  }

While I'd agree this is a good change, the author should justify it in the
commit log message.  I ask list regulars like you to set a good example
for others.

	When a document viewer that is unknown to the current version of
	git is specified in the .git/config file, instead of erroring out
	the process completely, just issue a warning.  It might be that
	the user usually is using a newer git that supports it (and the
	configuration is written for that version) but is temporarily
	using an older git that does not know the viewer.
