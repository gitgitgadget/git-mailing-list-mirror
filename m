From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fix overwritten remote ref on with fast-import.
Date: Mon, 16 Jul 2012 22:27:25 -0500
Message-ID: <20120717032725.GC3071@burratino>
References: <1342013933-14381-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1342362383-31167-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <20120716003024.GA4246@burratino>
 <11883284.WI8IR4K6qp@flobuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 05:28:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqySY-0007Ym-Cn
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jul 2012 05:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590Ab2GQD16 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jul 2012 23:27:58 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:54414 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab2GQD1a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2012 23:27:30 -0400
Received: by gglu4 with SMTP id u4so5741352ggl.19
        for <git@vger.kernel.org>; Mon, 16 Jul 2012 20:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=DyfX5yEXVDLnuD8wD7E0WvQWOjUmRvpjVIAnNV+d3is=;
        b=ZGED4+Y8Nk4dghSC0x2T7dqr7Yquwz+Snihq+00ofOGXsa5jGjFoIb/RehfR7z5uEO
         GtdmUHDq6aGYbGGEe9iKHdam7qBwyjpd2a7rcFVctUzmxUIs5sshZcJrsG2dAMGzI/T4
         KZQhulYfe5jKlC7l1qpuxDfojDFjcP7lAxzikUELyNnEnjqkwMRwlW4JtPVTXMquKXC+
         uDd18j+nAWzxRN+Sb5j/QZyLt7ZiXroKh7ORWUXud4ZMbIsIBg+e2CBPE/Ujx+w38YYm
         BLsSyI6OcB7O7CNY/w1fIp4GamgWOk6HjviZHa5WLf7JCZNImr7DP1Yh7PsrWD3OGuYe
         U3DA==
Received: by 10.50.100.129 with SMTP id ey1mr124570igb.35.1342495649252;
        Mon, 16 Jul 2012 20:27:29 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id ch4sm4964083igb.2.2012.07.16.20.27.27
        (version=SSLv3 cipher=OTHER);
        Mon, 16 Jul 2012 20:27:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <11883284.WI8IR4K6qp@flobuntu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201584>

Florian Achleitner wrote:

> When it does advertise refspec like:
> Debug: Remote helper: <- refspec refs/heads/master:refs/remotes/svnfile/master
> it all works. Unfortunatly I didn't understand that a day ago.

Hm, that still doesn't look right.  The RHS of the refspec is supposed to
be a _private_ namespace for the remote helper, and refs/remotes/ is
not private.

Would something like

	refspec refs/heads/*:refs/svn/<name of remote>/*

work?

[...]
> If yes, it makes sense now! A little comment in the sources would help a lot.

Now that you know what the reader of this code needs to know, a patch
would be very welcome.

"git blame" or "git log -S" can be useful to find what the authors
were thinking when they wrote that line, or to find wording to steal
for a comment. :)

Hope that helps,
Jonathan
