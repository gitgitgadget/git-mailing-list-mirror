From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: [PATCH] git-compat-util: Avoid strcasecmp() being inlined
Date: Thu, 19 Sep 2013 08:04:40 +0200
Message-ID: <CAA01CsrN+VLw4WQmObvh72_MoH1Lyh9dQbizJcVhqyJoRyms-Q@mail.gmail.com>
References: <523094F0.9000509@gmail.com>
	<20130911182921.GE4326@google.com>
	<20130911191620.GB24251@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 19 08:04:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMXMH-0003Q4-RJ
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 08:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495Ab3ISGEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 02:04:43 -0400
Received: from mail-ea0-f170.google.com ([209.85.215.170]:49695 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304Ab3ISGEm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 02:04:42 -0400
Received: by mail-ea0-f170.google.com with SMTP id h14so3979335eak.1
        for <git@vger.kernel.org>; Wed, 18 Sep 2013 23:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=c87F2I8lbItxDcV0Vn50mrGlGEQPLQnLA/zsJ2109nI=;
        b=tcBIN99EU/kWn5SBbYYRJ+KUZbcsN0pDSgQfcYc4LrVPrzqAbCcOc2qfrq4tFX7A7m
         5cwbL+DHm3iPoZhXZs0ItqwZyjf2gQCIMOe46MqRPFIszKYLTO5ZYj1eBVMGKfLSeI0J
         ukUV0SeAgxv4k80qN1imW/RAsV6f0EPJBGuRg0o/t5pdgIaluQJB3VYKnu+ARXtRI0/N
         I3pB+OUNgQtHCpY/hJ1EwusRuWok7LKDUa1OgIP2r+PoeH6ELB7d8N8GxNQ3idOIllxw
         IgKx5btvSBw7w/cuW1NHFiGIFsVeEtU2h0JTQT49Pi168jOgNcP+Dhfbq6vxNUS5SV4O
         LWZw==
X-Received: by 10.15.109.138 with SMTP id cf10mr22181eeb.86.1379570681225;
 Wed, 18 Sep 2013 23:04:41 -0700 (PDT)
Received: by 10.223.193.4 with HTTP; Wed, 18 Sep 2013 23:04:40 -0700 (PDT)
In-Reply-To: <20130911191620.GB24251@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235002>

On Wed, Sep 11, 2013 at 9:16 PM, Jeff King <peff@peff.net> wrote:
> I would prefer the static wrapper solution you suggest, though. It
> leaves the compiler free to optimize the common case of normal
> strcasecmp calls, and only introduces an extra function indirection when
> using it as a callback (and even then, if we can inline the strcasecmp,
> it still ends up as a single function call). The downside is that it has
> to be remembered at each site that uses strcasecmp, but we do not use
> pointers to standard library functions very often.

Is it possible to add a test which fails if wrapper is not used?

-- 
Piotr Krukowiecki
