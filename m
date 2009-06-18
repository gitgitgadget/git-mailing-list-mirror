From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: allow configurations to be overriden by command line
Date: Thu, 18 Jun 2009 11:34:09 -0700
Message-ID: <7veitho0gu.fsf@alter.siamese.dyndns.org>
References: <1245316674-32377-1-git-send-email-bebarino@gmail.com>
	<7vfxdxxzps.fsf@alter.siamese.dyndns.org> <4A3A8412.7070705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 20:34:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHMRI-0000EV-Gu
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 20:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335AbZFRSeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 14:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752143AbZFRSeI
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 14:34:08 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:46285 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbZFRSeH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 14:34:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090618183409.JZVP17135.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Thu, 18 Jun 2009 14:34:09 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 5Wa91c0084aMwMQ04Wa9ad; Thu, 18 Jun 2009 14:34:09 -0400
X-VR-Score: 0.00
X-Authority-Analysis: v=1.0 c=1 a=_eZ_frdmPJ4A:10 a=pGLkceISAAAA:8
 a=n2v8j7DWdZh9TkLZ2jYA:9 a=lzYCC7tnXxBhIyg7_8KEuvQ2Q7UA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <4A3A8412.7070705@gmail.com> (Stephen Boyd's message of "Thu\, 18 Jun 2009 11\:14\:42 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121866>

Stephen Boyd <bebarino@gmail.com> writes:

> I didn't think it would be very useful, which is why I left it out. But
> hey, at least it stops it from happening again. Squash it in if you want.
>
> diff --git a/t/t3700-add.sh b/t/t3700-add.sh
> index 6ce8256..91c1f7a 100755
> --- a/t/t3700-add.sh
> +++ b/t/t3700-add.sh
> @@ -242,4 +242,13 @@ test_expect_success 'git add to resolve conflicts on otherwise ignored path' '
>  	git add track-this
>  '
>  
> +test_expect_success POSIXPERM '--no-ignore-errors overrides config' '
> +	git config add.ignore-errors 1 &&
> +	git reset --hard &&
> +	date >foo1 &&
> +	test_must_fail git add --verbose --no-ignore-errors . &&
> +	! ( git ls-files foo1 | grep foo1 ) &&
> +	git config add.ignore-errors 0
> +'
> +
>  test_done

Why do you need POSIXPERM for this?
