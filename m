From: Christopher Tiwald <christiwald@gmail.com>
Subject: Re: [PATCH] Give better 'pull' advice when pushing non-ff updates to
 current branch
Date: Tue, 24 Apr 2012 08:21:49 -0400
Message-ID: <20120424122149.GB41274@gmail.com>
References: <1335221121-36664-1-git-send-email-christiwald@gmail.com>
 <vpqipgpehlk.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 24 14:22:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMekq-0000Dn-Dc
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 14:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752995Ab2DXMVz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 08:21:55 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:62453 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985Ab2DXMVy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 08:21:54 -0400
Received: by qatm19 with SMTP id m19so2750261qat.19
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 05:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Z4JA8kNqIM2tdTidxvHQIGJlKZEQAm6LeXIlQs7ZvhI=;
        b=0jEpSl4Mn5rkhZjYTL5m7oGcZAoUgU4KAcwQV+R3Eg+r16L+EspnrWm9TxLYCIxU/o
         ZAjs3Z8mjvcH2vMsaMN6UAdVl0kmfBo+gUq/L2bS/zIK+yMqTWFxNDV6cm06G6VpTpSQ
         Em6FstGzgzYo/kEvO90k8kfZyn/y5RmW7RicC1BMUiYeUB9QIGBVfB1CqleII50wnIWZ
         9Ywa9WMnN9o07/Mcd0PoLsWBTmxFAyb//ZnfENzKD/drnrxMJXnRHLK4Vdv8W2Ph4it+
         h55OXnIz8TfYehp51n6d5vWVrHQe7yoI1U/6p18ND4NufYHbntwAC4/Tz5TPhp/62+gW
         ywpw==
Received: by 10.224.180.212 with SMTP id bv20mr5977863qab.4.1335270114018;
        Tue, 24 Apr 2012 05:21:54 -0700 (PDT)
Received: from gmail.com (cpe-74-66-248-47.nyc.res.rr.com. [74.66.248.47])
        by mx.google.com with ESMTPS id s20sm1044994qap.16.2012.04.24.05.21.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Apr 2012 05:21:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqipgpehlk.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196220>

On Tue, Apr 24, 2012 at 09:04:07AM +0200, Matthieu Moy wrote:
> > +		if (branch->remote_name &&
> > +		    branch->merge &&
> > +		    branch->merge_nr == 1 &&
> > +		    !strcmp(transport->remote->name, branch->remote_name) &&
> > +		    !strcmp(strbuf_detach(&buf, NULL),
> > +			    prettify_refname(branch->merge[0]->dst))) {
> > +			advise_tracked_pull_before_push();
> > +		}
> > +		else
> > +			advise_untracked_pull_before_push();
> 
> Isn't this doing the opposite of what the comment is saying about
> octopus merge, i.e. if branch->merge_nr > 1, call
> advise_untracked_pull_before_push() which will advise 'git pull <remote>
> <branch>'?

Ah yes. The logic is wrong for the octopus case. That's easy to fix, but
I'm considering ditching the matching entirely per my response to
Junio's concerns. I think it might do more harm then good.

--
Christopher Tiwald
