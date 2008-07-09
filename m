From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: git over rsync+ssh
Date: Wed, 9 Jul 2008 16:02:00 +0100
Message-ID: <e2b179460807090802j2dbb72efo4f03c0a9e79241c0@mail.gmail.com>
References: <g52gbg$si9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Michael J Gruber" <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Wed Jul 09 17:03:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGbCj-0005ZO-KN
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 17:03:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757899AbYGIPCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 11:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757894AbYGIPCE
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 11:02:04 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:26357 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757859AbYGIPCB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 11:02:01 -0400
Received: by py-out-1112.google.com with SMTP id p76so1529282pyb.10
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 08:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=uVVtU2fZzj7NCUKuI4ZCSh2fzr5Mv8FpebzOOp7TW1o=;
        b=KaZb+gBGESFWXozfwCvbUT7xLCyky9BlmLMPnQSyobYTEJrur/ayqRV7KzSSp33ewf
         KuJtZDO3FcUQorb5SG6kV2eJnyTeY2WqBa1qe5lzz/XnRir7tjpFomlAEwGJ1sDwIF/U
         qZc8ylVe0OYcDwUj1Kk7/Idyv8jMeXLZJrcjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=T7Hzl9qF/5U4yiAneK/LWChy6WrPr+S+TOK0FnakIWjLR9Ih9jCBGEVAloWoJ793Eh
         be4tis/vYBYHoEKat93zbweKeoU9tX9fWkQgbrTvvTXwsIJAX189VOv/YLQY1uUERRFl
         rMBRHlgdHqL7L+cVAHFbp8gNG8JszcWXpqQX8=
Received: by 10.141.198.9 with SMTP id a9mr4038154rvq.108.1215615720386;
        Wed, 09 Jul 2008 08:02:00 -0700 (PDT)
Received: by 10.141.19.11 with HTTP; Wed, 9 Jul 2008 08:02:00 -0700 (PDT)
In-Reply-To: <g52gbg$si9$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87886>

2008/7/9 Michael J Gruber <michaeljgruber+gmane@fastmail.fm>:
> I want to put a git repo on a server where I have ssh access but failed to
> compile git (AIX 5.1, has libz.a but no .so nor headers; compiling
> prerequisite zlib failed, probably due to a botched build environment).

I can send you a binary to try if you'd like. It would be compiled on
AIX 5.3 but I have to jump through hoops on several non-identically
set-up servers here, so one might work for you.

# ldd /usr/local/bin/git
/usr/local/bin/git needs:
         /usr/lib/libc.a(shr.o)
         /usr/lib/libz.a(libz.so.1)
         /usr/lib/libiconv.a(shr4.o)
         /unix
         /usr/lib/libcrypt.a(shr.o)

# ar -t /usr/lib/libz.a
libz.so.1
shr.o

Alternatively I can send you what gets installed from zlib-devel.rpm
[1] which you might be able to install in your account's home
directory, and then ./configure --with-zlib=PATH ; gmake might work
for you.

> As far as I can see my only option for a private repo is using rsync over
> ssh.
>
> ... [snipped the bits I know not]
>
> Alternatively, can I maybe compile the bits that git over ssh needs on the
> server side without zlib?

I don't think any git is going to get very far without zlib, as it
won't understand (be able to verify) the object/pack format at all. I
might be wrong about that though.

Mike

[1] ftp://ftp.software.ibm.com/aix/freeSoftware/aixtoolbox/RPMS/ppc/zlib/zlib-1.2.3-4.aix5.2.ppc.rpm
