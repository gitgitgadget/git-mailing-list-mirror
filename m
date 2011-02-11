From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-blame.el: does not show one-line summary in echo area
Date: Thu, 10 Feb 2011 20:29:28 -0600
Message-ID: <20110211022928.GA24775@elie>
References: <87vdgm3e1k.fsf@osv.gnss.ru>
 <20110204014315.GB28525@elie>
 <87tygkm8h7.fsf@krank.kagedal.org>
 <201102041103.10770.jnareb@gmail.com>
 <87r5bom7g3.fsf@krank.kagedal.org>
 <87oc6sm1ef.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, Xavier Maillard <zedek@gnu.org>,
	Alexandre Julliard <julliard@winehq.org>,
	Martin Nordholts <enselic@gmail.com>,
	Kevin Ryde <user42@zip.com.au>, git@vger.kernel.org,
	Andreas Schwab <schwab@linux-m68k.org>,
	Sergei Organov <osv@javad.com>
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Fri Feb 11 03:29:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnilY-0006lc-Bu
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 03:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379Ab1BKC3m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Feb 2011 21:29:42 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:65346 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932349Ab1BKC3l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Feb 2011 21:29:41 -0500
Received: by ywo7 with SMTP id 7so881139ywo.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 18:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zKCbmXpN+IBw85zAl1kS4ztoGbljZnkt7+qs6w9c6q8=;
        b=cRXORybPTlfrr1Dmul/3VT5vzomKudGADHseUD8v4+mylq1h0rIZz7BXFTfSj2QtNM
         mVPzIenl6PketiG0+wEFGMfgNgpm9Nt2D/4Qf0L+H5ExSFXtshHIXMK2+CP7cpH8YLBZ
         pOePdiZTNn0BqYMrMOF+USwmm8KYQEKE/RKNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=IiqeT+D+T3KXyp902hKYiLlUBsTjHNeQRDsH04YZ35ehLa10t+mNe63cicLzWLPR6D
         gDPvr7POxgZZgX3pVLC2IjRa3cj04MlgyWvdE15oyVMrWstQ9U5euw8RT/eo3oZQAkSh
         VfUYUCQIJ9I1916Cj3xTuO9RBAqboPHLVAs+g=
Received: by 10.90.53.13 with SMTP id b13mr131322aga.131.1297391379992;
        Thu, 10 Feb 2011 18:29:39 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id w6sm298951anf.26.2011.02.10.18.29.36
        (version=SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 18:29:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87oc6sm1ef.fsf@krank.kagedal.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166534>

David K=C3=A5gedal wrote:

> I whipped up a patch anyway. This adds an echo area message shown aft=
er
> 0.5 seconds of idleness, using the git-blame-echo-format format strin=
g.
> Try it and see if makes sense. I can clean it up (and split it up)
> later.

Sorry for the slow response.

Some quick impressions:

 - The 0.5 second delay is noticeable but not terrible.

   The instantaneous response from the older point-entered based
   code was kind of nice --- too bad it has to go.

 - There is no obvious way to copy the (abbreviated or full) hash
   associated to the current line to the clipboard (for pasting in
   another terminal).

   People more familiar with emacs might want "git show" output in
   another buffer when the line is double-clicked or something. :)
   That would work for me, too (since I could copy the hash from
   there).

 - A nice brief oneline format is

	[%h] %a: %s

   which goes well with a git-blame-prefix-format of

	%t

 - The time format (%c) is rather verbose.  I think I prefer %D
   (so maybe this is a potential tweakable?).

 - email addresses are often longer than 20 characters.  Does
   format-spec provide a way to truncate to a certain length,
   so the prefixes can line up?

 - in general, I like it.  Thanks.

Jonathan
