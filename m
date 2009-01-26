From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: last-modified time should be commiter, not author
Date: Mon, 26 Jan 2009 12:43:11 +0100
Message-ID: <cb7bb73a0901260343leebb09fld144f1dec7c8470a@mail.gmail.com>
References: <1232686121-1800-5-git-send-email-giuseppe.bilotta@gmail.com>
	 <1232923370-4427-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200901260254.49919.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 12:44:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRPtR-0002JR-5u
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 12:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbZAZLnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 06:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbZAZLnP
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 06:43:15 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:45022 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbZAZLnO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 06:43:14 -0500
Received: by ewy14 with SMTP id 14so324735ewy.13
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 03:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/D7PmlBdGUjhawzuK282LgZ7IfnUJtKKPtAYBeYEFso=;
        b=FPAj2tsclc+Cu+M2ldxxt/3MiBWCn+25RcDxR9rgegS1OK0D19UoPn+hDSoGe7lYuO
         ZgfNuJkHZL3DEDaToasB/xob8Ip7NOfNfVvpdIkW7o1+mQscjHReUim1Un5uQd96NiWN
         4dBI3CD9RjNGDMvktlgQQopaXbyUWaza6rbyM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JbZZSSMTqhvneecRMjdATlS2y0xCTrXfid+jyxJmlJgYcOWT0ViBTbRoWYQ855XMu7
         CG4ul5L5xXgnJqYiYZm0eWNqhKJTGi+cVq2tGx1YzxyMqxZeTgbFLsySY6mhLkN/twjQ
         WqVk7vl+EGF/ZCMyPG5ndfw4hCu5agY1Y/Yos=
Received: by 10.210.65.15 with SMTP id n15mr6550257eba.186.1232970191815; Mon, 
	26 Jan 2009 03:43:11 -0800 (PST)
In-Reply-To: <200901260254.49919.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107194>

On Mon, Jan 26, 2009 at 2:54 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Sun, 25 Jan 2009, Giuseppe Bilotta wrote:
>
>> Subject: [PATCH] gitweb: last-modified time should be commiter, not author
>
> Should be really either "[PATCH 1/2]" or "[PATCH 5/4]" or "[PATCH 5/6]"
> just in case for the next patch, because next patch _depends_ on this
> one, and just in case of threading problem it should be marked as it;
> it also makes easier to apply patches from emails saved as individual
> files each.

I'll resend the whole 6-patch series cc'ing Junio too

>> Use the committer time for the last-modified header to ensure a more
>> correct guess of the last time the repository was modified.
>
> Good catch, good thinking IMHO. Committer date has much better chance
> to be monotonic than author date, and is more close related to
> _publishing_ date (author date is more of _creation_ date).

BTW, it is still not good enough. Consider a remote repo to which you
just pushed some changes you commited last week. The last-modified
date would be last-week, even if you just pushed those changes.

This used to be a problem for us on ruby-rbot because even when
watching the feed we would get no updates on the irc channel (the bot
thought the feed could still be cached). the if-modified thing seems
to have fixed this though.

> Lack signoff; if Junio forges it (or you reply that it should be
> signed off), you can add from me
>
> Acked-by: Jakub Narebski <jnareb@gmail.com>
>
>
> P.S. I wonder what other web interfaces do, for example cgit. I guess
> that web interfaces for other SCMs like SVN::Web, ViewVC etc. do not
> have this problem because they have only one, single date.

HEAD'ing a cgit atom url gives a last-modified date one hour from the
request, it seems. This is actually a typical (and not nice) behaviour
of many CGI scripts.

-- 
Giuseppe "Oblomov" Bilotta
