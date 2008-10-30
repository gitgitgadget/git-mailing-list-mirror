From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Introduce receive.denyDeletes
Date: Thu, 30 Oct 2008 11:32:10 -0700
Message-ID: <20081030183210.GO14786@spearce.org>
References: <20081030191134.62455c24@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jan Krrrger <jk@jk.gs>
X-From: git-owner@vger.kernel.org Thu Oct 30 19:33:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvcKs-0004sy-1h
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 19:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757207AbYJ3ScN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 14:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758254AbYJ3ScM
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 14:32:12 -0400
Received: from george.spearce.org ([209.20.77.23]:33303 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757197AbYJ3ScL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 14:32:11 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 1960B3835F; Thu, 30 Oct 2008 18:32:10 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081030191134.62455c24@perceptron>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99519>

Jan Krrrger <jk@jk.gs> wrote:
> Occasionally, it may be useful to prevent branches from getting deleted from
> a centralized repository, particularly when no administrative access to the
> server is available to undo it via reflog. It also makes
> receive.denyNonFastForwards more useful if it is used for access control, since
> it prevents force-updating refs by deleting and re-creating a ref.
...
>  test_expect_success \
> +	'pushing a delete should be denied with denyDeletes' '
> +	cd victim &&
> +	git config receive.denyDeletes true &&
> +	git branch extra master &&
> +	cd .. &&
> +	test -f victim/.git/refs/heads/extra &&
> +	git send-pack ./victim/.git/ :extra master && return 1

Hmm, that should be:

  test_must_fail git send-pack ./victim/.git/ :extra master

-- 
Shawn.
