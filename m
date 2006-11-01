X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Restore a single file in the index back to HEAD
Date: Wed, 1 Nov 2006 21:18:10 +0000
Message-ID: <200611012118.11558.andyparkins@gmail.com>
References: <200610261641.11239.andyparkins@gmail.com> <200611012029.41869.andyparkins@gmail.com> <7vbqnq51v4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 1 Nov 2006 21:21:47 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=WhY56Q2ux+FpFreE1i44ymztZd27Axiai8CKpNNiOZWcuVxTcCuARsxzOjrS8eWP5ZVyawTZ19MTYHnMz4pUhXQ3G1FSm3POAC54D4yRuUCLls88Yp8NOcSieD7mfIWFcQLiEqiUGWWYHF19HoZ/QXDAjqenYTZ/9Iu8YXzusX0=
User-Agent: KMail/1.9.5
In-Reply-To: <7vbqnq51v4.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30659>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfNWH-0004r8-Ab for gcvg-git@gmane.org; Wed, 01 Nov
 2006 22:21:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752222AbWKAVUl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 16:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752446AbWKAVUl
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 16:20:41 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:51363 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1752222AbWKAVUk
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 16:20:40 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1829813ugm for
 <git@vger.kernel.org>; Wed, 01 Nov 2006 13:20:39 -0800 (PST)
Received: by 10.67.93.7 with SMTP id v7mr8866245ugl; Wed, 01 Nov 2006
 13:20:39 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id s7sm1193241uge.2006.11.01.13.20.38; Wed, 01 Nov
 2006 13:20:38 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006, November 01 20:49, Junio C Hamano wrote:

> >> 	git-reset [--hard | --mixed] HEAD^ oops/file1
> While that perfect makes sense from mechanical point of view, I
> am not sure what it _means_ to keep some paths from now
> abandoned future while having some other paths reset to the
> rewound commit, from the point of view of end-user operation.

Isn't that exactly what the user would be asking for when they are doing a 
per-file reset?  This is a contrived example as git makes it easier to do it 
in far more sensible ways; but I've done this before now in subversion...  
What if I want to try out some radical change?  It goes like this:

x --- y --- z

Where x is some stable commit; y is a load of crazy changes; we discover that 
the crazy changes are all fine except for one, and so want to rollback one 
file, without yet commiting:

 git-reset --hard HEAD^ frotz

Git would get frotz from HEAD^ and write it to the working directory and the 
index (or just index with --mixed).

> In other words, I do not have a good explanation on what "git
> reset [--hard|--mixed] <commit> <path>..." does that I can write
> in the documentation.

 --mixed
   Resets the index but not the working tree (i.e., the changed files are
   preserved but not marked for commit) and reports what has not been
   updated. This is the default action.  If <path> is given then only that
   path will be reset to the state that <path> had in <commit-ish>.  The
   working tree will be untouched.

 --hard
   Matches the working tree and index to that of the tree being switched to.
   Any changes to tracked files in the working tree since <commit-ish> are
   lost.  If <path> is given then only that path will be reset in both the
   working tree and the index to the state that <path> had in <commit-ish>.

> Well, now I am not sure of anything anymore ;-).

I do hope I'm not being presumptuous with all the above.  I feel a bit gobby 
spouting off like I know what I'm talking about.  Especially as I wrote 
absolutely no part of git whatsoever :-)


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
