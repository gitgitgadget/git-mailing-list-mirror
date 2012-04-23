From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] push: introduce new push.default mode "simple"
Date: Mon, 23 Apr 2012 08:52:55 -0700
Message-ID: <xmqqehrela20.fsf@junio.mtv.corp.google.com>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-5-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Apr 23 17:53:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMLZa-0002vz-Nm
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 17:53:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558Ab2DWPxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 11:53:00 -0400
Received: from mail-lb0-f202.google.com ([209.85.217.202]:35854 "EHLO
	mail-lb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013Ab2DWPw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 11:52:59 -0400
Received: by lbol12 with SMTP id l12so389925lbo.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 08:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=FQm+zZJC3F61E+bkiKLFm9DwgMaXQW5Xe1p/ysPZlJw=;
        b=iXHSX6dgdvUGuGx903jorTRBn76Wd2AZ5M8BDE+HULwvqrKCkUM1gWPzj12gY/d7MF
         3yCoheYZE/3/Qg/NTkmGb3cAcAsmhQxkXeKyojHhgcL3ke4/dwrCMx5qrvqOFlA6FI6D
         WaUN+4ljEg9X19yJr+DiQ3mpyoLKtya1E1rUsL9+hpxVv4Yzff6VhH/eft2nbTaPTMbY
         q+9ByFpzLM9iNeeF1YptFlGVW2X2by/wy6aan5tYPmXnXffEZ5Zr8AM6E28wV3cnzSdr
         Ko7ooYVARZKbU/UecfIA4yQ5Os9MMeMxLJGIcvC2aZ9Wa2OudR/nhk4MJ31pwkT0Cn2W
         ApUg==
Received: by 10.14.199.133 with SMTP id x5mr3905178een.7.1335196377393;
        Mon, 23 Apr 2012 08:52:57 -0700 (PDT)
Received: by 10.14.199.133 with SMTP id x5mr3905163een.7.1335196377307;
        Mon, 23 Apr 2012 08:52:57 -0700 (PDT)
Received: from hpza9.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id y52si15013423eef.2.2012.04.23.08.52.57
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 23 Apr 2012 08:52:57 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza9.eem.corp.google.com (Postfix) with ESMTP id DD2625C0060;
	Mon, 23 Apr 2012 08:52:56 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id D79D2E120A; Mon, 23 Apr 2012 08:52:55 -0700 (PDT)
In-Reply-To: <1335170284-30768-5-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Mon, 23 Apr 2012 10:38:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmn+N5M9oLGfRXqWrqGL3yycMKZHNNU3GRJtdVuPUfZGbkPHB05VLVTJ3UQxC/2PIVJ+ogkHL/Z1pVsSaEpRWZyKc3ARmAHKveYdzuPop/8Qgo9chKuCEZUbN23v2Nu51qhQrtUt6DMT4AkbbxlmfDnJzyEofZipCh/dDKZb/gptmFybWA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196133>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> +* `simple` - like `upstream`, but refuses to push if the upstream
> +  branch's name is different from the local one. This is the safest
> +  option and is well-suited for beginners.

Looks good.

> diff --git a/builtin/push.c b/builtin/push.c
> index 6936713..dae8306 100644
> --- a/builtin/push.c
> +++ b/builtin/push.c
> @@ -76,7 +76,40 @@ static int push_url_of_remote(struct remote *remote, const char ***url_p)
>  	return remote->url_nr;
>  }
>  
> -static void setup_push_upstream(struct remote *remote)
> +NORETURN die_push_simple(struct branch *branch, struct remote *remote) {

Not static?

> +	/*
> +	 * There's no point in using shorten_unambiguous_ref here,
> +	 * as the ambiguity would be on the remote side, not what
> +	 * we have locally. Plus, this is supposed to be the simple
> +	 * mode. If the user is doing something crazy like setting
> +	 * upstream to a non-branch, we should probably be showing
> +	 * them the big ugly fully qualified ref.
> +	 */
> +	const char *short_up = skip_prefix(branch->merge[0]->src, "refs/heads/");

Unless you change behaviour depending on NULL-ness of this variable
later in this code (and I do not think you do---this is only for a
message string as far as I can see), I'd prefer to see that ?: you have
at the use site here instead, i.e.

	if (!short_up)
		short_up = branch->merge[0]->src;

perhaps with s/short_up/dest_branch/ or something.

> +	/*
> +	 * Don't show advice for people who explicitely set
> +	 * push.default.
> +	 */
> +	const char *advice_maybe = "";
> +	if (push_default == PUSH_DEFAULT_UNSPECIFIED)
> +		advice_maybe = _("\n"
> +				 "To choose either option permanently, "
> +				 "see push.default in 'git help config'.");

Nice.

> +	die(_("The upstream branch of your current branch does not match\n"
> +	      "the name of your current branch.  To push to the upstream branch\n"
> +	      "on the remote, use\n"
> +	      "\n"
> +	      "    git push %s HEAD:%s\n"
> +	      "\n"
> +	      "To push to the branch of the same name on the remote, use\n"
> +	      "\n"
> +	      "    git push %s %s\n"
> +	      "%s"),
> +	    remote->name, short_up ? short_up : branch->merge[0]->src,
> +	    remote->name, branch->name, advice_maybe);
> +}

> @@ -103,6 +136,9 @@ static void setup_push_upstream(struct remote *remote)
>  		      "your current branch '%s', without telling me what to push\n"
>  		      "to update which remote branch."),
>  		    remote->name, branch->name);
> +	if (simple && strcmp(branch->refname, branch->merge[0]->src)) {
> +		die_push_simple(branch, remote);
> +	}

Lose unnecessary {} pair, perhaps?

> +	git --git-dir=repo1 log -1 --format="%h %s" "other-name" >expect-other-name &&
> +	test_push_success current master &&
> +	git --git-dir=repo1 log -1 --format="%h %s" "other-name" >actual-other-name &&
> +	test_cmp expect-other-name actual-other-name

Hrm.

There is nothing wrong in the above part, but it shows taht it would be
very nice if test_push_success helper also encapsulated the "make sure
others did not change" logic.

Thanks for a pleasant read.
