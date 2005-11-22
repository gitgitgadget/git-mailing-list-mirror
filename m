From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] speedup allocation in pack-redundant.c
Date: Tue, 22 Nov 2005 12:41:56 -0800
Message-ID: <7vek58ct4b.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0511220656l528436b1xea80ee18965e4dda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lukas =?iso-8859-1?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 21:44:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eeey3-0001x7-0C
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 21:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965177AbVKVUmQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 15:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965179AbVKVUmQ
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 15:42:16 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:58611 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S965177AbVKVUl6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 15:41:58 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051122204051.ELNT26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Nov 2005 15:40:51 -0500
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0511220656l528436b1xea80ee18965e4dda@mail.gmail.com>
	(Alex Riesen's message of "Tue, 22 Nov 2005 15:56:35 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12576>

Alex Riesen <raa.lkml@gmail.com> writes:

> Subject: [PATCH] speedup allocation in pack-redundant.c
>
> Reuse discarded nodes of llists
>
> Signed-off-by: Alex Riesen <ariesen@harmanbecker.com>

I think making allocation/deallocation to the central place is a
good cleanup, but I am not sure about the free-nodes reusing.
Does this make difference in real life?  If so, it might be
worth doing the slab-like allocation, since free-nodes are very
small structure and malloc overhead is not ignorable there.
