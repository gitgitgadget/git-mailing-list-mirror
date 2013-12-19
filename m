From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git: problematic git status output with some translations (such as fr_FR)
Date: Thu, 19 Dec 2013 12:46:21 -0800
Message-ID: <xmqqk3f0efhe.fsf@gitster.dls.corp.google.com>
References: <20131008085036.11434.25160.reportbug@x230-buxy.home.ouaza.com>
	<20131219104613.GA18379@x230-buxy.home.ouaza.com>
	<20131219194319.GB20443@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Raphael Hertzog <hertzog@debian.org>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 19 21:46:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtkUJ-0006jN-RX
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 21:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756746Ab3LSUq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 15:46:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44406 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756195Ab3LSUqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 15:46:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70EB55BF25;
	Thu, 19 Dec 2013 15:46:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g+aHeVA+bqc6T+fLdUbTgY9M9/g=; b=BLG6oP
	1KPjsxMB1MAua8sSL3a2UinYUv/JjWBy6bUPB1zAt+czvHXIMm72FcfOsfko4gA1
	SpWdLXojeBbYlLLs3e2MlQ3Mwwgoa9tJTdx1sjEMFBn5/QbVR46InGRyrCi3wCZ9
	6q4fPAWgSHQiFK9YfKUGKgtkXFwsOYsRi4hMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DAiZab9xKefZLJObbeMdR8cMv6gGCYKp
	KBnWHQtFOA9M9KjxwigXn85RV94RdheFybFF10Cx4cEP6uq8brvO2VCxXBazexV9
	hzkyHCQ9t+CBerKDnx64A2kbwPcDyJkj2ARlmmh3zgDdDeQOb0ZkGRfjkHjvd1RJ
	w7GhF3rzSNQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BABE5BF24;
	Thu, 19 Dec 2013 15:46:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 831295BF23;
	Thu, 19 Dec 2013 15:46:23 -0500 (EST)
In-Reply-To: <20131219194319.GB20443@google.com> (Jonathan Nieder's message of
	"Thu, 19 Dec 2013 11:43:19 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9F4E56E8-68EE-11E3-8AB0-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239545>

Jonathan Nieder <jrnieder@gmail.com> writes:

> This includes the colon in the translated string, to make it easier to
> remember to keep the non-breaking space before it.

Hmph, recent 3651e45c (wt-status: take the alignment burden off
translators, 2013-11-05) seems to have gone in the different
direction when it updated similar code for the non-unmerged paths.

> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>
> [1] http://bugs.debian.org/725777
>
> diff --git i/wt-status.c w/wt-status.c
> index 4e55810..7b0e5b8 100644
> --- i/wt-status.c
> +++ w/wt-status.c
> @@ -245,27 +245,26 @@ static void wt_status_print_trailer(struct wt_status *s)
>  
>  #define quote_path quote_path_relative
>  
> -static void wt_status_print_unmerged_data(struct wt_status *s,
> -					  struct string_list_item *it)
> +static const char *wt_status_unmerged_status_string(int stagemask)
>  {
> -	const char *c = color(WT_STATUS_UNMERGED, s);
> -	struct wt_status_change_data *d = it->util;
> -	struct strbuf onebuf = STRBUF_INIT;
> -	const char *one, *how = _("bug");
> -
> -	one = quote_path(it->string, s->prefix, &onebuf);
> -	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
> -	switch (d->stagemask) {
> -	case 1: how = _("both deleted:"); break;
> -	case 2: how = _("added by us:"); break;
> -	case 3: how = _("deleted by them:"); break;
> -	case 4: how = _("added by them:"); break;
> -	case 5: how = _("deleted by us:"); break;
> -	case 6: how = _("both added:"); break;
> -	case 7: how = _("both modified:"); break;
> +	switch (stagemask) {
> +	case 1:
> +		return _("both deleted:");
> +	case 2:
> +		return _("added by us:");
> +	case 3:
> +		return _("deleted by them:");
> +	case 4:
> +		return _("added by them:");
> +	case 5:
> +		return _("deleted by us:");
> +	case 6:
> +		return _("both added:");
> +	case 7:
> +		return _("both modified:");
> +	default:
> +		return NULL;
>  	}
> -	status_printf_more(s, c, "%-20s%s\n", how, one);
> -	strbuf_release(&onebuf);
>  }
>  
>  static const char *wt_status_diff_status_string(int status)
> @@ -292,6 +291,48 @@ static const char *wt_status_diff_status_string(int status)
>  	}
>  }
>  
> +static int maxwidth(const char *(*label)(int), int minval, int maxval)
> +{
> +	const char *s;
> +	int result = 0, i;
> +
> +	for (i = minval; i <= maxval; i++) {
> +		const char *s = label(i);
> +		int len = s ? strlen(s) : 0;
> +		if (len > result)
> +			result = len;
> +	}
> +	return result;
> +}
> +
> +static void wt_status_print_unmerged_data(struct wt_status *s,
> +					  struct string_list_item *it)
> +{
> +	const char *c = color(WT_STATUS_UNMERGED, s);
> +	struct wt_status_change_data *d = it->util;
> +	struct strbuf onebuf = STRBUF_INIT;
> +	static char *padding;
> +	const char *one, *how;
> +	int len;
> +
> +	if (!padding) {
> +		int width = maxwidth(wt_status_unmerged_status_string, 1, 7);
> +		width += strlen(" ");
> +		padding = xmallocz(width);
> +		memset(padding, ' ', width);
> +	}
> +
> +	one = quote_path(it->string, s->prefix, &onebuf);
> +	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
> +
> +	how = wt_status_unmerged_status_string(d->stagemask);
> +	if (!how)
> +		how = _("bug");
> +	len = strlen(padding) - utf8_strwidth(how);
> +	status_printf_more(s, c, "%s%.*s%s\n", how, len, padding, one);
> +	strbuf_release(&onebuf);
> +}
> +
>  static void wt_status_print_change_data(struct wt_status *s,
>  					int change_type,
>  					struct string_list_item *it)
> @@ -309,14 +350,8 @@ static void wt_status_print_change_data(struct wt_status *s,
>  	int len;
>  
>  	if (!padding) {
> -		int width = 0;
> -		/* If DIFF_STATUS_* uses outside this range, we're in trouble */
> -		for (status = 'A'; status <= 'Z'; status++) {
> -			what = wt_status_diff_status_string(status);
> -			len = what ? strlen(what) : 0;
> -			if (len > width)
> -				width = len;
> -		}
> +		/* If DIFF_STATUS_* uses outside the range [A..Z], we're in trouble */
> +		int width = maxwidth(wt_status_diff_status_string, 'A', 'Z');
>  		width += 2;	/* colon and a space */
>  		padding = xmallocz(width);
>  		memset(padding, ' ', width);
