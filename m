From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] config: Cleanup config file handling.
Date: Sun, 15 Feb 2009 17:15:50 -0800
Message-ID: <7vljs7gp15.fsf@gitster.siamese.dyndns.org>
References: <1234688460-9248-1-git-send-email-felipe.contreras@gmail.com>
 <1234688460-9248-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 02:17:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYs74-0007d7-3N
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 02:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754619AbZBPBP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 20:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754560AbZBPBP5
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 20:15:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455AbZBPBP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 20:15:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7A0EC2B373;
	Sun, 15 Feb 2009 20:15:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id AC1092B372; Sun,
 15 Feb 2009 20:15:51 -0500 (EST)
In-Reply-To: <1234688460-9248-2-git-send-email-felipe.contreras@gmail.com>
 (Felipe Contreras's message of "Sun, 15 Feb 2009 11:00:54 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5C3232D8-FBC7-11DD-A603-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110106>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> As suggested by Johannes Schindelin.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>

Dscho won't be the only person who will read "git log" output.  What was
suggested, what convinced you it is a good idea, what goodness would this
patch add if I take it?

> -			if (git_config(show_all_config, NULL) < 0 &&
> -					file && errno)
> -				die("unable to read config file %s: %s", file,
> -				    strerror(errno));
> +			if (git_config(show_all_config, NULL) < 0)
> +				die("error processing config file(s)");
>  			return 0;

This is the only change with substance in this patch.  What difference
does it make?  Earlier we failed to say "die" with message in some
situations, and now we die when git_config() signals any error.

What are the situations in whoich the command misbehaved?  The commit log
message is where you are expected to explain that.
