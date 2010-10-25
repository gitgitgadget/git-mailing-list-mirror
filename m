From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH v2 0/3] Documentation: refactor config variable
 descriptions
Date: Mon, 25 Oct 2010 11:11:25 -0400
Message-ID: <20101025151125.GD28278@sigill.intra.peff.net>
References: <cover.1287690696.git.trast@student.ethz.ch>
 <20101022155307.GB5554@sigill.intra.peff.net>
 <201010251444.08780.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 25 17:10:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAOh7-0002In-Dd
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 17:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361Ab0JYPKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 11:10:36 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:49779 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171Ab0JYPKg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 11:10:36 -0400
Received: (qmail 20755 invoked by uid 111); 25 Oct 2010 15:10:35 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (74.7.61.109)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 25 Oct 2010 15:10:35 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Oct 2010 11:11:25 -0400
Content-Disposition: inline
In-Reply-To: <201010251444.08780.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159957>

On Mon, Oct 25, 2010 at 02:44:06PM +0200, Jakub Narebski wrote:

> 2. With checking for CONFIGURATION-like, we would miss the following
>    configuration variables:
> 
>      http.getanyfile:: (for git-http-backend, in 'SERVICES')
>      http.uploadpack:: (for git-http-backend, in 'SERVICES')
>      http.receivepack:: (for git-http-backend, in 'SERVICES')
> 
>    These are in git-http-backend manpage, in 'SERVICES' section, which 
>    probably should be named then 'CONFIGURING SERVICES'.

I would argue those should probably go in a CONFIGURATION section for
consistency with the rest of the manpages.

>    BTW, CONFIGURATION-like means:
> 
>     * Configuration
>     * CONFIGURATION
>    
>   but also
> 
>     * CONFIG FILE-ONLY OPTIONS
>     * CONFIGURATION FILE
>     * Configuration Mechanism
>     * CONFIG VARIABLES
>     * CONFIGURATION VARIABLES
>     * Configuring database backend

Again, I think for consistency for the reader, it may make sense to
switch them all to CONFIGURATION. I'd have to look at each page and see
how appropraite that is, though.

> >   2. You recursively follow includes via include::. This means that the
> >      make rule is not accurate. E.g., try:
> [...]
> We do that: see 'doc.dep' target in Documentation/Makefile.  We just
> need for this target to also add dependencies for config-vars.txt
> (perhaps separate mode for make-config-list.perl, or perhaps 
> build-docdep.perl should be config-vars-src.txt aware...).

Yeah, that would definitely work.

> Note however that make-config-list.perl only creates minimal documentation,
> just link(s) to appropriate mapage(s).  Include-ing merge-config.txt both
> in git-merge.txt and config-vars-src.txt means that we have merg config
> variables defined in git-config(1) manpage, which I think is nice to have.

I disagree. I think one of the benefits of this exercise is generating a
more concise list. That being said, I don't think there's any reason we
can't have a terse list in gitconfig(7) and a much larger one in
gitconfigfull(7) or something like that (or even put it later in the
manpage of gitconfig(7), or whatever).

If you're going to do that, though, there's no point in having
merge-options separate. make-config-list should just generate both
lists.

> >        format.pretty::
> >                The default pretty format for log/show/whatchanged command,
> >                See linkgit:git-log[1], linkgit:git-show[1],
> >                linkgit:git-whatchanged[1].
> [...]
> 
> Actually the above block describing `format.pretty` is from beginning in
> config-vars-src.txt, and is not added / created by said script.

Oh, you're right. I was browsing the output and just assumed it was
created by the script, since it is of a similar form.

> >      [1]: I assume the single line of block description is an error in
> >           your script.
> 
> Hmmm?

The comma at the end made it look to me like a sentence had been cut off
during parsing. But looking at config.txt, it is simply a typo.  The
comma should be a period.

-Peff
