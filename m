From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: cg-log patches
Date: Mon, 9 May 2005 14:41:00 +0200
Message-ID: <20050509124100.GB22830@diku.dk>
References: <1742.10.10.10.24.1115573750.squirrel@linux1> <20050508234936.GA26624@diku.dk> <4302.10.10.10.24.1115610350.squirrel@linux1> <20050509113907.GA22830@diku.dk> <20050509121435.GB18382@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>,
	GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 14:34:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DV7SX-0008TF-2u
	for gcvg-git@gmane.org; Mon, 09 May 2005 14:34:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVEIMlJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 08:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbVEIMlJ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 08:41:09 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:45774 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261337AbVEIMlB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 08:41:01 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 0459A6E257F; Mon,  9 May 2005 14:41:00 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id ACEBD6E2014; Mon,  9 May 2005 14:40:59 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id BC9FD61FDE; Mon,  9 May 2005 14:41:00 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050509121435.GB18382@pasky.ji.cz>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@ucw.cz> wrote Mon, May 09, 2005:
> Dear diary, on Mon, May 09, 2005 at 01:39:07PM CEST, I got a letter
> where Jonas Fonseca <fonseca@diku.dk> told me that...
> > Fix cg-log -f option so that a complete list of files is
> > displayed when a commit has more than one parent.
> > 
> > Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
> > Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
> 
> But that makes no sense, since each merge will have enormous amount of
> files listed, making no sense. E.g. each merge of Cogito with Linus will
> have all the Cogito files listed, since they aren't in the Linus branch
> - but that's wrong, since the merge _to_ the Cogito branch concerns no
> Cogito files.
>
> In git, the parents list is unordered. But this is different in Cogito,
> where the first parent _is_ special. If you are merging _from_ branch B
> _to_ branch A, the order of parents will be always
> 
> parent A
> parent B

Ok, forget the patch then. I was not sure how to handle the multiple parents.

> > Index: cg-log
> > ===================================================================
> > --- 95bc73fd188347aa294991d1c5c7cffd60422098/cg-log  (mode:100755)
> > +++ ddf82a0140bdc1440eb93bcbe01e14e90e44a3e8/cg-log  (mode:100755)
> > @@ -67,8 +67,16 @@
> >  		done
> >  	fi | sort -u | \
> >  	while read modes type sha1s file; do
> > -		echo -n "$sep$file"
		# Always put a trailing comma
> > +		echo -n "$sep"
> >  		sep=", "
> > + 		if [ $(echo "$line$sep$file" | wc -c) -lt 75 ]; then
> > + 			line="$line$sep$file"
> > + 			echo -n "$file"
> > + 		else
> > + 			line="$file"
> > + 			echo "$coldefault"
> > + 			echo -n "    $colfiles$file"
> > + 		fi
> >  	done
> >  	echo "$coldefault:"
> >  }
> 
> Could we have a trailing comma at the previous line?

It should already do that ..

committer Petr Baudis <xpasky@machine.sinus.cz> Sun, 08 May 2005 23:54:08 +0200

    * cg-Xlib, cg-update, cg-seek, cg-pull, cg-tag-ls, cg-branch-ls, cg-merge,
    cg-commit, cg-tag, cg-init, cg-branch-add, cg-admin-lsobj, cg-status,
    cg-cancel, cg-admin-uncommit:

-- 
Jonas Fonseca
