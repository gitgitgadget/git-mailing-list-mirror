From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Handling merge conflicts a bit more gracefully..
Date: Sat, 18 Jun 2005 10:15:22 +1000
Organization: Core
Message-ID: <E1DjQza-0001wP-00@gondolin.me.apana.org.au>
References: <Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org>
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 18 02:11:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjQvS-0003ub-UZ
	for gcvg-git@gmane.org; Sat, 18 Jun 2005 02:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVFRAQD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Jun 2005 20:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVFRAQD
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jun 2005 20:16:03 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:59912 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261433AbVFRAPo
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2005 20:15:44 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] ident=mail)
	by arnor.apana.org.au with esmtp (Exim 3.35 #1 (Debian))
	id 1DjQzd-0001oA-00; Sat, 18 Jun 2005 10:15:25 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1DjQza-0001wP-00; Sat, 18 Jun 2005 10:15:22 +1000
To: torvalds@osdl.org (Linus Torvalds)
In-Reply-To: <Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org>
X-Newsgroups: apana.lists.os.linux.git
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> 
>>  # Modified in both, but differently.
>> +     merge -p "$src1" "$orig" "$src2" > "$4"
>> 
>> Again, make sure "$4" is not a directory before redirecting into
>> it from merge, so that you can tell merge failures from it?
> 
> Hmm.. What's the cleanest way to check for redirection errors, but still
> be able to distinguish those cleanly from "merge" itself returning an
> error?

I don't know whether this is the cleanest, but this is one way:

redir=failed
{
	redir=ok
	merge -p "$src1" "$orig" "$src2"
} > "$4" || err=$?

if [ $redir = failed ]; then
	...
fi

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
