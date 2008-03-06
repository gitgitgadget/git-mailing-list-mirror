From: Pekka Kaitaniemi <kaitanie@cc.helsinki.fi>
Subject: Re: [PATCH] gitk: Add horizontal scrollbar to the diff view
Date: Thu, 6 Mar 2008 13:53:47 +0200
Message-ID: <20080306115347.GA11808@localdomain>
References: <20080305225123.GA8485@localdomain> <7vy78wgyu1.fsf@gitster.siamese.dyndns.org> <18383.51154.695501.543720@cargo.ozlabs.ibm.com>
Reply-To: kaitanie@cc.helsinki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, kaitanie@cc.helsinki.fi,
	newsletter@dirk.my1.cc, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 12:55:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXEgW-0006uu-1R
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 12:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759336AbYCFLyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 06:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758446AbYCFLyN
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 06:54:13 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:47303 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758245AbYCFLyL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 06:54:11 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1221421nfb.21
        for <git@vger.kernel.org>; Thu, 06 Mar 2008 03:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:reply-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=H7Xj+JtKCkgclxG+pIUfs1uQVn9xQMoOHaGS9EQLSRo=;
        b=i7/O21m5fvxhon3Nd0UxVQNd8HgmNaHqVBF+I/Eol52wOAejU7anGMs7wBhmuxoVZhTlGBE9KeUjcx/+HzENHUmH2QkC8TwN4cQFMzjhFzZrrJO3SFpDaDxdqF9lVUZrEWk7RvRlAVrzAcKxzmrlrNu4zHEv3JU1xXaq5N6DnF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=t2Wed4l1paPz5oBeoLDEGlx0etbVSygOJwv9g/BnDGSg9qESyQPM8GMW5/1rNO86i3fxiWkKhqUlWcedQDJEF3VFYeJQpJzSFA3G+RnVHj49SOWxN4y1zJ2CKXDwkTsUQrxyvyETjt6FWBWx+GWmq7as1K9PE4PVSLWWuIO0zrQ=
Received: by 10.78.160.2 with SMTP id i2mr2251899hue.56.1204804444800;
        Thu, 06 Mar 2008 03:54:04 -0800 (PST)
Received: from shadow ( [128.214.182.195])
        by mx.google.com with ESMTPS id n10sm2984723mue.18.2008.03.06.03.54.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Mar 2008 03:54:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <18383.51154.695501.543720@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76383>

Hi,

On Thu, Mar 06, 2008 at 09:30:42PM +1100, Paul Mackerras wrote:
> Junio C Hamano writes:
> 
> > An obvious solution is to show the scrollbar on-demand (i.e. when the
> > lines are overlong), but I do not talk Tcl/Tk and do not know if you can
> > do that easily.
> 
> I don't know of any extremely easy way to do it; it's certainly
> possible, but I think I would have to calculate the length of each
> line as it is put in, so as to get the maximum, and then have a
> handler for when the pane is resized, and pack and unpack the
> scrollbar as necessary.

I have spent some time today looking for examples on Tk scrollbar
handling (I'm not really a Tcl/Tk guru) and I haven't found any really
easy ways either.

> I think it's reasonable to have the scroll bar there always.  I think
> that pane could look better using the grid geometry manager (instead
> of pack), but that can be a separate patch.

I have modified the patch a bit to make the horizontal scrollbar a bit
narrower so the impact on screen real estate should be smaller
now.

The grid layout manager would probably be a bit better than pack for
the left pane. At least most examples of "text and two scrollbars"
case seem to be using it. Maybe I can try to prepare a patch that
converts the diff pane from pack to grid layout.

An interesting side effect of Tk scrollbars is that by default the
"elevator" size changes depending on the _visible_ content. So the
horizontal scrollbar "elevator" changes as the user scrolls the view
up and down.

Pekka

