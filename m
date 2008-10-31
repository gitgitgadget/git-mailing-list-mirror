From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Are binary xdeltas only used if you use git-gc?
Date: Fri, 31 Oct 2008 04:15:32 -0700 (PDT)
Message-ID: <m37i7pggnk.fsf@localhost.localdomain>
References: <f1d2d9ca0810310243r669840bbj2c5ee7183e0caaed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Thanassis Tsiodras" <ttsiodras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 12:16:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvrzj-0007VQ-Tu
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 12:16:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbYJaLPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 07:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbYJaLPh
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 07:15:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:41730 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbYJaLPf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 07:15:35 -0400
Received: by ug-out-1314.google.com with SMTP id 39so1195540ugf.37
        for <git@vger.kernel.org>; Fri, 31 Oct 2008 04:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=GOTwBAXqkpVgAtUskgx6gorXiXQOshMfxGKIVMy7c5M=;
        b=XFXTS1z+myN17mzb43CUZK0W5dnNjeJRyJCV/t/W0spWjdeUOMeEXiYDn9zjfjomzD
         9EXQpdcKFaR0fgWl8MZQGOPk/eC5qUTH4j6hqsWmBTJiJFdPGmmpjQtd9T8sZ9Kam53z
         5c2novssCNCxvrnT+IcDXw88ascN7HJcauBpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=Ln97Xz1fI+m5GeiLwHjNeVNiPR13uMxXAyfA9puD2Dygp6MshR+DdbVGVtUrpZyn37
         JdEfvCNS8ZhYY4fN8kJ1A5FNMsoSaLYygkhc555O1iW0N5BOeAXee2l1p14yyTlo+9Am
         dV2yk22BNYAymErUPIYYjjRhhb1RM1QBtxwjM=
Received: by 10.67.119.8 with SMTP id w8mr2555635ugm.20.1225451733844;
        Fri, 31 Oct 2008 04:15:33 -0700 (PDT)
Received: from localhost.localdomain (abvo7.neoplus.adsl.tpnet.pl [83.8.212.7])
        by mx.google.com with ESMTPS id s8sm4664155uge.18.2008.10.31.04.15.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 31 Oct 2008 04:15:32 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9VBF6eT024010;
	Fri, 31 Oct 2008 12:15:17 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9VBEtSo024006;
	Fri, 31 Oct 2008 12:14:55 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <f1d2d9ca0810310243r669840bbj2c5ee7183e0caaed@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99576>

"Thanassis Tsiodras" <ttsiodras@gmail.com> writes:

> I've been usig Git for the last couple of months and am quite happy with it.
> In one of my Git repositories, I am storing uncompressed .tar files
> (since being uncompressed allows git to detect and store
> only their "real"differences).

I think you can use clean / smudge filter in gitattributes for that.

[...]

> Then again, I must confess I only did the git-gc after I pushed.
> Does the git-push actually take advantage of the similarities only if
> I do a git-gc first?

Git does deltification _only_ in packfiles. But when you push via SSH
git would generate a pack file with commits the other side doesn't
have, and those packs are thin packs, so they also have deltas... but
the remote side then adds bases to those thin packs making them
standalone: you would have to git-gc on remote.

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
