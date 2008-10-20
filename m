From: "Simon Strandgaard" <neoneye@gmail.com>
Subject: Re: bug: git-stash save and symbolic links
Date: Mon, 20 Oct 2008 17:39:31 +0200
Message-ID: <df1390cc0810200839q5eddad1cp4bc14762724d8848@mail.gmail.com>
References: <df1390cc0810200134x68a8eb1fyc7f24650c8c9c5d3@mail.gmail.com>
	 <20081020151715.GA13553@coredump.intra.peff.net>
	 <df1390cc0810200832i4fa974fx1d70ed489aa1be02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 20 22:42:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrwsI-0007zm-W8
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 17:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbYJTPje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 11:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbYJTPje
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 11:39:34 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:48105 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbYJTPjd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 11:39:33 -0400
Received: by gxk9 with SMTP id 9so3848738gxk.13
        for <git@vger.kernel.org>; Mon, 20 Oct 2008 08:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ngH428YayFTpWKl3NjPaFL2+0V91yrs0gHw68P8/0s0=;
        b=S7DP+r6JTsg5c5JHnoJQEkTWCuDUOzgN1UT7LCVOJESC8Whber02ObqEiBCwU6sjHN
         Bd59u4dmVX+e/MwkU53Z3AzlOJDCZfSfBsuF/0ejL/Z1vnH7HKSNwL1EYZNBuFIdA8wN
         GNlEfKIA+HpJfFgXT0Y9CfJLstBE1l4A9iJ98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=RV2edfpZ9wJxUlMjhhT59SGcuhaJuZSeyu8wY0BXarApqYJhWzjhRl0JUKNVdhVrzv
         OfK3A8ns45u82DHXWNB/MObfirmyBkADa9xL8NaOHIm4tCN4tXf48NzX9FKNLhcPcnSo
         0JXTg7Piq4mLPNJT9HBx6irMDFFPB81rmZge0=
Received: by 10.143.19.16 with SMTP id w16mr3130374wfi.223.1224517171267;
        Mon, 20 Oct 2008 08:39:31 -0700 (PDT)
Received: by 10.143.168.21 with HTTP; Mon, 20 Oct 2008 08:39:31 -0700 (PDT)
In-Reply-To: <df1390cc0810200832i4fa974fx1d70ed489aa1be02@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98703>

On Mon, Oct 20, 2008 at 5:32 PM, Simon Strandgaard <neoneye@gmail.com> wrote:
> On Mon, Oct 20, 2008 at 5:17 PM, Jeff King <peff@peff.net> wrote:
>> On Mon, Oct 20, 2008 at 10:34:53AM +0200, Simon Strandgaard wrote:
> [snip]
>> What version of git are you running (though I tried a few different
>> ones, and all passed my test)?
>
>
> I have made some changes, so it can be reproduced
[snip]

Sorry, forget the other run.sh I forgot to add the dir to the repository.
Here the linked dir is included in the repository.

prompt> sh run.sh
Initialized empty Git repository in /Users/neoneye/Desktop/test/repo/.git/
Created initial commit b904776: one
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 file
Created commit 19746b5: two
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 test/file2
before stash
fatal: Not a git repository
fatal: Not a git repository
fatal: Not a git repository
You do not have the initial commit yet

prompt> cat run.sh
rm -rf repo &&
rm -f linked &&
mkdir repo &&
   cd repo &&
     git init &&
     echo content >file &&
     git add file &&
     git commit -m one &&
     mkdir test &&
     echo content >test/file2 &&
     git add test/file2 &&
     git commit -m two &&
   cd .. &&
     ln -s repo/test linked &&
   cd linked &&
     echo cruft >>file &&
     echo before stash &&
     git stash &&
     echo after stash

prompt> pwd
/Users/neoneye/Desktop/test
prompt>


[snip]
> This is my computer
>
> prompt> git --version
> git version 1.5.6.2
> prompt> uname -a
> Darwin Macintosh.local 9.5.0 Darwin Kernel Version 9.5.0: Wed Sep  3
> 11:29:43 PDT 2008; root:xnu-1228.7.58~1/RELEASE_I386 i386
> prompt>
>
>
> --
> Simon Strandgaard
> http://toolboxapp.com/
>



-- 
Simon Strandgaard
http://toolboxapp.com/
