From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH 2/2] Add --ignore-notfound option to exit with zero status
 when no files are removed.
Date: Mon, 16 Apr 2007 01:12:30 -0700
Message-ID: <46232FEE.9010907@midwinter.com>
References: <20070416000408.GA19107@midwinter.com> <7v4pnh18hr.fsf@assigned-by-dhcp.cox.net> <4622C0AC.8090904@midwinter.com> <7vps65yvc1.fsf@assigned-by-dhcp.cox.net> <20070416074648.GA18719@midwinter.com> <20070416075324.GA18961@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 10:12:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdMKD-0006x9-Ct
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 10:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbXDPIMe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 04:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbXDPIMe
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 04:12:34 -0400
Received: from tater.midwinter.com ([216.32.86.90]:53225 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964935AbXDPIMd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 04:12:33 -0400
Received: (qmail 21135 invoked from network); 16 Apr 2007 08:12:33 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=nSm4ciPJJ2gBkgtkd3QeekhavLe8rbzM2l8hDcG4lf6z/zNvh2+luj/53JTsg+Iw  ;
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1)
  by localhost with SMTP; 16 Apr 2007 08:12:33 -0000
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
In-Reply-To: <20070416075324.GA18961@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44619>

Steven Grimm wrote:
> This allows "git rm -r --ignore-notfound" to be used as an index filter
> with cg-admin-rewritehist. The documentation for that command recommends
> using git-update-index --remove to filter files out of a tree's history,
> but that doesn't support recursive deletion like git-rm does, making it
> less convenient to filter directories from history.
>   

Having said that, in some sense the problem here is arguably with 
cg-admin-rewritehist bailing out when a filter command exits with a 
nonzero status; given that git-rm is likely to be a common filter people 
will want to use, ideally cg-admin-rewritehist should do the right thing 
with git-rm's normal exit codes. But it appears Cogito is not being 
actively maintained any more (correct me if I'm wrong; the latest stable 
release is half a year old at this point, while git has changed 
substantially since then) so it didn't seem too worthwhile to try to 
patch things from that side.

I think it makes sense to be able to optionally treat a lack of matches 
as a non-error condition like "rm -f" does, so I'm comfortable 
submitting this patch regardless.

On a related note, last time I asked a question that caused someone to 
point me to cg-admin-rewritehist, Linus said he'd like to see its 
functionality folded into git proper. I have to agree with that idea; 
there are some obvious enhancements that program could use, and it'll be 
easier to do that if it's part of an actively maintained code base.

-Steve
