From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix memory leaks in read_tree_recursive()
Date: Wed, 04 May 2005 16:43:17 -0700
Message-ID: <7vpsw6muay.fsf@assigned-by-dhcp.cox.net>
References: <20050504231959.GA25475@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 01:37:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTTQK-0007FB-2k
	for gcvg-git@gmane.org; Thu, 05 May 2005 01:37:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVEDXnW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 19:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVEDXnW
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 19:43:22 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:38128 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261960AbVEDXnT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2005 19:43:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050504234316.BNGD20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 4 May 2005 19:43:16 -0400
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20050504231959.GA25475@diku.dk> (Jonas Fonseca's message of
 "Thu, 5 May 2005 01:19:59 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JF" == Jonas Fonseca <fonseca@diku.dk> writes:

JF> This patch fixes memory leaks in the error path of
JF> read_tree_recursive().

The leak seems to be real but what is "mem_free"?  Has it been
compile tested?

JF> @@ -39,14 +39,18 @@
JF>  		if (S_ISDIR(mode)) {
JF>  			int retval;
 
JF> ...
JF> -			if (!eltbuf || strcmp(elttype, "tree"))
JF> +			if (!eltbuf || strcmp(elttype, "tree")) {
JF> +				if (eltbuf) mem_free(eltbuf);
JF>  				return -1;

Btw, who is putting this header in your mail?  It does not make
sense to me unless Jonas is pseudonym for Linus...

  Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org 


