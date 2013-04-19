From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3 1/2] rev-parse: add --prefix option
Date: Fri, 19 Apr 2013 16:45:38 +0530
Message-ID: <CALkWK0kbXSfghZ69qypfaFF8orWy-bZLRPXcV5WMc5YQ=-18GA@mail.gmail.com>
References: <82316c445320b3cec3a35cbc87ad94a04ed26d1e.1366314439.git.john@keeping.me.uk>
 <1366365217-17674-1-git-send-email-artagnon@gmail.com> <20130419102207.GF2278@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Apr 19 13:16:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT9Il-0004lP-Hq
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 13:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968078Ab3DSLQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 07:16:19 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:45910 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968065Ab3DSLQS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 07:16:18 -0400
Received: by mail-ie0-f182.google.com with SMTP id bn7so2398390ieb.27
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 04:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=MNckHJ6WtmU5JGSRfn3KjeTfhWiMQJWbvhsvfe576CI=;
        b=YzoFtFiM2fU4f3wvYuGcZM5GAPhSNPrd39kNJmxNe04sFdYxUig+98o9TbEFB2Yn+w
         r7X6NghhnynD2wi++qw3vroDXFnJ2LLtajE8LasZApOGqtePstmGtryaUNCasNunhrIL
         8Ri+Rlc7z/xQFVnV+rU0aYVsNGOqrKubg9yadja7CM5uUXWdObd0ovBF804TNmT7IeT1
         hFhwVmfTHjDGbKnJ3QszhqPzo/8TA+wn6Pkq129GkpVmFBFECAqly0bwl50fwAnqqIhr
         ZK3irU28yzk9PlEUQ4QdHP3LxO4unAZ15JIQFNGVhrbL2MJCe5vI/D01cE54OOQGwFkT
         zmjw==
X-Received: by 10.50.50.71 with SMTP id a7mr15193550igo.14.1366370178294; Fri,
 19 Apr 2013 04:16:18 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Fri, 19 Apr 2013 04:15:38 -0700 (PDT)
In-Reply-To: <20130419102207.GF2278@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221755>

John Keeping wrote:
> I'm not actually sure this is better.  I'm more afraid of the condition
> for outputting files changing in the future than of passing
> output_prefix around, so I'd much rather keep that condition in one
> place.
>
> If you really feel strongly about it, I'd prefer to extract the if
> condition to a function and use that directly when deciding whether to
> print "--".

Yeah, it would probably make more sense to extract the conditional.  I
just thought it was unnecessary to pass the argument around, but feel
free to go either way on this one.

> [Also, you introduce a potential segfault via passing a NULL prefix to
> strlen.]

Isn't prefix guaranteed to be set by setup_git_directory()?  If I
wanted to check it nevertheless, I'd probably put in a die("internal
error") before this line.  Feel free to go either way though.
