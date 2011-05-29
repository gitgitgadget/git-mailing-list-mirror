From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] rebase: learn --discard subcommand
Date: Sun, 29 May 2011 08:50:19 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1105290841400.28815@debian>
References: <1306551495-26685-1-git-send-email-martin.von.zweigbergk@gmail.com> <BANLkTim-Wva018BFeTUPqZuiK02-X01XJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 29 14:50:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQfRw-00023v-Qv
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 14:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444Ab1E2Mu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2011 08:50:27 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48464 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631Ab1E2Mu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2011 08:50:26 -0400
Received: by qyk7 with SMTP id 7so451969qyk.19
        for <git@vger.kernel.org>; Sun, 29 May 2011 05:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type;
        bh=HrFflcMRbaNJm5ykqz1oQP181FOu/iuom6DwodgJw4E=;
        b=hZ8ICCRLCdGWoUTIMM+vwCU5h6I85e/qOgZmWh4r0rF/O6udAP9erzGaRuo7DHzOwr
         lz1pDKtk+hEmBzyMw7jkrM5JVP1at38QbRSkmJVKF9JrpsiVbgw43yloQmHeaXREOpoN
         rD3mcilwOo1PPwhajl2jJdIQ1lmTIJVx8c9qw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        b=I3uMO1jk4mvpLOmR4m5+j2FBuoUA1RF1vIcGO2+56k1VpEfQDCrAc6NdwsBXmaaoz8
         iEK/Uv0puf8+Yd+bEzaaXL0UI9frS0r9eDekNY7HyBi/9vygJKxnvmS6oiNqzF91e0Ym
         J1U4h/B44iJV/4gQt5GD5DRgReaKhRx5jVkAY=
Received: by 10.224.184.204 with SMTP id cl12mr2903927qab.69.1306673425711;
        Sun, 29 May 2011 05:50:25 -0700 (PDT)
Received: from [192.168.1.103] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id j18sm2242017qck.15.2011.05.29.05.50.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 May 2011 05:50:24 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <BANLkTim-Wva018BFeTUPqZuiK02-X01XJQ@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174688>

On Sat, 28 May 2011, Ramkumar Ramachandra wrote:

> > I used "rm -r" without -f to match how it is done in --abort, but
> > maybe -f should be used? That is what we recommend to the end-user to
> > use today.
> 
> If you've verified that a rebase is already in progress, I don't see
> the point of using '-f'. Otherwise, it should error out and say that
> "no rebase is in progress", like the other command-line options
> currently do.

Yep, it does verify that a rebase is in progress. I think rm without
-f still asks the user to confirm if the file is read-only. I can't
see why that would happen, so maybe it's good to have the user confirm
it it does happen.

> > A difference from --abort is that --discard does not clear
> > rerere. Need this be mentioned in the documentation?
> 
> It depends on what you're expecting the user to do in this detached
> HEAD state, no?

The subcommand will most likely be run when the user had forgotten the
current rebase and tries to start a new rebase and get's the message
that a rebase is already in progress. At this point, the user is not
necessarily in a detached HEAD state any more.

/Martin
