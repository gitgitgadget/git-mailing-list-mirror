From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 7/9] revert: allow mixed pick and revert instructions
Date: Fri, 9 Dec 2011 14:26:45 -0600
Message-ID: <20111209202645.GJ20913@elie.hsd1.il.comcast.net>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
 <1323445326-24637-8-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 21:26:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ71y-00020B-JM
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 21:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753711Ab1LIU0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 15:26:50 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53271 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761Ab1LIU0t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 15:26:49 -0500
Received: by ggnr5 with SMTP id r5so3705677ggn.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 12:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=q6f+vvazJRVZjLDqERG+Si4VJOJbmNuTr58vzoHZvTE=;
        b=fjd417nl0RCIAo2QZa95h4LCH5M6eNfmuwlOsrVM8o74DWrT/iFshG+ShhbL+sc98f
         YDLz7Xt/hgFA2NfitVyzE0ao2IBpOqDdqkYwFA3gZTjwc0sFeaoJu640B5EHgoVImFh9
         FCwLo9RbbSDzOu7aThSzo5fbe64c8lD5y71UM=
Received: by 10.100.42.16 with SMTP id p16mr2208924anp.103.1323462409093;
        Fri, 09 Dec 2011 12:26:49 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id t3sm3678160anf.0.2011.12.09.12.26.47
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 12:26:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323445326-24637-8-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186688>

Ramkumar Ramachandra wrote:

> Parse the instruction sheet in '.git/sequencer/todo' as a list of
> (action, operand) pairs, instead of assuming that all instructions use
> the same action.  Now you can do:
>
>   pick fdc0b12 picked
>   revert 965fed4 anotherpick
>
> For cherry-pick and revert, this means that a 'git cherry-pick
> --continue' can continue an ongoing revert operation and viceversa.

Sounds like a good thing.

[...]
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -39,7 +39,7 @@ static const char * const cherry_pick_usage[] = {
>  	NULL
>  };
>  
> -enum replay_action { REVERT, CHERRY_PICK };
> +enum replay_action { REPLAY_REVERT, REPLAY_PICK };

What does this have to do with it?
