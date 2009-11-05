From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCHv3/RFC 4/5] gitweb: Create links leading to
 'blame_incremental' using JavaScript
Date: Thu, 5 Nov 2009 21:33:16 +0100
Message-ID: <20091105203316.GD17748@machine.or.cz>
References: <1251805160-5303-1-git-send-email-jnareb@gmail.com>
 <1251805160-5303-2-git-send-email-jnareb@gmail.com>
 <1251805160-5303-3-git-send-email-jnareb@gmail.com>
 <1251805160-5303-4-git-send-email-jnareb@gmail.com>
 <1251805160-5303-5-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 21:33:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N691R-0004NU-J4
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 21:33:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758648AbZKEUdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 15:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758611AbZKEUdN
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 15:33:13 -0500
Received: from w241.dkm.cz ([62.24.88.241]:40219 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758550AbZKEUdM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 15:33:12 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id BF15386201A; Thu,  5 Nov 2009 21:33:16 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1251805160-5303-5-git-send-email-jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132246>

  Hi!

On Tue, Sep 01, 2009 at 01:39:19PM +0200, Jakub Narebski wrote:
> @@ -4806,6 +4820,10 @@ sub git_tag {
>  
>  sub git_blame_common {
>  	my $format = shift || 'porcelain';
> +	if ($format eq 'porcelain' && $cgi->param('js')) {
> +		$format = 'incremental';
> +		$action = 'blame_incremental'; # for page title etc
> +	}
>  
>  	# permissions
>  	gitweb_check_feature('blame')

  I'm a bit concerned here. I have somewhat backed out of incremental
blame myself because I have found (in accord with Junio's old findings)
that in most cases, incremental blame can be actually slower than normal
blame because of slow browsers where it takes long to update the page in
each step.

  I'm sorry if I missed this in one of your mails, but how fast is
incremental blame in your implementation? If this still might be an
issue, I think it should be configurable whether to use incremental
blame, or perhaps use some quick heuristic wrt. file size (negative
bias) and history length (positive bias) [not sure if that information
is quickly available].

-- 
				Petr "Pasky" Baudis
A lot of people have my books on their bookshelves.
That's the problem, they need to read them. -- Don Knuth
