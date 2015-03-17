From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [RFC] git submodule purge
Date: Tue, 17 Mar 2015 09:25:56 +0100
Message-ID: <20150317082556.GI3766@paksenarrion.iveqy.com>
References: <20150316134407.GA31794@pks-tp.elego.de>
 <xmqqmw3drl7s.fsf@gitster.dls.corp.google.com>
 <20150317081826.GB354@pks-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Tue Mar 17 09:26:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXmpE-0000N0-VT
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 09:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbbCQI0E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 04:26:04 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:36103 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbbCQI0A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 04:26:00 -0400
Received: by lbcds1 with SMTP id ds1so1645885lbc.3
        for <git@vger.kernel.org>; Tue, 17 Mar 2015 01:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wbS/PUrdGKYR17q9x5/x1Zw16e+FpfODacbqP4IFrRY=;
        b=SOCjj5dmVFy28iy42S7jARyzDuLduaA8+Af0fq1DRbLNLdXtwhR9iKmzjrjesHacKG
         5caYTJ38SFqVWeUj9nHBHo5sBGjkDVLdenP3g8DjAJpb6nlYfGD0Ma07OPaBcl/qOi83
         EYHMXFKqQ7NCWzuNj5NZEv56iDHXTQ4Y6w3F6c5lzPMLDolf19ZJBeFE1/1f35OeahAb
         0f/B3Ej5lqEwPaZLhYcY7+zrPDGlpGjWonQO8sayG5ogAWkx/3cluFwvvMMcmHgmrCAv
         AUhqWuJLeM0CJFPdC4ueSMZsp59M8vgEKHnL+4TRWzgxmjvJCocUPapm8I73MmY4j/5Q
         9n3Q==
X-Received: by 10.152.36.138 with SMTP id q10mr58028722laj.113.1426580758943;
        Tue, 17 Mar 2015 01:25:58 -0700 (PDT)
Received: from paksenarrion.paks.iveqy.com (c83-249-10-52.bredband.comhem.se. [83.249.10.52])
        by mx.google.com with ESMTPSA id n15sm2658113laa.36.2015.03.17.01.25.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2015 01:25:58 -0700 (PDT)
Received: from iveqy by paksenarrion.paks.iveqy.com with local (Exim 4.84)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1YXmp2-0004jx-Rc; Tue, 17 Mar 2015 09:25:56 +0100
Content-Disposition: inline
In-Reply-To: <20150317081826.GB354@pks-pc>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265622>

On Tue, Mar 17, 2015 at 09:18:26AM +0100, Patrick Steinhardt wrote:
> Is it even possible to create a new submodule without any
> upstream repository? At least `git submodule init` does not work
> without a corresponding entry in .gitmodules which the user would
> have needed to create himself manually. In this case one _could_
> assume that the user knows what he is doing and expect him not to
> call `submodule purge` (or whatever the command will be called)
> on the authoritative copy. Other than that I've got no idea how
> to assure safety.

Look at git/t/t7400-submodule-basic.sh for example at the test starting
at line 84 on how to add a submodule without any upstream.

Git has already a disadvantage against other SCM (like mercurial)
because it's "too easy to loose data with git". Meaning that we purge
unrefered commits. (Yes this is up to debate if this is good or bad, but
here's not the place).

I think we should be very carefully with adding commands that
permanently removes data. They should be really well crafted so that
there's no way to do this by mistake.

-- 
Fredrik Gustafsson

phone: +46 733-608274
e-mail: iveqy@iveqy.com
website: http://www.iveqy.com
