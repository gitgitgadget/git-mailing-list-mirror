X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Do not ignore hidden refs
Date: Sat, 18 Nov 2006 05:53:23 +0100
Message-ID: <20061118045323.GK7201@pasky.or.cz>
References: <20061118041137.6064.75827.stgit@machine.or.cz> <7v8xi9fjw9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 04:53:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v8xi9fjw9.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31754>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlICv-00049g-IN for gcvg-git@gmane.org; Sat, 18 Nov
 2006 05:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753501AbWKRExZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 23:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753877AbWKRExZ
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 23:53:25 -0500
Received: from w241.dkm.cz ([62.24.88.241]:21221 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1753501AbWKRExY (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 23:53:24 -0500
Received: (qmail 12088 invoked by uid 2001); 18 Nov 2006 05:53:23 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Sat, Nov 18, 2006 at 05:39:34AM CET, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > Some of the ref manipulation tools (git-for-each-ref and git-show-ref in
> > particular) would not handle hidden (~ /^\./) refs.
> 
> refs.c::check_ref_format() seems to suggest that any ref whose
> path component begins with a dot is invalid (since October last
> year), so I am a bit surprised you are bringing this up now.

Oops, I must've forgotten that already.

> Do you know of specific examples where this is not enforced?  It
> could even be argued that the places in the system that allow
> such a ref are buggy.

Cogito creates such refs for internal purposes in two scenarios, on the
other hand it could be argued that in one of those cases the file has no
business in refs/ at all (temporary fetching refs, but they may be
actually symrefs) and in the other case it has no business in refs/heads/
at all (pointers to shelved changes in a branch).

However, I in fact *did* intend to make leading-dot refnames a public
interface. The thing is, I need a way to mark some tags as private to
your repository if Cogito is to support autopushing tags, and I still
think the most elegant way to do that is to make them like hidden files.
Alternative suggestions welcome.

I don't *need* but it might be nice to have also private heads, for
possible setups when you declare heads namespace of two repositories
matching 1:1 but would like to temporarily make a short-lived head in
one of them or so.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
The meaning of Stonehenge in Traflamadorian, when viewed from above, is:
"Replacement part being rushed with all possible speed."
