From: Christopher Tiwald <christiwald@gmail.com>
Subject: Re: [PATCH] push: Provide situational hints for non-fast-forward
 errors
Date: Wed, 14 Mar 2012 11:52:04 -0400
Message-ID: <20120314155204.GC3558@gmail.com>
References: <20120313232256.GA49626@democracyinaction.org>
 <vpqipi7zh3n.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, peff@peff.net, Matthieu.Moy@grenoble-inp.fr,
	zbyszek@in.waw.pl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 16:52:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7qV7-0005Ky-C0
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 16:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759352Ab2CNPwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 11:52:16 -0400
Received: from mail-fa0-f46.google.com ([209.85.161.46]:51247 "EHLO
	mail-fa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759089Ab2CNPwL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 11:52:11 -0400
Received: by faas1 with SMTP id s1so387421faa.19
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 08:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=DnhIG2b3HYSKFljifhSB0If83UcMwtqhPctgfnFrNCg=;
        b=USPCVc1zemKv6Olax/5qo5mkijSAF3WYm5tloT8dHksmql6YKSfd/p18kdXObQsdEG
         N5nxNkcwAKJfsT7l6dsSHiOEtmJCYxUsaAvKQpbfQJDcAa6lIB9XIz0K/DE/v0xUwyoD
         ZpKNkjl9rBLrrFFaO90AiwCJX2p0UfBy2p90hW1lsqf5+wxo1kfEGxoS9BJuomkDi7+k
         twJqONEJLUPhE/lNfnurxviv5Y0keNhDoU4XOvR5aSxqRecangjuLjM7oFo2VsmX2tDE
         U8L6dZvkFY5eUIW8FYTK1NxvrG2q7/DIMP+8XYkGJ/0/c6pJ3xwJ0La9OU7a56OuoOpG
         nm2A==
Received: by 10.224.183.65 with SMTP id cf1mr3510689qab.77.1331740330256;
        Wed, 14 Mar 2012 08:52:10 -0700 (PDT)
Received: from gmail.com ([216.55.38.246])
        by mx.google.com with ESMTPS id o8sm9474543qan.11.2012.03.14.08.52.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Mar 2012 08:52:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqipi7zh3n.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193122>

On Wed, Mar 14, 2012 at 10:06:52AM +0100, Matthieu Moy wrote:
> Depending on the outcome of the discussion in the thread about
> 'push.default', you may want to suggest 'current' instead of upstream:
> http://thread.gmane.org/gmane.comp.version-control.git/192547/focus=192694
> 
> Actually, if the user has 'push.default=matching', the least surprising
> move from this value is 'push.default=current', that will push a subset
> of what used to be pushed, and won't change the target branch.

My only concern about 'push.default=current' vs. 'upstream' is the
case where a developer might push to a central shared repository, but
has a local branch tracking a remote branch with a different name.
That might be too deep in the edge-case weeds, but it seems like for
'centralized' git users, 'upstream' covers more cases without any
distraction to their workflows.

> Your patch removes the _(...) around the string, which breaks the
> internationalization.
> ...
> > +	for (i = 0; i < ARRAY_SIZE(message_advice_pull_before_push); i++)
> > +		advise(message_advice_pull_before_push[i]);
> 
> I'm no expert in gettext, but I think the internationalization people
> will have a hard time dealing with a single message split accross an
> array.
> 
> Actually, I prefer the effect of a single advise() call (i.e. say
> "hint:" just once, not for each line), but this part is subjective.

The lack of support for internationalization is an oversight. I'll
correct it in v2.

> I'd give the full cut-and-paste ready command to set the variable, to
> help the user who doesn't know what "configuration variable" really
> means in the context of Git.

Makes a lot of sense. I remember struggling with setting config
variables when I was new to git. I'll make that change.

--
Christopher Tiwald
