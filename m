From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git: How to keep multiple bare repos in sync?
Date: Tue, 12 May 2015 21:37:45 -0700
Message-ID: <xmqq4mnhccti.fsf@gitster.dls.corp.google.com>
References: <2015051312090840845945@126.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: chenxitwo <chenxitwo@126.com>
X-From: git-owner@vger.kernel.org Wed May 13 06:37:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsOQa-0001Ij-4o
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 06:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbbEMEhs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 00:37:48 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36782 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbbEMEhr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 00:37:47 -0400
Received: by igbpi8 with SMTP id pi8so128561557igb.1
        for <git@vger.kernel.org>; Tue, 12 May 2015 21:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=kgws02kjuieujvRqT3sBykG62hGzD/+NQz54SqfE4mM=;
        b=CNQFxWButVAEzs4hlikTFF/EEZkzyNEJeqSY36lslWjmY+1IVjEv/Am+ZC94Us5PuG
         lFhFOL2SOxNOHGunDlxfNJN8BTPAnt11rQ5neon9oId7T4TOy+bNB4Pc6rcFkgrJev35
         XxftJ6ohANe4+XVV/G1q7H6IkQ8pjvLA83oCyg7IHd7H8lnFvf4Jdv0sdb+K02mhivtZ
         WYjU1iAgW1ZnSbPrevffUuBdwPgRSrmxVEElD/GF07LUa/D5M/uGHmYPknlT0G3R/euS
         mwCH6HyXYTOYeUG8N9VoFBDyuvp6ZwIiEiLwMjVjk2xZF4oHH5owF22+OpZVafJWTnDb
         hNdg==
X-Received: by 10.107.135.35 with SMTP id j35mr23985935iod.91.1431491867006;
        Tue, 12 May 2015 21:37:47 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3cfa:54ee:8e48:89ad])
        by mx.google.com with ESMTPSA id i191sm9843793ioe.0.2015.05.12.21.37.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 21:37:46 -0700 (PDT)
In-Reply-To: <2015051312090840845945@126.com> (chenxitwo@126.com's message of
	"Wed, 13 May 2015 12:09:10 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268925>

chenxitwo <chenxitwo@126.com> writes:

> There are three git server(bare repos), but i don't know to solve the
> problem that how to keep these git servers in sync.

rsync?

The problem is under-specified.  Is there one of them that is
authoritative and that the other ones should match its progress?
If so, perhaps push from the authoritative one to the other two
with "push --mirror" (or have the other ones "fetch --mirror")?

If you are allowing people to push into any of them randomly,
then there is no general solution.  If I push an update to 'master'
of instance A while you update the same 'master' branch of instance
B, somebody has to reconcile the divergence between the two by
creating a merge, and that can possibly conflict, needing human
intervention to resolve.
 
