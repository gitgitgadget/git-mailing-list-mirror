From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: About *git clone --depth=n* puzzle
Date: Thu, 15 Aug 2013 09:08:38 +0700
Message-ID: <CACsJy8DDf64M1qruUNH7M=eB=1cJpYuYXLEkpPUPfrREeSLEew@mail.gmail.com>
References: <BAY169-W472B90AB796C71E8D0D038B4450@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"junchunx.guan@gmail.com" <junchunx.guan@gmail.com>
To: XinLingchao <douglarek@outlook.com>
X-From: git-owner@vger.kernel.org Thu Aug 15 04:09:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9mzz-0001l0-F6
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 04:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760069Ab3HOCJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 22:09:10 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:48809 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759979Ab3HOCJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 22:09:09 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so240531obc.34
        for <git@vger.kernel.org>; Wed, 14 Aug 2013 19:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vjeM1PbqamvFzbek9kOA5YG25PeqiT2eeIrzUnfMqbE=;
        b=fMYS6HxikVin2MTM8J339qOHYsd3rL93klkPyI1qE+Y6KzIKpZ8d9DY2g0Rw1734Un
         rgqDEsrY6CQBQx3jixIMKMaiYVJ5DXVlR23XTHEwzzWi1D8CNxNmwf4LoPo5Apnpne0w
         WdHbNdUA9+JK3CV1atSyli8+aQ/2ZdH1agILDQVmJEn2fBsQw+l8eS+AZ0xZWyPGr/0X
         18eTwaPuKzuRLSe9iULbEaHBPqyFcq3ngoBQQ49dEuu3GweyC3pB2qSL5smu6kF75wKd
         NLbO9UBT3f5JiI9iR0F9BvqDkMamAq2dNyPKAepI/mLWWldMQyOhAg6+fel4PkGYcsQ9
         PFvA==
X-Received: by 10.60.93.67 with SMTP id cs3mr12113166oeb.12.1376532548720;
 Wed, 14 Aug 2013 19:09:08 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Wed, 14 Aug 2013 19:08:38 -0700 (PDT)
In-Reply-To: <BAY169-W472B90AB796C71E8D0D038B4450@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232325>

On Wed, Aug 14, 2013 at 3:20 PM, XinLingchao <douglarek@outlook.com> wrote:
> Hi Guys,
>
> I think I have got some trouble when I use `git clone --depth=n` command. Take a real repo for example:
>
>
> `git clone https://github.com/douglarek/vimrc.git --depth=1`
>
>
> then I use `git log`:
>
> ```
>     commit d04ca09ecc723739123fae11ad56784eb0c9b36a
>     Author: Lingchao Xin <douglarek@outlook.com>
>     Date:   Fri Jun 7 09:39:22 2013 +0800
>
>         Update vnudle to master branch, add wm shortcut, pylint optimization
>
>     commit c66d827dc212f6ae8aab6b5c44631564bcbe2acd
>     Author: icocoa <lingchax@outlook.com>
>     Date:   Tue Mar 12 01:36:34 2013 -0700
>
>         Merge pull request #1 from douglarek/master
>
>         Add markdown, flake8, pylint plugin
>
> ```
>     but when I clone it with `file://`:
>
>     git clone https://github.com/douglarek/vimrc.git
>     git clone file://vimrc.git --depth=1 vimrc1
>
>     I got this log:
> ```
>     commit d04ca09ecc723739123fae11ad56784eb0c9b36a
> Author: Lingchao Xin <douglarek@outlook.com>
> Date:   Fri Jun 7 09:39:22 2013 +0800
>
>     Update vnudle to master branch, add wm shortcut, pylint optimization
> ```
>
> so the two results are not same, is it a bug? or it should be so?
>
> My os is openSUSE 12.3 and git version 1.8.3.4; and myabe it occured in git 1.8.1.4 +.

The fix is at the server side. >=1.8.2 corrects --depth, which is what
you use for file://. github is still on 1.8.1.6, which does not have
that fix. Oh and the commit is 682c7d2 (upload-pack: fix off-by-one
depth calculation in shallow clone - 2013-01-11)
-- 
Duy
