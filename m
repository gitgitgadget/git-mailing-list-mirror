From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] "git add -A/--no-all" finishing touches
Date: Fri, 26 Apr 2013 14:30:43 -0700
Message-ID: <20130426213043.GP29963@google.com>
References: <7vehe3qi5m.fsf@alter.siamese.dyndns.org>
 <1366663435-13598-1-git-send-email-gitster@pobox.com>
 <7vhaiu1a89.fsf@alter.siamese.dyndns.org>
 <7v4neu19mj.fsf@alter.siamese.dyndns.org>
 <20130425232410.GN29963@google.com>
 <7vvc7ayy84.fsf@alter.siamese.dyndns.org>
 <7vobd2yy3c.fsf@alter.siamese.dyndns.org>
 <20130425235624.GO29963@google.com>
 <7vhaiuywps.fsf@alter.siamese.dyndns.org>
 <7vd2thvx7l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 26 23:31:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVqEP-0007Ob-3f
	for gcvg-git-2@plane.gmane.org; Fri, 26 Apr 2013 23:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529Ab3DZVat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 17:30:49 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34245 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228Ab3DZVas (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 17:30:48 -0400
Received: by mail-pa0-f47.google.com with SMTP id bj3so667578pad.20
        for <git@vger.kernel.org>; Fri, 26 Apr 2013 14:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=DuX6aPKiRfmGrhC2vuk9iXLaAIMNUT/nTfcum3TY+XI=;
        b=y8AqLxW5+Bi17dujEtEa7GdzZaJk3Aq6ZN7tsR46D9v1fUbk551Fy2VdGB42hLx7qC
         AXRIc3/PnC4LVTHDLbXhYBa7vnfAGoImSbNBT4r9mAciuunC5G4b+tPDCxE7yKgoHce7
         0Gd/A+BM46BWTlXmH+WSqkrTq9f4xWFWDrlJ62u/GrL/ZQ+tlz8IdIpvkedo51CvomTi
         giYtPBe1gPLoZJmL04gG7ZquKATe0fzOxdaHI7raLu4+OgiiNqI7FsnrvR0yyjuTneGv
         SOnpg5qfZ8dxv5IJxYNfJ+RqjKzv8KXepmWHJ9JlPVaZNFMQkzQBv9TEkP8r0zoj0n4k
         ZnnA==
X-Received: by 10.68.137.168 with SMTP id qj8mr33883379pbb.17.1367011848098;
        Fri, 26 Apr 2013 14:30:48 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id v5sm1604542pbz.4.2013.04.26.14.30.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 14:30:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vd2thvx7l.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222593>

Junio C Hamano wrote:

> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -495,6 +495,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>  		refresh(verbose, pathspec);
>  		goto finish;
>  	}
> +	if (implicit_dot && !prefix)
> +		refresh_cache(REFRESH_QUIET);

I think you mean "if (implicit_dot && prefix)". :)

This strategy is much less invasive than the alternatives discussed,
so for what it's worth, with that correction,

Acked-by: Jonathan Nieder <jrnieder@gmail.com>

I'll try to get time to work on those promised tests this weekend.
