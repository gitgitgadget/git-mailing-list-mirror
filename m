From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 2/3] pull: trivial cleanups
Date: Thu, 16 May 2013 15:24:59 +0530
Message-ID: <CALkWK0kP1yhdhV7oLA4gYJTJ7VtU2WuhtJ_Q5UsZSS00y=FP_w@mail.gmail.com>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
 <1368675828-27418-3-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0=tP=v=3Q4dzPc=W0=j_7iFYdGnzkaV6U_MFSg=NCE49w@mail.gmail.com>
 <CAMP44s0sg6zQc9=cD1X61joxSd=LK7qT1k-suej3dYDD826hgw@mail.gmail.com>
 <CALkWK0=RF4cjQ4Lz4Qi2iac_NgLdzBRw5Q9uf8KjYJju8swWDQ@mail.gmail.com> <CAMP44s1vMTfrSaU+0S8EOM5g4L0885780SvT_THBr7u==bJ06A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 11:55:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcuuW-000205-KT
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 11:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039Ab3EPJzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 05:55:41 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:45537 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab3EPJzk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 05:55:40 -0400
Received: by mail-ie0-f175.google.com with SMTP id s9so6000650iec.34
        for <git@vger.kernel.org>; Thu, 16 May 2013 02:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=5VrrgCDk7LDgs/5yowIzJjzyZD8pZPa59Ps7CjVzL9I=;
        b=o9MIkDCklrSQ0yCzTV00u4nD5dtmnPjeBXmdc86EEl2uVOoM5haX1rDLPerniPNzP1
         Wl/KjrR2Q8uLjblr/BjLFxUMZTDrhgt9ePW05J6xQ5GC0vm3B28ZTIoRDHNqF3H0HQnC
         DfUSfBOxtkRLS7Rr5EXcXmpzI6rt6Gg347uhM/hAB4kbRA9+vD3Ri78pbICJpvBLtwAQ
         LfVkv3VzB5gqL7ToBXDBBd3Tw5jWIXrfdobn5cNjHofdylVj7VL0YfPOhdhyfMrq+xz3
         JKmZfzQ+1Ub4cSAsRP2eK7n0BrdNvEj8kxhLi+yG6o9EBBYOtpXhh40Xg4fq7ipyP7a9
         Zq/w==
X-Received: by 10.50.3.38 with SMTP id 6mr8653312igz.44.1368698139914; Thu, 16
 May 2013 02:55:39 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 16 May 2013 02:54:59 -0700 (PDT)
In-Reply-To: <CAMP44s1vMTfrSaU+0S8EOM5g4L0885780SvT_THBr7u==bJ06A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224543>

Felipe Contreras wrote:
> % git fetch origin 'refs/tags/*:refs/tags/*' 'refs/heads/*:refs/heads/*'
> fatal: Refusing to fetch into current branch
> refs/heads/fc/fast-export/cleanup of non-bare repository
> fatal: The remote end hung up unexpectedly

That's because your HEAD is pointing to something under refs/heads/*:
it would work otherwise.  When I'm developing on my personal branch, I
sometimes do 'git fetch origin master:master +pu:pu +next:next', and
it works as expected.  When on master branch, I can't git fetch origin
master:master and this is a cute safety feature.

Either way, I think it's a bad practice to fetch directly into
refs/heads/*: you should really be fetching to refs/remotes and then
merging your changes in.  I do want shortcuts though, which is why I'm
interested in fixing pull: there is nothing to fix in fetch as far as
I'm concerned.
