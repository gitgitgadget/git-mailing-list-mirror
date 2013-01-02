From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] build: do not automatically reconfigure unless
 configure.ac changed
Date: Wed, 2 Jan 2013 00:48:07 -0800
Message-ID: <20130102084807.GB22919@elie.Belkin>
References: <CANiSa6jt7_ixi7L6U9sfpV2mvT_7zgYV+m+sLiXjkDsFehAuwA@mail.gmail.com>
 <20130102072141.GB18974@elie.Belkin>
 <CANiSa6iMea95ELqS3-w01bL=LTgE9Cx6+8sXK=s-pPPFwjGCCA@mail.gmail.com>
 <20130102082544.GD18974@elie.Belkin>
 <20130102083837.GA9328@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martinvonz@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 02 09:48:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqK01-0001GI-69
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 09:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752297Ab3ABIsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 03:48:14 -0500
Received: from mail-da0-f49.google.com ([209.85.210.49]:61999 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229Ab3ABIsN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 03:48:13 -0500
Received: by mail-da0-f49.google.com with SMTP id v40so6340972dad.22
        for <git@vger.kernel.org>; Wed, 02 Jan 2013 00:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=WOLKM0zDuoI+VCxR319AKFwHsTFRi6QfzVVuU73iyZ8=;
        b=pBLA3p60LXYPVH78Zv9qiMQPj4ds+f90+o5nzYJWOPE8Rbzayf0MSawXyfk8T3iOFa
         JLHrdtxkOY7DfvqsbfG2vrjtLUd9RiBPI74NXcjTAynkCVzOJ0zeT4qCMjFixigvHgJx
         zllEUfoCohuSYYarZRVYkp7Sjb0W5FpjVHucyfqzpPmqpxeUm+qmJCW2s3Wv9Jtu0HvJ
         G2NQJ2GUHvWqwj+6aQtNeswIO33usLcHS63NFfctaE8LqXakbN48lZeq4aP+rfXIxpXy
         18o4yaGpmyNXhTrFYZtGowlUzREyv+y/MgVLyPb65hG3HVi05oozvC2QUyuZqQq2IGqK
         3rZA==
X-Received: by 10.68.220.198 with SMTP id py6mr142755721pbc.119.1357116492900;
        Wed, 02 Jan 2013 00:48:12 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id t5sm28966770paw.20.2013.01.02.00.48.10
        (version=SSLv3 cipher=OTHER);
        Wed, 02 Jan 2013 00:48:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130102083837.GA9328@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212506>

Jeff King wrote:

> It seems I am late to the party. But FWIW, this looks the most sane to
> me of the patches posted in this thread.

Thanks.  config.status runs ./configure itself, though, so the rule
should actually be

	config.status: configure.ac
		$(QUIET_GEN)$(MAKE) configure && \
		if test -f config.status; then \
		  ./config.status --recheck; \
		else \
		  ./configure;
		fi

Rather than screw it up yet again, I'm going to sleep. :)  If someone
else corrects the patch before tomorrow, I won't mind.
