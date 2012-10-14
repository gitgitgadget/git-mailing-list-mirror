From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 0/2] Re: [PATCH] config: warn on inaccessible files
Date: Sun, 14 Oct 2012 02:00:42 -0700
Message-ID: <20121014090041.GE7190@elie.Belkin>
References: <20121014000210.GA19094@elie.Belkin>
 <7vhapx1wlh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 14 11:01:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNK4D-0000K8-2U
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 11:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490Ab2JNJAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 05:00:50 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:42208 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab2JNJAt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 05:00:49 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so2063526dak.19
        for <git@vger.kernel.org>; Sun, 14 Oct 2012 02:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=c+cC9F+j6unwr4KMwDJZs7EgpiVXMibWYudi6F/YhKA=;
        b=jujSZx3z+I3AgDYHFHtWCg+d12SCY8JCJNxmNDJ66W7SXQcWrRTVEuJBDW3qodvMhU
         bhHEWSH2jqs/FcTrqgA3NS9KAcaNFSyISzLmRIT0o9pXC1Jgt3CewMrp+JqFAuQ6uRXk
         yov9IC9wFn+ITxJFXh3pi5czo8fIwrE2OQrRXQkXB73Q8xFWyIwTAooW4sMVuLjLReAf
         KRmQPSNqYeiv724kl2Hm+HmQ5pXCSHnQcb5XlAS38hPB4fTZr2EnUgmwssINl5fE8g0Q
         /BfG6Q2ORjn5hHNANBdNhP/1d2keO9XFtYFqlByVNZwJSzH5KbbtH6w5g0JFAry++SpW
         Q8zQ==
Received: by 10.66.88.40 with SMTP id bd8mr24208992pab.36.1350205249076;
        Sun, 14 Oct 2012 02:00:49 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id qd9sm7229155pbb.31.2012.10.14.02.00.48
        (version=SSLv3 cipher=OTHER);
        Sun, 14 Oct 2012 02:00:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vhapx1wlh.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207649>

Junio C Hamano wrote:

>                                             If the config side can
> be switched to unconditionally attempt to fopen and then deal with
> an error when it happens, we can get rid of access_or_{warn,die}
> and replace them with fopen_or_{warn,die} and use them from the two
> places (attr.c:read_attr_from_file() and the configuration stuff).
>
> I haven't looked to see if that a too intrusive refactoring to be
> worth it, though.

That sounds reasonable, but I'm punting on it.  The first step would
be tweaking the git_config_from_file() calling convention to convey
"missing file" errors specially, perhaps by making sure errno is
meaningful when the return value is -1, and that already sounds like
work. ;-)

Thanks,
Jonathan
