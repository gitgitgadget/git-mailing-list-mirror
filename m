From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v17 14/14] tag.c: implement '--merged' and '--no-merged'
 options
Date: Fri, 18 Sep 2015 09:42:08 +0100
Message-ID: <20150918084208.GJ17201@serenity.lan>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
 <1441902169-9891-3-git-send-email-Karthik.188@gmail.com>
 <20150917213619.GI17201@serenity.lan>
 <xmqq37ycitps.fsf@gitster.mtv.corp.google.com>
 <vpqoah0kxtb.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Sep 18 10:43:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcrG4-0003rx-Tv
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 10:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbbIRIma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 04:42:30 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:57510 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750740AbbIRIm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 04:42:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id D9526CDA5C6;
	Fri, 18 Sep 2015 09:42:25 +0100 (BST)
X-Quarantine-ID: <LFtO9hMupRuj>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id LFtO9hMupRuj; Fri, 18 Sep 2015 09:42:24 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id DFE1DCDA600;
	Fri, 18 Sep 2015 09:42:10 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <vpqoah0kxtb.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278184>

On Fri, Sep 18, 2015 at 09:10:08AM +0200, Matthieu Moy wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > John Keeping <john@keeping.me.uk> writes:
> >
> >>> +--[no-]merged [<commit>]::
> >>
> >> We prefer to write --[no-]* as:
> >>
> >> 	--option::
> >> 	--no-option::
> >>
> >> although this may be the first instance that we see this combination
> >> with an argument.
> >>
> >> I also found the "[<commit>]" syntax confusing and had to go and figure
> >> out what PARSE_OPT_LASTARG_DEFAULT does; I wonder if it's worth
> >> appending something like the following to the help for this option:
> >>
> >> 	The `commit` may be omitted if this is the final argument.
> >
> > "may be omitted" must be followed by a description of what happens
> > when omitted (i.e. "defaults to ...").
> 
> Then:
> 
> The `commit` may be omitted and defaults to HEAD if this is the final
> argument.

I find that slightly confusing, although that might just be me.  It's
slightly longer, but I would write:

	The `commit` may be omitted if this is the final argument, in
	which case it defaults to `HEAD`.

I also had a look at git-branch(1), which has similar `--merged` and
`--no-merged` options and says:

	Only list branches whose tips are reachable from the specified
	commit (HEAD if not specified).  Implies `--list`.

The two options are listed separately in that case.
