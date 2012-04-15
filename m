From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Pushing to a remote repo from a remote repo?
Date: Sun, 15 Apr 2012 03:09:55 -0700 (PDT)
Message-ID: <m3lilx9uhf.fsf@localhost.localdomain>
References: <CAAnwhhWTcfOi+qqXPnGNXSKHbFh5L=+6eSKaaex5mq6VTwSxEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Cardarella <brian@dockyard.com>
X-From: git-owner@vger.kernel.org Sun Apr 15 12:10:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJMPC-00059C-Ue
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 12:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917Ab2DOKJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 06:09:58 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:64267 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750963Ab2DOKJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 06:09:57 -0400
Received: by wgbdr13 with SMTP id dr13so4307004wgb.1
        for <git@vger.kernel.org>; Sun, 15 Apr 2012 03:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=ILNrU2DKPiy195IvsNvcgF37lHHlLmx9fSzqNb033rY=;
        b=UyEQyU/GizxtqYiuVl5ZDrjXrXhxvfIyXkBBT5MH+lAv/D00+Hj/ij76ld9txBgETN
         pQsXCvYOIC3e/QEXK3PPVr32N7U/MY/xI+We1/KiSDZY5MjsRNH38eAxqAPQfJiPqg2m
         TZEd2t7heo0O+ILxKwB5BIEp09ogJKcch/ABJjBt+J9mEwhlrD2AaB47HUVZyqIFuK/t
         cfVU3btQp4z9V6pSWEDNHqcOUMvTjWwLg5slFC7vN1JEHkZrlcQ8gdaQ4hZSIe1LDYub
         oEDAYYBFQtm3e1+5r5tHPdeY3TSFsFf12V6HCTOoJnH2lLzP7YkapgUCUeqizIsz7AbI
         aIFg==
Received: by 10.180.101.136 with SMTP id fg8mr9811798wib.4.1334484596340;
        Sun, 15 Apr 2012 03:09:56 -0700 (PDT)
Received: from localhost.localdomain (acxb239.neoplus.adsl.tpnet.pl. [83.11.159.239])
        by mx.google.com with ESMTPS id n8sm17888023wix.10.2012.04.15.03.09.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 Apr 2012 03:09:55 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q3FA9o1X003342;
	Sun, 15 Apr 2012 12:09:51 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q3FA9nJ1003339;
	Sun, 15 Apr 2012 12:09:49 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAAnwhhWTcfOi+qqXPnGNXSKHbFh5L=+6eSKaaex5mq6VTwSxEw@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195555>

Brian Cardarella <brian@dockyard.com> writes:

> So I have a destination repo that is remote. And I have a source repo
> that is also remote. I would like my local machine to act as a proxy
> to allow me to push to the destination from the source without ever
> download the repo to my machine. Is this possible?

First, you can set up either SSH tunnel (for SSH transport), or HTTP
proxy (`http_proxy`[1] environment variable or `http.proxy` config
variable[2] for HTTP transport, both smart and dumb), or git proxy
(`core.gitproxy`, e.g. netcat or ssh, for git:// protocol)

Second, you can configure repository using hooks so that pushing to
said intermediate repository would push to destination repository.  In
this solution you would have repository on disk on intermediate
machine, but you can avoid manual transfer to and from intermediate
machine.

[1] curl(1) manpage, the "Environment" section
[2] git-config(1) manpage

HTH
-- 
Jakub Narebski
