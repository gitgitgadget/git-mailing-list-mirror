From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] commit: allow --pretty= args to be abbreviated
Date: Mon, 15 May 2006 13:47:45 -0700
Message-ID: <7vac9jhv66.fsf@assigned-by-dhcp.cox.net>
References: <11476199622462-git-send-email-normalperson@yhbt.net>
	<1147619963765-git-send-email-normalperson@yhbt.net>
	<7vwtcoyxs2.fsf@assigned-by-dhcp.cox.net>
	<20060515003405.GA5533@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 22:47:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ffjys-0000AL-Ev
	for gcvg-git@gmane.org; Mon, 15 May 2006 22:47:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbWEOUrt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 16:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751644AbWEOUrt
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 16:47:49 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:7413 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751508AbWEOUrs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 16:47:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060515204747.RWAI9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 May 2006 16:47:47 -0400
To: Eric Wong <normalperson@yhbt.net>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20083>

Eric Wong <normalperson@yhbt.net> writes:

> Unlike the original one, this one only does prefix matches, so
> you can't do --pretty=er anymore :)

Sounds good.  But then you know how long the unique prefix
are for each candidate, so wouldn't this rather be redundant, I
wonder?

> +
> +	/* look for abbreviations */
> +	len = strlen(arg);
> +	found = -1;
> +	for (i = 0; i < ARRAY_SIZE(cmt_fmts); i++) {
> +		if (!strncmp(cmt_fmts[i].n, arg, len)) {
> +			if (found >= 0)
> +				die("invalid --pretty format: %s", arg);
> +			found = i;
> +		}
> +	}
> +	if (found >= 0)
> +		return cmt_fmts[found].v;
> +	die("invalid --pretty format: %s", arg);
>  }

It would probably be better to say "ambiguous" not "invalid" in
the die() message.
