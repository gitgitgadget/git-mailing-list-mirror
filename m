From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 04/10] pkt-line: change error message for oversized
 packet
Date: Mon, 18 Feb 2013 02:15:23 -0800
Message-ID: <20130218101523.GD7049@elie.Belkin>
References: <20130218091203.GB17003@sigill.intra.peff.net>
 <20130218092221.GD5096@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 18 11:15:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7NlI-0005fF-SY
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 11:15:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757009Ab3BRKP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 05:15:29 -0500
Received: from mail-pb0-f41.google.com ([209.85.160.41]:42473 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357Ab3BRKP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 05:15:28 -0500
Received: by mail-pb0-f41.google.com with SMTP id um15so1601761pbc.14
        for <git@vger.kernel.org>; Mon, 18 Feb 2013 02:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=L4flUP3+RJpn/K78hdXyIGCfK6SLcJNfjlUaaTetA4g=;
        b=BSgwLf4FrmRusFTdANE98S0liM28UpcyduiTWdEXqYUhTK4AZWF0ZFICCI8TGqlHxH
         V4pGkO7JfSJDH5f/FUJ97QS8d10+7muQQY5UmsKeREUcYNVn6zKFtT+jKx6fLt+XPzG1
         RjSB+NiqwRo3tA8ZALZne2+OnQeoABD65yLb1I3A96xYcT5Pqv1G2S8AdGe8aro16bNk
         g232FRGN66yaIOw3w2fiz4IOAOeh9qv/+b9tUQAAjTurL212NHmPtetAP1HrU9MQnD77
         FCevzpzgr2FtRdX8xrkZpIAH0CsRq6I6dFLO7wKzXUKUBGAsTsfmVtEGm+dWFI554muE
         q5kQ==
X-Received: by 10.68.75.109 with SMTP id b13mr28945214pbw.25.1361182528239;
        Mon, 18 Feb 2013 02:15:28 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id eh5sm14031095pbc.44.2013.02.18.02.15.26
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Feb 2013 02:15:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130218092221.GD5096@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216466>

Jeff King wrote:

> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -160,7 +160,8 @@ static int packet_read_internal(int fd, char *buffer, unsigned size, int gently)
>  	}
>  	len -= 4;
>  	if (len >= size)
> -		die("protocol error: bad line length %d", len);
> +		die("protocol error: line too large: (expected %u, got %d)",
> +		    size, len);

Makes sense.  I think this should say "expected < %u, got %d", since we
don't actually expect most lines to be 1004 bytes in practice.

With or without such a change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
