From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] status: display the SHA1 of the commit being currently
 processed
Date: Mon, 17 Jun 2013 14:10:31 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1306171357440.7683@perkele.intern.softwolves.pp.se>
References: <1371471004-9069-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Mon Jun 17 15:17:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoZJ5-0001pm-VV
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 15:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756280Ab3FQNRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 09:17:11 -0400
Received: from mx.getmail.no ([84.210.184.7]:34012 "EHLO lamora.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756150Ab3FQNRK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 09:17:10 -0400
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Jun 2013 09:17:10 EDT
Received: from localhost (localhost [127.0.0.1])
	by lamora.getmail.no (Postfix) with ESMTP id 2C49370857;
	Mon, 17 Jun 2013 15:10:35 +0200 (CEST)
X-Spam-Flag: NO
X-Spam-Score: -2.87
X-Spam-Level: 
X-Spam-Status: No, score=-2.87 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, T_FAKE_REPLY_SURE_A=0.01,
	T_FAKE_REPLY_SURE_B=0.01, T_KHOP_THREADED=-0.01,
	T_LONG_HEADER_LINE_80=0.01, T_UNKNOWN_ORIGIN=0.01] autolearn=ham
Received: from lamora.getmail.no ([127.0.0.1])
	by localhost (lamora.get.c.bitbit.net [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id vpdQlN-vrnVg; Mon, 17 Jun 2013 15:10:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lamora.getmail.no (Postfix) with ESMTP id C907779AD1;
	Mon, 17 Jun 2013 15:10:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
Received: from lamora.getmail.no ([127.0.0.1])
	by localhost (lamora.get.c.bitbit.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id UhKEPwCWJvVB; Mon, 17 Jun 2013 15:10:33 +0200 (CEST)
Received: from perkele (cm-84.215.89.29.getinternet.no [84.215.89.29])
	by lamora.getmail.no (Postfix) with ESMTP id 96AF9706F1;
	Mon, 17 Jun 2013 15:10:33 +0200 (CEST)
Received: by perkele (Postfix, from userid 501)
	id E42322FCF3; Mon, 17 Jun 2013 15:10:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by perkele (Postfix) with ESMTP id D1A972FCF2;
	Mon, 17 Jun 2013 14:10:31 +0100 (CET)
In-Reply-To: <1371471004-9069-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228064>

Mathieu Lienard--Mayor:

> +	/*
> +	 * If the file stopped-sha does not exist
> +	 * we go back to the old output saying "a commit"
> +	 * instead of providing the commit's SHA1.
> +	 */
> +	if (!stopped_sha) {
> +		stopped_sha = "a commit";
> +		must_free_stopped_sha = 0;
> +	}

This is missing gettext markers, and besides that, it very difficult 
to handle for translators. Please consider changing the code to use 
different strings based on what you want to insert, i.e.:

> 		if (state->branch)
> 			status_printf_ln(s, color,
> -					 _("You are currently splitting a commit while rebasing branch '%s' on '%s'."),
> +					 ("Splitting %s while rebasing branch '%s' on '%s'."),

    stopped_sha ? _("Splitting %s while rebasing branch '%s' on '%s'.")
                : _("Splitting a commit while rebasing branch '%2$s' on '%3$s'.")

or something similar.

-- 
\\// Peter - http://www.softwolves.pp.se/
