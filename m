From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] mailsplit and mailinfo: gracefully handle NUL characters
Date: Fri, 16 May 2008 10:03:46 -0400
Message-ID: <32541b130805160703r27a55b91xbad03eb1d107a176@mail.gmail.com>
References: <482BE5F7.2050108@thorn.ws>
	 <alpine.DEB.1.00.0805161139530.30431@racer>
	 <alpine.DEB.1.00.0805161148010.30431@racer>
	 <alpine.DEB.1.00.0805161403130.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Tommy Thorn" <tommy-git@thorn.ws>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 16 16:04:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx0Y2-0007fB-Qz
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 16:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbYEPODs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 10:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbYEPODs
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 10:03:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:64640 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbYEPODs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 10:03:48 -0400
Received: by fg-out-1718.google.com with SMTP id 19so715255fgg.17
        for <git@vger.kernel.org>; Fri, 16 May 2008 07:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+ZQ0wIpoVOk9FoayxH2UxJw/UZydORY5WtFnPbujUMY=;
        b=xdqHDdU6qUChDTjCYjq0OS4h+UCH1jsbj0BQ0j4b+OsnnJwN74AXpUWiVKObNlIymPurQDs6OoJvl/Z0T3lp3+53398+sc5Y2MRzw3mXCj6YqfCkp8Ihl2lb8w5kA2IOFI/7xIDLwOSHC8HRd7d41c3iRDHPD0KaNOslXuAc7iE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UGGxDU1Wa4NC6q4KfdBdxfyfeDhYVe3iaZmAIydNTsgf1Cx799zhNYGBlsX7MpyG3IqkMqMwwiq2lbM8y5aQk+hFhTL7cV/i1nPdlzRoWZt+DRGY/kbPlRPFP47QGQmO+CwHGJGEw3VNGxbwVZ6ycuRb/qAYxAyPW40ASUnxTvg=
Received: by 10.82.175.7 with SMTP id x7mr493694bue.35.1210946626229;
        Fri, 16 May 2008 07:03:46 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Fri, 16 May 2008 07:03:46 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805161403130.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82289>

On 5/16/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>         BTW I do not know how much fgetc() instead of fgets() slows
>         down things, but I expect both to be equally fast because
>         they are both buffered, right?

In my experience, fgetc() is pretty fantastically slow because you
have a function call for every byte (and, I gather, modern libc does
thread locking for every fgetc).  It's usually much faster to fread()
into a buffer and then access the buffer.  I don't know if that's
appropriate (or matters) here, though.

Have fun,

Avery
