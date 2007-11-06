From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Mon, 5 Nov 2007 23:05:12 -0600
Message-ID: <20071106050512.GA6768@mediacenter.austin.rr.com>
References: <1194202941253-git-send-email-shawn.bohrer@gmail.com> <11942029442710-git-send-email-shawn.bohrer@gmail.com> <11942029474058-git-send-email-shawn.bohrer@gmail.com> <7vejf4pf7r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 06:05:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpGdI-00007j-Vs
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 06:05:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464AbXKFFE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 00:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752507AbXKFFE5
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 00:04:57 -0500
Received: from an-out-0708.google.com ([209.85.132.249]:27338 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbXKFFE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 00:04:56 -0500
Received: by an-out-0708.google.com with SMTP id b36so232374ana
        for <git@vger.kernel.org>; Mon, 05 Nov 2007 21:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=2ZnG2cJSGc606ultpyzsimZja1cDIfucFssFhvjbvV8=;
        b=i4ez+cKpHwCl4eVc+w5xjaQzAgte6ghrRNvtL40rZ4xhurbXPg626mvHGIPTjnOx3uAOXgPn7hwdYaFOBuonzsbOL5lA6qClqQkRIEDDtdr1K8Uo5Cxp43S34Sm4/Em0StmwxJtyMCjlmpAGT0Tq4FMw5DlQLcwDZr1K0SejvAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=T4GMj4EqjotezXox0Xx5obSkCl5FXs9a4Z3L1bOC3URCbpdgmZAERlksy64iXItKtFe5AhfNrMtOYgH6SuSsvrQWTSTPi/XyE8Eq9hg32iSR/RkqKGa/6LFlX+D1hXuiMGgC2gXpPHIUxEDEs/3yKeN1xe2UKZMUcjvo4gAFbew=
Received: by 10.100.227.20 with SMTP id z20mr7666048ang.1194325495657;
        Mon, 05 Nov 2007 21:04:55 -0800 (PST)
Received: from mediacenter.austin.rr.com ( [70.112.149.232])
        by mx.google.com with ESMTPS id m29sm236729wrm.2007.11.05.21.04.54
        (version=SSLv3 cipher=OTHER);
        Mon, 05 Nov 2007 21:04:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vejf4pf7r.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63626>

On Mon, Nov 05, 2007 at 01:14:32PM -0800, Junio C Hamano wrote:
> Shawn Bohrer <shawn.bohrer@gmail.com> writes:
> [...]
> > +static int disabled = 1;
> 
> This means we are committed to make clean.requireForce default
> to true, which is fine by me.  I need to warn the users about
> this early.

Actually I don't care either way, but in my last rebase on next this
change was already made to git-clean.sh so I adjusted accordingly.

> > +static int show_only = 0;
> > +static int remove_directories = 0;
> > +static int quiet = 0;
> > +static int ignored = 0;
> > +static int ignored_only = 0;
> 
> Please do not explicitly initialize static variables to zero.

I realize that static variables will be automatically initialized to
zero so this is unnecessary, but is there some technical reason not to
initialize explicitly?  If the answer is simply a style preference that
is fine, I'm just here to learn.

Of course as already pointed out these don't actually need to be static
in the first place so I'll simply move them into cmd_clean().  This does
lead me to another question though.  Now that Dscho has converted my
patch to use parse-options, what is the best way to update my patch
while still giving credit to Dscho?
