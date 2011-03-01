From: Chad Joan <chadjoan@gmail.com>
Subject: Re: Git changes permissions on directories when deleting files.
Date: Tue, 1 Mar 2011 14:35:41 -0500
Message-ID: <AANLkTimBrUo_O6sjhSEf2sPKrYhjMcr24hwRe0kH4CgO@mail.gmail.com>
References: <AANLkTikJcOgBAZS=cCWULFYz4U_Mxx1gFMg51+r9qDo0@mail.gmail.com>
 <AANLkTinCjaGMe3TnheqORe7Y_qWYTAr3p6UEsK3u4VyE@mail.gmail.com>
 <AANLkTikFMg_yLWmanqyHveDMR==bw8kxjZgr4mSOmY-2@mail.gmail.com>
 <AANLkTimw+TLYv3ANf_Gx6G3SaLwRnRf6PF1YUv86rC5J@mail.gmail.com> <AANLkTimx7s94wjPasgdY7O9eoyzXXmhWm6f+CB0_2sv3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Computer Druid <computerdruid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 20:36:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuVMi-0007ux-8H
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 20:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757177Ab1CATgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 14:36:06 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46792 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756962Ab1CATgD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 14:36:03 -0500
Received: by vxi39 with SMTP id 39so4503695vxi.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 11:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=iDRGR/bMmlpSCnRXBN+WpGOhOF0mf8Z57Zp40eYsnnE=;
        b=KxgptYvPaxgs1jmkzwMcrpWxOQvdX8IGegvXxSYxhvN74q0aVt3wQhMt7d4Xsr36GK
         wk2irvV/n3Z1S/FwsSpqFq0a3ZgON4bGKpDSsIOjcE3dD5pnyaIIqJ1HOM9yZb5KZDfO
         EHhHT8TUWJcoQmAeuvotyRDypRhZVwJHOnQKY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Z2X4gVnoivNYpl1UgU6yMI6uPcMjCeI1RcgQU5ycq0wY6ktzAOjAV2SR593d4Iapt/
         yNTCMl+LNu5rcdII+hPxBSnL0tuOvRC9durdGHOphqPqg5pzTCpZynpkDrj1RLa8QvGP
         0fVEsNkh0Oiok/RCKd7Gn3seZRzJcUk0buo5Q=
Received: by 10.220.195.195 with SMTP id ed3mr1695846vcb.180.1299008161084;
 Tue, 01 Mar 2011 11:36:01 -0800 (PST)
Received: by 10.220.94.136 with HTTP; Tue, 1 Mar 2011 11:35:41 -0800 (PST)
In-Reply-To: <AANLkTimx7s94wjPasgdY7O9eoyzXXmhWm6f+CB0_2sv3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168242>

On Tue, Mar 1, 2011 at 12:11 PM, Computer Druid <computerdruid@gmail.com> wrote:
> On Tue, Mar 1, 2011 at 10:51 AM, Chad Joan <chadjoan@gmail.com> wrote:
>> More info:
>>
>> $ mkdir foo
>> $ mkdir foo/bar
>> $ echo "test" > foo/bar/baz.txt
>> $ echo "somestuff" > foo/bar/somefile.txt
> What happens if you "rmdir foo/bar" here? (while there are files still in it)
>
> -Dan Johnson
>

Something fairly interesting:

$ mkdir foo
$ mkdir foo/bar
$ ls -dl foo/bar
drwxr-x--x 1 cjoan cjoan 0 Mar  1 14:31 foo/bar
$ ls -dl foo
drwxr-x--x 1 cjoan cjoan 0 Mar  1 14:31 foo
$ echo "test" > foo/bar/baz.txt
$ echo "somestuff" > foo/bar/somefile.txt
$ ls -dl foo/bar
drwxr-x--x 1 cjoan cjoan 0 Mar  1 14:31 foo/bar
$ ls -dl foo
drwxr-x--x 1 cjoan cjoan 0 Mar  1 14:31 foo
$ rmdir foo/bar
rmdir: failed to remove `foo/bar': Directory not empty
$ ls -dl foo/bar
drw------- 1 cjoan cjoan 0 Mar  1 14:32 foo/bar
$ ls -dl foo
drwxr-x--x 1 cjoan cjoan 0 Mar  1 14:31 foo


The rmdir fails of course, but it also changes the permissions.
So I take it that git always runs an rmdir on the parent directory
when it removes a file?  Seems like it would be a sensible way to do
it on a system without this behavior.

- Chad
