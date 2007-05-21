From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Teach 'git-apply --whitespace=strip' to remove empty lines at the end of file
Date: Mon, 21 May 2007 13:23:59 +0200
Message-ID: <e5bfff550705210423i34dc481es61d3b886ae77c5f7@mail.gmail.com>
References: <e5bfff550705200251j3dd9b377je7ae5bafac988060@mail.gmail.com>
	 <7vabvzq0bb.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550705200334pef694cn1a7842c23e2672f5@mail.gmail.com>
	 <7vabvzoij8.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550705200545kcf1f7f9n4f3f6d7d25955e1@mail.gmail.com>
	 <7v1whbmjel.fsf@assigned-by-dhcp.cox.net>
	 <7vmyzyhdfh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 21 13:24:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq5zj-0007X2-M1
	for gcvg-git@gmane.org; Mon, 21 May 2007 13:24:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755326AbXEULYB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 07:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754970AbXEULYB
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 07:24:01 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:4336 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755326AbXEULYA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 07:24:00 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1347746wra
        for <git@vger.kernel.org>; Mon, 21 May 2007 04:23:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AMPsY4uxajYfNu4juBoHeTnw8u19jIauAfCUavv3C73sy1lRsJVKQclBgplHnZV20gPvzkkjfHW0KR70zwoKjMZGpMUKXAbO/19cJNp8DvrJlPxmtJOQFaIAjWZoFf1dvmet07Bnd18vv+Qelq4B1YtMwqi51mEn8OxzUpVkheY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Udl87GWcdMq8AiITvEBPZUKuSxlJMXI4Px2GZiSpoj84foFObG+pUjzh/9/8RqwgZLpzC6l/+PiyebuQ+zFOWsCvUAZ6Xj5d235iKSY3MTpOxjWtCAPSiWYZtiYQkVCR0mKQe4/IivdcQVQXY0eoebgNsuFzaDaTUFVc8ujulDw=
Received: by 10.114.131.2 with SMTP id e2mr2605976wad.1179746639229;
        Mon, 21 May 2007 04:23:59 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Mon, 21 May 2007 04:23:59 -0700 (PDT)
In-Reply-To: <7vmyzyhdfh.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48008>

On 5/21/07, Junio C Hamano <junkio@cox.net> wrote:
> Junio C Hamano <junkio@cox.net> writes:
>
>
> We somehow end up removing one LF too many, like this:
>
>     diff --git a/contrib/emacs/.gitignore b/contrib/emacs/.gitignore
>     index c531d98..016d3b1 100644
>     --- a/contrib/emacs/.gitignore
>     +++ b/contrib/emacs/.gitignore
>     @@ -1 +1 @@
>     -*.elc
>     +*.elc
>     \ No newline at end of file
>

I also had that, but after adding

+
+               if (empty < trailing_added_lines)
+                       empty--;
+

everything worked correctly. I made again the same test myself without problems.

I really don't understand how could be broken.


For me it's OK if you don't like my patch, but I would really
understand why that very strange error.

Thanks
 Marco
