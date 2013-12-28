From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] t0000: set TEST_OUTPUT_DIRECTORY for sub-tests
Date: Sat, 28 Dec 2013 14:20:03 -0800
Message-ID: <20131228222003.GD5544@google.com>
References: <20131228092731.GA26337@sigill.intra.peff.net>
 <20131228092915.GA21109@sigill.intra.peff.net>
 <20131228221313.GB5544@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Thomas Rast <tr@thomasrast.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 28 23:20:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vx2FJ-0000Zd-Jf
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 23:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206Ab3L1WUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 17:20:09 -0500
Received: from mail-gg0-f180.google.com ([209.85.161.180]:46543 "EHLO
	mail-gg0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037Ab3L1WUI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 17:20:08 -0500
Received: by mail-gg0-f180.google.com with SMTP id k1so2092267gga.25
        for <git@vger.kernel.org>; Sat, 28 Dec 2013 14:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XXkPtDQhI+nVrYYRsaIs4kvBWKsBmsjpfPJJ3GAH8ng=;
        b=Dwl/H7RDZQZrjeW9D1DEI2DXGDNqDxtrX56jAm8iRcZwgQjjJVEyIJv7rV3FCrPUDK
         /BRTA/6NK/tT0eKricFbmn0z4CQdrz9ikk6Ox5qT5cYiiFPjqPNUJes5BcLkKZG1wZec
         JOH/GRqP6G0FKqK4fa1r8KZzfQN2wXj8PdMiiKKx4TNpJYnAIvYiEkfMIcftJP7F8XAf
         n75u6ZDlza2nFa/XoTrI61TTEHuN8NMSglMR9DADM71FiDwtL99lOby0m0LiloBpyeA8
         Byutf1bhHUh4t3khJ/SmG2uzTPcHJEqJd+qg5xznJ3mZ6U7RBE2EJ/VkexSbR1IqlY75
         61tg==
X-Received: by 10.236.19.77 with SMTP id m53mr256591yhm.143.1388269206661;
        Sat, 28 Dec 2013 14:20:06 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id o27sm53468904yhb.19.2013.12.28.14.20.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 28 Dec 2013 14:20:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131228221313.GB5544@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239792>

Jonathan Nieder wrote:

>  - git used to only use TEST_OUTPUT_DIRECTORY to decide where test
>    results go.  You'd have to use --root to set a custom location for
>    trash directories.
>
>  - in that old setup, t0000 leaves around extra trash directories with
>    --root, since the sub-tests inherit the parent test's $root and put
>    trash directories there.

Nope, since sub-tests are run with fork + exec, which loses $root...

>  - after 38b074d, that old problem still exists and furthermore
>    t0000 leaves around extra trash directories even when --root is not
>    in use, since the sub-tests inherit the value of
>    TEST_OUTPUT_DIRECTORY from the parent test.

... meaning the TEST_OUTPUT_DIRECTORY problem is the only problem....

>  - this patch fixes the TEST_OUTPUT_DIRECTORY problem (but not the $root
>    problem) by setting TEST_OUTPUT_DIRECTORY explicitly
>
> Does that sound right?  If so, should sub-tests unset $root, too?

... and there's no need to 'unset root'.

So the patch itself looks right.  I think describing the symptoms up
front would probably be enough to make the commit message less
confusing to read.

Jonathan
