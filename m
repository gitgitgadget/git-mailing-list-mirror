From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-clone.txt: Adjust note to --shared for new pruning behavior of git-gc
Date: Thu, 03 Apr 2008 23:49:10 -0700 (PDT)
Message-ID: <m3prt6t8sn.fsf@localhost.localdomain>
References: <47F52145.306@nrlssc.navy.mil>
	<alpine.LSU.1.00.0804032113280.4008@racer.site>
	<47F54342.1040901@nrlssc.navy.mil>
	<alpine.LSU.1.00.0804032200310.4008@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 04 08:50:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhfkR-0004QU-Dz
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 08:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbYDDGtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 02:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbYDDGtP
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 02:49:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:40010 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbYDDGtP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 02:49:15 -0400
Received: by ug-out-1314.google.com with SMTP id z38so910330ugc.16
        for <git@vger.kernel.org>; Thu, 03 Apr 2008 23:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=Hef7LY0C2bK2wTUMhm2Y0978ewlE7S/idL8rxpK2zH0=;
        b=s48iXKbvfFI9WeYzRhQBqziYzo3TwHHoOL0ixTM4Mi3e1wIKeuMuiAuvLIjlql9pAEycroRJHAo34r9lYr5GrOcOclG6z031lmebMHOIPrZTrXeKYXi4JgyIBnrPGEAZEL+Kxnj5fh0/hyIBlEkZpPPYZM53/7JHFQEOPEmTGoY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=g/Fa6bqJy/g9D3TnIQfyAsrWgbtJ10ZCDzgrsIxnEIbUcNtRlUmGrOL0SiaPCl+B6dLAvpVKy9tu8CL3c9QMvepozw00oPY2vblSkyz8hEQNmwnwY3QPU6qBNxRsIhxukhrieBZP/NS46OtQArUnkfJ9Uab5MZZdCjMz4iCtaUo=
Received: by 10.67.116.19 with SMTP id t19mr516748ugm.47.1207291751557;
        Thu, 03 Apr 2008 23:49:11 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.217.217])
        by mx.google.com with ESMTPS id l33sm2354357ugc.67.2008.04.03.23.49.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Apr 2008 23:49:10 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m346n0OP010874;
	Fri, 4 Apr 2008 08:49:01 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m346mOBY010869;
	Fri, 4 Apr 2008 08:48:24 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.LSU.1.00.0804032200310.4008@racer.site>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78797>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 3 Apr 2008, Brandon Casey wrote:
> > But what I was really trying to point out in the documentation changes 
> > was that now _other_ commands such as git-commit are also unsafe since 
> > they call 'git-gc --auto' and could cause loose unreferenced objects to 
> > be deleted. So it is not enough to just avoid calling git-gc when 
> > dealing with a --shared repository.
> 
> Right.  Hmm.  I missed that completely when I thought about prune 
> --expire.

I think that if you are using repository from which other repos borrow
objects via alternates, it is a good idea to turn off automatic
repacking with "git gc --auto" by setting gc.auto to 0 (or, hopefully,
"never" or "false").

-- 
Jakub Narebski
Poland
ShadeHawk on #git
