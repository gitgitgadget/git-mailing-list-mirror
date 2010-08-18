From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH re-roll] Do not display 'Switched to a new branch' when
 the branch existed
Date: Wed, 18 Aug 2010 04:16:03 -0500
Message-ID: <20100818091603.GA6263@burratino>
References: <AANLkTimaZF1Q6BPB7CN0Wa5-Ov2ejVfPsmL34vps2VqK@mail.gmail.com>
 <AANLkTi=3z9gJdT8LL3NANFyppUjvOVcrszjf5J5zAKPe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
To: Knittl <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 11:17:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlemJ-0005dB-Vj
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 11:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059Ab0HRJRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 05:17:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:61205 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040Ab0HRJRm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 05:17:42 -0400
Received: by iwn7 with SMTP id 7so457310iwn.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 02:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=tvLp0X5y5y7PLo7w9Kw9sgQXZC8x1lNdHYyPhL/Jnnw=;
        b=uJ3RawYahLtTZW+TLIvSKOHM24B9w93x0hJQrmydWhc7DK+wxNDsJlUhzjYbCnb1xD
         TfD8GSjm60foLIth0LaPe44+AUZW2XcWFaLTpA5CZe1UwL0x0QGnA3wjniRvHNurJCoL
         VdaLB+2UPesi4BrdePlMP95aYUHCvXbyPYeVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=U5Jw5iWOy0DTMT545u/uQdd/H4Rx6sss4xTbJbozEXvqxmtz2/TEZdj3AEKDBBTk4E
         ez9cpuofRZr0LGIjrk2hPoxqXfkxzmbn3OiIo6HYCUrIDuQGgM5c/kcgvP8yVxnc3rbN
         kjHgTowucLofVjCwS9XQwCFEJtc8YTabnGTRU=
Received: by 10.231.147.202 with SMTP id m10mr9304892ibv.2.1282123061615;
        Wed, 18 Aug 2010 02:17:41 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id e8sm50174ibb.14.2010.08.18.02.17.40
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 02:17:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=3z9gJdT8LL3NANFyppUjvOVcrszjf5J5zAKPe@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153821>

Hi,

Warning: nitpicks coming.

Knittl wrote:

> From 16f540c87f8c7b87692dfd488d507802ae975312 Mon Sep 17 00:00:00 2001
> From: Daniel Knittl-Frank <knittl89+git@googlemail.com>
> Date: Wed, 18 Aug 2010 10:35:42 +0200
> Subject: [PATCH] builtin/checkout: fix info message for `git checkout <branch>`

On the git list, there are two formats often used for patches (see
Documentation/SubmittingPatches for details): whole-message patches,
which look like this:

	git checkout should only display 'Switched to a new branch <branch>'
	when it creates a new branch, not when it simply switches branches.

	This fixes a bug introduced by 02ac9837 (builtin/checkout:
	learn -B, 2010-06-24).

	Signed-off-by: Daniel Knittl-Frank <knittl89+git@googlemail.com>
	---
	comments of the moment

	 diffstat
	...

and "inline" patches, which look like this:

	comments of the moment
	-- 8< --
	Subject: patch subject

	patch rationale
	---
	 diffstat
	...

and sometimes get used when it is more natural for discussion.

The "From " line and so on output by "git format-patch" are for your
mailer.  Clarifying From:, Date:, and Subject: lines at the start of
your message are allowed, though, and can be useful when forwarding
patches from someone else.

> +++ b/builtin/checkout.c
> @@ -536,7 +536,9 @@ static void update_refs_for_switch(struct
> checkout_opts *opts,
>  					new->name);
>  			else
>  				fprintf(stderr, "Switched to%s branch '%s'\n",
> -					opts->branch_exists ? " and reset" : " a new",
> +					opts->branch_exists
> +						? " and reset"
> +						: opts->new_branch ? " a new" : "",

Maybe it would be clearer to write

	opts->new_branch ? " a new"
		: opts->branch_exists ? " and reset"
		: "",

to emphasize that this is a list of condition/result pairs?

The functionality of your patch is obviously good.  Thanks.

Jonathan
