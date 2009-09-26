From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: how optparse can go horribly wrong
Date: Sat, 26 Sep 2009 03:51:27 +0200
Message-ID: <20090926015127.GA12994@vidovic>
References: <20090925233226.GC14660@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 26 03:51:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrMRj-0002Jh-Or
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 03:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664AbZIZBv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 21:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbZIZBv2
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 21:51:28 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:46279 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931AbZIZBv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 21:51:28 -0400
Received: by ewy7 with SMTP id 7so3042890ewy.17
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 18:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=V3IRiKG2rK0pDZR4SHPyMEGOcQDTnWceuOJt1uU0Eu0=;
        b=RaWhYfqwX7CJt4h4HPxnKACphaFIlaSr1ISF3N+HG9hyJBvPlPOZAA/ubjxFHxjc4K
         q9YCoy9pxjnfKDHbPAZU2Xp9H0m/J4GtZjId7DmlO3PwtN9PcW8CedyGQ/vYiXLru/nN
         vl6UgXGheUcc3SjGrOXEdovKvjWqlKTyzoLNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=M4RJRXyAITywfs9A2TVYWizHEKrvBgVFbBjOoK/vUBaia0t3SzRsXAWGPJ8DOigy2q
         7YKLQcbZIXj7U5eQYSTmpGaeQmGuhqGKbk5sIrXumXMWA/Jqh4v8f9KQTbiWFx3vdq9D
         nveZCW/gINald5FLUiBhu19JkF63cvUDQjtY8=
Received: by 10.210.9.17 with SMTP id 17mr955001ebi.23.1253929890966;
        Fri, 25 Sep 2009 18:51:30 -0700 (PDT)
Received: from @ (91-164-146-118.rev.libertysurf.net [91.164.146.118])
        by mx.google.com with ESMTPS id 7sm141415eyg.8.2009.09.25.18.51.29
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 25 Sep 2009 18:51:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090925233226.GC14660@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129140>

The 25/09/09, Shawn O. Pearce wrote:
> *sigh*.  Someone just ran into this today:
> 
>   $ git commit -a -ammend
>   [work ce38944] mend
>    1 files changed, 2 insertions(+), 0 deletions(-)
> 
> Omit one - and include an extra 'm', and instead of --amend you
> have -a -m mend.  Which isn't exactly what you wanted.
> 
> We do catch -amend with an error though:
> 
>   $ git commit -amend
>   error: did you mean `--amend` (with two dashes ?)

OTOH, this is a bit odd because a commit with the message "end" makes
perfect sense for a "fast and crappy commit local workflow".

And we allow -ammend (with two 'm')

  $ git commit -ammend
  [next 101f014] mend
   1 files changed, 1 insertions(+), 0 deletions(-)
  $

> I wonder, should the -m flag on commit not allow cuddling its
> value against the switch when its combined in short form with
> other switches?

Doing this only to -m flag would break consistency. That said, I don't
have any opinion in disallowing the sticked form for _all_ short
options.

-- 
Nicolas Sebrecht
