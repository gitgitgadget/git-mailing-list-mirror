From: Peter Wu <lekensteyn@gmail.com>
Subject: Re: [PATCH 2/2] branch: let branch filters imply --list
Date: Thu, 31 Jan 2013 17:13:15 +0100
Message-ID: <1504250.y8BAS4sG2O@al>
References: <20130131064357.GA24660@sigill.intra.peff.net> <20130131064611.GB25315@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 31 17:21:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0wst-0005XQ-3j
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 17:21:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753985Ab3AaQUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 11:20:45 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:63095 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666Ab3AaQUo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 11:20:44 -0500
Received: by mail-wi0-f174.google.com with SMTP id hj13so4294177wib.1
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 08:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=2eYQ0lKcNgXGfKwGhcdfrZJ2fdPDbmCp3A/xmwFtUdo=;
        b=kF/HqEUxJRbcL84nGzbbEdHMpKDKS5JigV9IhZp+necBmzCWvxMq+S0qs5jvLoTaMO
         Qp6lRFJMUcPWPP8QjabKzGwRS5MwB+AMWYINlDInZoiRf5267+9Ka3h/2bU270ChCFtB
         Bbu0VSic7JHtcqfO+78/OxxMty5DT8rZoRouzNQIU1v/zLlk+bC/GEbcojPmwjwVcpjO
         KYRnPU0IJ9Ry05plM0Lu+4/wJ0ZYxtLr3R9giY0uTAPVLfe5aYhwnUqdthgYynuOMKh9
         sgmTfo/QMxqajShKrTTiupwf2BliY6JMMcFLTWjZFubKaWPEgMoMOFHSm99KmHehuxAl
         Omjg==
X-Received: by 10.180.78.34 with SMTP id y2mr16197509wiw.3.1359648798297;
        Thu, 31 Jan 2013 08:13:18 -0800 (PST)
Received: from al.localnet (svr.lekensteyn.nl. [178.21.112.251])
        by mx.google.com with ESMTPS id s10sm10239008wiw.4.2013.01.31.08.13.16
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jan 2013 08:13:17 -0800 (PST)
User-Agent: KMail/4.9.5 (Linux/3.8.0-2-custom; KDE/4.9.5; x86_64; ; )
In-Reply-To: <20130131064611.GB25315@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215122>

On Thursday 31 January 2013 01:46:11 Jeff King wrote:
> Currently, a branch filter like `--contains`, `--merged`, or
> `--no-merged` is ignored when we are not in listing mode.
> For example:
> 
>   git branch --contains=foo bar
> 
> will create the branch "bar" from the current HEAD, ignoring
> the `--contains` argument entirely. This is not very
> helpful. There are two reasonable behaviors for git here:
> 
>   1. Flag an error; the arguments do not make sense.
> 
>   2. Implicitly go into `--list` mode
> 
> This patch chooses the latter, as it is more convenient, and
> there should not be any ambiguity with attempting to create
> a branch; using `--contains` and not wanting to list is
> nonsensical.
> 
> That leaves the case where an explicit modification option
> like `-d` is given.  We already catch the case where
> `--list` is given alongside `-d` and flag an error. With
> this patch, we will also catch the use of `--contains` and
> other filter options alongside `-d`.
> 
> Signed-off-by: Jeff King <peff@peff.net>
Tested-by: Peter Wu <lekensteyn@gmail.com>

I have tested this patch on top of 1.8.1.2 and it seems to work.

One note, the following command spits out master without complaining about the 
non-existing branch name:

    git branch --contains <id> master <non-existant branch name>

(the order of branches doesn't affect the result.)

Regards,
Peter
