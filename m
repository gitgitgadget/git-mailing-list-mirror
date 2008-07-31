From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: linking libgit.a in C++ projects
Date: Thu, 31 Jul 2008 14:57:27 +0400
Message-ID: <20080731105727.GF7008@dpotapov.dyndns.org>
References: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: cte <cestreich@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 12:59:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOVs8-0006XC-Db
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 12:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbYGaK5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 06:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751718AbYGaK5g
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 06:57:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:35705 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbYGaK5f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 06:57:35 -0400
Received: by fg-out-1718.google.com with SMTP id 19so240794fgg.17
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 03:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=RkI+C/iQM7LiYqb/UYoDLApjOD32fqbBPb+R/gaQYKc=;
        b=NIHxyqHILyx/JkApVDtAFmWbu5dfjvveg9I5CRGE5PJfArF1isyUjxQV+fQWvfNayw
         P76tHV+HzIUFV4wL+KD9U1ino0pzylM0qEIYRbjJowmH6y5S/ault6cFlgDj06spcrrn
         t6SJD5wzdkub6jzGM8ss3FLfyq0qxtoCx/zJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tahhcxO3KAQlZx4ZxbBTgBvLhRYHsuatb+r9s5v7JOqzlb84yR3tZNXuagEkqi5n63
         lVJdIsiK5SLrpdMsM2WFJY435RK5HvqMdETvSycq+CDwU14X1zUvhJrpd9vAGLwU4JVh
         I68/qtVY/3WOPhC/QL+e5xF19JQbX4KP7cziE=
Received: by 10.86.82.16 with SMTP id f16mr5956571fgb.9.1217501852452;
        Thu, 31 Jul 2008 03:57:32 -0700 (PDT)
Received: from localhost ( [85.141.148.53])
        by mx.google.com with ESMTPS id 12sm2641091fgg.0.2008.07.31.03.57.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 31 Jul 2008 03:57:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90924>

On Thu, Jul 31, 2008 at 02:53:37AM -0700, cte wrote:
> I'm writing a git gui for OS X using cocoa/Objective-C++, and rather
> than being lame and parsing the output the various git commands, I'm
> using libgit.a to provide all of the needed functionality for my app.

Don't do that! libgit.a is an internal library used solely to build
git binaries. It means that its interface can be cahnged at any time.
Though, there is an idea of creating the real git library that other
applications can use, but AFAIK no one is working on it. So parsing
output is the only correct solution right now. In fact, it is not
difficult to do, because most plumbing commands are rather flexibly
in what they output and how.

> However, the git source uses a few reserved C++ keywords; namely
> 'typename', and 'new'.

Because this source code are meant to be compiled by C and not by C++!
Even if we will have real git library for other applications to use,
it still be compiled only by C. Thus, C++ keywords are not issue.

Dmitry
