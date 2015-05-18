From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 06/14] pull: support pull.ff config
Date: Mon, 18 May 2015 21:02:32 +0200
Organization: gmx
Message-ID: <86694e742e55b6db71ec30d43c5643d7@www.dscho.org>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
 <1431961571-20370-7-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Stephen Robin <stephen.robin@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 21:02:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuQJK-0002Go-0p
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 21:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754990AbbERTCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 15:02:40 -0400
Received: from mout.gmx.net ([212.227.15.15]:59439 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755104AbbERTCh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 15:02:37 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LkPBT-1ZRI153vmV-00cUca; Mon, 18 May 2015 21:02:32
 +0200
In-Reply-To: <1431961571-20370-7-git-send-email-pyokagan@gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:MkkgqBQ6/xKmjD1i5pHzo4ZjNozzErlMZvGKqD0q5KqWCVM0w2v
 Zv8ry9jZkdYAq1YBMCudCZNryTa0H/ZyyGIruaO3EsNOPQFNLc+5AY4nB9pf1ZEbRFaazdJ
 3O9655o5qpYnT4Cw64cKv3H9H6e/jGNWfAowycHO+fhKcijjuDGet1ncoMYJ35HWx+QlfwK
 08xfNNi/jmpau8mNwl2nA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269300>

Hi Paul,

On 2015-05-18 17:06, Paul Tan wrote:

> diff --git a/builtin/pull.c b/builtin/pull.c
> index 8982fdf..b305a47 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -209,6 +209,28 @@ static void argv_push_force(struct argv_array *arr)
>  		argv_array_push(arr, "-f");
>  }
>  
> +/**
> + * If pull.ff is "true", returns "--ff". If pull.ff is "false", returns
> + * "--no-ff". If pull.ff is "only", returns "--ff-only". Otherwise, returns
> + * NULL.
> + */
> +static const char *config_get_ff(void)
> +{
> +	const char *value;
> +
> +	if (git_config_get_value("pull.ff", &value))
> +		return NULL;
> +	switch (git_config_maybe_bool("pull.ff", value)) {
> +		case 0:
> +			return "--no-ff";
> +		case 1:
> +			return "--ff";
> +	}
> +	if (!strcmp("pull.ff", "only"))

I think you want to test `!strcmp("only", value)` ;-)

Ciao,
Dscho
