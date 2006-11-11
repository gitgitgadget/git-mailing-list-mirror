X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: gitk feature request..
Date: Sat, 11 Nov 2006 18:42:42 +0100
Message-ID: <20061111174242.GB7201@pasky.or.cz>
References: <452A37FB.60507@adelaide.edu.au> <17745.1213.22769.420355@cargo.ozlabs.ibm.com> <7vslgu28do.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 11 Nov 2006 17:43:25 +0000 (UTC)
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org,
	Pierre Marc Dumuid <pierre.dumuid@adelaide.edu.au>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vslgu28do.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31234>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Giwst-0000s2-Q8 for gcvg-git@gmane.org; Sat, 11 Nov
 2006 18:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424590AbWKKRmp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 11 Nov 2006
 12:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424592AbWKKRmp
 (ORCPT <rfc822;git-outgoing>); Sat, 11 Nov 2006 12:42:45 -0500
Received: from w241.dkm.cz ([62.24.88.241]:3032 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1424590AbWKKRmo (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 11 Nov 2006 12:42:44 -0500
Received: (qmail 10149 invoked by uid 2001); 11 Nov 2006 18:42:42 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Tue, Nov 07, 2006 at 11:34:59PM CET, Junio C Hamano wrote:
> Paul Mackerras <paulus@samba.org> writes:
> 
> > Good idea.  Junio, is there a canonical place under .git where gitk
> > should put such things?
> 
> Well, we do not design things in advance but tend to let things
> evolve, which probably is a bad habit but I am not sure how else
> we can avoid overdesigning before knowing the needs.
> 
> The existing state-keeping programs seem to keep their stuff
> immediately under $GIT_DIR.  Examples are:
> 
> 	.git/description (gitweb)
>         .git/cvs-authors (cvsimport)
>         .git/gitcvs.<branch>.sqlite (cvsserver)
> 
> So, .git/gitk-<foo> (or .git/gitk/<bar>) would be in line with
> others.  We _might_ want to have a standard plan to keep
> Porcelains stepping on each other's toes, and probably migrating
> everybody to .git/aux/{common,gitcvs,gitk,...}/<foo> would be a
> sane thing to do.  description and cvs-authors could probably be
> shared across Porcelains, so I do not think we mind leaving them
> in the current place or throw them in .git/aux/common/

I think the porcelains tend to use pretty specific names for their stuff
and a risk of conflict is pretty small, so I don't think it's worth the
compatibility problems. Also, over time it's bound that qgit will
something like start to peek and poke at some gitk stuff and learn about
CVS imports so it'll peek at gitcvs as well, etc., so I'm not sure if
the net benefit would really be that large or rather give the porcelains
a false illusion of safety and privacy.

Except for cg-merge which is quite a pig when it comes to its state and
.git files; I guess it should use a .git/cg-merge-state/ directory
instead. And the hooks space where cg sort of hoped that git would reuse
its hooks names but it didn't play out.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
