From: "Chris O'Kelly" <chris@mapcreative.com.au>
Subject: Re: Feature Request: provide cmdline args to git hooks
Date: Wed, 15 Apr 2015 08:28:39 +1000
Message-ID: <CAM-hpQcowcRaRMnYcZD8oUDep-nSw1e4Sy3CHjCojpQd=238Ug@mail.gmail.com>
References: <CAM-hpQcgOgrAJBAZrH4icDtJMiHUYOz1tynYkoj7qzyVMZ0eVQ@mail.gmail.com>
	<xmqqwq1e3fy4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 00:28:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi9K1-0005aV-0R
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 00:28:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297AbbDNW2k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 18:28:40 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:35622 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754216AbbDNW2k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 18:28:40 -0400
Received: by igbyr2 with SMTP id yr2so51943759igb.0
        for <git@vger.kernel.org>; Tue, 14 Apr 2015 15:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ByEP6YkayfrZgWiA1C0sx0QrM0mN95VYnACl8Hsrn60=;
        b=dmuhRROHa6MlAakUfYrnKMOGopwgaFMlW6l+YhrmK4XOxJ6/w3xtZim2o/UNc/JNGQ
         yKnfADjNWM43FH01qi8UkSkihywUPKnO5w/D4FBjqoD9TzWIqxtQfwzCrHp5JPvcJQl1
         Fgf+aSPPnquuPoTcqufdQ0o/nXeU0qxXo1rwPRAtqwXsKeKNYNQCfMD8f/xrLqBjwHCI
         viV/USNMrGalJzqBHwqRkKukvIkacBIdfXNY7sFLawZ4fNgZk4E6dZNAjY2adr80v6Hc
         mpQskFbUXHQeLSrzs7H5c6Yf8RWLlqCSOsTCtlbTWtCS+pzy7REJ5yrgBxBDtBThIQuA
         Y/pQ==
X-Gm-Message-State: ALoCoQmmlqy7M/5HLeYBOIqHBdjt73HiQeXOa4y7XgxIfQhWszOiUSp0GmsmGaoeSnHzuecdmG/h
X-Received: by 10.50.137.2 with SMTP id qe2mr4918892igb.20.1429050519806; Tue,
 14 Apr 2015 15:28:39 -0700 (PDT)
Received: by 10.64.76.84 with HTTP; Tue, 14 Apr 2015 15:28:39 -0700 (PDT)
In-Reply-To: <xmqqwq1e3fy4.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267171>

Unfortunately in this case we don't have control over the hooks at the
receiving end - we want to prevent tags from being pushed by all users
to these repo's.

On Wed, Apr 15, 2015 at 1:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Chris O'Kelly" <chris@mapcreative.com.au> writes:
>
>> A brief background of my use case:
>> I am wanting to write a pre-push hook to prevent tags being pushed to
>> our production servers. The production servers in our case are --bare
>> endpoints, and when we push a tag at them, they always checkout the
>> commit that tag is attached to via some post-receive magic (WPEngine,
>> FWIW). This behavior is even present when the tag was already pushed
>> to the repo previously, if for instance a normal push is made with the
>> --tags argument.
>
> Do you mean that you want to forbid some people from pushing tags
> into that repository while allowing others (i.e. those who manage
> production deployment)?  If that is the goal, it sounds like that
> the right place to do this is at the receiving end via pre-receive,
> not at the sending end via pre-push.
>
