From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [RFC] checkout to notice forks (Re: Minor annoyance with git push)
Date: Wed, 20 Feb 2008 17:01:15 +0100
Message-ID: <8aa486160802200801p28b74755xd1242a74c0e417a8@mail.gmail.com>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
	 <20080209030046.GA10470@coredump.intra.peff.net>
	 <7vtzkihkx5.fsf@gitster.siamese.dyndns.org>
	 <46a038f90802090350rc4780d1ted60c03b9abf1fc0@mail.gmail.com>
	 <7vwspd5z1d.fsf@gitster.siamese.dyndns.org>
	 <7vfxvs75kp.fsf_-_@gitster.siamese.dyndns.org>
	 <20080217122815.GA26031@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Martin Langhoff" <martin.langhoff@gmail.com>,
	"Steffen Prohaska" <prohaska@zib.de>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Johannes Schindelin" <johannes.schindelin@gmx.de>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 20 17:02:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRrOO-0000zs-8L
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 17:01:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123AbYBTQBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 11:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753957AbYBTQBU
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 11:01:20 -0500
Received: from ti-out-0910.google.com ([209.85.142.191]:41326 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbYBTQBT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 11:01:19 -0500
Received: by ti-out-0910.google.com with SMTP id 28so1146436tif.23
        for <git@vger.kernel.org>; Wed, 20 Feb 2008 08:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ljqLQIxJolnVcGrJo3gP/PGcEerVSV5uo33toWF5nbg=;
        b=EcrCN1dM/e1x9e2+lPp5MAoctrbwrsdpztXGHMg2Hn6jf3xhMF1grRzv5MAOOLgfU4SoHBfAlyin5UZkB78MNP6UD57L6A8eMGTogeTZZwzXuihr8O9gaEJOCObAn+krXtHxaSxsvc7AYXjQfXLvfiy3sXmWuh5ha06G9pN+s1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K4s5DD304h6H1zNM64wmZih1R9fndJtrjVFDDwrXN9Yz2IeEaIWZNaLpUU+O5qjyJ5d2RT81D9zCVblrIIBoaZnNp/e65DkxNhQjWyuIgFfC6xoRASqnIzcE1vvDv6EixuBkk6HUBLbsy527FiVawdfxvbmavl33lsyZMNEsfvU=
Received: by 10.150.189.9 with SMTP id m9mr2787198ybf.142.1203523275586;
        Wed, 20 Feb 2008 08:01:15 -0800 (PST)
Received: by 10.150.205.9 with HTTP; Wed, 20 Feb 2008 08:01:15 -0800 (PST)
In-Reply-To: <20080217122815.GA26031@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74522>

On Sun, Feb 17, 2008 at 1:28 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Feb 16, 2008 at 05:08:22PM -0800, Junio C Hamano wrote:
>
>  > and you say "git checkout next", then after we switch the branch
>  > we check the upstream (in this case, refs/remotes/linus/next)
>  > and our branch, and:
>  >
>  >     (1) if they match, nothing happens;
>  >
>  >     (2) if you are ahead (i.e. the upstream is a strict ancestor
>  >         of you), one line message tells you so;
>  >
>  >     (3) otherwise, you are either behind or you and the upstream
>  >         have forked.  One line message will tell you which and
>  >         then you will see a "log --pretty=oneline --left-right".
>
>  Overall I think this is a sensible idea. For (3), it probably makes
>  sense to limit the output in some cases. If I checkout a topic branch
>  that I haven't looked at in a few days or even weeks, I am going to get
>  spammed with hundreds of commits.
>
>  Most of the time what I really want to know is "I am not up to date and
>  should merge or rebase." Automatically showing _which_ commits diverge
>  is a convenience that makes sense if there are a handful of them. For
>  larger cases, the user can easily run "git log upstream...branch".

I prefer to always have a summary as:

The tracking branch is ahead:
 $branchsha1..$upstreamsha1 (<n> commits)

and

Branch and tracking branch have diverged:
 $branchsha1...$upstreamsha1 (<n>|<m> commits)

or something like that.

Additionally, the text send to stderr (Switched to... Your branch can
be fast...) is hidden when the pager run.

Santi
