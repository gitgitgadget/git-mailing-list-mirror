From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] rebase: learn --discard subcommand
Date: Sun, 29 May 2011 06:41:44 -0700 (PDT)
Message-ID: <m3r57hy68n.fsf@localhost.localdomain>
References: <1306551495-26685-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<7vpqn2psjv.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.2.00.1105290850340.28815@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 29 15:41:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQgFe-0005UN-3y
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 15:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753969Ab1E2Nlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 May 2011 09:41:49 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49183 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942Ab1E2Nls (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2011 09:41:48 -0400
Received: by fxm17 with SMTP id 17so2046324fxm.19
        for <git@vger.kernel.org>; Sun, 29 May 2011 06:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=DxoUsGVQ23AeWc5/KKXSFI9F4pkfVA13+oHbZ6IyTfw=;
        b=XP+srHHQ1hmR/uwifNy2C831TpjXiWFsz10wKHqtIpUGw5lheHcVSwWtR1zsrNvZCI
         ihxVCZx7JIiU8Fs12EBvFEk6rqPmuKKRkTcla0alI/zDdV7l4I3gcg4/ltvoUh4JAuw5
         iiJg8A5s5z9eHgml8DYKPbvSj3sZNFF/bpH2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=McS+6tdN0t4pnaqupagFNQE1gYjjf7UL8UFm81o59msl8ll+z6kjmWc9YFSr0ObHGj
         SpEi8ACbfWKKTHEvl1w4M86EbthKgvqiB0pJX8Z/JBAmFnG9t5EYVNUlimQjm2tVXIW0
         dV9pCyDrOnnNzWUctus2Y0e/Qw2fDuGISioq0=
Received: by 10.223.59.81 with SMTP id k17mr2882730fah.94.1306676506264;
        Sun, 29 May 2011 06:41:46 -0700 (PDT)
Received: from localhost.localdomain (abvt40.neoplus.adsl.tpnet.pl [83.8.217.40])
        by mx.google.com with ESMTPS id m26sm430949fab.10.2011.05.29.06.41.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 May 2011 06:41:44 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p4TDfD40023131;
	Sun, 29 May 2011 15:41:23 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p4TDeu88023124;
	Sun, 29 May 2011 15:40:56 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.2.00.1105290850340.28815@debian>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174691>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> Maybe the recent patch [1] about adding information to git status
> about any ongoing operation would help. I'm not sure, but I think I
> would personally be a bit hesitant to cancel the current sequence
> operation without first checking what it was. OTOH, if I don't even
> remember starting a rebase operation, maybe knowing whether it was a
> rebase or an am operation might not help much. But if the message from
> git status would actually say something like "rebase in progress:
> [2/3] War on nbsp: a bit of retreat", then that might help more in
> making a decision to cancel or not.
> 
>  [1] http://thread.gmane.org/gmane.comp.version-control.git/172919

Such information could be not enough.  I understand that "git status"
output space is limited, but it would be nice if e.g. "git status -v"
described current state in more detail:

  rebase in progress: [2/3] War on nbsp: a bit of retreat"
  rebasing xx/foo --onto master~5

It would describe which branch were we rebasing, and on what commit
(preferring for name-rev description to start from branch we were
rebasing onto, if possible).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
