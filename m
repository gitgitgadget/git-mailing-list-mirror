From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v9 11/11] Documentation: add documentation for 'git
 interpret-trailers'
Date: Tue, 1 Apr 2014 17:39:38 -0700
Message-ID: <20140402003938.GE6851@google.com>
References: <20140401191831.353.99271.chriscool@tuxfamily.org>
 <20140401192023.353.34477.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Josh Triplett <josh@joshtriplett.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:00:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeD9-0006sp-2V
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757396AbaDBAjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 20:39:45 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:58508 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757324AbaDBAjm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 20:39:42 -0400
Received: by mail-pd0-f173.google.com with SMTP id z10so10297589pdj.4
        for <git@vger.kernel.org>; Tue, 01 Apr 2014 17:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=l6VqXRWWPT9589NKabzxgLigcfFZjidS5jB3tN5paic=;
        b=mmOlljf8nN1Zf6553u5dghpieWdC9b4Iiw+SLFhg0TowgGz6hh+0guVoGqznQFznKe
         0zwr7lRfyOf2BPtPboJaWTPwPNyOKgv1Wupq9qqMprFt8K6GOM4y6TY2Skv3QgwPzsLa
         LVtB+MW+E+BN5AO+4DskncKVr2cLwDvsJJysqrmv55QhCNRIjvdLlanBluj9d9GsALYJ
         NK9iLl46Ni2+ifUND+DwWWtsECoqPrMNNsYltiYnxwVmrMJ/+Bdz8SKm+hHLoCzMuhfN
         qQOQoIS3ITrdnoPGru6w6oK/PW2tomvCgjha4DJdKBYo4StZwV8KHo6ZDGTUGufAv+wo
         HNnA==
X-Received: by 10.66.190.4 with SMTP id gm4mr16439133pac.116.1396399182058;
        Tue, 01 Apr 2014 17:39:42 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ix6sm395525pbd.66.2014.04.01.17.39.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 01 Apr 2014 17:39:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140401192023.353.34477.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245672>

(culling cc list)
Hi,

Christian Couder wrote:

> [Subject: Documentation: add documentation for 'git interpret-trailers']
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

This should be squashed into the patch that introduces the
interpret-trailers command, IMHO (or if it should be reviewed
separately, it can be an earlier patch).  That way, someone looking at
when the command was introduced and wanting to understand what it was
originally meant to do has the information close by.

Thanks for picking up the 'git commit --fixes' topic and your steady
work improving the series.

[...]
> --- /dev/null
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -0,0 +1,123 @@
> +git-interpret-trailers(1)
> +=========================
> +
> +NAME
> +----
> +git-interpret-trailers - help add stuctured information into commit messages
> +
> +SYNOPSIS
> +--------
> +[verse]
> +'git interpret-trailers' [--trim-empty] [(<token>[(=|:)<value>])...]
> +
> +DESCRIPTION
> +-----------
> +Help add RFC 822-like headers, called 'trailers', at the end of the
> +otherwise free-form part of a commit message.
> +
> +This command is a filter. It reads the standard input for a commit
> +message and applies the `token` arguments, if any, to this
> +message. The resulting message is emited on the standard output.

Do you have an example?  Does it work like this?

	$ git interpret-trailers 'signoff=Jonathan Nieder <jrnieder@gmail.com>' <<EOF
	> foo bar baz qux
	> EOF
	foo bar baz qux

	Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
	$

A short EXAMPLES section could help.

If I am understanding it correctly, would a name like 'git add-trailers'
work?  How do I read back the trailers later?

[...]
> +By default, a 'token=value' or 'token:value' argument will be added
> +only if

Why support both '=' and ':'?  Using just one would make it easier to
grep through scripts to see who is adding signoffs.

Hope that helps,
Jonathan
