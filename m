From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: Libgit2 on the Summer of Code
Date: Thu, 27 May 2010 21:35:34 +0300
Message-ID: <20100527183534.GA10414@LK-Perkele-V2.elisa-laajakaista.fi>
References: <AANLkTil-M3kQGbRZIacItlwr37Lf3lso7FspftLr43_F@mail.gmail.com>
 <20100527174636.GB9909@LK-Perkele-V2.elisa-laajakaista.fi>
 <20100527180554.GM16470@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org,
	srabbelier@gmail.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 27 20:37:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHhxK-0000VX-1g
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 20:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759089Ab0E0ShP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 14:37:15 -0400
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:47932 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754928Ab0E0ShN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 14:37:13 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 5D766C804E;
	Thu, 27 May 2010 21:37:11 +0300 (EEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A069345A5DE; Thu, 27 May 2010 21:37:11 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 1C71F2BD50;
	Thu, 27 May 2010 21:37:07 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20100527180554.GM16470@spearce.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147893>

On Thu, May 27, 2010 at 11:05:54AM -0700, Shawn O. Pearce wrote:
> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
> > * Where algorithm in git_revpool_table__hash() is from? Since it appears to
> > hash binary object IDs, wouldn't just simple sum/xor over words be sufficient
> > (all SHA-1 output bits are very nearly independent). Or do you need to be
> > compatible with some other implementation (doesn't appear so, because hash
> > is computed differently depending on endianess)?
> 
> If you need a hash value for a SHA-1, why not just cast the unsigned
> char* to unsigned int* and load the first int as the hash code?
> The output of SHA-1 is pretty evenly distributed, using the first
> few bytes as an int should yield a sufficient distribution throughout
> the hashtable.

Yeah, With pseudorandom function[*], all ways of reducing the output to n bits are
at most as good as just taking first n bits. But if reducing output to [0, m),
the best way (distribution-wise, not speed-wise) is to take remainder of the whole
value divided by m...

[*] SHA-1 is not pseudorandom function, but for virtually all practical purposes
it is.

-Ilari
