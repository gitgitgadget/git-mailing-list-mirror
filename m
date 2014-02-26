From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 1/3] wt-status: Make conflict hint message more consistent
 with other hints
Date: Wed, 26 Feb 2014 12:34:03 -0800
Message-ID: <20140226203403.GL7855@google.com>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
 <1393437985-31401-2-git-send-email-andrew.kw.w@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 26 21:34:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIlBF-0005wF-PZ
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 21:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570AbaBZUeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 15:34:09 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:45891 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbaBZUeH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 15:34:07 -0500
Received: by mail-pb0-f41.google.com with SMTP id jt11so1503600pbb.0
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 12:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ev+COPwsQB9Vwki7g4ROfVhpna3WWJGfZEkshv9wPJM=;
        b=gen/InYixJa6+MWqTb8IIrlhlRQgeS2dwpgF8jxsZUl8IFc4+OeVVT5jgQ0Aq2FQwo
         Al4dM0nxcy4HiiT1c2QtRj84Oczl3wcpZxhEufWIX8Wt2ngvrOhYFF6c51abOFdh0X7m
         djPQuwC9bxvGZL7kOsGMiOaMnsVFpUK3xgJWCJ+0wCXU5ds8UEHnYUbvjXvzkIRpBd4G
         WomlnCT65Us+24QoRanM87WnyIJbgOcrxv6lGgm9RcMvCJah/1Upbtbq1XybD3arrQ+e
         3ZNPDTg+nBl9N5627gpGyvDf39VAnalrRck60JWvdGOPuUGEe9T/KBPIqEW8DfQbLAXI
         HEuw==
X-Received: by 10.66.136.103 with SMTP id pz7mr11138119pab.140.1393446847248;
        Wed, 26 Feb 2014 12:34:07 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ug2sm14127092pac.21.2014.02.26.12.34.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 26 Feb 2014 12:34:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1393437985-31401-2-git-send-email-andrew.kw.w@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242762>

Hi,

Andrew Wong wrote:

> [Subject: wt-status: Make conflict hint message more consistent with other hints]

Thanks for working on this.

Could you include a little more detail?  What other hints is this
making the message more consistent with?

Ideally the commit message would include a quick sample interaction,
so the reviewer could see the user going "Wha?" and then look at the
patch to see how it resolves the confusion.

[...]
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -899,7 +899,7 @@ static void show_merge_in_progress(struct wt_status *s,
>  		status_printf_ln(s, color, _("You have unmerged paths."));
>  		if (s->hints)
>  			status_printf_ln(s, color,
> -				_("  (fix conflicts and run \"git commit\")"));
> +				_("  (fix conflicts, and use \"git commit\" to conclude the merge)"));

Quick thoughts:

 - The comma just moves the message closer to the right margin.  I think
   it makes the message less readable.

 - What else would "git commit" do other than concluding the merge?
   What confusion is this meant to prevent?

 - Would introducing a new "git merge --continue" command help?

   Advantages: (1) the name of the command makes it obvious what
   it does; (2) the command could check that there is actually
   a merge in progress, helping the user when the state is not
   what they think; (3) consistency with "git cherry-pick --abort" /
   "git cherry-pick --continue".

   Disadvantage: redundancy (but see (2) above).

Hope that helps,
Jonathan
