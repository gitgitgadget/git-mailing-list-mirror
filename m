From: Hakim Cassimally <hakim.cassimally@gmail.com>
Subject: Re: git-cherry-pick problem - directory not touched by commit is 
	marked "added by us"
Date: Fri, 8 Jan 2010 22:29:12 +0000
Message-ID: <82cfa8031001081429i58496c8y1775deadc11ab4be@mail.gmail.com>
References: <82cfa8031001050433r6d705222qf905c929ad6395c4@mail.gmail.com>
	 <1262727434.22597.8.camel@denix>
	 <82cfa8031001060328r21aa8de3s5c2dd5dac005b679@mail.gmail.com>
	 <7v4omyfv6h.fsf@alter.siamese.dyndns.org>
	 <7vzl4qegdm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sam Vilain <sam@vilain.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 08 23:29:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTNKe-0006RB-NV
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jan 2010 23:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754244Ab0AHW3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 17:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754219Ab0AHW3P
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 17:29:15 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:51401 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218Ab0AHW3O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2010 17:29:14 -0500
Received: by ey-out-2122.google.com with SMTP id 4so238716eyf.5
        for <git@vger.kernel.org>; Fri, 08 Jan 2010 14:29:12 -0800 (PST)
Received: by 10.216.86.193 with SMTP id w43mr4167615wee.17.1262989752335; Fri, 
	08 Jan 2010 14:29:12 -0800 (PST)
In-Reply-To: <7vzl4qegdm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136483>

(woops, sent just to Junio, resending to list)

Hi,

Thanks for the suggestions, I've tried both those commands, and they
break too :-(

2010/1/7 Junio C Hamano <gitster@pobox.com>:
> Junio C Hamano <gitster@pobox.com> writes:
>> What "cherry-pick" internally does is to run:
>>
>>     git merge-recursive 301a^ -- HEAD 301a
>>
>> That is, "We are at HEAD; consolidate the change since 301a^ to 301a into
>> our state, and leave the result in the index and the work tree".  Then it
>> commits the result.  One thing to try is to see if this gives the same
>> kind of breakage.

    $ git merge-recursive 301a^ -- HEAD 301a
    # woo! no response!  promising
    $ git status
# On branch cgi_branch
<snip>
#       new file:   bin/upload_module.pl
#
# Unmerged paths:
#       added by us:        www/client/css/admin-clean.css
#       added by us:        www/client/css/admin.css
<snip dozens of spurious "added by us">

> There actually is another possibility; we used to run inside "cherry-pick"
>
>    git merge-resolve 301a^ -- HEAD 301a
>
> instead.  The request is the same but it uses a different algorithm, so if
> one fails and one succeeds, that might give us a better clue to figure out
> what is going on.

  $ git merge-resolve 301a^ -- HEAD 301a
  Trying simple merge.
  Simple merge failed, trying Automatic merge.
  error: www/client: is a directory - add individual files instead
  fatal: Unable to process path www/client
  error: www/css: is a directory - add individual files instead
  fatal: Unable to process path www/css
  error: www/images: is a directory - add individual files instead
  fatal: Unable to process path www/images
  error: www/js: is a directory - add individual files instead
  fatal: Unable to process path www/js
  fatal: merge program failed

At least the latter fails more informatively?

Thanks again for the help and suggestions ;-)

osfameron
