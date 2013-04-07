From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Remote helpers and signed tags
Date: Sun, 7 Apr 2013 14:46:26 -0700
Message-ID: <20130407214626.GC19857@elie.Belkin>
References: <20130407103418.GT2222@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Apr 08 08:46:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5pr-0000sy-6O
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934375Ab3DGVqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 17:46:34 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:44255 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934366Ab3DGVqd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 17:46:33 -0400
Received: by mail-pd0-f172.google.com with SMTP id 5so2892342pdd.17
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 14:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=tIk4boomtGtAmYwhZFcjnMdHZzRLwgk6Pj0L1SuDw0k=;
        b=v1gJu1q7ULKE+137monGL5lp12ZShpUYpc3a5+ymXqJvfrehVRZ3MQQTCkE28z6lQo
         IDNUIqdvWXknJDZ+bDI7OEipBSDElXlYDbhWim+A3va23njnsvIac/asHBuSJs1C2lUp
         jHDojJC0ShcrrzPm9iAY44xGETeiw16y8IU/9UHaSnRgL2ZH51PbOpAsd8HvCpkYJvrv
         pqq6TlHao/J4klhFSTusZ1npph9NshDMC+1rXY3PjTYhi56voo+2auOKhV9BCOc8AGGd
         5kEG8bBEEw1Y42tUrV6oJPXvN5D20Z3kPnVPkpr7lwhnjqC0/b5LJhcg7D0Rcamt4b0p
         EJRA==
X-Received: by 10.66.157.195 with SMTP id wo3mr31207501pab.79.1365371193303;
        Sun, 07 Apr 2013 14:46:33 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ak5sm13902743pac.4.2013.04.07.14.46.30
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 14:46:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130407103418.GT2222@serenity.lan>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220374>

Hi John,

John Keeping wrote:

> It appears to be impossible to push signed tags using a remote helper
> that supports only fast-export.
[...]
>     fatal: Encountered signed tag 572a535454612a046e7dd7404dcca94d6243c788;
>         use --signed-tag=<mode> to handle it.
>     fatal: Error while running fast-export
>
> which is not particularly helpful for a user who doesn't know how the
> remote helper is implemented

Yeah, this is idiotic.

The remote helper infrastructure is certainly being unhelpful here.  I
wonder if transport-helper should just pass --signed-tag=strip and be
done with it (leaving open the possibility of a capability to switch
to --signed-tag=verbatim when someone wants to teach the testgit
helper to support that).  What do you think?

Thanks,
Jonathan
