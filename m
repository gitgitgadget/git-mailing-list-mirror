From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Submodule relative URL problems
Date: Mon, 13 Jan 2014 11:55:18 -0800
Message-ID: <20140113195518.GB18964@google.com>
References: <DC691CA7-BE36-4FE7-895A-FE8E1FD0C080@kcl.ac.uk>
 <DAD6CF7D-49F2-4FB5-9EF2-EBAAF86881AA@kcl.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Lianheng Tong <lianheng.tong@kcl.ac.uk>
X-From: git-owner@vger.kernel.org Mon Jan 13 20:55:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2nbd-0002ti-9U
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jan 2014 20:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbaAMTzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 14:55:24 -0500
Received: from mail-gg0-f177.google.com ([209.85.161.177]:45174 "EHLO
	mail-gg0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbaAMTzX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jan 2014 14:55:23 -0500
Received: by mail-gg0-f177.google.com with SMTP id f4so555296ggn.22
        for <git@vger.kernel.org>; Mon, 13 Jan 2014 11:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vdwS6HHXcTf3rVOYMuoI429bPBPIpJPKm+DFxphWkVg=;
        b=dKYp/qCy5gvFY7IJJiQ+J043NiJ5ihstpD+R3ZaVo2pkdTc3eOBXTYxjWrfP6W1+S7
         bJ5AvaElfYd6GVpt1/vzVGZ5LWBgGxv9h97rPYD4KIqgYdGEOoD9Nx9Lj4n70cWKZB7o
         Do39lnu5gup4hNGoiES1DiYRe6tkiPWpd687YX4jscyv8oVzRb1I7XzGQw8mzVRSswgs
         TF+LZlaLvIV7J/xCz1nJHppt3oHpY4rnQnwyUUzBEMG6gDvJf5yX8zZCIpGjG4JyR2Pp
         LmnUlzAAXVaLSCSxnnVzWVBD9Jxt+++58YagEJTnPx/PEiWJgSMtbiRx7xE+lyAnfrOL
         /7Lg==
X-Received: by 10.236.101.227 with SMTP id b63mr28386668yhg.37.1389642921062;
        Mon, 13 Jan 2014 11:55:21 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id c44sm29285259yho.20.2014.01.13.11.55.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 Jan 2014 11:55:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <DAD6CF7D-49F2-4FB5-9EF2-EBAAF86881AA@kcl.ac.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240369>

Hi,

Lianheng Tong wrote:

> git clone W1:<path to A on W1>/.git  <path to A on W2>

Interesting.

Thoughts:

 * More typical usage is to clone from a bare repository (A.git), which
   wouldn't have this problem.  But I think your case is worth
   supporting, too.

 * What would you think of putting symlinks in A's .git directory?

	cd A/.git
	ln -s ../B ../C ../D .

 * Perhaps as a special case when the superproject is foo/.git, git
   should treat relative submodule paths as relative to foo/ instead
   of relative to foo/.git/.  I think that would take care of your
   case without breaking existing normal practices, though after the
   patch is made it still wouldn't take care of people using old
   versions of git without that patch.  What do you think?

Thanks,
Jonathan
