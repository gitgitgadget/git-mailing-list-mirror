From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Possible bug in 'git status' exit code is 1 instead of 0
Date: Tue, 9 Jan 2007 21:47:53 +0100
Message-ID: <e5bfff550701091247n67b8d080oe804320453114d04@mail.gmail.com>
References: <e5bfff550701090945u5a240fe9xf46cc40b030e1ba7@mail.gmail.com>
	 <7vhcv0m5md.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550701091033x51496b38x6c6f798e8a7ae795@mail.gmail.com>
	 <7vslekkpav.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 21:48:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Nsz-0008HJ-E4
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 21:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbXAIUrz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 15:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbXAIUrz
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 15:47:55 -0500
Received: from nz-out-0506.google.com ([64.233.162.237]:23172 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932337AbXAIUry (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 15:47:54 -0500
Received: by nz-out-0506.google.com with SMTP id s1so4087959nze
        for <git@vger.kernel.org>; Tue, 09 Jan 2007 12:47:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pIQ264jGLpFpu6H8V2G2CmRuqqzT3Iw/O5xCJQnklVC7uAU9I7NpulNpbNTPNgZksmJoPkjZNfNhHZ2jCfSBe3YFKO2g8/GZcjiZLWEagtFd868pBgHGLOdgropHYUyTjK7NDztZhvRey7I5I71d3QBDVDZCRUKTONVjFEF3r4o=
Received: by 10.35.41.12 with SMTP id t12mr51619581pyj.1168375673691;
        Tue, 09 Jan 2007 12:47:53 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Tue, 9 Jan 2007 12:47:53 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vslekkpav.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36397>

On 1/9/07, Junio C Hamano <junkio@cox.net> wrote:
> "Marco Costalba" <mcostalba@gmail.com> writes:
>
> > Ok, I was changing the error detection to check exit status, but it's
> > definitely better to still check for something written to stdErr
> > instead.
>
> Non-zero status to indicate there is nothing to commit has
> always been the way for git-status to report since the very
> first edition of the command (a3e870f2, May 30 2005), so you
> should be able to depend on it.
>

Thanks, but what I was trying to find was a reliable way to know, from
qgit side, when a launched external program failed. This should apply
to git commands of course but also to others, as example StGit or bash
ones (ls, cd, etc..).

So the rule should be general enough. Now the rule is to test for the
presence of any message in stdError _or_  for a special Qt flag set,
that is useful to know if the application crashed or terminated
abruptly.

I think I will stick with that because this error detect framework
should stay command agnostic.

 Marco
