X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sam Vilain <sam@vilain.net>
Subject: Re: On removing files and "git-rm is pointless"
Date: Sun, 03 Dec 2006 09:00:00 +1300
Message-ID: <4571DB40.6020800@vilain.net>
References: <87odqm2ppv.wl%cworth@cworth.org> <Pine.LNX.4.64.0612020919400.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 2 Dec 2006 20:00:25 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
In-Reply-To: <Pine.LNX.4.64.0612020919400.3476@woody.osdl.org>
X-Enigmail-Version: 0.94.0.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33037>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqb24-00012M-37 for gcvg-git@gmane.org; Sat, 02 Dec
 2006 21:00:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424437AbWLBUAO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 15:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424439AbWLBUAO
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 15:00:14 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:61582 "EHLO
 magnus.utsl.gen.nz") by vger.kernel.org with ESMTP id S1424437AbWLBUAM (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 15:00:12 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534) id BB1C4139B0D;
 Sun,  3 Dec 2006 09:00:10 +1300 (NZDT)
Received: from [127.0.0.1] (longdrop.magnus.utsl.gen.nz [192.168.253.12])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by magnus.utsl.gen.nz (Postfix) with ESMTP id
 D737B1380C2; Sun,  3 Dec 2006 09:00:04 +1300 (NZDT)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> I'd like it more if it defaulted to actually removing the file, preferably 
> refusing to with an error message if the file didn't match the index. 

index, or HEAD version?  Otherwise you can "update-index"; "rm" without
seeing something wrong is happening.

> Final note: arguably, the current "git rm" is a better mirror image of 
> "git add" than what I suggest above. "git add" doesn't actually create the 
> working file (you had to do that yourself), so you _could_ argue that "git 
> rm" as it stands now is closer to the "reverse" of git add. The same is 
> true of the recursive behaviour.

For this reason I think that the current behaviour is not so broken.
Everywhere else, it is up to the user to make the changes to the working
copy that they want to commit.  I like git-rm because I can go:

  rm -rf whatever
  git-rm whatever

I can see why you'd want

  git-rm -u whatever

or

  rm -rf whatever
  git-commit -a

An extra flag to actually unlink the files is less likely to cause bugs
with porcelain expecting git-rm to behave as it does currently.  If it
is to be changed in backwards incompatible ways, there should probably
be a deprecation time.

"rm -u" could alter the default semantics, ie, require the extra -r
option to recurse and require -f unless things are safe.

