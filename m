From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2 0/4] Auto-generate mergetool lists
Date: Tue, 29 Jan 2013 12:09:23 +0000
Message-ID: <20130129120923.GE7498@serenity.lan>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
 <7v38xm12kk.fsf@alter.siamese.dyndns.org>
 <CAJDDKr7sQKDNPpaFJi+en479TF=aLXL2pvXODeo6CC3xD1KMGw@mail.gmail.com>
 <7vr4l6yrd3.fsf@alter.siamese.dyndns.org>
 <CAJDDKr75K3RGgU79nrznbpjQMLQGkDs=W8XEofURNsS1X1bvjg@mail.gmail.com>
 <20130128210136.GC7498@serenity.lan>
 <7vk3qxugdg.fsf@alter.siamese.dyndns.org>
 <20130128222147.GD7498@serenity.lan>
 <ke8de9$lk5$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Tue Jan 29 13:09:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0A0f-0003qJ-Jd
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 13:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756027Ab3A2MJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 07:09:32 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:36779 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755578Ab3A2MJa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 07:09:30 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 6E6B76064D4;
	Tue, 29 Jan 2013 12:09:30 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zju6zxZ8sBsp; Tue, 29 Jan 2013 12:09:30 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 126FA606506;
	Tue, 29 Jan 2013 12:09:28 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id D3F63161E3A4;
	Tue, 29 Jan 2013 12:09:28 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9zMaX0r5uPY1; Tue, 29 Jan 2013 12:09:28 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id CCAD6161E564;
	Tue, 29 Jan 2013 12:09:25 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <ke8de9$lk5$1@ger.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214931>

On Tue, Jan 29, 2013 at 12:56:58PM +0100, Joachim Schmitz wrote:
> John Keeping wrote:
> > Currently I'm extracting the command word using:
> >
> >    cmd=$(eval -- "set -- $(git config mergetool.$tool.cmd); echo
> > \"$1\"")
> 
> Shouldnt this work?
> cmd=$((git config "mergetool.$tool.cmd" || git config "difftool.$tool.cmd") 
> | awk '{print $1}')

That doesn't handle paths with spaces in, whereas the eval in a subshell
does:

    $ cmd='"my command" $BASE $LOCAL $REMOTE'
    $ echo "$cmd" | awk '{print $1}'
    "my
    $ ( eval -- "set -- $cmd; echo \"\$1\"" )
    my command


John
