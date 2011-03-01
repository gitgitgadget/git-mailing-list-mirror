From: Chad Joan <chadjoan@gmail.com>
Subject: Re: Git changes permissions on directories when deleting files.
Date: Mon, 28 Feb 2011 23:00:26 -0500
Message-ID: <AANLkTikFMg_yLWmanqyHveDMR==bw8kxjZgr4mSOmY-2@mail.gmail.com>
References: <AANLkTikJcOgBAZS=cCWULFYz4U_Mxx1gFMg51+r9qDo0@mail.gmail.com> <AANLkTinCjaGMe3TnheqORe7Y_qWYTAr3p6UEsK3u4VyE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Computer Druid <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 05:01:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuGlY-00048O-EX
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 05:00:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396Ab1CAEAr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 23:00:47 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47987 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004Ab1CAEAr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 23:00:47 -0500
Received: by vws12 with SMTP id 12so3813447vws.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 20:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=A8HBbIhL5X/raO6SFBSex7rsFx0DPFFDY9V14eJsSlU=;
        b=eP4MwR/wDtobqNLkIGYMM0uWyl9ZZekgQxE5IzS7RpSnclAfcFNuPrR4tSTJZvbqED
         2YNjivvuFu1TQdAeok+VbmA0ypeyBH+SqBMLP7MHHLpMu6IisUoYjQ7u0RT65umKH6Yq
         tHD2m9pVuoFmONfXN5b0sECI4bHB6CJhvXtAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=bRFgU7iBD+nGYboJHDsHxXvZhWdOzhsfhRi1UGi0w3HUwXQtsXYZ0nMaQaweJ2AZPO
         78tn2cn+AX6xpBgvEBUeSq9W9V+TiVJWQBjq8/CH21uTTXm6mcOsCGo80BLuEtfq0Gsk
         BN11KV6F6toDvo/BpO/9rKiUL5EVq4xmS3sx8=
Received: by 10.52.68.65 with SMTP id u1mr3497086vdt.176.1298952046136; Mon,
 28 Feb 2011 20:00:46 -0800 (PST)
Received: by 10.220.94.136 with HTTP; Mon, 28 Feb 2011 20:00:26 -0800 (PST)
In-Reply-To: <AANLkTinCjaGMe3TnheqORe7Y_qWYTAr3p6UEsK3u4VyE@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168184>

On Mon, Feb 28, 2011 at 9:19 PM, Computer Druid <computerdruid@gmail.com> wrote:
> On Mon, Feb 28, 2011 at 8:42 PM, Chad Joan <chadjoan@gmail.com> wrote:
>> Hello,
>>
>> What I'm experiencing is this:
>>
>> $ cd ~/project
>> $ ls -dl somedir
>> drwxrwx--- 1 cjoan cjoan 0 Feb 28 19:57 somedir
>> $ echo "some text" > somedir/somefile.txt
>> $ git add somedir/somefile.txt
>> $ git rm -f somedir/somefile.txt
>> rm 'somedir/somefile.txt'
>> $ ls -dl somedir
>> drw------- 1 cjoan cjoan 0 Feb 28 19:57 somedir
>> $ echo "some text" > somedir/somefile.txt
>> bash: somedir/somefile.txt: Permission denied
>
> After you remove the file, is "somedir" empty?
>

Nope.

> Git doesn't track empty directories, and therefore git rm on the last
> file in a directory deletes it:
>
> % git init
> Initialized empty Git repository in /home/cdruid/testrepo/.git/
> % mkdir dir
> % ls -l
> total 4
> drwxr-xr-x 2 cdruid cdruid 4096 Feb 28 21:14 dir
> % touch dir/test.txt
> % git add dir/test.txt
> % git rm -f dir/test.txt
> rm 'dir/test.txt'
> % ls -l
> total 0
>
> My guess is git is somehow failing to delete the directory, thus
> causing your changed permissions issue.
>
> -Dan Johnson
>

'somedir' still has plenty of files in it after the deletion, so I'm
afraid this isn't the case.

- Chad
