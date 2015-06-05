From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] git-am: handling unborn branches
Date: Fri, 05 Jun 2015 08:36:37 -0700
Message-ID: <xmqqfv66tbei.fsf@gitster.dls.corp.google.com>
References: <CACRoPnSmF0ym7ONnLAfL=o5ouSrP2Ucxdh40k6Ps-hnTsSUx4w@mail.gmail.com>
	<xmqqpp5bv0z9.fsf@gitster.dls.corp.google.com>
	<CACRoPnS9UK0ebD2JdSfun8+F0MXj6Loza4Y07whqbO6tV4_APQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 17:37:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0tfo-0000in-Iv
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 17:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423552AbbFEPgk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 11:36:40 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35590 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527AbbFEPgj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 11:36:39 -0400
Received: by igbzc4 with SMTP id zc4so18633919igb.0
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 08:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=RbZYaqFzXVE+c/mgoygBbl9eU85n42+ZHcXjLVQzUtY=;
        b=EqmKqIZ9U8Qe3uBt8zlmLPHgPrATsvBSQq1IFmhVbKjFydL+Aa180gO3bhbilWPt5c
         gRy9vJ5Lpb88hevatiIOhUXBTofUtVH4FpiYMm4rqFBiwUeofYGBieVgO+Xvov+Ws8xN
         HT6nAOvOl8p3oxA+blOOtGUPHGqnnB4wvkhmA3nZ1zqu7xfWJx2XLHyaZTBpzb5f4HC9
         Cyj92bodLotj+GgOVt//VEa3Pvn8em8mVoJrFYNZ5UE7Sc2BG8gLzuSVCaVNxay0cwip
         KzwJVU4aseXaNNYvIs9Mosds+wx2TBeTx4+oGU18/ZQld3GBapWuqS/hV7mIXb2j2amQ
         8b/A==
X-Received: by 10.50.136.134 with SMTP id qa6mr41888968igb.26.1433518598648;
        Fri, 05 Jun 2015 08:36:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:8c50:e66f:fc40:1825])
        by mx.google.com with ESMTPSA id v14sm1524549igd.12.2015.06.05.08.36.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jun 2015 08:36:38 -0700 (PDT)
In-Reply-To: <CACRoPnS9UK0ebD2JdSfun8+F0MXj6Loza4Y07whqbO6tV4_APQ@mail.gmail.com>
	(Paul Tan's message of "Fri, 5 Jun 2015 14:37:24 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270842>

Paul Tan <pyokagan@gmail.com> writes:

> Hmm, actually git-am.sh doesn't seem to do that even when we have a
> history to apply patches to. This is okay in the non-3way case, as
> git-apply will check to see if the patch applies before it modifies
> the index, but if we fall back on 3-way merge, any new files the
> failed merge added will not be deleted in the "git read-tree --reset
> -u HEAD HEAD".
>
> Should we do that?

That sounds like the right thing to do; I agree that fixing it may
or may not be outside the scope of the immediate series.
