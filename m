Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 7278 invoked by uid 107); 2 Nov 2012 17:37:03 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.84) with ESMTP; Fri, 02 Nov 2012 13:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763145Ab2KBRgL (ORCPT <rfc822;peff@peff.net>);
	Fri, 2 Nov 2012 13:36:11 -0400
Received: from plane.gmane.org ([80.91.229.3]:42142 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763032Ab2KBRgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 13:36:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TULAD-00081V-8i
	for git@vger.kernel.org; Fri, 02 Nov 2012 18:36:13 +0100
Received: from ip68-6-43-149.sb.sd.cox.net ([68.6.43.149])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 18:36:13 +0100
Received: from richard_hubbe11 by ip68-6-43-149.sb.sd.cox.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 18:36:13 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	rh <richard_hubbe11@lavabit.com>
Subject: Re: [PATCH] gitweb.perl: fix %highlight_ext
Date:	Fri, 2 Nov 2012 10:41:21 -0700
Message-ID: <20121102104121.4f81a160e4e6368dde3a8373@lavabit.com>
References: <20121029094207.deafafed22ea70fbc4fbd4bb@lavabit.com>
	<20121102145425.GC11170@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ip68-6-43-149.sb.sd.cox.net
User-Agent: dsodnetnin
X-Mailer: EZnn0.37p
X-Newsreader: EZnn0.37p
X-Gmane-NNTP-Posting-Host: EZnn0.37p
Original-Received: from slem by 1.1 with local
X-No-Archive: yes
Archive: no
X-Archive: expiry=11
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, 2 Nov 2012 10:54:25 -0400
Jeff King <peff@peff.net> wrote:

> On Mon, Oct 29, 2012 at 09:42:07AM -0700, rh wrote:
> 
> > I also consolidated exts where applicable.
> > i.e. c and h maps to c
> > 
> > 
> > -- 
> > 
> > diff --git a/a/gitweb.cgi b/b/gitweb.cgi
> > index 060db27..155b238 100755
> > --- a/a/gitweb.cgi
> > +++ b/b/gitweb.cgi
> > @@ -246,19 +246,19 @@ our %highlight_basename = (
> >         'Makefile' => 'make',
> >  );
> >  # match by extension
> > +
> >  our %highlight_ext = (
> >         # main extensions, defining name of syntax;
> >         # see files in /usr/share/highlight/langDefs/ directory
> > -       map { $_ => $_ }
> > -               qw(py c cpp rb java css php sh pl js tex bib xml
> > awk bat ini spec tcl sql make),
> > +       (map { $_ => $_ } qw(py rb java css js tex bib xml awk bat
> > ini spec tcl sql)),
> >         # alternate extensions, see /etc/highlight/filetypes.conf
> > -       'h' => 'c',
> > -       map { $_ => 'sh'  } qw(bash zsh ksh),
> > -       map { $_ => 'cpp' } qw(cxx c++ cc),
> > -       map { $_ => 'php' } qw(php3 php4 php5 phps),
> > -       map { $_ => 'pl'  } qw(perl pm), # perhaps also 'cgi'
> > -       map { $_ => 'make'} qw(mak mk),
> > -       map { $_ => 'xml' } qw(xhtml html htm),
> > +       (map { $_ => 'c'   } qw(c h)),
> > +       (map { $_ => 'sh'  } qw(sh bash zsh ksh)),
> > +       (map { $_ => 'cpp' } qw(cpp cxx c++ cc)),
> > +       (map { $_ => 'php' } qw(php php3 php4 php5 phps)),
> > +       (map { $_ => 'pl'  } qw(pl perl pm)), # perhaps also 'cgi'
> > +       (map { $_ => 'make'} qw(make mak mk)),
> > +       (map { $_ => 'xml' } qw(xml xhtml html htm)),
> 
> I think the patch itself looks OK, but:
> 
>   1. It isn't formatted to apply with git-am. Please use
>      git-format-patch.
> 
>   2. The commit message does not explain the reason for the change.
> 
>   3. It isn't signed-off.
> 
> The first two are things I can fix up (though it is inconvenient for
> me to do so), but the third is a show-stopper.  Please look through
> Documentation/SubmittingPatches, especially the bit about the
> Developer's Certificate of Origin, and re-send.
> 
> -Peff

Thanks for taking the time to explain the workflow. If I can figure all this
out I will try to do what's needed.  This is feeling like a strange cult
that I've bumped into!

-- 
"...she's got smarts and never farts and owns a chain of liquor stores."

