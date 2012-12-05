From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git-svn with non-standard repository layout
Date: Wed, 5 Dec 2012 23:19:44 +0100
Message-ID: <CAA01CsoS6xA-tGPw81tYmi1ETU8sQ08+oyHGg5ou1VGYrwd_SQ@mail.gmail.com>
References: <CAA01Csoam7pXqPKnjvJB46T_sdjcW2S1oXdQT3HbUdfN4TK0kw@mail.gmail.com>
	<1056577717.281976.1354725880396.JavaMail.root@genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>,
	Carsten Fuchs <carsten.fuchs@cafu.de>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 23:20:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgNJy-0000il-4m
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 23:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753772Ab2LEWTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 17:19:46 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:39290 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291Ab2LEWTp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Dec 2012 17:19:45 -0500
Received: by mail-qa0-f53.google.com with SMTP id a19so1662qad.19
        for <git@vger.kernel.org>; Wed, 05 Dec 2012 14:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=X3jYjD3SLADUhIaHZAPxtYkdQcd4lGSk4ayHaZCcw1c=;
        b=oGin3g88VPI2H1N1xP0EpzG/RgKe4YvdJUEQaDopoV4LPIqlyj6GieLwS9UTsjvOFQ
         P6bC8HM4o1tDienHBlrXpn8PvaqqyGHblt9Mz5EVxRoHkh6sAxmjGdMSXgYziWav/4ep
         Xg/X63g1F3yjdrvkxvil8sZfEj/BEMRi4TJFgMpIJJgg1wv2LaLKBjOhiPTt7D0EmxEt
         MLDyWdhQYIHchX4c5T5cc/xlgWhlii6hBrLXiXiXzDqC63Tn8sU9uT18O3rhWjjNRymT
         Gi+SYMIlajB79np6pQ8luAEmoOAXRfNMshkybDUDrQikK+ODJZfmL+QfsydOti1LgBn5
         EcKA==
Received: by 10.229.174.226 with SMTP id u34mr7358974qcz.26.1354745984747;
 Wed, 05 Dec 2012 14:19:44 -0800 (PST)
Received: by 10.49.26.132 with HTTP; Wed, 5 Dec 2012 14:19:44 -0800 (PST)
In-Reply-To: <1056577717.281976.1354725880396.JavaMail.root@genarts.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211142>

On Wed, Dec 5, 2012 at 5:44 PM, Stephen Bash <bash@genarts.com> wrote:
> ----- Original Message -----
>> From: "Piotr Krukowiecki" <piotr.krukowiecki@gmail.com>
>> Sent: Wednesday, December 5, 2012 11:26:54 AM
>> Subject: Re: git-svn with non-standard repository layout
>>
>> On Tue, Dec 4, 2012 at 10:19 PM, Carsten Fuchs
>> <carsten.fuchs@cafu.de> wrote:
>> > Hi Piotr,
>> >
>> > Am 2012-12-04 18:29, schrieb Piotr Krukowiecki:
>> >
>> >> Is there a way to handle svn repository with following layout?
>> >>
>> >> repo/trunk
>> >> repo/branches/branch1
>> >> repo/branches/branch2
>> >> repo/branches/work/developer1/branch3
>> >> repo/branches/work/developer1/branch4
>> >> repo/branches/work/developer2/branch5
>> >
>> > see my post at
>> >     http://www.cafu.de/forum/viewtopic.php?f=14&t=1092
>> > heading "Branches outside branches/".
>> >
>> > You may need something like
>> >     git config --add svn-remote.svn.fetch
>> > "path.../branchX:refs/remotes/branchX"
>> > for each of your branches.
>>
>> that works :)
>>
>> Although not an ideal solution - I have to manually configure all
>> branches + update them as they are created
>
> It's not a 100% solution, but you can use a limited glob-like syntax in the branches and tags lines of the svn-remote config block.  You still need to do some manual work (one entry for each developer), but the wildcards eliminate a lot of the grunt work as individual branches are created.  See the very end of the git-svn manpage for examples (section titled CONFIGURATION).  I use that technique to track a subdirectory of the Slimdevices SVN repo [1], which has a similarly complex layout:
>
> repo/7.1/trunk
> repo/7.1/branches/branchA
> repo/7.1/branches/branchB
> repo/7.1/tags/tag1
> repo/7.2/trunk
> repo/7.2/branches/branchC

Do you mean something like

   branches = branches/work/*/*:refs/remotes/work/*
   branches = branches/{branch1,branch2}:refs/remotes/branches/*

instead of (currently used)

   branches = branches/work/*/*:refs/remotes/work/*
   fetch = branches/branch1:refs/remotes/branches/branch1
   fetch = branches/branch2:refs/remotes/branches/branch2

I will try that tomorrow.

BTW what's the difference between "fetch" and "branches" keys? I could
only find one: "fetch" does not support glob arguments and "branches"
do.

--
Piotr Krukowiecki
