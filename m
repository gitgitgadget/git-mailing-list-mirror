From: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: grep.patternType
Date: Thu, 4 Oct 2012 08:05:43 +0200
Message-ID: <20121004080543.3b31280f@mkiedrowicz>
References: <7vwqz9ak2f.fsf@alter.siamese.dyndns.org>
	<7v626r48cv.fsf@alter.siamese.dyndns.org>
	<7vmx032of1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, J Smith <dark.panda@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:01:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtOq-0001DP-Jg
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755962Ab2JDGGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 02:06:12 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62960 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754964Ab2JDGGL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 02:06:11 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so50682bkc.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 23:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=sNQo6+NSRRuopBPsBjR2VYOh2ayk48IsJ+EvWU9upwE=;
        b=T62JHS7bh/qH8TB01HXAIt2YMb2ZSE+BpPukX/e9/5A/Ppi/6oHPKB78aUYGmhyf7p
         DpOjVxj7y6F+RTPiIWCtozP+oWyVlTDhfgj9YKfirWe00gPCh6uI7z5oL0Xku1kRqDwR
         S+YZJrR/ZZwOpARY3QKEs3kDreaZyaW2Lw5Y7DvXBi4jDfy/+ARakLfKq556Lr6JKUdZ
         L/O6CnqP69xNDmjIoUgVs8qptAE4vkho6nhPRJmFp1QGiNk1e5tcjJLtp9ecO5hBNWGO
         Deabo/zToUirx/k+PXkj1fyjEF+7qt+ri3+qaDOOtNSGsrBNnKDDM5QoAsG2NqRVw9vM
         IYPw==
Received: by 10.204.128.201 with SMTP id l9mr1160848bks.66.1349330769908;
        Wed, 03 Oct 2012 23:06:09 -0700 (PDT)
Received: from mkiedrowicz (pc10.ivo.park.gdynia.pl. [153.19.128.10])
        by mx.google.com with ESMTPS id e3sm4643597bks.7.2012.10.03.23.06.08
        (version=SSLv3 cipher=OTHER);
        Wed, 03 Oct 2012 23:06:09 -0700 (PDT)
In-Reply-To: <7vmx032of1.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206952>

Junio C Hamano <gitster@pobox.com> wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >>  * "git grep" learned to use a non-standard pattern type by
> >> default if a configuration variable tells it to.
> >
> > This addition makes
> >
> >     git grep -e "(integer|buffer)"
> >
> > work as expected, when grep.patternType is set to "extended".
> >
> > Should this
> >
> >     git log --grep="(integer|buffer)"
> >
> > also honor the same configuration variable?  If not, why not?

I think this should respect grep.patternType.

> >
> > One more thing.  Currently you can say
> >
> >     git log -E --grep="(integer|buffer)"
> >
> > to ask for the ERE.  Should we also support -P to ask for pcre?  If
> > not, why not?

This also.

> 
> Answering to myself who has been in tying-loose-ends mode.
> 
> My answers to these questions are both yes, and I have a neatly
> lined up series that begins with a small bugfix and then
> enhancement, but I do not think these do not deserve to in the
> upcoming release.  The topic came too late, and even the fix is
> for a bug that has been with us for a long time.

I think I am the one to blame for this inconsistency.  When I
implemented "git-grep -P" I was thinking about making it work for all
regex operations in git but since I'm mostly using regexes with
git-grep I was too lazy to make it work with git-log.
