From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-help: add -w|--web option to display html man page in a browser.
Date: Sat, 08 Dec 2007 00:28:44 -0800
Message-ID: <7vir39wpxf.fsf@gitster.siamese.dyndns.org>
References: <20071202060755.4d6d5ec8.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Theodore Tso <tytso@mit.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Eric Wong <normalperson@yhbt.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 09:29:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0v44-0002G4-6M
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 09:29:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756015AbXLHI3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 03:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755978AbXLHI3P
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 03:29:15 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:61051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753899AbXLHI3P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 03:29:15 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 01DCB431D;
	Sat,  8 Dec 2007 03:29:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 28930431C;
	Sat,  8 Dec 2007 03:28:52 -0500 (EST)
In-Reply-To: <20071202060755.4d6d5ec8.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sun, 2 Dec 2007 06:07:55 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67528>

Christian Couder <chriscool@tuxfamily.org> writes:

> diff --git a/help.c b/help.c
> index 0f1cb71..ecc8c66 100644
> --- a/help.c
> +++ b/help.c
> @@ -265,6 +265,12 @@ static void show_info_page(const char *git_cmd)
>  	execlp("info", "info", page, NULL);
>  }
>  
> +static void show_html_page(const char *git_cmd)
> +{
> +	const char *page = cmd_to_page(git_cmd);
> +	execlp("git-browse-help", "git-browse-help", page, NULL);
> +}
> +

This should be execl_git_cmd() to honor GIT_TRACE and to help transition
to bindir != gitexecdir layout, I think.
