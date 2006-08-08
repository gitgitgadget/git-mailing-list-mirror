From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: [PATCH 2/2] builtin git-mv: support moving directories
Date: Tue, 8 Aug 2006 20:34:24 +0200
Message-ID: <17624.55600.423000.61479@lapjr.intranet.kiel.bmiag.de>
References: <Pine.LNX.4.63.0607261941210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jon Smirl <jonsmirl@gmail.com>, git@vger.kernel.org,
	junkio@cox.net, Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 08 20:35:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAWPs-0002jo-FW
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 20:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965023AbWHHSe5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 14:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbWHHSe4
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 14:34:56 -0400
Received: from bilbo.bmiag.de ([62.154.210.131]:43780 "HELO bilbo.bmiag.de")
	by vger.kernel.org with SMTP id S965023AbWHHSe4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Aug 2006 14:34:56 -0400
Received: (qmail 9773 invoked by uid 106); 8 Aug 2006 18:34:54 -0000
Received: from eotheod.intranet.kiel.bmiag.de(10.130.2.1)
 via SMTP by bilbo.bmiag.de, id smtpdu5usum; Tue Aug  8 20:34:46 2006
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id A77743BB50
	for <git@vger.kernel.org>; Tue,  8 Aug 2006 20:34:45 +0200 (CEST)
Received: from eotheod.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eotheod [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 05720-09 for <git@vger.kernel.org>;
	Tue, 8 Aug 2006 20:34:36 +0200 (CEST)
Received: from bmiag.de (elros.intranet.kiel.bmiag.de [10.132.1.1])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with SMTP id F0BA43AF51
	for <git@vger.kernel.org>; Tue,  8 Aug 2006 20:34:35 +0200 (CEST)
Received: (qmail 21735 invoked by uid 5002); 8 Aug 2006 18:34:35 -0000
Received: from dialin5.galadriel.bmiag.de (HELO LAPJR) (192.168.251.5)
  by elros.intranet.kiel.bmiag.de with SMTP; 8 Aug 2006 18:34:35 -0000
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607261941210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eotheod.intranet.kiel.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25080>

This might have been fixed already (my tree is a couple of days old),
but the strcat fails for me, because the alloced memory is not
cleared.

Johannes Schindelin writes:
 > +static const char *add_slash(const char *path)
 > +{
 > +	int len = strlen(path);
 > +	if (path[len - 1] != '/') {
 > +		char *with_slash = xmalloc(len + 2);
 > +		memcpy(with_slash, path, len);
 > +		strcat(with_slash + len, "/");
 > +		return with_slash;
 > +	}
 > +	return path;
 > +}

perhaps morph the strcat into a memcopy or append the slash and the
NUL manually?

  jr
