From: Steven Grimm <koreth@midwinter.com>
Subject: Re: --exit-code (and --quiet) broken in git-diff?
Date: Sun, 12 Aug 2007 21:02:40 +0800
Message-ID: <46BF04F0.5020304@midwinter.com>
References: <17875.88.10.191.55.1186873960.squirrel@secure.wincent.com>	<46BED5AA.7050900@lsrfire.ath.cx>	<24332.88.10.191.55.1186917895.squirrel@secure.wincent.com> <85643lq99h.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>,
	=?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 15:02:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKD5n-0001Gf-Uq
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 15:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932794AbXHLNCr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 09:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932654AbXHLNCr
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 09:02:47 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:55894 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1765418AbXHLNCq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 09:02:46 -0400
Received: (qmail 23117 invoked from network); 12 Aug 2007 13:02:46 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=TgvB9M9AGt9I0rYDDQLNCirp/F+/2zaoQaIwBAoHB8XvjcEq+H6KdY9JpBoX+dW3  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 12 Aug 2007 13:02:45 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <85643lq99h.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55681>

David Kastrup wrote:
> I think I would call that a mistake.  However, I don't see that fixing
> it would actually be useful: if a pager gets called, this means that
> git-diff might die with SIGPIPE (when the user quits the pager), and
> that in turn has pretty much no meaning.  So one really needs to
> redirect the output, anyway.
>   

It does sort of make one wonder, though, if there's much point ever 
launching a pager when git-diff is run with --quiet -- it will never 
produce any output to page, so running a pager is guaranteed to always 
be a waste of cycles.

Unfortunately the pager is launched before the option processing code 
knows whether --quiet is being used or not; I'm not sure it's worth 
refactoring the pager launch code just to handle this one special case. 
(Or are there other cases where programs would want to be able to 
control the use of the pager?)

-Steve
