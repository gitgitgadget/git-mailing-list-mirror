From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Limit filename for format-patch
Date: Fri, 23 Feb 2007 22:39:18 +0100
Message-ID: <200702232239.19504.robin.rosenberg@dewire.com>
References: <20070223003711.6895.24185.stgit@lathund.dewire.com> <Pine.LNX.4.63.0702230143370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 23 22:37:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKi74-00016p-Fd
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 22:37:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbXBWVhz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 16:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbXBWVhz
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 16:37:55 -0500
Received: from [83.140.172.130] ([83.140.172.130]:12578 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S932237AbXBWVhz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 16:37:55 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 91588802E11;
	Fri, 23 Feb 2007 22:32:53 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 18136-06; Fri, 23 Feb 2007 22:32:53 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 3D21B802AB6;
	Fri, 23 Feb 2007 22:32:51 +0100 (CET)
User-Agent: KMail/1.9.4
In-Reply-To: <Pine.LNX.4.63.0702230143370.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40469>

fredag 23 februari 2007 01:49 skrev Johannes Schindelin:
> Hi,
> 
> I agree that your patch fixes a long-time issue.
> 
> On Fri, 23 Feb 2007, Robin Rosenberg wrote:
> 
> > +		if (strlen(output_directory) > sizeof filename - suffix_len)
> 
> I know that "sizeof filename" works, but in git.git, `git grep sizeof' 
> returns > 700 instances, only 23 of which do not use the 
> "sizeof(filename)" form. It's just a style issue, but I prefer the latter 
> nevertheless...
Actually there are (only) about 500 of them that are not the sizeof(type) kind.

I prefer not to use extra parentheses except for grouping complex expressions 
for readability.

> >  		for (j = 0;
> 
> Does this:
> 
> > +		     j< 64-suffix_len-5 && 
> >  		     len < sizeof(filename) - suffix_len &&
> >  			     sol[j] && sol[j] != '\n';
> >  		     j++) {
> 
> not make this:
> 
> > +	if (len + strlen(fmt_patch_suffix) >= sizeof filename)
> > +		return error("Patch pathname too long");
> 
> unnecessary for the case that there _was_ an output directory specified? 
> I'd make that an "else if"... But I might be missing something.

The last statement errs out if the total length is too long which is a different
issue than truncating the patch name. There is no reason to two paths when
one does perfectly well.  But I could replace strlen there.

-- robin
