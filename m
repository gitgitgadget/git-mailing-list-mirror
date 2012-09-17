From: Ben Walton <bdwalton@gmail.com>
Subject: Re: Unable to clone GIT project
Date: Mon, 17 Sep 2012 16:36:19 -0400
Message-ID: <CAP30j15=gz9w-ZU+b5Jm+fM1PmYgFrwBwAFxzAcPRsWgNcByOw@mail.gmail.com>
References: <0D5A104FDD13FC4C9EE1E66F4FA3ABF60FCFDB65@NOIX10HMNOI01.AMER.DELL.COM>
	<20120916104651.GF32381@localhost.localdomain>
	<CABPQNSbPF=_a7-+JnojM2DQAkkj7ZLhSnO+n-Ab=LSrHge1dnQ@mail.gmail.com>
	<20120917202124.GC24888@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Ankush_Aggarwal@dell.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 17 22:36:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDi3W-0002iA-81
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 22:36:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755616Ab2IQUgW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 16:36:22 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:52256 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755368Ab2IQUgU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 16:36:20 -0400
Received: by wgbdr13 with SMTP id dr13so6162040wgb.1
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 13:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xO8FCEhjCokWB9IQ9lliAmGkf48wK4i48lHcDI6kbnI=;
        b=AWlk7oQehxjw0bNDfPtmUowEad0KJBqfb5pkGdhiYzZpAq7dHYSk+l+p35LwanE8zd
         CIP6txWRK+fjIHywjdntIqb6SXZb+Q7wJHBeucU4fAwUpH6hcbqdxNHQGb+CJkGZHmpZ
         sAGzzcDycGe/tM9GiRNkECtqDIAb/DTkvkBaZsBko9+pi6HljYI0IKiTluFkiREgUWj9
         IeSVmz2Ke/zgN+PdW7pnSh8KNmVpYp2i2q8TQDG0N0Y0ngP4s6aCmLPMSDO8C1KoUbb7
         yc9yqBR8OuknyW2zKXc30FMrvalmIK6RGLBvDChrdfEeyIfVmJ4GbuIK83TINuOlGUxf
         1i5A==
Received: by 10.180.73.76 with SMTP id j12mr18365096wiv.11.1347914179137; Mon,
 17 Sep 2012 13:36:19 -0700 (PDT)
Received: by 10.216.61.143 with HTTP; Mon, 17 Sep 2012 13:36:19 -0700 (PDT)
In-Reply-To: <20120917202124.GC24888@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205741>

> If I had to guess, I'd say it was ssh, the library is installed in a
> non-standard place (e.g., because he built them as a regular user and
> put them in his home directory), and LD_LIBRARY_PATH does not get set
> properly by ssh for the incoming ssh session.

This would be my guess as well.  If LD_LIBRARY_PATH is being relied
upon though, a more stable solution would be to rebuild git with
"-Wl,-rpath /path/containing/libiconv" in the LD_OPTIONS environment.
That would remove the need for LD_LIBRARY_PATH at runtime.  Any other
libraries linked in non-standard locations should also have a similar
option if the path to the library differs.

HTH.

Thanks
-Ben
-- 
---------------------------------------------------------------------------------------------------------------------------
Take the risk of thinking for yourself.  Much more happiness,
truth, beauty and wisdom will come to you that way.

-Christopher Hitchens
---------------------------------------------------------------------------------------------------------------------------
