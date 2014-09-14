From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] help: ensure that common-cmds.h is only included by
 help.c
Date: Sun, 14 Sep 2014 01:44:30 -0700
Message-ID: <20140914084429.GA74582@gmail.com>
References: <1410657073-3089-1-git-send-email-davvid@gmail.com>
 <5414f6b2.XwoOyI03zlXiZ3ds%perryh@pluto.rain.com>
 <CAPc5daXDCAi3eP3YmXfcO+9ncN8=b6tCGUFUxwKE=MuRBuXvEg@mail.gmail.com>
 <541549fd.u4o+i0ruC2hh0cGO%perryh@pluto.rain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Perry Hutchison <perryh@pluto.rain.com>
X-From: git-owner@vger.kernel.org Sun Sep 14 10:45:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XT5Qk-000689-SD
	for gcvg-git-2@plane.gmane.org; Sun, 14 Sep 2014 10:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbaINIo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 04:44:56 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:57996 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbaINIom (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 04:44:42 -0400
Received: by mail-pa0-f43.google.com with SMTP id fa1so4428556pad.2
        for <git@vger.kernel.org>; Sun, 14 Sep 2014 01:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=D0Z5SMYV4gsf4JovfWI4wf3Devj5mPvXNpO5mQl/l10=;
        b=FKEKUh9Gfw9j/Be4Pp82hrt4le8/+PTak3cxIWYYE9WtWna5VjDrgfyytBcKp4ml07
         us0VRfzXwHjlsplFIVqg2MaZg4jUBrIndrUiNLjjtsRVVNh/sQ/EFWayXqrYjxA29ll8
         p4M14E5Ef/kZ28T4zMMgJ2mTwkG+lcK7M1v+TsYyDeddiZxmUrqJmzmNx5NZwaU12CFz
         GOSLHVG6NUylJ9Wb4tvw9uBa+3OD+WPXWl7gXYhKs9/wxGkuRnq4e6Cb+P/oDddc1dke
         IdFU+LqvcZIAf5bJdATNdog1ZBFdD5tp2DHnIX2L0asuZ/O8od6rjASGzShebKuP6Je3
         bSlA==
X-Received: by 10.66.66.101 with SMTP id e5mr28792210pat.100.1410684282252;
        Sun, 14 Sep 2014 01:44:42 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id fo8sm8272133pdb.69.2014.09.14.01.44.40
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 14 Sep 2014 01:44:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <541549fd.u4o+i0ruC2hh0cGO%perryh@pluto.rain.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257009>

On Sun, Sep 14, 2014 at 12:55:41AM -0700, Perry Hutchison wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > On Sat, Sep 13, 2014 at 7:00 PM, Perry Hutchison <perryh@pluto.rain.com> wrote:
> > > David Aguilar <davvid@gmail.com> wrote:
> > >> Add a #ifndef guard to ensure that common-cmds.h can only
> > >> be included by help.c.
> > >
> > > ... If these definitions are intended to be private to help.c,
> > > why not put them there and eliminate common-cmds.h entirely?
> >
> > Have you studied where common-cmds.h comes from?
> 
> Not when I wrote that :)
> 
> > After you have done so, would you make the same suggestion?
> 
> Yes, as a matter of using C in a conventional and non-hackish
> manner.  The normal and expected purpose of .h files is to share
> definitions among compilation units.  If certain definitions are
> -- by design -- intended to be used in only a single compilation
> unit, they should not be put in a .h file; that only encourages
> other programmers who come along later to use those definitions
> in an incorrect way.
> 
> If it's too much trouble to have the auto-generation mechanism 
> insert the definitions into help.c where they belong, at least
> name the auto-generated file something else, like commands-auto.res
> or command-list.txt.  A #include file's name does not _have_ to
> end in .h, and avoiding the .h convention in a case such as this
> would make it blatantly obvious that something unconventional is
> being done.

I would generally agree.  Nonetheless, I was able to implement
this check without touching any of these files so these should
probably stay as-is.

Thanks,
-- 
David
