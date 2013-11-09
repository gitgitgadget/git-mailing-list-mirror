From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] Minor grammatical fixes in "git log" man page
Date: Fri, 8 Nov 2013 17:00:48 -0800
Message-ID: <20131109010048.GG10302@google.com>
References: <1383957130-2979-1-git-send-email-jstjohn@purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>
To: "Jason St. John" <jstjohn@purdue.edu>
X-From: git-owner@vger.kernel.org Sat Nov 09 02:01:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VewvI-0000PN-LV
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 02:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757907Ab3KIBAw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Nov 2013 20:00:52 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:61585 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756675Ab3KIBAv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Nov 2013 20:00:51 -0500
Received: by mail-pa0-f51.google.com with SMTP id ld10so2981815pab.10
        for <git@vger.kernel.org>; Fri, 08 Nov 2013 17:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=uYCwOCSlKv1MsECd/HUGGovNT2KkUgfT4dZmwO+1Zaw=;
        b=k05JmlaqTYZHPXUQQbzr+jXD0LNYBvOouOTN2OR4sGYKvErfixjvDWEW61w4NJ4X2T
         G78lZqEV4WfZqJe7WJlVeK21x2CxbLE1TG+c6rA33b931MCBsry0coWLECCXM+waUkzQ
         /LeHhS4jx45NXR7pShbu9QB/bIDW3fuTRZ7Ati12dsCi5MkM2hcSRiPVmuJqwf/Wop8k
         DDeI+rfKesMCRUHPA9wj/Gukv9f105ZV1CEn92L7ivAKvdAMxrkMdriom/QNVRfrR6bP
         XvYs7kp+0icrJBtXkpylNtYqxhUbXIqp8SmIHp1otPN1UrcbetP9blhl3DdxncRoM0gC
         ahBA==
X-Received: by 10.66.242.17 with SMTP id wm17mr18768661pac.102.1383958851106;
        Fri, 08 Nov 2013 17:00:51 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ed3sm14881313pbc.6.2013.11.08.17.00.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 08 Nov 2013 17:00:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1383957130-2979-1-git-send-email-jstjohn@purdue.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237480>

Hi,

Jason St. John wrote:

> git-log.txt: grammatical fixes under --log-size option

Thanks.

[...]
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -56,10 +56,10 @@ Note that this affects all diff-based output types, e.g. those
>  produced by --stat etc.
> 
>  --log-size::
> -	Before the log message print out its size in bytes. Intended
> +	Before the log message, print out its size in bytes. Intended
>  	mainly for porcelain tools consumption. If Git is unable to
> -	produce a valid value size is set to zero.
> -	Note that only message is considered, if also a diff is shown
> +	produce a valid value size, this is set to zero.
> +	Note that only message is considered. Also, if a diff is shown,
>  	its size is not included.

I have no idea what this option does, before or after the change.

The commit that introduced --log-size says the following in its
change description:

	$ git log --grep=--log-size
	commit 9fa3465d6be83c08ed24762c82eb33cb005729f3
	Author: Marco Costalba <mcostalba@gmail.com>
	Date:   Fri Jul 20 20:15:13 2007 +0200

	    Add --log-size to git log to print message size

	    With this option git-log prints log message size
	    just before the corresponding message.

	    Porcelain tools could use this to speedup parsing
	    of git-log output.

	    Note that size refers to log message only. If also
	    patch content is shown its size is not included.

Perhaps some of the above could make it into a clearer description?
E.g.,

	--log-size::
		Include a line "log size <number>" in the output for each
		commit, where <number> is the length of that commit's
		message in bytes.  Intended to speed up tools that
		read log messages from 'git log' output by allowing them
		to allocate space in advance.

The commit introducing --log-size also says:

	    In case it is not possible to know the size upfront
	    size value is set to zero.

Is this still true?  When is it not possible to know the size up
front?

The implementation of --log-size is

	if (opt->show_log_size) {
		printf("log size %i\n", (int)msgbuf.len);
		graph_show_oneline(opt->graph);
	}

What happens if the commit message is long enough to overflow a 32-bit
integer?  Is that impossible for other reasons?  If it is possible,
(not about this patch) should this be using a 64-bit integer to print
instead?

Thanks and hope that helps,
Jonathan
