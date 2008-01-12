From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] git-submodule: New subcommand 'summary' (3) - limit summary size
Date: Sat, 12 Jan 2008 00:36:36 -0800
Message-ID: <7vabnbv3sb.fsf@gitster.siamese.dyndns.org>
References: <1200123435-16722-1-git-send-email-pkufranky@gmail.com>
	<f67f45eeb9648bb7e5adaf53544443b79643914e.1200122041.git.pkufranky@gmail.com>
	<62a73e734832ad67e89be706f1f8b3dbc30cfcf4.1200122041.git.pkufranky@gmail.com>
	<bce0ee9fde688c27fc788fab91a571184918da67.1200122041.git.pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 09:37:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDbrd-0002nr-Q7
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 09:37:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758611AbYALIgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 03:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758499AbYALIgn
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 03:36:43 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225AbYALIgn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 03:36:43 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3189940E0;
	Sat, 12 Jan 2008 03:36:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AAB3E40DD;
	Sat, 12 Jan 2008 03:36:38 -0500 (EST)
In-Reply-To: <bce0ee9fde688c27fc788fab91a571184918da67.1200122041.git.pkufranky@gmail.com>
	(Ping Yin's message of "Sat, 12 Jan 2008 15:37:13 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70298>

Ping Yin <pkufranky@gmail.com> writes:

> @@ -265,6 +267,10 @@ set_name_rev () {
>  #
>  modules_summary()
>  {
> +	summary_limit=${summary_limit:-1000000}

Why a million?

> +	summary_limit=$((summary_limit<0?1000000:summary_limit))

This is doubly bashism.  Variables must be referenced with $,
and $(( conditional ? iftrue : iffalse )) is not POSIX.
