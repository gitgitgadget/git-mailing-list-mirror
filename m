From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [FIXED PATCH] Make rebase save ORIG_HEAD if changing current branch
Date: Mon, 07 Jul 2008 15:14:49 -0700 (PDT)
Message-ID: <m3tzf1e3ze.fsf@localhost.localdomain>
References: <1215379370-34265-1-git-send-email-benji@silverinsanity.com>
	<7v7iby9ucx.fsf@gitster.siamese.dyndns.org>
	<803A3528-2451-4C5D-A48D-5E0C37B8E90E@silverinsanity.com>
	<7vbq1a8ay3.fsf@gitster.siamese.dyndns.org>
	<7vod591hlp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 00:15:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFyzu-0002Z3-JV
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 00:15:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253AbYGGWOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 18:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755261AbYGGWOw
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 18:14:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:26200 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755115AbYGGWOw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 18:14:52 -0400
Received: by nf-out-0910.google.com with SMTP id d3so702058nfc.21
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 15:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=Sjtg0OQngDspj4EtzfSNdlu3AwhEOdVQb8VIPn0lSBM=;
        b=jOOwa+kGP+Jh5BN7190RccpSSijRABbd8LB3ezyfcPiSemviy/nXgLsjBvxNm1mcU8
         V8BlSPeEU3Q66ujsZsXpikFyD93CwXFTgKWwHXMFMcCb6rmXJSC86bgek7TCryCN2MCW
         ZFDn3iGqVFKEQQGmltoGp3ww74HRgcD+gpQBU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=hcHIyp9OaWvGrEjx3A+p5ScEa8KSw3tXaSKmbcQMr5a6YYIOYofLfWlRLgIQDcCJyS
         TJsaSgXZcZeDNTr2cAdFVj6SHa+huDJhQJhjfDOChjYxXReuw8fjZxzE/Pw1OtzpSklt
         lkl7MxQdrSr7zduRxNVvfnA8qdPq19zDzwqX8=
Received: by 10.210.121.8 with SMTP id t8mr3490167ebc.67.1215468890271;
        Mon, 07 Jul 2008 15:14:50 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.206.62])
        by mx.google.com with ESMTPS id c24sm7384256ika.4.2008.07.07.15.14.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jul 2008 15:14:49 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m67MEmHm008535;
	Tue, 8 Jul 2008 00:14:49 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m67MEjxQ008532;
	Tue, 8 Jul 2008 00:14:46 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vod591hlp.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87661>

Junio C Hamano <gitster@pobox.com> writes:

> -- >8 --
> Documentation: update sections on naming revisions and revision ranges
[...]
> While at it, reword the explanation on r1..r2 notation to reduce
> confusion.


> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index 378a312..7184274 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt

> @@ -289,10 +299,10 @@ notation is used.  E.g. "`{caret}r1 r2`" means commits reachable
>  from `r2` but exclude the ones reachable from `r1`.
>  
>  This set operation appears so often that there is a shorthand
> -for it.  "`r1..r2`" is equivalent to "`{caret}r1 r2`".  It is
> -the difference of two sets (subtract the set of commits
> -reachable from `r1` from the set of commits reachable from
> -`r2`).
> +for it.  When you have two commits `r1` and `r2` (named according
> +to the syntax explained in SPECIFYING REVISIONS above), you can ask
> +for commits that are reachable from r2 but not from r1 by
> +"`{caret}r1 r2`" and it can be written as "`r1..r2`".

I'm not sure if the last part is improvement, and it wouldn't be better
to say rather than r1..r2 / ^r1 r2 are "commits that are reachable from
r2, excluding those commits which are reachable from r1" (which translates
into set difference / subtracting set of commits.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
