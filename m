From: Jeff King <peff@peff.net>
Subject: Re: git latest master: a6828f536119c3288b0be772e3870f1a464d017d --
	error in t0050-filesystem.sh on Solaris
Date: Wed, 12 Mar 2008 10:53:33 -0400
Message-ID: <20080312145333.GA11236@coredump.intra.peff.net>
References: <8ec76080803120649h587b1933x6ec513d4b51a29a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 15:54:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZSLO-0003gl-Gf
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 15:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbYCLOxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 10:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbYCLOxg
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 10:53:36 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3578 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585AbYCLOxf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 10:53:35 -0400
Received: (qmail 7131 invoked by uid 111); 12 Mar 2008 14:53:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Mar 2008 10:53:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2008 10:53:33 -0400
Content-Disposition: inline
In-Reply-To: <8ec76080803120649h587b1933x6ec513d4b51a29a9@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76953>

On Wed, Mar 12, 2008 at 09:49:25AM -0400, Whit Armstrong wrote:

> xs5-trd-p1.grn:warmstro> uname -a
> SunOS xs5-trd-p1.grn.tudor.com 5.9 Generic_118558-38 sun4u sparc
> SUNW,Sun-Fire-V240 Solaris
> 
> the Unrecognized switch: -O is from the perl call:
> 
> ++ perl -CO -e 'print pack("U",0x00E4)'
> Unrecognized switch: -O  (-h will show valid options).
> + auml=
> ++ perl -CO -e 'print pack("U",0x0061).pack("U",0x0308)'
> Unrecognized switch: -O  (-h will show valid options).
> + aumlcdiar=

Yes, perl 5.005 doesn't understand -CO. You can replace that with
"binmode STDOUT, ':utf8'", but then you will find that it also doesn't
understand "U" as a pack specifier. :)

While the perl code nicely shows what is going on, perhaps it would be
simpler to just do something like:

  auml=`printf '\xc3\xa4'`

(which is the output that the perl gives on my Linux system).

-Peff
