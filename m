X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Some advanced index playing
Date: Sun, 3 Dec 2006 20:11:25 +0000
Message-ID: <200612032011.25922.alan@chandlerfamily.org.uk>
References: <200612031701.15594.alan@chandlerfamily.org.uk> <Pine.LNX.4.64.0612031008360.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 3 Dec 2006 20:12:03 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0612031008360.3476@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33136>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gqxgo-00022o-TB for gcvg-git@gmane.org; Sun, 03 Dec
 2006 21:11:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760057AbWLCULo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 15:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760058AbWLCULo
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 15:11:44 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:65206 "EHLO home.chandlerfamily.org.uk") by vger.kernel.org
 with ESMTP id S1760057AbWLCULn (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3
 Dec 2006 15:11:43 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1Gqxgb-0000Sq-W6; Sun, 03 Dec 2006 20:11:42 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Sunday 03 December 2006 18:24, Linus Torvalds wrote:
> On Sun, 3 Dec 2006, Alan Chandler wrote:
> > With all the discussion about the index file in the last few days I would
> > have thought that this issue would have come up.  But I don't think it
> > has.
> >
> > I have been editing a set of files to make a commit, and after editing
> > each one had done a git update-index.
> >
> > At this point I am just about to commit when I realise that one of the
> > files has changes in it that really ought to be a separate commit.
> >
> > So effectively, I want to do one of three things
> >
> > a) git-commit <that-file>
> >
> > Except I can't because there is a safety valve that prevents this and
> > there is no force option.
...
>
> 	git ls-tree HEAD -- that-file | git update-index --index-info
> 	git commit that-file

I don't quite understand this - maybe it should be

git ls-tree HEAD -- that-file | git update-index --index-info
git commit
git commit -a

either I want to ONLY commit that file at the working tree state (and index 
before these commands), or I want to commit ALL except this file (so I can 
later come and commit just that file)

so having reset the index to the state of HEAD for "that-file" then the commit 
should make a commit with all the other changes in the index (but NOT 
that-file) and then the git commit -a picks up "that-file"

-- 
Alan Chandler
