From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/5] sha1_name.c: simplify @-parsing in get_sha1_basic()
Date: Wed, 1 May 2013 11:54:14 -0700
Message-ID: <20130501185414.GN24467@google.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
 <1367425235-14998-4-git-send-email-artagnon@gmail.com>
 <CAMP44s1tHC+i+Wug_UuPnprZNvaPgLMNBX9MZi49SFv4iO62SQ@mail.gmail.com>
 <CALkWK0nTSMYvh8VMgQ6Q0EoPMmRa2vyodz+tDmpPp1d6KYmq8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 20:54:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXcAa-0001Yn-Kn
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 20:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756171Ab3EASyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 14:54:20 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:43004 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755776Ab3EASyT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 14:54:19 -0400
Received: by mail-pd0-f172.google.com with SMTP id 4so953694pdd.17
        for <git@vger.kernel.org>; Wed, 01 May 2013 11:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=1ExeLXFLnfUArJv6Qzwox0aKhEXP6kNCvVvEfZeTAPs=;
        b=Qf2fHYhy+7xUr1ud5cyKRUumNMZjJJU+j8LaQSaKVFWV7nepT/iyEK3/ZPhl8/ln1e
         R8r7hkaXhsFoSU8RJq2Lms9QatKHY0T3RKpI7QMA07b4HHri5uYFEMGqrHk2+lAeUXr7
         Twr1iuMHWks1wNqXgMKOhnd6a38U9bCsl645ji6ZW1jmQlubE3g0wAM/cLYQ/CC8tUmz
         DiVB1z1I8ZFVghvGjrwr0bN4B591rWOCLYRB+qH7R/YurR4/0Z4QcgsLskEUgsq8NSWI
         2y2XZaBzrkIiA4HExlSRji2591A57ZJ5gp/bdA+j/KUsN2oiObLX2b1LeOLJBgEZTpRQ
         E/bw==
X-Received: by 10.66.13.35 with SMTP id e3mr6304360pac.186.1367434458881;
        Wed, 01 May 2013 11:54:18 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id z8sm3958964pbt.23.2013.05.01.11.54.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 May 2013 11:54:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0nTSMYvh8VMgQ6Q0EoPMmRa2vyodz+tDmpPp1d6KYmq8w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223124>

Ramkumar Ramachandra wrote:

> [1]: https://www.ohloh.net/p/git/factoids#FactoidCommentsLow

Since this has been coming up from time to time:

I have nothing against including helpful comments where appropriate.
But one aspect which that factoid misses is that git has some very
detailed, very dense documentation available in its commit log.  Tools
like "git gui blame" and "git log -S" can show detailed historical
information about the purpose of every line of code.  A nice feature
of such documentation is that it is in a context where it cannot fall
out of date.

So for example I can do

	$ git log -S'if (len && ambiguous_path(str, len))' -- sha1_name.c
	commit 11cf8801
	Author: Nicolas Pitre <nico@cam.org>
	Date:   Thu Feb 1 17:29:33 2007 -0500

	    provide a nice @{...} syntax to always mean the current branch reflog

	    This is shorter than HEAD@{...} and being nameless it has no semantic
	    issues.

	    Signed-off-by: Nicolas Pitre <nico@cam.org>
	    Signed-off-by: Junio C Hamano <junkio@cox.net>

and then "git show 11cf8801" will show me exactly what change prompted
that "len" test.

The same is true of the Linux kernel, too.

Hope that helps,
Jonathan
