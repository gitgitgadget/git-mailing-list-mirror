From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: potential improvement to 'git log' with a range
Date: Wed, 23 Jun 2010 23:24:31 +0200
Message-ID: <201006232324.32516.jnareb@gmail.com>
References: <w2j3abd05a91004091624mb2836ff4v118a1ae9ac5ca6e7@mail.gmail.com> <201006232002.18921.jnareb@gmail.com> <877hlpimkq.fsf@hbox.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	mercurial list <mercurial-devel@selenic.com>,
	git list <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Aghiles <aghilesk@gmail.com>
To: Martin Geisler <mg@lazybytes.net>
X-From: git-owner@vger.kernel.org Wed Jun 23 23:24:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORXRB-0002wu-NO
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 23:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387Ab0FWVYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 17:24:40 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55146 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357Ab0FWVYj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 17:24:39 -0400
Received: by fxm10 with SMTP id 10so3457241fxm.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 14:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=B8+0yg+QXqd7INK0dVM8Bg3aO/4TUUARJhwECRZ9Bz0=;
        b=mA2Tg3iU0eBaWBKZEbx0ai0QaMwTL7OzGnSi9IeGLbIDqs5P3G3Asz1kRev9tLABIa
         Xk9fXFN+5azLm0ZXny0KR+VjqBd9ap6mxAWsuRnq3sc1sVBwPosx1Dn29W0bt224p1xA
         UJArrvVZt20y9SBQhZmdxd67ktPdMSH3IsJkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=OnIlUniE8NMQzpJBLtjVh6Zxi5I8AXSfZ+0KgIzsPcjXAAwiWR/t9QEthmSeixU4ZO
         0L2Yut23c/Qzci97SAeA1sR5NOe+ZZ3g9sGptsedzhYXlVyQPgDQqXw4oYZ+JhhrHmnW
         VNOcRAcHKo1AWU8CcGutBqXmZ+8C/e3WTrjAg=
Received: by 10.223.24.133 with SMTP id v5mr8310707fab.46.1277328277786;
        Wed, 23 Jun 2010 14:24:37 -0700 (PDT)
Received: from [192.168.1.15] (abwj124.neoplus.adsl.tpnet.pl [83.8.233.124])
        by mx.google.com with ESMTPS id e11sm33504962fak.17.2010.06.23.14.24.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jun 2010 14:24:36 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <877hlpimkq.fsf@hbox.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149550>

On Wed, 23 Jun 2010, Martin Geisler wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> On Wed, 23 Jun 2010, Martin Geisler wrote:
>>
>>> This is fixed with Mercurial 1.6: we now have a query language where
>>> 'X..Y' (or 'X::Y') is understood as the set of changesets that are
>>> both descendents of X and ancestors of Y.
>>
>> Thanks. It looks like Mercurial's 'X::Y' is equivalent to Git's
>> '--ancestry-path X..Y' (the --ancestry-path option is a new feature).
> 
> Yeah, it is equivalent to --ancestry-path. I had no idea Git's range
> operator worked the way it does :-)
> 
> For mercurial-devel: 'X..Y' is a shorthand for '^X Y', which in turn
> means ancestors of Y, excluding ancestors of X (and excluding X).

Err... so how it is for X..Y / X::Y in Mercurial?  "Ancestors of Y, 
excluding ancestors of X" is larger range (and default result for
X..Y in Git) than "descendants of X and ancestors of Y" (i.e. the
result of new --ancestry-path X..Y in Git).

See http://repo.or.cz/w/git.git/blob/refs/heads/pu:/Documentation/rev-list-options.txt#l582

>>>> [1]
>>>> http://stackoverflow.com/questions/1598759/git-and-mercurial-compare-and-contrast/1599930#1599930
>>
>> Fixed. Could you please take a look if it is correct, and if there are
>> errors, either correct it yourself, or ask me to do it (either via
>> comments for this question, or via email)? Thanks in advance.
> 
> Yes, its correct now. But would you object if I or someone else took out
> all those personal opinions and rewrote it from a neutral point of view?

Well, I do provide disclaimer upfront that I am biased towards Git, and
I have tried to be objective.

But I don't mind if someone who uses Mercurial fixed that side, and
tried for neutral point of view (but not introducing the opposite bias).
There would be problem with NPOV with issues without clear answer, where
personal preference matters, though.

>> P.S. Isn't mercurial-devel subscribe only?
> 
> No, not really -- you will be whitelisted the first time you post.

Nice.

-- 
Jakub Narebski
Poland
