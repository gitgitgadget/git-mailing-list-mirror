From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v14 5/8] bisect: introduce --no-checkout support into
 porcelain.
Date: Wed, 3 Aug 2011 20:57:19 +0200
Message-ID: <20110803185719.GA4275@elie.Hillsp>
References: <1312323362-20096-1-git-send-email-jon.seymour@gmail.com>
 <1312323362-20096-6-git-send-email-jon.seymour@gmail.com>
 <7voc07ct9z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org,
	chriscool@tuxfamily.org, j6t@kdbg.org, jnareb@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 20:57:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QogdH-0002yU-S4
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 20:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755035Ab1HCS52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 14:57:28 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60848 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872Ab1HCS51 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 14:57:27 -0400
Received: by wwe5 with SMTP id 5so1139481wwe.1
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 11:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=E68ACP75ncY91EmrL7PUzksMoAk8WrxIYE50YfeuhcY=;
        b=btlkW/9P0btFYZPpT2XAZk74PqFvXVBESTCu9s5ttEcjv0cXnd8Z5QAODAO8EaVPIt
         qp/RP2+HtXRo0bm7wuWPIjtFqUwQtlDfNmK0wWgQ6uv5hjfCHmdu0qPOnQ8EN+6GarAu
         Um/maYSQj6gN3Co+t21o3BBu6v94p4HDHLp4I=
Received: by 10.227.160.78 with SMTP id m14mr8641695wbx.80.1312397845742;
        Wed, 03 Aug 2011 11:57:25 -0700 (PDT)
Received: from elie.Hillsp (94-194-201-239.zone8.bethere.co.uk [94.194.201.239])
        by mx.google.com with ESMTPS id fc2sm901884wbb.18.2011.08.03.11.57.24
        (version=SSLv3 cipher=OTHER);
        Wed, 03 Aug 2011 11:57:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7voc07ct9z.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178607>

Junio C Hamano wrote:

> Just a minor worry but I would not be surprised if somebody's "test"
> implementation barfs upon:
>
> 	test "--no-checkout" = "--no-checkout"
>
> mistaking the string with a dash at the beginning as an option unknown to
> it. That is why we often have "z$variable" in our comparison, like so:
>
> 	if test "z$BISECT_MODE" = "z--no-checkout"

Hmm.

	$ git grep -e 'test "\$' | wc -l
	712
	$ git grep -e 'test ".\$' | wc -l
	183

We are very inconsistent about such usage, generally, and of course
POSIX is very clear about the 'z' not being needed in a three-argument
"test" used for string comparison.  Is there any platform that is
usable for git (e.g., that implements "$( ... )") and has that
problem?
