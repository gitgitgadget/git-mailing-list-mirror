From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] git.c: Remove unnecessary new line
Date: Sat, 9 Mar 2013 16:00:23 -0800
Message-ID: <20130310000023.GI3908@elie.Belkin>
References: <513BB4A2.8000407@fallo.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Michael Fallows <michael@fallo.ws>
X-From: git-owner@vger.kernel.org Sun Mar 10 01:00:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEThA-0007Wg-Uv
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 01:00:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218Ab3CJAAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 19:00:31 -0500
Received: from mail-pb0-f54.google.com ([209.85.160.54]:54900 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194Ab3CJAAa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 19:00:30 -0500
Received: by mail-pb0-f54.google.com with SMTP id rr4so2474728pbb.13
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 16:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=r6rb6vPzyYtFlNxBeg1EYZJCvla0OGkQ3T6emOdEEMI=;
        b=ARGC9w81BY6mFDzwxwAcg44g9M911UxGO0LDK6/41O1PexT1O5SsRvizF/DCLJ8R4e
         OVYyJe+eJ4jPGYGwymBNb+pXtFZ8Z9ZMwzA2q3IsxMBJhWsvR8tmYbuojS9OLqexjsIF
         dbdl90zmAuy4hIBU7iwyKLZ2RORAXhBkZRXTdqc4SozLdXu3HBLb+TGE5DhuHAFb4+Re
         P+rcpDOC1ydQlsuMUAV9WhA+j18OCzJ++7bXlR21faBFrAaHN5XvAktDAmzoCJgbfc5V
         2BKwGYlvXCV/mUOUJya2jHR3uuBTum8dfWBsjjgzWiZ5ID841Ov6bp5/3icJt5zA2mMq
         G2Nw==
X-Received: by 10.68.198.97 with SMTP id jb1mr1425248pbc.23.1362873630019;
        Sat, 09 Mar 2013 16:00:30 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id i10sm12460285pbd.1.2013.03.09.16.00.26
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Mar 2013 16:00:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <513BB4A2.8000407@fallo.ws>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217774>

Hi,

Michael Fallows wrote:

> --- a/git.c
> +++ b/git.c
> @@ -316,8 +316,7 @@ static void handle_internal_command(int argc, const char **argv)
>  		{ "check-ignore", cmd_check_ignore, RUN_SETUP | NEED_WORK_TREE },
>  		{ "check-ref-format", cmd_check_ref_format },
>  		{ "checkout", cmd_checkout, RUN_SETUP | NEED_WORK_TREE },
> -		{ "checkout-index", cmd_checkout_index,
> -			RUN_SETUP | NEED_WORK_TREE},
> +		{ "checkout-index", cmd_checkout_index, RUN_SETUP | NEED_WORK_TREE },

This wrapped line was introduced a while ago (4465f410, checkout-index
needs a working tree, 2007-08-04).  It was the first line to wrap, but
it was also the longest line at the time.

Now the longest line is

		{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE },

(94 columns), so you are right that consistency would suggest dropping
the line wrapping for checkout-index.

But I find it hard to convince myself that alone is worth the churn.
In what context did you notice this?  Is the intent to help scripts to
parse the commands[] list, or to manipulate it while preserving
formatting to avoid distractions?  Did you notice the broken line
while reading through and get distracted, or did some syntax
highlighting tool notice the oddity, or something else?

Hope that helps,
Jonathan
