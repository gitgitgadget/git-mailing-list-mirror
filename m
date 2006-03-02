From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: cygwin: push/pull takes very long time
Date: Thu, 2 Mar 2006 18:09:23 +0100
Message-ID: <81b0412b0603020909p179ed9bx4ed8fc2ddf77e868@mail.gmail.com>
References: <81b0412b0603020526w7db41994v54a96895c1a6e960@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Mar 02 18:10:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FErJD-0002Ha-D2
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 18:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbWCBRJc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 12:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752018AbWCBRJc
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 12:09:32 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:10294 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752021AbWCBRJb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 12:09:31 -0500
Received: by nproxy.gmail.com with SMTP id a27so314304nfc
        for <git@vger.kernel.org>; Thu, 02 Mar 2006 09:09:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iikvOhsZhTfh0CL0/GgONIvWYGrEGjvxaNuKOnhJrLPGjCjMeXh+Af07UrvQhpYC98zSk6ylIfSj3pZeSqDIyiVCkCHPAfiHIvRjExomOd5dMKHjvJxLKUHAmjilmd1r8JlTiuxeKFVKI8AjCIFiRcHxV12u70gLW8epyX0SM0Y=
Received: by 10.49.95.12 with SMTP id x12mr739756nfl;
        Thu, 02 Mar 2006 09:09:23 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Thu, 2 Mar 2006 09:09:23 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
In-Reply-To: <81b0412b0603020526w7db41994v54a96895c1a6e960@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17095>

On 3/2/06, Alex Riesen <raa.lkml@gmail.com> wrote:
> It's still working, half an hour since it was started.
> It can be seen that it is constantly growing and shrinking
> (for about 20k,50k,80k,100k back and forth).

The distribution is (there are some git-commits and gitks
probably, here as git-read-tree?) below. The first number
after program name is lower range limit, the second - upper limit.
The number after them - counter of *alloc calls.
The strange pair 65536:99999 means very big objects, more than 1Mb.
I'll cleanup the profiling code and send it as well soon
(I had to instrument x*alloc).

      git-read-tree:16:256      127002
       git-rev-list:16:256      44775
        git-read-tree:0:16      22577
   git-pack-objects:16:256      12495
 git-pack-objects:256:4096      12303
git-pack-objects:4096:65536     6929
     git-diff-index:16:256      4381
     git-http-fetch:16:256      3535
     git-diff-index:16:256      2914
  git-write-tree:4096:65536     2876
       git-http-fetch:0:16      2111
     git-fetch-pack:16:256      1646
       git-fetch-pack:0:16      1522
     git-rev-list:256:4096      1067
                   :16:256      976
    git-read-tree:256:4096      965
   git-http-fetch:256:4096      835
                     :0:16      825
         git-ls-files:0:16      791
         git-rev-list:0:16      748
   git-fetch-pack:256:4096      698
    git-upload-pack:16:256      610
git-pack-objects:65536:1048576  594
      git-rev-parse:16:256      571
                 :256:4096      554
        git-rev-parse:0:16      492
      git-upload-pack:0:16      469
  git-upload-pack:256:4096      248
         git-cat-file:0:16      243
    git-peek-remote:16:256      242
       git-merge-base:0:16      229
     git-merge-base:16:256      208
       git-cat-file:16:256      167
    git-rev-parse:256:4096      141
      git-rev-parse:16:256      117
        git-rev-parse:0:16      116
     git-cat-file:256:4096      80
     git-pack-objects:0:16      73
       git-diff-index:0:16      65
   git-merge-base:256:4096      59
git-pack-objects:65536:99999    54
   git-current-branch:0:16      48
       git-diff-index:0:16      47
      git-diff-tree:16:256      42
   git-diff-index:256:4096      36
 git-unpack-objects:16:256      31
      git-diff-tree:16:256      30
       git-ls-files:16:256      27
   git-update-index:16:256      27
   git-diff-index:256:4096      24
     git-write-tree:16:256      23
       git-cat-file:16:256      22
