From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] push: introduce implicit push
Date: Mon, 15 Apr 2013 19:13:16 -0700
Message-ID: <20130416021316.GF3262@elie.Belkin>
References: <1365780835-2853-1-git-send-email-artagnon@gmail.com>
 <7v38uvcrjl.fsf@alter.siamese.dyndns.org>
 <CALkWK0=-GcOF17Q-y-Aqj0ThX5pPQFrriDqoJ2qsr=CS+wUNGA@mail.gmail.com>
 <7vehed7ilu.fsf@alter.siamese.dyndns.org>
 <CALkWK0k6bmjFxTSMAutgu2EjWRZ_cyTU9jZ3Er-aaV78T16RtQ@mail.gmail.com>
 <7vppxw335o.fsf@alter.siamese.dyndns.org>
 <CALkWK0nNn_dGgr8F-kcQZm9UfkZAKwBd0bPSW9yCex4L9F+4Qw@mail.gmail.com>
 <20130416020515.GE3262@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 04:13:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URvOq-0005xT-IC
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 04:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935328Ab3DPCNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 22:13:22 -0400
Received: from mail-da0-f45.google.com ([209.85.210.45]:62956 "EHLO
	mail-da0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934994Ab3DPCNV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 22:13:21 -0400
Received: by mail-da0-f45.google.com with SMTP id v40so8216dad.4
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 19:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=YE5TddhQh9xdsFFpAd862QSXMfbebtdE7RCmrL++bqg=;
        b=V1UpLu1qSv4RCs5sH3OJJ+ygB5PgoyUwYou7ampQVL8IIGg5eOzs3ALhPV1MLcx2bW
         6BkKHHIlVUjZdBYh/Mv0+0SB/RCD3vkXL2PgMZKv5xQGgmaqBuU/W7OuhQBxkCgw4z2P
         Ry6EzaQHWbhfOpLOhQ58xf7DF0LJYBvBVlIDbpt+xKfDeYnWl/K2/gegBGZ44hIylWd3
         zWtA6WMMEN/V53fmuzO+ax7TZY6WPPRGj7VWQt5ZhFj5JZz9odxCUqY43e3aaOJutDhg
         4WSMYA+SfdOxVlCk3mIofymbb4sb5m26QQuXZRtQnw61LsD0+PDJYhE33fJrW5bhlh3x
         f+aQ==
X-Received: by 10.66.227.228 with SMTP id sd4mr967480pac.38.1366078401033;
        Mon, 15 Apr 2013 19:13:21 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id j13sm418012pat.17.2013.04.15.19.13.18
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 19:13:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130416020515.GE3262@elie.Belkin>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221345>

Jonathan Nieder wrote:

> As you hinted before, this would involve reverting the introduction
> of "branch.<name>.pushremote", with the explanation that it was a
> mistake inspired by that false symmetry, that you noticed and were
> uncomfortable with but the rest of us were blind too.

s/too/to/

For the curious, here is the motivation for the weird syntax I
suggested:

	git push foo bar -- baz qux

Sure, I want "git push master" to work since it might reduce the
volume of questions on #git.  But selfishly, more important to me
was that it would simplify my life as I frequently do

	git push repo wagner vasks -- debian-experimental +candidate+patches

in three steps, and I'd rather do it in one.  I think of repo.or.cz,
wagner.debian.org, and vasks.debian.org as three different remotes and
like maintaining separate remote-tracking branches for them, so a
single remote/multiple urls setup didn't work as well when I tried it.

I should warn you that the sketch of a design I am replying to is
incomplete.  It doesn't say what should happen if you try

	git push -- master:theirmaster next:theirnext

Thanks,
Jonathan
