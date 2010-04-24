From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fsck: check ident lines in commit objects
Date: Sat, 24 Apr 2010 12:04:19 -0700
Message-ID: <20100424190419.GA7502@spearce.org>
References: <1272069944-20626-1-git-send-email-lodatom@gmail.com> <20100424160608.GA14690@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@fluxnic.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 24 21:04:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5keb-0004YO-D1
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 21:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337Ab0DXTEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 15:04:24 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49644 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876Ab0DXTEX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 15:04:23 -0400
Received: by pwj9 with SMTP id 9so7603593pwj.19
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 12:04:22 -0700 (PDT)
Received: by 10.140.57.8 with SMTP id f8mr1767445rva.102.1272135862485;
        Sat, 24 Apr 2010 12:04:22 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 20sm2352846pzk.3.2010.04.24.12.04.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 12:04:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100424160608.GA14690@progeny.tock>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145696>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> Check that email addresses do not contain <, >, or newline so they can
> be quickly scanned without trouble.  The copy() function in ident.c
> already ensures that ordinary git commands will not write email
> addresses without this property.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Thoughts?  Should some of these errors be warnings?

These should be errors.  We should never see this sort of thing
occur in a live repository.
 
> git fast-import is capable of producing commits with some of these
> problems: for example, it is fine with
> 
> 	committer C O Mitter <foo@b>ar.net> 005 -    +5

Yuck.  We probably should tighten up the parser in fast-import a
bit more.  The above is pretty insane for it to produce into the
repository.  I can't even begin to count how many ways the above
line is just wrong...  :-)

-- 
Shawn.
