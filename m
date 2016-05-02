From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 06/14] remote.h: add get_remote_capabilities,
 request_capabilities
Date: Mon, 02 May 2016 14:57:43 -0400
Organization: Twitter
Message-ID: <1462215463.4123.70.camel@twopensource.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
	 <1461972887-22100-7-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon May 02 20:57:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axJ2V-000241-TQ
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 20:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbcEBS5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 14:57:48 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:35677 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932082AbcEBS5q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 14:57:46 -0400
Received: by mail-qg0-f48.google.com with SMTP id f74so73506515qge.2
        for <git@vger.kernel.org>; Mon, 02 May 2016 11:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=PqKudN6dj3kMr8RWCCW9NF6/lGA0TWMQyDCA9Bigksc=;
        b=fghjbnJaLoVQEceP2bUyTUIK8AOzMWQm8+wvGSjg0KEEEmw/SOYP1Px40z+U2c3H/p
         aqM7qWgF/e87SAz/b/9lIIawJRZjmODQs217DtAufDLHTKUxBPBxlRyx099Y9uTkVdAy
         SnDfHH4ijnhhychDlpvyqGyeJ3UXMuZgST9QZITenmJ4thirAhLcwT9gnmAAlFJw5Dc5
         zviNoyuHvA4Wv1aYBzcpuYOjvdnd1+vUYA/IP8tiYdVDchG3dWB94uIngtSY0sKF7vkS
         oHsP0qL3DL+jRox35sdvEoPF2HmjTXr7wgJpcjVjDqDUzCs4YjSfZxcUAaDFYcK4oRdn
         BvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=PqKudN6dj3kMr8RWCCW9NF6/lGA0TWMQyDCA9Bigksc=;
        b=H8GpFqKC+P3Ksl1yi87vzlHAOwraaiibmsCiyS9Y7/Lb95DT7hKHpZk8Y7kU99+8qP
         7hkyXi5K968dIxjvEOyrKK9zJf7nvDcQ3fcJzZOvdxM0/Ix+/W7X66J8VUIqyxdqr3/H
         38PVfDPvk7PSXVfoazf/TKK5PsbMIY3dZvQ2IURKdM1OAOknDeF2O6vfu83vXraSxjaA
         BuPwkSLffuza+PdzTbBf+5kNbvsV+6jrjGKAvplio8HH7biZoVLchx7kNUTSuH8fGFrJ
         0Tmzf5ZVo0tvybrfqabJVfy18A67hmMc3M73xQUnR3zwFkwe5fYLDzA6PmzjoLsl5iEp
         pMTg==
X-Gm-Message-State: AOPr4FU+uJRgt3GlgfjYKZynDD4AXYFUC3WX+PRyhwOX7je6g3ZQCfADC3h8Xhcrc9utDw==
X-Received: by 10.140.96.78 with SMTP id j72mr33670887qge.84.1462215465573;
        Mon, 02 May 2016 11:57:45 -0700 (PDT)
Received: from ubuntu ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id q201sm9659308qke.11.2016.05.02.11.57.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 May 2016 11:57:44 -0700 (PDT)
In-Reply-To: <1461972887-22100-7-git-send-email-sbeller@google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293268>

On Fri, 2016-04-29 at 16:34 -0700, Stefan Beller wrote:
 
> +const char *known_capabilities[] = {
> +	"multi_ack",
> +	"thin-pack",
> +	"side-band",
> +	"side-band-64k",
> +	"ofs-delta",
> +	"shallow",
> +	"no-progress",
> +	"include-tag",
> +	"multi_ack_detailed",
> +	"allow-tip-sha1-in-want",
> +	"allow-reachable-sha1-in-want",
> +	"no-done",
> +};

I wonder if it is possible to not repeat the list from upload-pack.c?
It seems unfortunate to have to add the same string in two places
whenever you add a capability.

> +static int keep_capability(char *line)

s/keep_/is_known_/ ?  Also it would be good to handle capabilities that
are prefixes of others correctly.

> +{
> +	int i;
> +	for (i = 0; i < ARRAY_SIZE(known_capabilities); i++)
> +		if (starts_with(line, known_capabilities[i]))
> +			return 1;
> +	return 0;
> +}
> +
> +void get_remote_capabilities(int in, char *src_buf, size_t src_len)

maybe rename "in" to "fd" or "in_fd"?  I don't immediately know what
"in" is supposed to be when I just look at this signature.

> +void request_capabilities(int out, struct string_list *list)

Maybe name this "send_capabilities_request"?
