From: Junio C Hamano <gitster@pobox.com>
Subject: Re: end of file newline regression
Date: Sun, 16 Dec 2007 17:24:27 -0800
Message-ID: <7vsl22glkk.fsf@gitster.siamese.dyndns.org>
References: <20071216.155413.165709543.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Mon Dec 17 02:25:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J44jD-0005FS-4Q
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 02:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758275AbXLQBYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 20:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757591AbXLQBYl
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 20:24:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40157 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756753AbXLQBYl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 20:24:41 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D36A55F3;
	Sun, 16 Dec 2007 20:24:36 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DCBD355F2;
	Sun, 16 Dec 2007 20:24:33 -0500 (EST)
In-Reply-To: <20071216.155413.165709543.davem@davemloft.net> (David Miller's
	message of "Sun, 16 Dec 2007 15:54:13 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68504>

David Miller <davem@davemloft.net> writes:

> I've stumbled into a problem with current mainline.
>
> I have this changeset that I can't get GIT to properly
> generate diffs for.  It always give me:
>
> diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
> index 4440532..096974b 100644
> --- a/net/ipv6/esp6.c
> +++ b/net/ipv6/esp6.c
> @@ -177,5 +177,4 @@ static int esp6_input(struct xfrm_state *x, struct sk_buff *skb)
>  			BUG();
>  
>  		if (unlikely(memcmp(esp->auth.work_icv, sum, alen))) {
> -			x->stats.integrity_failed++;
> -			ret = -EINVAL;
> \ No newline at end of file
> +			ret = -EBADMSG;
> \ No newline at end of file
>
> No matter what I do, 1.5.3.7 doesn't do this.

Sorry, there was a recent brown-paper-bag.  Should have been fixed with
the patches flew on the list for the past 24 hours or so.  Could you try
it with the tip of 'master'?
