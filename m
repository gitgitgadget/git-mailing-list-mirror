From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] pretty.c: add %O format specifier to format_commit_one()
Date: Sat, 01 May 2010 12:39:48 -0700 (PDT)
Message-ID: <m3fx2bcsze.fsf@localhost.localdomain>
References: <1272711401-29005-1-git-send-email-ash@koowaldah.org>
	<7vsk6b5yms.fsf@alter.siamese.dyndns.org>
	<20100501175601.GB27062@shisha.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alexander Shishkin <ash@koowaldah.org>
X-From: git-owner@vger.kernel.org Sat May 01 21:39:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8IXe-00033d-BK
	for gcvg-git-2@lo.gmane.org; Sat, 01 May 2010 21:39:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757416Ab0EATjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 May 2010 15:39:53 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:38783 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757232Ab0EATjw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 May 2010 15:39:52 -0400
Received: by bwz19 with SMTP id 19so674341bwz.21
        for <git@vger.kernel.org>; Sat, 01 May 2010 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=aqTa76iVKsZPuSQtrvAFkvNNVxd4FY4cehcwclfKCGY=;
        b=iRVYgKTObyLa6dI+72KJrLX3vcewQrekA6F8xxqiDiGqojQu7qAPmZ45jKTwqAUS2g
         ipuMweiwbE8eG36frbHuK/hJsAVMAYG+EnvxmjAKkKAEcjTFYyarMsXezgTrQkrN7tr9
         o7/xTalsUUTcoMMY0xDJlXTi6DrdPgM6UCCVo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=D/oMSE0KAEMEeFwS2iwPTb1zvqqCH4l/DwaPp38LB0MmXpaGnsDyKQv3xqO8MnRLKY
         NkXnE6R8LAnX4wRBzCeKFZp6BTdqQvrAmXPzBkO7lzt1e2/7eunkVICOE5ayuTq1Bmkq
         z8cN1eAVoIHAPNzJNoq+ooxa1J4Jzw+gHfHJc=
Received: by 10.204.136.156 with SMTP id r28mr8259963bkt.112.1272742789931;
        Sat, 01 May 2010 12:39:49 -0700 (PDT)
Received: from localhost.localdomain (abvy46.neoplus.adsl.tpnet.pl [83.8.222.46])
        by mx.google.com with ESMTPS id 13sm1104856bwz.15.2010.05.01.12.39.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 01 May 2010 12:39:48 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o41JdCdB002637;
	Sat, 1 May 2010 21:39:23 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o41JckVI002632;
	Sat, 1 May 2010 21:38:46 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100501175601.GB27062@shisha.kicks-ass.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146111>

Alexander Shishkin <ash@koowaldah.org> writes:

> On Sat, May 01, 2010 at 10:18:35 -0700, Junio C Hamano wrote:
> > Alexander Shishkin <ash@koowaldah.org> writes:
> > 
> > > This specifier represents the number of each commit in the output
> > > stream.
> > 
> > I don't like this.  What does such a number _mean_ in a non-linear
> > history?
> 
> My idea is to have something like
> 
> $ git log --pretty=oneline | nl | less -R
> 
> This is generally useful when my local topic branch contains more than 5
> (or so) commits and I can't immediately see which one's which if I want
> to do a
> 
> $ git show HEAD~$n
> 
> to see what's inside, which is useful when reordering and/or squashing
> commits by an interactive rebase. So this %O gives me this $n quicker
> than counting.

Wouldn't somthing like

  git log --pretty=oneline | git name-rev --stdin | less -R

be good enough?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
