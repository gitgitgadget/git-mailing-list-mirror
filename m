From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: No progress from push when using bitmaps
Date: Fri, 14 Mar 2014 17:21:59 +0700
Message-ID: <CACsJy8BZd0uL2M8NHO+sFcWfkmoyuVnU1Mh2eKZ2OXm=Y-Ge5g@mail.gmail.com>
References: <CAJo=hJth1YB+u2Y9S0X3xk7s2-HcPP4_k03qprHBU4A9721i8g@mail.gmail.com>
 <20140313212626.GA23618@sigill.intra.peff.net> <CAJo=hJu1WscibwectWzrUcoOV4-9xk4hBm1JA+RjONmgvZTXwQ@mail.gmail.com>
 <20140313220754.GA20173@sigill.intra.peff.net> <5322CF58.6060506@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	git <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Mar 14 11:22:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOPG7-0001l7-Ky
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 11:22:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbaCNKWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 06:22:31 -0400
Received: from mail-qc0-f181.google.com ([209.85.216.181]:37911 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbaCNKWa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 06:22:30 -0400
Received: by mail-qc0-f181.google.com with SMTP id e9so2537136qcy.40
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 03:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GnQaIS/D8xdpCT9hiWppTA0qvxGG5CfIThB0tnx1JKA=;
        b=iD3OKG5IjtoDx0/rlnsUlBqcWi4Cc5gD3z0XVVbSjN3kD4r+3qH1p1rXXdWyf+gjZc
         etTWs4jkkOaDEs/aj9qC3v0wUR2jklqbTFyD4ABBaWnw/IC4W8mdOt9XXOgq7P4inGe+
         Uclxc/Pr++H1VdhTq0CYwkhX8at1go1Yqdu545gbs6MU5ZgCwwzJQUgzeOZr4fYAdgib
         3P7mgLHEUMksR52U/rXQfdEJbxIvyZEc9qjcs2ghVEFRd2407ZGN89LK34UaKx3cZ6HL
         XDIl/FMmcCP2fhdMrX4cA41lvjf93bwi03DEh2C3BIwBBm9lsj12R8cS9P7HVi1yK7VA
         gluQ==
X-Received: by 10.224.112.6 with SMTP id u6mr8585188qap.78.1394792549131; Fri,
 14 Mar 2014 03:22:29 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Fri, 14 Mar 2014 03:21:59 -0700 (PDT)
In-Reply-To: <5322CF58.6060506@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244086>

On Fri, Mar 14, 2014 at 4:43 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Would it be practical to change it to a percentage of bytes written?
> Then we'd have progress info that is both convenient *and* truthful.

I agreed for a second, then remembered that we don't know the final
pack size until we finish writing it.. Not sure if we could estimate
(cheaply) with a good accuracy though.

If an object is reused, we already know its compressed size. If it's
not reused and is a loose object, we could use on-disk size. It's a
lot harder to estimate an not-reused, deltified object. All we have is
the uncompressed size, and the size of each delta in the delta chain..
Neither gives a good hint of what the compressed size would be.
-- 
Duy
