From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Feature Request] git blame showing only revisions from git rev-list --first-parent
Date: Sun, 18 Oct 2015 10:41:17 -0700
Message-ID: <xmqqlhb0axc2.fsf@gitster.mtv.corp.google.com>
References: <CA+nPnMx1tkwTRckUjhg6LD055n-jzYDTKsH2sz-0PXPfJiy_tA@mail.gmail.com>
	<20150911140133.GA14311@sigill.intra.peff.net>
	<xmqqa8ss29tq.fsf@gitster.mtv.corp.google.com>
	<xmqqsi6kzsgc.fsf@gitster.mtv.corp.google.com>
	<20150912033054.GA30431@sigill.intra.peff.net>
	<xmqqy4gcxcp4.fsf@gitster.mtv.corp.google.com>
	<20150913100728.GA26562@sigill.intra.peff.net>
	<CAPc5daUcwCferagupF+iy3gxxorfMyEMn0oFMRWBNjc0=2r4og@mail.gmail.com>
	<20150915100538.GA21831@sigill.intra.peff.net>
	<20151018113857.GA5722@wheezy.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Stephen Connolly <stephen.alan.connolly@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Sun Oct 18 19:41:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Znrxv-0007P7-CZ
	for gcvg-git-2@plane.gmane.org; Sun, 18 Oct 2015 19:41:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbbJRRlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2015 13:41:20 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33938 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932087AbbJRRlT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2015 13:41:19 -0400
Received: by padhk11 with SMTP id hk11so5741071pad.1
        for <git@vger.kernel.org>; Sun, 18 Oct 2015 10:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=IQBQDy0s1YOA/+02K643bckHyH7cA8/6NGMF3hcO8+s=;
        b=LBh6vee2f5ppCWPbLqaay2oe1AnA9cV4T7VQjnQO3Si4WeZw8CJ8t1Xk9vbE0kLR3F
         bMljHrNf9BH+Dz//NRa3G9v+QBa7fs1DX0M5CSPxLazEuHOy1enJAeyR6hJguUVz2AVl
         vOwmFbFzmp8KWyOPfFY61TkGCgMCODpRWI+rxsJVdH+j9LS9bqch5V/Cd5YxcfizuKLg
         +eKvhskKU6ONJafuev2Os28FzcLKgE89XHPhXYFmHtqvhTPFbYZAdL2C47EbKjTLlM/Q
         /3qdpbTt0KpLgRMC0dIV7yKGWe8jDZaUQhbNR+YaJMDtvpj/jspT1yr3kr8AjOkh+WyR
         rKBw==
X-Received: by 10.66.227.201 with SMTP id sc9mr29222917pac.62.1445190078776;
        Sun, 18 Oct 2015 10:41:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:305b:5af5:2c51:11cd])
        by smtp.gmail.com with ESMTPSA id bn1sm32231480pad.17.2015.10.18.10.41.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 18 Oct 2015 10:41:17 -0700 (PDT)
In-Reply-To: <20151018113857.GA5722@wheezy.local> (Max Kirillov's message of
	"Sun, 18 Oct 2015 14:38:57 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279817>

Max Kirillov <max@max630.net> writes:

> I might be late for this discussion, but I seem to have
> a case when blame --reverse --first-parent seems to work.

I think during the discussion we already established that there are
cases where the mode happens to do the right thing (the most trivial
is a completely linear history).

I do not strongly object to enabling the mode when it is safe to
enable (i.e. it can be proven to work and produce a sensible and
meaningful result); patches welcome to enable it when it can be
shown that it is safe; "to disable it only when it can be shown that
it is meaningless" is a different way to state the same thing.
