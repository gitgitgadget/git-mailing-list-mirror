From: Andy Parkins <andyparkins@gmail.com>
Subject: OT: Funny tab behaviour on terminals
Date: Wed, 28 Feb 2007 09:34:51 +0000
Message-ID: <200702280934.52650.andyparkins@gmail.com>
References: <200702271529.13258.andyparkins@gmail.com> <7v4pp7flew.fsf@assigned-by-dhcp.cox.net> <7vslcrcpeg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 10:35:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMLDB-0007Nj-0K
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 10:35:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbXB1Je7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 04:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbXB1Je7
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 04:34:59 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:3262 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbXB1Je6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 04:34:58 -0500
Received: by nf-out-0910.google.com with SMTP id o25so495876nfa
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 01:34:56 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pYExGh9mBMenMD3uZNferLFi2jv+3AO5WzQx/ofbHQqwWvzeFlzEQ70XlVWYxnm1NFTY78uC+V1I24ZS6Ga7AgduT3g4orzwIUU58yeD9+SIvD2UYysv6t/Ya+jtPDi9blkTezfwGs1LLFIZJ7Z6wgkQ6nPksbSGPrE+4Z4mIgs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qM50KyGTMaMVGv3xPX7KI7qUZf/6sKXfW6i2SWQn0W/OCczpo5sviXeMaFIcPFuGT7BVCNDxl8r/gJyw+PJamPgMra5nJF9RnTPsoSnNNMZj+U44w95qLHLJUesa4tDPtK5Wa1dIFDy0BrvR+nba5PLDNtiJ/Ys7LL2eT656yeU=
Received: by 10.49.12.4 with SMTP id p4mr3210019nfi.1172655296912;
        Wed, 28 Feb 2007 01:34:56 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id o9sm5137136nfa.2007.02.28.01.34.54;
        Wed, 28 Feb 2007 01:34:54 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vslcrcpeg.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40910>

On Tuesday 2007 February 27 20:32, Junio C Hamano wrote:

>  * refs.c::log_ref_write() gets an optional log message and
>    writes it after the GMT offset, with an explicit "\t", so
>    this is not it, either.

Your mention of tabs set off alarm bells in my head.  I had another look at 
the files with "less -S" instead of tail and lo-and-behold, the tab is shown.

Panic over.  This isn't a fault with git.  Stop reading now if you're only 
interested in git.

It's some weird interaction with tabs and my terminal and those particular 
line lengths.  The two repositories I was comparing logs in have different 
email addresses for me, so the column at which the tab activates is 
different.  Bizarrely, in one case the tab appears swallowed, in the other it 
appeared correctly.

-- time passes ---

It seems like a fault in terminals in general to me (perhaps it's specified in 
a standard somewhere, so everyone just implements it):  if a tab is output in 
the last column of the terminal, it's just swallowed - no space at all is 
shown.

It's easily repeatable.
 * Open an xterm
 * Resize it so that it's 50 columns wide.
 * echo -e "0xxxxxxxxx1xxxxxxxxx2xxxxxxxxx3xxxxxxxxx4xxxxxxxx\t5xxxxxxxxx"
 * Notice that the "5" is not on the next line where one might expect, but is
   in column 49

Am I wrong to think this is wrong?  I've always thought that there was an 
implicit tab just off the end of a terminal line, which effectively brings 
the output to the next tab stop (i.e. column 0 of the next line).


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
