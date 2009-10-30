From: Jeff King <peff@peff.net>
Subject: Re: Bug#553296: gitignore broken completely
Date: Fri, 30 Oct 2009 16:05:00 -0400
Message-ID: <20091030200500.GA24831@coredump.intra.peff.net>
References: <7vaaz8lleg.fsf@alter.siamese.dyndns.org>
 <20091030194333.GA4551@coredump.intra.peff.net>
 <20091029233458.GA32764@ikki.ethgen.de>
 <20091030162857.26604.qmail@67b7e3b41a17c8.315fe32.mid.smarden.org>
 <20091030165903.GA10671@ikki.ethgen.de>
 <20091030173838.GB18583@coredump.intra.peff.net>
 <20091030182331.GC10671@ikki.ethgen.de>
 <20091030184155.GC19901@coredump.intra.peff.net>
 <20091030190552.GA3528@coredump.intra.peff.net>
 <20091030200148.GD10671@ikki.ethgen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: 553296@bugs.debian.org, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Klaus Ethgen <Klaus@Ethgen.de>
X-From: git-owner@vger.kernel.org Fri Oct 30 21:05:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3xip-0006b9-Mw
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 21:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbZJ3UFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 16:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbZJ3UFG
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 16:05:06 -0400
Received: from peff.net ([208.65.91.99]:58962 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932283AbZJ3UFG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 16:05:06 -0400
Received: (qmail 2924 invoked by uid 107); 30 Oct 2009 20:08:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 30 Oct 2009 16:08:48 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Oct 2009 16:05:00 -0400
Content-Disposition: inline
In-Reply-To: <20091030200148.GD10671@ikki.ethgen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131743>

On Fri, Oct 30, 2009 at 09:01:48PM +0100, Klaus Ethgen wrote:

> > +test_expect_success 'ls-files -i lists only tracked-but-ignored files' '
> > +	echo content >other-file &&
> > +	git add other-file &&
> > +	echo file >expect &&
> > +	git ls-files -i --exclude-standard >output &&
> > +	test_cmp expect output
> > +'
> > +
> >  test_done
> 
> Do that fit? shouldn't it be "test_cmp other-file output"? "git ls-files
> -i --exclude-standard" should show the files in the index that are also
> in the exclude list. And you only add other-file to the index. And
> shouldn't there be also a "echo other-file > .gitignore"?

No, because it is building on the previous tests. The point of the test
is:

  - we already have 'file' tracked and in gitignore (from previous
    tests in the series)
  - we add other-file to have some other file which is tracked but not
    in gitignore
  - we check the output of "ls-files -i" to make sure that "file" is
    there, but "other-file" is not

-Peff
