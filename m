From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git_config_push_parameter: handle empty
 GIT_CONFIG_PARAMETERS
Date: Tue, 22 Mar 2016 14:43:55 -0700
Message-ID: <20160322214355.GI28749@google.com>
References: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
 <1456786715-24256-8-git-send-email-jacob.e.keller@intel.com>
 <20160322185628.GA19993@google.com>
 <20160322192309.GA9782@sigill.intra.peff.net>
 <20160322195051.GA20563@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Shin Fan <shinfan@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 22 22:44:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiU5r-0002Gh-Dj
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 22:44:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbcCVVoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 17:44:00 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33938 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbcCVVn6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 17:43:58 -0400
Received: by mail-pf0-f193.google.com with SMTP id n5so38049603pfn.1
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 14:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yKttuSMsDTNE1wK2mi8D9iq8oxnCvsN4gLA+czX+rSI=;
        b=R2PmLdBrN9O2ZNUE6hIFGdWVvc8XnEF/OZ9aMBbqnFaXV/mISNV/tu8Pm6a/P7D4vZ
         UqSSy92IulU9gStFOtIc5Njv7Yfq96DvmRF5RePE6WBrOoqLheUSS3iwk9y+kracMyFJ
         24l+numsFPQKBfDcEZBy4FcSt/HSMVmzsnGrYceaFkjugcTnGKI/mmpG7Kh+GNrkh0co
         P63qIDqKUj5K/oBVnm/UoHEX1oy+VJvPB0G50CAfLhEQOaIWEGetqSNu6+87neRVCPJm
         f3bAkmJaoM+PdJKjkzHYVWCKbI6j/TkiRf1jMeQcinHOTPOE0+luTzZ5vGDLjNPyZXHS
         U6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yKttuSMsDTNE1wK2mi8D9iq8oxnCvsN4gLA+czX+rSI=;
        b=jnz6SVcv15bwtwwzEwl0LKQBxmKQD6IPeUYn7dtYQI8ocE4GpFjAWP3PEK/8DJnFf4
         tSRfAi2AO++ebFAGEsfPcB+/SoamWcHl66NaYkiEWN80k5nUqa5K402maZHWSMYsDWo7
         8vmzgoGSPRlGNNYA0JO/EtHPLZVfrBQLdLhfhdeuCUpXHmVkKqTJ7dne58xXO9NwFBxw
         RIm2DIx3Ueezjii7xx7psY4oPyB6230nswyOxLD67Gg3uJnRjEq3sNh7zKZL3J+BvHZ6
         B1XxwPjdT2d3PjgsinUmnI60KgeGGIMZ7BQEAVkL46s7k60O95vyb5az7l5uFbuMsVTp
         ncFQ==
X-Gm-Message-State: AD7BkJLMiLsVpPnyjEWRfBrYzXA+vX6NziwVnDsR6YXxunaqwHsLGGH8CZDBmbWZWYLhzA==
X-Received: by 10.66.65.137 with SMTP id x9mr57335901pas.137.1458683038146;
        Tue, 22 Mar 2016 14:43:58 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:694a:ddce:573a:2ea8])
        by smtp.gmail.com with ESMTPSA id g6sm50533149pfg.15.2016.03.22.14.43.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Mar 2016 14:43:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160322195051.GA20563@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289571>

Jeff King wrote[1]:

> Subject: git_config_push_parameter: handle empty GIT_CONFIG_PARAMETERS
>
> The "git -c var=value" option stuffs the config value into
> $GIT_CONFIG_PARAMETERS, so that sub-processes can see it.
> When the config is later read via git_config() or similar,
> we parse it back out of that variable.  The parsing end is a
> little bit picky; it assumes that each entry was generated
> with sq_quote_buf(), and that there is no extraneous
> whitespace.
>
> On the generating end, we are careful to append to an
> existing $GIT_CONFIG_PARAMETERS variable if it exists.
> However, our test for "should we add a space separator" is
> too liberal: it will add one even if the environment
> variable exists but is empty. As a result, you might end up
> with:
>
>    GIT_CONFIG_PARAMETERS=" 'core.foo=bar'"
>
> which the parser will choke on.
>
> This was hard to trigger in older versions of git, since we
> only set the variable when we had something to put into it
> (though you could certainly trigger it manually). But since
> 14111fc (git: submodule honor -c credential.* from command
> line, 2016-02-29), the submodule code will unconditionally
> put the $GIT_CONFIG_PARAMETERS variable into the environment
> of any operation in the submodule, whether it is empty or
> not. So any of those operations which themselves use "git
> -c" will generate the unparseable value and fail.
>
> We can easily fix it by catching this case on the generating
> side. While we're adding a test, let's also check that
> multiple layers of "git -c" work, which was previously not
> tested at all.
>
> Reported-by: Jonathan Nieder <jrnieder@gmail.com>

I should have mentioned this is

Reported-by: Shin Fan <shinfan@google.com>

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I just did this on master, and it is standalone. But for the reasons
> above I think it would also be fine to stick on the tip of the
> jk/submodule-c-credential topic.
>
>  config.c               |  2 +-
>  t/t1300-repo-config.sh | 14 ++++++++++++++
>  2 files changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Tested-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks for the quick fix.

Sincerely,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/287928/focus=289551
