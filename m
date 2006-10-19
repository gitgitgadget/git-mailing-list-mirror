From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Don't segfault if the given SHA1 name is longer than 40 characters
Date: Thu, 19 Oct 2006 11:54:39 +0700
Message-ID: <fcaeb9bf0610182154l55de75d1w4a99db608f7f6477@mail.gmail.com>
References: <20061019013441.GB9379@localhost>
	 <7vwt6xvt7q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 06:54:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaPvi-0001kt-IY
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 06:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422794AbWJSEyn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 00:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422774AbWJSEyn
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 00:54:43 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:47826 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1030304AbWJSEym (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 00:54:42 -0400
Received: by wx-out-0506.google.com with SMTP id h28so500577wxd
        for <git@vger.kernel.org>; Wed, 18 Oct 2006 21:54:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oqjNCRV3ku49dbZnwf6go1FHWpFP1RYEtSQ11nWCnZ5d5/pZwcbv7guvcDwDko2xWdRAkxytC56eVDOV6trSvP20xuZzJ88wqIxQpB++YvB4Q7RsKqO2JorvUN47RxqiJTI2pJj2SqOJggi/ttM9qB/t906uNfnSMNIRP6r9nrI=
Received: by 10.70.87.9 with SMTP id k9mr17554221wxb;
        Wed, 18 Oct 2006 21:54:39 -0700 (PDT)
Received: by 10.70.46.13 with HTTP; Wed, 18 Oct 2006 21:54:39 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vwt6xvt7q.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29320>

On 10/19/06, Junio C Hamano <junkio@cox.net> wrote:
> The patch is correct, but it needs a better explanation in the
> proposed commit log message than just "Don't segfault".

Well, maybe because I got a segfault when I accidentally pasted an
sha1 twice (blame my mouse). I hadn't looked closely enough to the
bug. Anyway, you got the bug and obviously have a better explanation
than mine. Please fix it with a better explanation. I'll be more
explanatory next time. Thank you :-)

> get_describe_name() can be fed a string foo-gXXX...XXX with a
> very looooooooong hexstring.  It calls get_short_sha1() without
> checking if XXX...XXX part is longer than 40-bytes (in which
> case it cannot be a valid object name).
>
> get_sha1_1() has the same problem.  Given a hexstring longer
> than 40-bytes, it calls the function with it because earlier
> ones such as get_sha1_hex() would reject the input.
-- 
Duy
