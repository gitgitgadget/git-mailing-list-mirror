From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Minor grammar fix in the 'Not a git repository' message
Date: Mon, 16 Feb 2009 15:33:56 -0800
Message-ID: <7vd4diez2z.fsf@gitster.siamese.dyndns.org>
References: <cover.1234825069u.git.johannes.schindelin@gmx.de>
 <8787c5894e7831bbd1ace3b2fd6649f1362d4b78.1234825069u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Richard Hartmann <richih.mailinglist@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 17 00:35:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZCzv-0003Xk-Ba
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 00:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbZBPXeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 18:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbZBPXeH
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 18:34:07 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45127 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750727AbZBPXeG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 18:34:06 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9CD3F9805E;
	Mon, 16 Feb 2009 18:34:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DE2E598059; Mon,
 16 Feb 2009 18:33:58 -0500 (EST)
In-Reply-To: <8787c5894e7831bbd1ace3b2fd6649f1362d4b78.1234825069u.git.johannes.schindelin@gmx.de> (Johannes Schindelin's message of "Mon, 16 Feb 2009 23:58:10 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4BA75162-FC82-11DD-9928-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110264>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> It might cause less head-scratching to say 'nor any of the parent
> directories' than 'or ...' after saying that this is not a git
> repository.
> ...
> +			die("Not a git repository (nor any of the parent directories): %s", DEFAULT_GIT_DIR_ENVIRONMENT);
>  		}
>  		if (chdir(".."))
>  			die("Cannot change to %s/..: %s", cwd, strerror(errno));

The grammar may be more correct, but I wonder if the parenthesised part is
adding any value to the message or instead it is making the message more
confusing.

You will get this message when you are in /a/b/c/d and no .git
subdirectory was found in /a/b/c/d, nor in /a/b/c, nor in /a/b,...

But the message sounds as if the command expected ".git" to be either (1)
a git repository (which is false, because ".git" would mean /a/b/c/d/.git
and there is no git repository there), or (2) a parent directory (of
something unspecified, but a natural interpretation is "where you are"),
i.e. "I wanted you to be somewhere inside .git".  That obviously is not
what you wanted to say.

    "No git repository ".git" found here nor in any of the parent directories"

might be an improvement, though.
