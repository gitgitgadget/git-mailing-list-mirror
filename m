X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Len Brown <len.brown@intel.com>
Subject: Re: how to ignore merge conflicts?
Date: Wed, 1 Nov 2006 02:51:20 -0500
Organization: Intel Open Source Technology Center
Message-ID: <200611010251.20874.len.brown@intel.com>
References: <200610301448.38222.len.brown@intel.com> <Pine.LNX.4.64.0610301223021.25218@g5.osdl.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 1 Nov 2006 07:48:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.8.2
In-Reply-To: <Pine.LNX.4.64.0610301223021.25218@g5.osdl.org>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.88.5/2136/Wed Nov  1 03:06:48 2006 on hera.kernel.org
X-Virus-Status: Clean
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30616>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfAq9-00063O-LI for gcvg-git@gmane.org; Wed, 01 Nov
 2006 08:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946677AbWKAHsq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 02:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946674AbWKAHsq
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 02:48:46 -0500
Received: from hera.kernel.org ([140.211.167.34]:18376 "EHLO
 hera.kernel.org") by vger.kernel.org with ESMTP id S1946677AbWKAHsp (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 02:48:45 -0500
Received: from lenb-laptop (c-65-96-213-102.hsd1.ma.comcast.net
 [65.96.213.102]) (authenticated bits=0) by hera.kernel.org (8.13.7/8.13.7)
 with ESMTP id kA17mHiJ023631 (version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128
 verify=NO); Wed, 1 Nov 2006 07:48:42 GMT
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Monday 30 October 2006 15:29, Linus Torvalds wrote:
> 
> On Mon, 30 Oct 2006, Len Brown wrote:
> >
> > Sometimes when a multiple-file merge give conflicts, I don't want to edit
> > one of the resulting <<<<<=====>>>>> files.
> > Instead, I just want to choose the version of that particular file that
> > existed in one of the two merged branches and commit that along with
> > the rest of the merge.
> > 
> > How to do this?
> 
> Well, if you promise not to do what has happened several times before in 
> people who maintained their own CVS trees, for example (which is to just 
> ignore all merge problems, and force _their_ version, even though the 
> reason for the merge problem was that somebody else had fixed a bug, that 
> was now unfixed by the "merge"), here's the trivial way to do it:
> 
> 	git checkout HEAD the/file/you/wanted.c
> 
> (or, if you want to take it from the source you are merging _from_, just 
> use MERGE_HEAD instead of HEAD).
> 
> And you're done.

Thank you.  This worked, and it is simple enough that I can actually remember it:-)

No, obviously I wouldn't intentionally blow away a bug  fix.

I believe this scenario is actually quite common, and this action justified.
Indeed, many years ago Larry McVoy ("He That Must Not Be Named" on this list?:-)
added commands to the nse-lite merge dialogue at my request to handle exactly this case.

Tonight, for example, I merged a big cleanup patch that removed a bunch of
unnecessary casts from many files, with a branch that includes a complete
re-write of one of those files.

So here I chose the re-written version of the file and discarded the cleaned up version
that now no longer makes any sense -- while keeping the rest of the cleanup patch
that does still make sense.  Yes, key here is knowing that there was not a bugfix
bundled along in the branch with the cleanup that got thrown away.

thanks,
-Len

ps. Maybe residing at the "top of the tree" as you do, other folks do a lot of
