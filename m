From: Pierre Penninckx <ibizapeanut@gmail.com>
Subject: Re: [PATCH] subtree: add squash handling for split and push
Date: Thu, 28 Nov 2013 23:58:23 +0100
Message-ID: <1B2468D5-F0B7-4D11-8710-A3A7C8D66215@gmail.com>
References: <C3EF61D4-5274-4A10-9594-4E631D75C3F4@gmail.com> <20131128182309.GA3655@comcast.net>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, greened@obbligato.org, amdmi3@amdmi3.ru,
	john@keeping.me.uk, git@cryptocrack.de, techlivezheng@gmail.com,
	apenwarr@gmail.com, cstanfield@antifusion.net,
	jakub.suder@gmail.com, jesse.greenwald@gmail.com,
	pelle@kodfabrik.se, treese@acm.org, wayne@tickzoom.com
To: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
X-From: git-owner@vger.kernel.org Thu Nov 28 23:58:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmAXY-0006AB-Qf
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 23:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210Ab3K1W63 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Nov 2013 17:58:29 -0500
Received: from mail-wg0-f53.google.com ([74.125.82.53]:43773 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab3K1W62 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Nov 2013 17:58:28 -0500
Received: by mail-wg0-f53.google.com with SMTP id k14so6223358wgh.32
        for <git@vger.kernel.org>; Thu, 28 Nov 2013 14:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=E4Q2zoiuitDYWKOSyyijm50v19HbZYdODxGLgla8hsQ=;
        b=VgkqV2eyXjELq6NbbjsiOjKtGOukNp/CWOKf+kA4G8KKoYnWKwyG9luRZ4AYkDWr65
         OE3dKP3ovGd8xzYjfejTaFQrYqbvlPLeg+Yyw3QlO46PdD8vbWRntRrgALn+GdrBFMNr
         OqJyqXXO0WkwTe7GCMSoKfzNkQ8Dql78TYgqjo21KtJtYz4uhRZYg/JFi0JoHk6ACVe0
         B4/aKHKmStJHsTwvF3hhj3TBvY5sxs+EmX1mJQ6QkM5KrYnXrumO/BdjqkQ7gEYlJlBQ
         feKgqqlhpZBcVylB/+xed6opO8iG0ZbzADHtr/8bfs/9J5nKWoEm5+Ij0XzJnR9XiZ2f
         Gncg==
X-Received: by 10.194.104.42 with SMTP id gb10mr38675839wjb.16.1385679506966;
        Thu, 28 Nov 2013 14:58:26 -0800 (PST)
Received: from [10.118.12.101] ([109.128.254.82])
        by mx.google.com with ESMTPSA id a19sm85989118wib.1.2013.11.28.14.58.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 28 Nov 2013 14:58:25 -0800 (PST)
In-Reply-To: <20131128182309.GA3655@comcast.net>
X-Mailer: Apple Mail (2.1822)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238519>

Hi Matthew,

> Clarification: The current documentation (correctly) doesn't
> actually claim to support "split --squash", but it does erroneously
> claim to support "push --squash =BB.

Yes indeed. ;)

> It looks like your patch is basically squashing the new subtree commi=
ts
> together, throwing out those commits completely, and only keeping
> the squashed commit in the split =97branch.

Exactly.

> 3. (new/better) Use "split --rejoin --squash" (or some other
>   invocation to be defined).  The subtree branch is generated
>   exactly like normal, including fine-grained history.  But
>   instead of merging the subtree branch directly, --rejoin
>   will squash all the changes to that branch, and merge in
>   just the squash (referencing the unsquashed split
>   branch tip in the commit message, but not the
>   parent).  Subsequent splits can run very fast, while the
>   "--rejoin" only generated two commits instead of the=20
>   potentially thousands of (mostly) duplicates it would pull
>   in without the "--squash =BB.

Isn=92t this similar to "my" way? I mean I too generate the fine-graine=
d history and make a squash afterwards, no?
I also don=92t get why would your solution generate any duplicates. Wou=
ld mine generate some?
I suppose the two answers are linked.

> I have this third option half-coded already, but I still need
> to finish it.

I=92m eager to test it!

> Does anyone have any suggestions about the UI?  Do we need to also
> support Pierre Penninckx's "split --squash" semantics somehow?  If
> so, what command line options would allow for distinguishing the
> two cases?

Maybe `split --rejoin-squash` since it=92s really a third way?
I intended to use `push --squash` to send a squash of the commits to hi=
de the actual tinkering. So if your way allows to do it, I vote to stic=
k with yours.

Regards,
Pierre Penninckx