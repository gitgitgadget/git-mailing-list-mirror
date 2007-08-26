From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Git.pm: Add remote_refs() git-ls-remote frontend
Date: Sun, 26 Aug 2007 11:58:36 +0200
Message-ID: <20070826095836.GG1219@pasky.or.cz>
References: <20070825221143.6514.22516.stgit@rover> <7v6432udje.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 26 11:59:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPEtg-0003ZX-5x
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 11:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbXHZJ6i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 05:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbXHZJ6i
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 05:58:38 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43596 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200AbXHZJ6h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 05:58:37 -0400
Received: (qmail 24752 invoked by uid 2001); 26 Aug 2007 11:58:36 +0200
Content-Disposition: inline
In-Reply-To: <7v6432udje.fsf@gitster.siamese.dyndns.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56682>

On Sun, Aug 26, 2007 at 06:26:29AM CEST, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > diff --git a/git-remote.perl b/git-remote.perl
> > index 01cf480..8ce8418 100755
> > --- a/git-remote.perl
> > +++ b/git-remote.perl
> > @@ -128,10 +128,7 @@ sub update_ls_remote {
> >  	return if (($harder == 0) ||
> >  		   (($harder == 1) && exists $info->{'LS_REMOTE'}));
> >  
> > -	my @ref = map {
> > -		s|^[0-9a-f]{40}\s+refs/heads/||;
> > -		$_;
> > -	} $git->command(qw(ls-remote --heads), $info->{'URL'});
> > +	my @ref = keys %{$git->remote_refs($info->{'URL'}, [ 'heads' ])};
> >  	$info->{'LS_REMOTE'} = \@ref;
> >  }
> 
> IIRC, ls-remote returns refs sorted and this function returns
> them as it receives.
> 
> Doesn't this change make @ref randomly ordered?  

Yes, but I couldn't find any place in git-remote.perl where we rely on
the @ref ordering - maybe I'm blind...

-- 
				Petr "Pasky" Baudis
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
