From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Give better 'pull' advice when pushing non-ff updates to current branch
Date: Tue, 24 Apr 2012 12:06:48 -0700
Message-ID: <xmqqehrdgd9z.fsf@junio.mtv.corp.google.com>
References: <1335221121-36664-1-git-send-email-christiwald@gmail.com>
	<xmqqvckpho0a.fsf@junio.mtv.corp.google.com>
	<20120424045844.GA41274@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr, peff@peff.net
To: Christopher Tiwald <christiwald@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 21:07:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMl4h-0008Sw-Pl
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 21:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745Ab2DXTGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 15:06:51 -0400
Received: from mail-ey0-f202.google.com ([209.85.215.202]:34992 "EHLO
	mail-ey0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab2DXTGu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 15:06:50 -0400
Received: by eaaq10 with SMTP id q10so53127eaa.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 12:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=TjcW7cBsOXAKUC6bREyLUGHr7eBEpenKNb624JLf0ek=;
        b=JyFKPKBlpSDDDnkUdO8zvEPsDHjlHEF5+uU77kKnKpWxSa8et8IbBk0Ia/YwSQRp5g
         Q2DiTazG4Q/EFtTEilTM+zYOkY+1yER7jDiQyZt2ezCbbvfb5aoFHXKt7N12JfBNX2HX
         KsmO/2Yy2pUEx7aywOrnxeDWK3R7mP9rw7K4jc3AqOfpFFqcWQaSMw5r5M/DYI8fwcFn
         XvWjEprexvtJ0no9tnpcVpBYDzMPsVNzcm5kH79z1cn9Yb0LKeVU5++gj170TreoXfd0
         JZr5pSUaOAx0Pffrz4ReJ0YROYUK/qepFe+zDI9XZwtqxbKUJu50wNuTfhtL/CHrg1LP
         8MHA==
Received: by 10.213.4.83 with SMTP id 19mr14850ebq.16.1335294409451;
        Tue, 24 Apr 2012 12:06:49 -0700 (PDT)
Received: by 10.213.4.83 with SMTP id 19mr14837ebq.16.1335294409327;
        Tue, 24 Apr 2012 12:06:49 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id t8si13802290eef.1.2012.04.24.12.06.49
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 24 Apr 2012 12:06:49 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 245DD20004E;
	Tue, 24 Apr 2012 12:06:49 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 76470E125C; Tue, 24 Apr 2012 12:06:48 -0700 (PDT)
In-Reply-To: <20120424045844.GA41274@gmail.com> (Christopher Tiwald's message
	of "Tue, 24 Apr 2012 00:58:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQkHTd5g3vH3GkL62N3at8nR9P2Hjv3oYAWhID1ceSAQbrZkk9ieUy/puECN5jhECkKCCu6CqzlngPwbLl4PQp2gSJpZkhzjcwdrpQz7A1vFfjgbdFo7pBkJUTiLYJxDEKUUOqQH8o+7hbsxZB+Tx43/Z33PfkauOb1c5oa3W5j3kVjUgnY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196237>

Christopher Tiwald <christiwald@gmail.com> writes:

> I think that might be the way to go. I approached this from a specific
> workflow assumption. In retrospect, I can't divine the motivation of
> merge configurations well enough to avoid bad advice.

I am very sympathetic to your underlying motivation to avoid telling
them to "perform a git pull to integrate the history from the other side
before you push" and then getting misunderstood as if you told them to
LITERALLY type "git pull<RETURN>".  Depending on how the branch the user
wanted to push, the approach needed to update its history so that
contains the history from the other side will be different, and you need
to have everything configured correctly for your case to be able to type
"git pull<RETURN>" literally and get the right result.  If you were trying
to push one-shot into somewhere you do not usually push to, it is very
likely that you would need to say "git pull $there $that", and there is
no canned "Type this LITERALLY to continue" recipe that is appropriate
in the advice message.

Perhaps a safer way out is to phrase the advice message in such a way
that it is crystal clear to anybody halfway intelligent that there is
nothing the user can cut and paste from there?
