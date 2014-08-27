From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: problem with def of inet_ntop() in git-compat-util.h as well as
 other places
Date: Wed, 27 Aug 2014 15:28:03 -0700
Message-ID: <20140827222803.GZ20185@google.com>
References: <1024776344.30870.1409166905539.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
 <20140827192848.GC7561@peff.net>
 <805178325.32077.1409168920760.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
 <20140827200612.GA10469@peff.net>
 <597210348.36175.1409173228026.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: dev <dev@cor0.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 00:28:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMlhM-0000ss-Uv
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 00:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935699AbaH0W2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 18:28:08 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:58905 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932246AbaH0W2H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 18:28:07 -0400
Received: by mail-pa0-f53.google.com with SMTP id fa1so8870pad.12
        for <git@vger.kernel.org>; Wed, 27 Aug 2014 15:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7Jky7AGEUBYMUHbqwvMELoZGzjgZREZVSemIXqrApGE=;
        b=e9z+aINll8l0CvhOFACnJgO9mM4TdWT09uqCZUOmhu/BSBcGX4LNLjeGAX3ciEZVO/
         fKCQBeESUlfOtex+fj6pYbkkDgQLMLN6eBQ1G+QzMKPyMer7v9o0Q8sMoDEk87ECq7GI
         LBCZsgC2Kn1Em/wQc6L03tsccnOzcoElOtnrrfhiJV3BedDMShgkiYPmQuQzbBJS8e3a
         qT3phdAImqhyi3Pxe5JJJdgvEsLaTqxGsSGtdhHstfIHngWvowqYqPVmi+UdfrrbSWHA
         tO1pWOExLIblVZN/8rRALuYJ9eCrJKCe96RjSbE1b30yJt2mZK+8r059seIfUaAX3elB
         YXtw==
X-Received: by 10.66.252.170 with SMTP id zt10mr32919847pac.111.1409178485679;
        Wed, 27 Aug 2014 15:28:05 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id ba5sm1439109pbd.72.2014.08.27.15.28.04
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 Aug 2014 15:28:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <597210348.36175.1409173228026.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256055>

Hi again,

dev wrote:

> So I guess I have to create a config.mak file from somewhere.

Sorry, let's take a step back.

What exact commands do you use to build, starting from a pristine
extracted tarball?  What output do you get back?

[...]
> Undefined                       first referenced
>  symbol                             in file
> libiconv_close                      libgit.a(utf8.o)  (symbol belongs to implicit dependency /usr/local/lib/libiconv.so.2)

Sounds like NEEDS_LIBICONV should be set on Solaris.  You can test
this by passing NEEDS_LIBICONV=YesPlease on the gmake command line and
seeing what happens.

But it seems odd --- was iconv once part of libc on Solaris and then
moved out or something?  There have been lots of people building git
on Solaris over the years (and writing patches to fix other build
problems) without needing to set that flag.

[...]
>> You would potentially also need to turn off a few feature flags manually

The options for tweaking the build are described at the top of the
Makefile.

Thanks again,
Jonathan
