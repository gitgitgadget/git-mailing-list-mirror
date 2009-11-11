From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] gitk: Add ability to define an alternate temporary
 directory
Date: Wed, 11 Nov 2009 08:44:53 -0800
Message-ID: <20091111164451.GA45475@gmail.com>
References: <1257904149-44381-1-git-send-email-davvid@gmail.com>
 <4AFA368F.207@vilain.net>
 <20091111040715.GA44672@gmail.com>
 <7vr5s5y8n8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sam Vilain <sam@vilain.net>, paulus@samba.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 17:51:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8GPL-0000ex-Ie
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 17:50:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758282AbZKKQuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 11:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756999AbZKKQuh
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 11:50:37 -0500
Received: from mail-pz0-f188.google.com ([209.85.222.188]:64790 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758282AbZKKQuc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 11:50:32 -0500
Received: by pzk26 with SMTP id 26so850274pzk.4
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 08:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=iUsX62OKfn5dvRijMXa17DZE6Vv8puMqnF+IG/4wDAQ=;
        b=gxHyrnSUr1iI9U8Du/jaOAS7GxJT3m1sKcnmPdzPwxt1e9XFAxyTB9DbIphHkMJ+6F
         Pjhy4ou6Mucp7ZpqFBIOdnjIkcxLIk74H2QgszIZtJ5LsNPthd9OEYK0hOZfb8y0B/VK
         u3Gr4/tII3eWBY5YZwmJEXVlYdJICiW1CCBFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=m5VFmqcYv5Lyv5Yc2qObmsWWdcceZ0snF6p3qQOU+lL83Yd/AhN0iDuhfxGI1UKi3k
         q1Nxz01pgVQieAvOwqUvAwHAFO0exLjccHci2CZMfNBY3zKAjWXkXQZutSe4Ovn9hjPD
         fgTMxUoPVsB5y6omyjqBUCYwiQOEIT3ar3Zaw=
Received: by 10.114.83.17 with SMTP id g17mr3644771wab.38.1257957899552;
        Wed, 11 Nov 2009 08:44:59 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 23sm1103175pzk.12.2009.11.11.08.44.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 11 Nov 2009 08:44:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vr5s5y8n8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132671>

On Tue, Nov 10, 2009 at 08:42:35PM -0800, Junio C Hamano wrote:
> David Aguilar <davvid@gmail.com> writes:
> 
> > That said, if there's a consensus that the path doesn't matter
> > much than we could change the behavior.  I was just trying to be
> > careful.
> 
> If we are not honoring GITK_TMPDIR and suddenly start paying attention to
> it, that already is a change in behaviour.  Why is it better than paying
> attention to TMPDIR?

True.

> But why does gitk, which is primarily a read-only history browsing tool
> (yes, I know it can do "checkout" and stuff), needs to write anything to
> anywhere in the first place?

It happens when you click on a commit, right-click on a file
and then choose "external diff".

gitk writes file@commit and file@commit^ to temporary files
and diffs them using an external diff tool.

Shall I reroll with s/GITK_TMPDIR/TMPDIR/ ?

gitk was written before git-difftool existed.
A higher impact change would be to change gitk to use
git-difftool instead of managing its own temporary files.

If we're looking for the ideal solution than that is
probably it.  The only downside is that gitk would stop
working with git versions < 1.6.3.  That doesn't seem like
a real issue, though, because gitk is bundled with git.

Thoughts?

-- 
		David
