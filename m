From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] gitweb: make feature_blame return a list
Date: Mon, 15 Dec 2008 18:46:05 -0800
Message-ID: <20081216024605.GA4529@ftbfs.org>
References: <1229352709-4663-1-git-send-email-kraai@ftbfs.org> <7v7i61w06k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 03:48:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCPye-00014t-Gn
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 03:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbYLPCqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 21:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbYLPCqq
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 21:46:46 -0500
Received: from neon.ftbfs.org ([83.168.236.214]:43633 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802AbYLPCqq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 21:46:46 -0500
Received: from pool-71-119-193-199.lsanca.dsl-w.verizon.net ([71.119.193.199] helo=macbookpro.ftbfs.org)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1LCPwy-0001cR-2U; Mon, 15 Dec 2008 18:46:26 -0800
Received: from kraai by macbookpro.ftbfs.org with local (Exim 4.69)
	(envelope-from <kraai@ftbfs.org>)
	id 1LCPwj-0001Eh-MY; Mon, 15 Dec 2008 18:46:05 -0800
Content-Disposition: inline
In-Reply-To: <7v7i61w06k.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Score-Int: -41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103236>

On Mon, Dec 15, 2008 at 02:20:03PM -0800, Junio C Hamano wrote:
> Matt Kraai <kraai@ftbfs.org> writes:
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -367,12 +367,12 @@ sub feature_blame {
> >  	my ($val) = git_get_project_config('blame', '--bool');
> >  
> >  	if ($val eq 'true') {
> > -		return 1;
> > +		return (1);
> >  	} elsif ($val eq 'false') {
> > -		return 0;
> > +		return (0);
> >  	}
> >  
> > -	return $_[0];
> > +	return ($_[0]);
> >  }
> 
> My Perl may be getting rusty, but does the above make any difference?

I'm still relatively new to Perl, but at least in my limited testing,
I couldn't generate a case in which these different constructs had
different results.

I made this change so that all of the boolean feature subroutines
would have the same body, modulo the name of the option; that way,
replacing them with a single routine only involves making the option
name a parameter.

If you'd like me to resubmit my second patch, I'm happy to do so.
Just let me know whether you prefer the resulting function to wrap its
return values in parentheses (as is currently done by feature_grep and
feature_pickaxe) or not.

-- 
Matt                                                 http://ftbfs.org/
