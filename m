From: Jonathan Nieder <jrnieder@gmail.com>
Subject: jn/config-ignore-inaccessible (Re: What's cooking in git.git (Apr
 2013, #10; Mon, 29))
Date: Sat, 4 May 2013 13:14:14 -0700
Message-ID: <20130504201414.GA2420@elie.Belkin>
References: <7vppxdgife.fsf@alter.siamese.dyndns.org>
 <87y5bvyw7j.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sat May 04 22:14:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYiqu-00071z-4T
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 22:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131Ab3EDUOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 16:14:24 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:37873 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536Ab3EDUOX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 16:14:23 -0400
Received: by mail-pa0-f51.google.com with SMTP id ld10so1436484pab.38
        for <git@vger.kernel.org>; Sat, 04 May 2013 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=mmFvdavQ5OwfbSY9YBaz3CYmSGrvg8ctGiU+JbtS+Ok=;
        b=O2rGndBjze7O1x+FnXjalIeeeFAvaUGaYq9pMDbdtBdw783uIjh8gkFszDnBIGGO7p
         pJXltiF6JA91wRaidj7iCmXq6nF33OtKgAMm7Y8GMQ5ys3hhuri6WqHOV6Ii5fZ8lUQX
         zkplYHI3LZpiBF9vsR6XHYA3tQc8R0bq07zArb0qNDrh2iczDQXszoEjaeGBp96DS+Lx
         CKYzNlTPnYUNQDY+a0vKhmkf00zszyWS1yoVl4PZa8uBOTLK852AfBiBSvDmTT+VFCK5
         tBFesi87AGmFXTOw/NLjVmUMUB8OngYZYNafhHk/q9D3wZRYa/DSoEAi6wxUGrGR3s8R
         LfQg==
X-Received: by 10.68.232.234 with SMTP id tr10mr19564193pbc.11.1367698463368;
        Sat, 04 May 2013 13:14:23 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id t1sm18377192pab.12.2013.05.04.13.14.21
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 04 May 2013 13:14:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87y5bvyw7j.fsf@hexa.v.cablecom.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223376>

Thomas Rast wrote:
> Junio C Hamano <gitster@pobox.com> writes:

>> * jn/config-ignore-inaccessible (2013-04-15) 1 commit
>>  - config: allow inaccessible configuration under $HOME
>>
>>  When $HOME is misconfigured to point at an unreadable directory, we
>>  used to complain and die. This loosens the check.
>>
>>  I do not think we agreed that this is a good idea, though.
>
> As a data point: yesterday on IRC, two users complained that they each
> had this problem.
>
>   http://colabti.org/irclogger/irclogger_log/git?date=2013-05-03#l3022
>   http://colabti.org/irclogger/irclogger_log/git?date=2013-05-03#l3111

I think the approach taken in the patch above is a good one.  If
/etc/gitconfig contains important configuration, it is still not
ignored, errors other than permissions reading ~/.gitconfig are
still fatal, and permissions errors accessing ~/.gitconfig are no
longer fatal because they are expected as something very common
in normal setups.

I haven't been able to convince myself there is a different, better
behavior to be found.  Special-casing inaccessible $HOME while still
forbidding inaccessible $HOME/.config/git and $HOME/.gitconfig would
seem strange.

Hmm?
Jonathan
