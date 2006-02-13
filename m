From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] Don't send copies to the From: address
Date: Mon, 13 Feb 2006 02:20:53 -0500
Message-ID: <20060213072053.GA5540@mythryan2.michonline.com>
References: <11396260373307-git-send-email-cbiesinger@web.de> <7vk6c2sg66.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Biesinger <cbiesinger@web.de>, git@vger.kernel.org,
	Greg Kroah-Hartman <greg@kroah.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 08:22:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8Y2H-0005b4-QO
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 08:22:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWBMHWJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 02:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWBMHWJ
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 02:22:09 -0500
Received: from mail.autoweb.net ([198.172.237.26]:29625 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1751144AbWBMHWH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 02:22:07 -0500
Received: from c-68-60-186-73.hsd1.mi.comcast.net ([68.60.186.73] helo=h4x0r5.com)
	by mail.internal.autoweb.net with esmtp (Exim 4.50)
	id 1F8Y27-0000Cj-SI; Mon, 13 Feb 2006 02:22:05 -0500
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by h4x0r5.com with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.60)
	(envelope-from <ryan@michonline.com>)
	id 1F8Y25-0000H4-SQ; Mon, 13 Feb 2006 02:22:03 -0500
Received: from ryan by mythical with local (Exim 4.60)
	(envelope-from <ryan@mythryan2.michonline.com>)
	id 1F8Y1X-0008MN-8o; Mon, 13 Feb 2006 02:21:27 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk6c2sg66.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
X-Spam-Score: -4.2
X-Spam-Report: Spam detection software, running on the system "h4x0r5.com", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Fri, Feb 10, 2006 at 07:55:13PM -0800, Junio C Hamano
	wrote: > Christian Biesinger <cbiesinger@web.de> writes: > > > Sending
	copies to the from address is pointless. > > Ryan, care to defend this
	part of the code? This behaviour > might have been inherited from Greg's
	original version. > > I cannot speak for Ryan or Greg, but I think the
	script > deliberately does this to support this workflow: > > (1) The
	original author sends in a patch to a subsystem > maintainer; > > (2)
	The subsystem maintainer applies the patch to her tree, > perhaps with
	her own sign-off and sign-offs by other people > collected from the
	list. She examines it and says this > patch is good; > > (3) The commit
	is formatted and sent to higher level of the > foodchain. The message is
	CC'ed to interested parties in > order to notify that the patch
	progressed in the > foodchain. > > Me, personally I do not like CC: to
	people on the signed-off-by > list, but dropping a note to From: person
	makes perfect sense to > me, if it is to notify the progress of the
	patch. [...] 
	Content analysis details:   (-4.2 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.8 ALL_TRUSTED            Passed through trusted hosts only via SMTP
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.2 AWL                    AWL: From: address is in the auto white-list
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16050>

On Fri, Feb 10, 2006 at 07:55:13PM -0800, Junio C Hamano wrote:
> Christian Biesinger <cbiesinger@web.de> writes:
> 
> > Sending copies to the from address is pointless.
> 
> Ryan, care to defend this part of the code?  This behaviour
> might have been inherited from Greg's original version.
> 
> I cannot speak for Ryan or Greg, but I think the script
> deliberately does this to support this workflow:
> 
>  (1) The original author sends in a patch to a subsystem
>      maintainer;
> 
>  (2) The subsystem maintainer applies the patch to her tree,
>      perhaps with her own sign-off and sign-offs by other people
>      collected from the list.  She examines it and says this
>      patch is good;
> 
>  (3) The commit is formatted and sent to higher level of the
>      foodchain.  The message is CC'ed to interested parties in
>      order to notify that the patch progressed in the
>      foodchain.
> 
> Me, personally I do not like CC: to people on the signed-off-by
> list, but dropping a note to From: person makes perfect sense to
> me, if it is to notify the progress of the patch.

That's the thinking I've been using everytime I think about how that
code works.

> What you are after _might_ be not CC'ing it if it was your own
> patch.  Maybe something like this would help, but even if that
> is the case I suspect many people want to CC herself so it needs
> to be an optional feature.

This is probably along the right lines, but there are a few other things
we need as well.

I'm thinking of "don't add my email to cc:", as well ass "don't add cc:s
from From and Signed-off-by" as an option.

So, please feel free to commit this one, and I'll send a patch in a
minute or two for the other half.

> 
> -- >8 --
> [PATCH] Do not CC me
> 
> ---
> git diff
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 3f1b3ca..a02e2f8 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -343,7 +343,7 @@ foreach my $t (@files) {
>  	}
>  	close F;
>  
> -	$cc = join(", ", unique_email_list(@cc));
> +	$cc = join(", ", unique_email_list(grep { $_ ne $from } @cc));
>  
>  	send_message();
>  
> 
> 
> 
> 

-- 

Ryan Anderson
  sometimes Pug Majere
