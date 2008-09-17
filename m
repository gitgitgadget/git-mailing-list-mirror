From: "Michael Kerrisk" <mtk.manpages@googlemail.com>
Subject: Re: Getting correct tree layout when importing svn repo into git
Date: Wed, 17 Sep 2008 03:38:12 -0700
Message-ID: <cfd18e0f0809170338v168c2991ma3964392e44e0194@mail.gmail.com>
References: <cfd18e0f0809161505g4c04bd88vaf4fd7c40f67b243@mail.gmail.com>
	 <48D0BEF1.10008@drmicha.warpmail.net>
Reply-To: mtk.manpages@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, michael.kerrisk@gmail.com
To: "Michael J Gruber" <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Sep 17 12:41:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfuTd-0004iH-CI
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 12:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbYIQKiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 06:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbYIQKiN
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 06:38:13 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:25225 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbYIQKiM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 06:38:12 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3125739rvb.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2008 03:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=KASBkaBnDYw2kPYQwNUmuX3y3qBeGuPQUsVQNBpYWds=;
        b=X59vlTZkrlu2KrsB7wqhSkrM1+y0lL8BaQ/NZ+VAB58RCafahtXuyuC94PY2zKF80t
         sk2oqwhP4Svi7yvmuIjTZaVLerqd+FrXjnnyLgOIg21IQmK74cGXjBwd1/58STgp/eWy
         xOd8Pa95eIWj+2gFzIlS/xuKIYKrYdo2XDUJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=ErecmE8I1KhkzsL8z9ptVLYYgdHCwhFCJtgOQ6KA+Mx5Kn9r8erY7rrUpQwwlrtpZf
         WL9HRV0+TSDDJNSY1Bukp7t0GnLPYmQJshLKdXoLEEkEwfqQd09qnSWOY5GeRLOnhxvD
         WpBb9FauUmo6+hHB/I5mdyvMJ6mEmyuj5IBDI=
Received: by 10.141.66.16 with SMTP id t16mr6400326rvk.168.1221647892066;
        Wed, 17 Sep 2008 03:38:12 -0700 (PDT)
Received: by 10.141.176.2 with HTTP; Wed, 17 Sep 2008 03:38:12 -0700 (PDT)
In-Reply-To: <48D0BEF1.10008@drmicha.warpmail.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96084>

Hello Michael,

On Wed, Sep 17, 2008 at 1:25 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Michael Kerrisk venit, vidit, dixit 17.09.2008 00:05:
>> Hello,
>>
>> I'm currently trying to import an svn repository, along with its tags,
>> into git, and everything seems okay except that after the import I
>> expect to have the following structure to my checked out repository:
>>
>>     [root-dir]
>>         .git
>>         <checked-out-files>
>>
>> But instead I end up with
>>
>>     [root-dir]
>>         .git
>>         man-pages               <-- name of my svn project
>>             <checked-out-files>
>>
>> I've tried out a few different command-line flag settings but so far I
>> haven't managed to get the desired layout.  I guess that I'm missing
>> something trivial, but I haven't worked out what it is so far.
>>
>> The commands I'm using to do the import are:
>>
>> $ git svn init file:///home/mtk/man-pages-rep/ -t tags -T trunk -b branches
>> $ git svn fetch
>>
>> The svn tags are getting imported okay, since:
>>
>> git branch -a | head
>>   tags/man-pages-2.00
>>   tags/man-pages-2.01
>>   ...
>>   tags/man-pages-3.08
>>   tags/man-pages-3.09
>>   trunk
>>
>> The following commands show the layout of my svn repo, which is pretty
>> much standard:
>>
>> $ svn list file:///home/mtk/man-pages-rep
>> branches/
>> tags/
>> trunk/
>> $ svn list file:///home/mtk/man-pages-rep/trunk
>> man-pages/
>
> That's the part that says that your layout is non-standard. What do your
>  branches and tags look like? Do they have that superfluous "man-pages"
> part as well?

$ svn list file:///home/mtk/man-pages-rep/tags
man-pages-2.00
man-pages-2.01
man-pages-2.02
man-pages-2.03
...
$ svn list file:///home/mtk/man-pages-rep/tags/man-pages-2.00
man-pages
$ svn list file:///home/mtk/man-pages-rep/tags/man-pages-2.01
man-pages
[and so on]
$ svn list file:///home/mtk/man-pages-rep/branches
$
(i.e., no branches, since this has been a linear svn repo.)

>> $ svn list file:///home/mtk/man-pages-rep/trunk/man-pages
>> Changes
>> Changes.old
>> Makefile
>> README
>> man-pages-3.09.Announce
>> ...
>> man7/
>> man8/
>> scripts/
>> $ svn list file:///home/mtk/man-pages-rep/tags
>> man-pages-2.00/
>> man-pages-2.01/
>> ...
>> man-pages-3.08/
>> man-pages-3.09/
>>
>> What 'git svn init' command do I need to get the layout that I want
>> for my imported git repo?
>
> It depends on the structure of your branches and tags. My guess would be
> that you have something like tags/man-pages-2.00/man-pages/ etc., in
> which case you would need a special configuration if you want to get rid
> of the "man-pages" part. Tells us your structure, we'll tell you the
> config ;)

Do you now have enough info above?

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
man-pages online: http://www.kernel.org/doc/man-pages/online_pages.html
Found a bug? http://www.kernel.org/doc/man-pages/reporting_bugs.html
