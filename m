From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [2/4] Sorting commits by date
Date: Tue, 19 Apr 2005 04:13:38 +0200
Message-ID: <20050419021338.GX5554@pasky.ji.cz>
References: <Pine.LNX.4.21.0504182139250.30848-100000@iabervon.org> <Pine.LNX.4.21.0504182152000.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 04:09:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNiBM-000444-5E
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 04:09:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbVDSCNq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 22:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVDSCNq
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 22:13:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:17332 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261270AbVDSCNo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 22:13:44 -0400
Received: (qmail 6815 invoked by uid 2001); 19 Apr 2005 02:13:38 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504182152000.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 19, 2005 at 03:54:56AM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> Index: commit.c
> ===================================================================
> --- b3cf8daf9b619ae9f06a28f42a4ae01b69729206/commit.c  (mode:100644 sha1:0099baa63971d86ee30ef2a7da25057f0f45a964)
> +++ 7e5a0d93117ecadfb15de3a6bebdb1aa94234fde/commit.c  (mode:100644 sha1:ef9af397471817837e1799d72f6707e0ccc949b9)
> @@ -83,3 +83,47 @@
>  		free(temp);
>  	}
>  }
> +
> +static void insert_by_date(struct commit_list **list, struct commit *item)
> +{
> +	struct commit_list **pp = list;
> +	struct commit_list *p;
> +	while ((p = *pp) != NULL) {
> +		if (p->item->date < item->date) {
> +			break;
> +		}
> +		pp = &p->next;
> +	}
> +	struct commit_list *insert = malloc(sizeof(struct commit_list));
> +	insert->next = *pp;
> +	*pp = insert;
> +	insert->item = item;
> +}

Note that you are breaking gcc-2.95 compatibility when using declarator
in the middle of a block. Not that it might be a necessarily bad thing
;-) (although I still use gcc-2.95 a lot), just to ring a bell so that
it doesn't slip through unnoticed and we can decide on a policy
regarding this.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
