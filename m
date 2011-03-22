From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: cherry-pick applies some other changes than the specified one?
Date: Tue, 22 Mar 2011 00:27:43 -0500
Message-ID: <20110322052742.GA7637@elie>
References: <AANLkTikE5AqJyShN+GfFYe0kBS=ShGnKQcnwbarNZrjm@mail.gmail.com>
 <7vwrjssbfk.fsf@alter.siamese.dyndns.org>
 <4D877FAD.9000807@viscovery.net>
 <4D879516.3060204@gmail.com>
 <20110321195846.GA4277@elie>
 <4D87B00D.2010905@gmail.com>
 <7v62rcp6m6.fsf@alter.siamese.dyndns.org>
 <7vsjugnqig.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 06:27:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1u8L-00084w-NQ
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 06:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753884Ab1CVF1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 01:27:52 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63535 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692Ab1CVF1v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 01:27:51 -0400
Received: by iyb26 with SMTP id 26so7088639iyb.19
        for <git@vger.kernel.org>; Mon, 21 Mar 2011 22:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=zgxL75//Qtv5IWIr9ki+D7tNOe9HTKHvZo4/dLfRl5o=;
        b=L9cliwUpUnyiFyj3E0gl7RMs271AHGzvVbQeGFxOZfs043uu5Rp3sx1G4Gd7d34VyD
         /uWSDijfku4UsKbifcRUB/5GS39vRvFTE6LNvuw4PiNEayA1jOA/bDJAQXptSfZRAnxT
         oWS/Wnbxl8fEz0MLHphO6PLTDT6EMioSxa7bg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HP2kHq/U5z+zCB9nylshInfNeTaz9zIsCw9wcRFRsIa+/8EKI116I6xuJpoNmjlsxB
         tUhb2oC4OGs5Hg7pIoGTkqjz4x2pncuTq3LnI44E1Cus8X5UjHmvqPM39voXqb0yC3/e
         4qyI19CT3oiAo65EtdvAlsTj8OxUEvIfNyNV0=
Received: by 10.42.74.70 with SMTP id v6mr8357231icj.190.1300771670838;
        Mon, 21 Mar 2011 22:27:50 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id g4sm4409085ick.23.2011.03.21.22.27.48
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Mar 2011 22:27:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vsjugnqig.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169700>

Junio C Hamano wrote:

> This just leaves the details of what -c/--cc are about to the combined
> diff format section in diff-generate-patch.txt, which I updated in the
> separate patch.

Thanks; this looks pretty good.  A few nitpicks:

> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -24,6 +24,37 @@ ifndef::git-format-patch[]
>  --patch::
>  	Generate patch (see section on generating patches).
>  	{git-diff? This is the default.}
> +
> +-1 --base::
> +-2 --ours::
> +-3 --theirs::
> +-0::
> +	These make sense only when comparing the index and the working
> +	tree (i.e. `git diff-files` or `git diff <path>...`) and compares
> +	against the "base" version, "our branch" or "their
> +	branch" respectively.  With these options, diffs for
> +	merged entries are not shown.
> ++
> +The default is to diff against our branch (-2) and the
> +cleanly resolved paths.  The option -0 can be given to
> +omit diff output for unmerged entries and just show "Unmerged".

I am not sure what this comment about the default means.  Isn't the
default to use --cc?

> +
> +-c::
> +--cc::
> +	Produce "combined diff" (and "dense combined diff" showing how the
> +	result is different compared to more than one original.

Missing an article after "Produce" (produce a combined diff) and a
closing parenthesis after "dense combined diff", I think.

More importantly, it might be nice to say

	See the section "diff format for merges" of
	linkgit:git-diff[1] for details.
