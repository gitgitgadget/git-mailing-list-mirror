X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: how to revert changes in working tree?
Date: Wed, 6 Dec 2006 09:43:27 +0100
Message-ID: <81b0412b0612060043t488d356du8f5fcdd164a45eb5@mail.gmail.com>
References: <4576680B.7030500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 08:43:44 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NyVDICyGZGiiFUgRt6E0eynkJFVGD01fnKkHysqVZv6wck1NRa/d1mv33V8OWyTxjih1ToudW/S8YYCxhjtBwz/jFKEA9+yHONVm3iZS/+BXDWtlRi7Th8YQIv6cDeIo6kVkoGuGkQ2JHVkHODChzYbNCgbZv696xQ5RM9PT5r8=
In-Reply-To: <4576680B.7030500@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33407>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrsNK-0006tK-22 for gcvg-git@gmane.org; Wed, 06 Dec
 2006 09:43:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760311AbWLFInb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 03:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760312AbWLFInb
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 03:43:31 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:25765 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760305AbWLFIna (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 03:43:30 -0500
Received: by ug-out-1314.google.com with SMTP id 44so73956uga for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 00:43:29 -0800 (PST)
Received: by 10.78.185.7 with SMTP id i7mr377542huf.1165394607654; Wed, 06
 Dec 2006 00:43:27 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Wed, 6 Dec 2006 00:43:27 -0800 (PST)
To: "Liu Yubao" <yubao.liu@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/6/06, Liu Yubao <yubao.liu@gmail.com> wrote:
> I'm confused how to revert changes in working tree:
>
> $ git fetch
> $ git merge "sync with origin" HEAD origin
> ....conflict....

You may want to consider git pull. It'd do exactly the same

> $ git branch
> * master
>   origin
>
> $ git status
> # .....: needs update
> # .....: needs update
> (In fact I never modified anything in this tree, and "git diff"
> showed many difference indeed, very strange).

That's windows and cygwin for you. They work together
and may someday even figure how to commit the changes.

They problem is the exec-bit which windows does not
have and cygwin failed to correctly workaround the
limitation.

Do a "git repo-config core.filemode false" to almost
disable the checks for exec bit.

> I tried "git update-index --refresh", "git reset --hard",
> "git reset --hard master", "git checkout master",
> "git checkout -f master", but "git status" still said same
> as above.

After git update-index --refresh you shouldn't have had
the diffs (unless you actually had textual changes).

> At last, I deleted all files that were reported to be updated
> with "rm -rf", ran "git checkout master" and "git status", then
> git reported:
> #       deleted:    ....
> #       deleted:    ....

Now do a git reset --hard and you should be set,
unless you're unlucky enough to work on FAT,
where probably nothing will save you.

And avoid using any "special" characters (8bit, utf/unicode)
in filenames, while you're on windows: you'll never be able
to share the repository (unless others agree to use your
