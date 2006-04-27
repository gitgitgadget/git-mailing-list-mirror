From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: [PATCH] C version of git-count-objects
Date: Thu, 27 Apr 2006 09:16:32 -0400
Message-ID: <118833cc0604270616u2961ab10waef5807c429be784@mail.gmail.com>
References: <20060427101254.GA22769@peppar.cs.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Apr 27 15:16:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZ6MJ-0006a4-As
	for gcvg-git@gmane.org; Thu, 27 Apr 2006 15:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbWD0NQd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 09:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWD0NQd
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 09:16:33 -0400
Received: from pproxy.gmail.com ([64.233.166.177]:4848 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965035AbWD0NQc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Apr 2006 09:16:32 -0400
Received: by pproxy.gmail.com with SMTP id i49so2058136pye
        for <git@vger.kernel.org>; Thu, 27 Apr 2006 06:16:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rEcn/T5VW+YoS9SXmdCh1AS4wlrwxAiWLF0jg0a2bGvsjo9pK9nlaRIrtmXGN2o9SiBPkscRwP8hZEvFLL38MqeTGl5kBT63nxxr7UwxzJWY8+m+0b2hR8kAyN2CYIWe9VfxBRxXanA1Swf0P9eEhXFpNB6Kc6VQm21B4iZvyps=
Received: by 10.35.17.8 with SMTP id u8mr88316pyi;
        Thu, 27 Apr 2006 06:16:32 -0700 (PDT)
Received: by 10.35.39.13 with HTTP; Thu, 27 Apr 2006 06:16:32 -0700 (PDT)
To: "Peter Hagervall" <hager@cs.umu.se>
In-Reply-To: <20060427101254.GA22769@peppar.cs.umu.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19229>

> +                       if (access(subdir, R_OK | X_OK))
> +                               continue;
> +                       chdir(subdir);

You've got yourself a needless race condition right there.  Just
do the chdir and check the return value.  (And besides, access
checks with the wrong set of permissions, should this ever end
up in set[ug]id context.)

Morten
