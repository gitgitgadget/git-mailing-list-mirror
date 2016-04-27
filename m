From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 2/2] merge: warn --no-commit merge when no new commit is
 created
Date: Wed, 27 Apr 2016 07:57:13 +0200
Message-ID: <572054B9.5080601@kdbg.org>
References: <874mb0kkkk.fsf@gmail.com>
 <alpine.DEB.2.20.1604180825170.2967@virtualbox>
 <CAH5451kW3t1Y7oW=uHv85jzHwsnQcDK2jdLisauNF-x1LRwqLA@mail.gmail.com>
 <87a8krpehl.fsf@gmail.com>
 <CAH5451mDYhavx_OLfXe6cC2WguCsFWEBBBBOCPyX3E6ZJw27+w@mail.gmail.com>
 <xmqqy48a6fht.fsf@gitster.mtv.corp.google.com>
 <xmqqtwiy6end.fsf@gitster.mtv.corp.google.com>
 <xmqqd1pcdpb8.fsf_-_@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andrew Ardill <andrew.ardill@gmail.com>,
	Christoph Paulik <cpaulik@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 07:57:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avITQ-0006Cp-Un
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 07:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbcD0F5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 01:57:17 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:47444 "EHLO bsmtp1.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752787AbcD0F5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 01:57:16 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 3qvq3s75hcz5tlM;
	Wed, 27 Apr 2016 07:57:13 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 25700527B;
	Wed, 27 Apr 2016 07:57:13 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <xmqqd1pcdpb8.fsf_-_@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292704>

Am 26.04.2016 um 23:37 schrieb Junio C Hamano:
>   * The necessary update to avoid end-user mistake would look like
>     this.  I am not queuing this or further working on it myself,
>     as I am not sure if it is all that useful.

Whoever picks up this patch, be warned that the i18n coding should be 
corrected:

> +static void no_commit_impossible(const char *message)
> +{
> +	if (!option_commit) {
> +		warning("%s\n%s", _(message),

The i18n call around message is not required, because...

> +			_("--no-commit is impossible"));
> +		warning(_("In future versions of Git, this will become an error."));
> +	}
> +}
> +
>   int cmd_merge(int argc, const char **argv, const char *prefix)
>   {
>   	unsigned char result_tree[20];
> @@ -1403,6 +1412,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>   		 * If head can reach all the merge then we are up to date.
>   		 * but first the most common case of merging one remote.
>   		 */
> +		no_commit_impossible(_("Already up-to-date"));

... the call sites takes care of it.

-- Hannes
