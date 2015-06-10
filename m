From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/7] bisect: add the terms old/new
Date: Wed, 10 Jun 2015 14:03:29 -0700
Message-ID: <xmqqoakni8da.fsf@gitster.dls.corp.google.com>
References: <1433953472-32572-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433953472-32572-4-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.lespinet@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	remi.galan-alfonso@ensimag.grenoble-inp.fr,
	guillaume.pages@ensimag.grenoble-inp.fr,
	Matthieu.Moy@grenoble-inp.fr, chriscool@tuxfamily.org,
	thomasxnguy@gmail.com, valentinduperray@gmail.com
To: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 23:03:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2n9t-0002Zi-9s
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 23:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583AbbFJVDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 17:03:32 -0400
Received: from mail-ie0-f194.google.com ([209.85.223.194]:36259 "EHLO
	mail-ie0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754578AbbFJVDb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 17:03:31 -0400
Received: by ierx19 with SMTP id x19so7039260ier.3
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 14:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=3pjKkjLF6fkGJwTgu/HR/NCrqCxSLcDdV0tqlojy6+0=;
        b=dXn1CVXViApeV0VhjLNfg+YmJJuUNwMWqQ/ZM+Sqd81xmYgo1PuKIVLeQvoXexSxgt
         H/Fb9BCXRONVSIipo9fbG1j1UAFppb+HTpjamJl43t6fbb1p80LRiMO0j5KWzZjDm5vr
         /0iNh5i+iSP7zp/HTed1TtSgT7p7JO1wc6Dzg5rjhfHRaxiqzQgHGh6bCct5W1qXe59t
         LbpFdSX+Ox6A14jK2kkrFKR+xk+sF/edE6ph2hiP01+7alCtaGFGrGlJRhkSRt1Cp20x
         w/sCG4cIsT/qC5wv06kDf/AGD2YZfzVP1+d2ypLU+RLPHTipXjPyW9gdwOXWVThLxGb3
         RY2Q==
X-Received: by 10.50.138.74 with SMTP id qo10mr8463894igb.39.1433970211224;
        Wed, 10 Jun 2015 14:03:31 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:683f:a599:6eb8:1b1d])
        by mx.google.com with ESMTPSA id 85sm6759717iom.25.2015.06.10.14.03.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 14:03:30 -0700 (PDT)
In-Reply-To: <1433953472-32572-4-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	(Antoine Delaite's message of "Wed, 10 Jun 2015 18:24:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271355>

Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr> writes:

> Related discussions:
>
> 	- http://thread.gmane.org/gmane.comp.version-control.git/86063
> 		introduced bisect fix unfixed to find fix.
> 	- http://thread.gmane.org/gmane.comp.version-control.git/182398
> 		discussion around bisect yes/no or old/new.
> 	- http://thread.gmane.org/gmane.comp.version-control.git/199758
> 		last discussion and reviews

Hmph, recent reviews and discussions we had here do not count?

I do agree with Matthieu's review on the last round, which is still
not quite addressed in this round.  The current code only supports
good/bad and this series merely adds another hardcoded pair old/new,
which is disappointing, given that this is a very good opportunity
to place an infrastructure to allow other pairs like unfixed/fixed
building on top of the most generic old/new.
