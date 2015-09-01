From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] path.c: make 'common_list' a file local symbol
Date: Tue, 01 Sep 2015 11:06:07 -0700
Message-ID: <xmqqegiirp4g.fsf@gitster.mtv.corp.google.com>
References: <55E5CA21.5080306@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 20:06:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWpwl-0001q2-3U
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 20:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbbIASGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 14:06:11 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35993 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbbIASGK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 14:06:10 -0400
Received: by pacwi10 with SMTP id wi10so3140271pac.3
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 11:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nkbvrAWmpJBVzV/+f1LHIGpBGDRDixDdwebrSek3eXQ=;
        b=lffXNvunBd+LFuwIuMjU6XoOC3/IalQwCoOG/4xq4EtmMaPFddUKL5iDsw0U5abbNB
         ZQ4DkrQD5yorORo/5ZNAtPzruo+QjvfzFLw5F+QSusdWQHdd+lVgAabRswwa0VSdajdD
         M8r69SXEgoNQ0s4MonG2uomF6msfXQssmoVYIUvVAX+4LmZHZWBpu+3YDRpPOw2lXGrY
         yWrfxteI1uGM9U3+i6oCRGW8EmOTHkJeDDdCGna0369CsD//dxnm4F+OEyO9qdPpBcRP
         O3ykU4ToaCu+CiZlO5S4q6uBndJLhFhgs+ALgmsW41fLB4Vg6VfEw00oqf1bbkeeUeXV
         Chfw==
X-Received: by 10.67.15.66 with SMTP id fm2mr23970152pad.82.1441130768850;
        Tue, 01 Sep 2015 11:06:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c585:9fe7:e0d8:e718])
        by smtp.gmail.com with ESMTPSA id u10sm18893141pbs.16.2015.09.01.11.06.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 01 Sep 2015 11:06:08 -0700 (PDT)
In-Reply-To: <55E5CA21.5080306@ramsayjones.plus.com> (Ramsay Jones's message
	of "Tue, 1 Sep 2015 16:54:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277005>

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Commit 04afda89 ("refs: clean up common_list", 26-08-2015) changed
> the type of the 'common_list' symbol from an array of 'formatted'
> strings to an array of struct containing the same data. However, in
> addition it also (inadvertently) changed the visibility of the
> symbol from file local to external.
>
> In order to revert the visibility of the symbol to file local, add
> the static modifier to the declaration of 'common_list'.
>
> Noticed by sparse (symbol 'common_list' was not declared. Should it
> be static?).
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi David,
>
> If you need to re-roll the patches on your 'dt/refs-bisection' branch, could you
> please squash this into the relevant patch.
>
> Thanks!

Thanks.  I've squashed this into David's [v5 1/3] while queuing.

>
> ATB,
> Ramsay Jones
>
>  path.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/path.c b/path.c
> index 9d32d19..a80eaf7 100644
> --- a/path.c
> +++ b/path.c
> @@ -100,7 +100,7 @@ struct common_dir {
>      const char *dirname;
>  };
>  
> -struct common_dir common_list[] = {
> +static struct common_dir common_list[] = {
>      { 0, 1, 0, "branches" },
>      { 0, 1, 0, "hooks" },
>      { 0, 1, 0, "info" },
