From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Add -k kill keyword expansion option to git-cvsimport
Date: Mon, 15 Aug 2005 19:37:19 +1200
Message-ID: <46a038f90508150037f128d6@mail.gmail.com>
References: <46a038f9050814235140877be7@mail.gmail.com>
	 <7vk6in65dp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 09:39:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4ZYa-0005Ax-AK
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 09:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbVHOHh1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 03:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbVHOHh1
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 03:37:27 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:4233 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932140AbVHOHh1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 03:37:27 -0400
Received: by rproxy.gmail.com with SMTP id i8so741093rne
        for <git@vger.kernel.org>; Mon, 15 Aug 2005 00:37:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L9uVxzC6i/Kj8u1GWInuMQZNy3P1lduuIXgTvMmRhZcqGfgCTJxhsuxJ8h/CZxnbF5LDL1aBYM7IuighFW1sKTMGbbBmoEKlagRb9XcZrmXJcEXKLTde6QBIc8CZBjHK51tCqb5iyNwOZUPnJvZ2pQdaNeW0sLSUY3aIWU3O/Vc=
Received: by 10.38.104.22 with SMTP id b22mr1866206rnc;
        Mon, 15 Aug 2005 00:37:19 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Mon, 15 Aug 2005 00:37:19 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6in65dp.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 8/15/05, Junio C Hamano <junkio@cox.net> wrote:
> The discussion between you and Linus since you brought this up
> has kept me wondering if -ko is the only thing people may want
> to do, or sometimes -kk or even -kb or -kv make sense for some

The git-cvsimport script requests the full file at a given revision
straight from the cvs server daemon it has instantiated. So I suspect
we are mixing up cvs client flags with protocol flags. Hmm, reading up
on it  ( http://www.elegosoft.com/cvs/cvsclient.html#SEC9 ) the flags
are carried through, and it sounds like it's pretty broken.

Still, it clearly leaves handling of newlines to the client. The
difference between -kb and -ko (we are using -ko ATM) is the newline
handling if you are using standard cvs clients. With git-cvsimport, we
are doing the unix thing, which happens to be right thing to do.

Perhaps repos created with early versions of CVSNT are broken in this
regard, but tough.

I think -kv is just the wrong thing to do if you are migrating to git.
Anyway, this script has so far followed cvs's own default... which is
-kv, and I am generally unwilling to break backwards compatibility.
Though we could make it default to 'on' and provide '-K' for those
masochistic enough to want it.

People with repos where cvswrappers was set to mark files as -kb or
-ko are safe from all this pain and tears.

cheers,


martin
