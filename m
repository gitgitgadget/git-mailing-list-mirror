From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 3/3] for-each-ref: introduce %(color:...) for color
Date: Thu, 14 Nov 2013 12:33:05 +0530
Message-ID: <CALkWK0k4MudojZt4PkLjnq0uZe322n30WP-=N0ckLw2QcnbzMA@mail.gmail.com>
References: <1384335406-16332-1-git-send-email-artagnon@gmail.com>
 <1384335406-16332-4-git-send-email-artagnon@gmail.com> <xmqqbo1odqb4.fsf@gitster.dls.corp.google.com>
 <xmqq38n0dpgy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 14 08:03:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vgqxy-00015u-K1
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 08:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896Ab3KNHDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 02:03:47 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:44731 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab3KNHDp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 02:03:45 -0500
Received: by mail-ie0-f180.google.com with SMTP id qd12so2061274ieb.25
        for <git@vger.kernel.org>; Wed, 13 Nov 2013 23:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=P5H7QNQmfsZsFE9iBCynSQyUr82E7JRG40of9Sy1e7Y=;
        b=JxD60W4q3q4fslaHvF1kXnKr7aWWrlwpCtnVxgh4lUGi5NBuFZE0xHNTz+QhB2jJcT
         CxikDIZej9vWB9xnwP30jH3KzkBLx5mTFSK4dNxUVx0RSMgK3QERUVk4+OcjTviZZDpp
         Fv1ODuLoEDwhLSfRGO+QhMGjCKA9N/QSBCPuB3oojbkcY0FhVihcFu2Lsj3LyN/QMejw
         OM0r4bTH4ZuZen+bhxzP/RIZpvePqovs8AW0WqhdTwhuTAKtjKmdhzPqgOI111xjR5Rc
         GwN8NV+4Xcy2b2PGr1Gfn3vY7vF2JnPcvkLcISkZ11bYFOg0aF9PhXt4o/TPuxgapFnJ
         O0nA==
X-Received: by 10.50.73.74 with SMTP id j10mr528337igv.50.1384412625308; Wed,
 13 Nov 2013 23:03:45 -0800 (PST)
Received: by 10.64.73.36 with HTTP; Wed, 13 Nov 2013 23:03:05 -0800 (PST)
In-Reply-To: <xmqq38n0dpgy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237812>

Junio C Hamano wrote:
> Perhaps like this (obviously not tested as these three patches did
> not add any tests ;-)

Sorry about that. I didn't notice t6300-for-each-ref.sh. Will fix in
the next round.

> I also think that there should be a mechanism to do "color:reset"
> after each record is issued automatically, and also have the color
> output honor --color=auto from the command line, i.e.
>
>         git for-each-ref --color=auto --format='%(color:blue)%(subject)' | cat
>
> should turn the coloring off.

We can add --color=auto later, but I'm wondering about auto-reset
color after each token. What happens if I do:

  $ git for-each-ref --format='%(subject)%(color:blue)'

No color, right? So, it should be auto-reset color after each token
_and_ at end of format-string.
