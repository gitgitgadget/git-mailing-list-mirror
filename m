From: Nicolas Sebrecht <nicolas.s.dev@gmail.com>
Subject: [PATCH 0/6] Re: cleanups for git-send-email
Date: Thu, 30 Apr 2009 00:27:11 +0200
Message-ID: <20090429222711.GC12908@vidovic>
References: <7vws939skl.fsf@gitster.siamese.dyndns.org> <20090429194852.0976257034@viridian.itc.Virginia.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bill Pemberton <wfp5p@viridian.itc.Virginia.EDU>
X-From: git-owner@vger.kernel.org Thu Apr 30 00:28:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzIGG-00044H-SQ
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 00:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761952AbZD2W1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 18:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761949AbZD2W1W
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 18:27:22 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:43394 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761938AbZD2W1U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 18:27:20 -0400
Received: by ewy24 with SMTP id 24so1564457ewy.37
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 15:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=89ENuH1FlxGJrtWdRrGgh3m4JCJb1BAZjJxJTxJN3yc=;
        b=G2g/xqUCRx32eNccpU9O316fCjyj6ng9ykKME1c2DpmZorSV6WN2DVGYwHVObm+4je
         /cf6AR6bGXyvUzLUsSgP0YLLa3st8Wn4JH9iDm2yj4fcVKbHvG19lno3qzUzuRj0FkAG
         XPpRhPVwyYosoJEH736oma1Ox7jliard/XJtA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hkF9U7h8SsfErRlaxiiM+GWvMhGmuv6DRQUhR/cJ41rRUX+fR38lDbefb2dEWhReGt
         KZSTSQ8XCrz7lD1/TkVT3W3NWbRG1y8zbH9hAOTwTP/IOMfsllnnCbqEXZCiosFqvkun
         zv48bCJhmw1NJWGjdknjDQ+e6rWoUxMwuFPQM=
Received: by 10.210.136.10 with SMTP id j10mr983950ebd.93.1241044037981;
        Wed, 29 Apr 2009 15:27:17 -0700 (PDT)
Received: from @ (91-164-142-73.rev.libertysurf.net [91.164.142.73])
        by mx.google.com with ESMTPS id 5sm2840765eyh.10.2009.04.29.15.27.13
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 29 Apr 2009 15:27:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090429194852.0976257034@viridian.itc.Virginia.EDU>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117968>

On Wed, Apr 29, 2009 at 03:48:51PM -0400, Bill Pemberton wrote:

> Again, it prevents bugs.  People use "and" vs "&&" as the same thing,
> when they are not.  The have different precedence in perl.

I agree with you except that the chapter 4.16 from the Perl Best
Practices book does not apply here. FMPOV, we don't really mix booleans
because the precedence is explicitly given by the parentheses.

[ Notice _how_ the author raises the ambiguity to explain his point in
  the book: he uses parentheses. ]

> For example, 
> 
> next if not $finished || $x < 5;
> next if !$finished || $x < 5;
> 
> do not mean the same thing.

True. But the lines we are talking about are different. We have:

	next if ($finished or $x < 5);

If we add a "not"/"!" or append a "&&"/"and" - or whatever -, we do know what will
be evaluated easily:

	next if !($finished or $x < 5);

looks rather different from

	next if (!$finished or $x < 5);

-- 
Nicolas Sebrecht
