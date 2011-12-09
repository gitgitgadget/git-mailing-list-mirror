From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/9] revert: tolerate extra spaces, tabs in insn sheet
Date: Fri, 9 Dec 2011 13:40:03 -0600
Message-ID: <20111209194003.GE20913@elie.hsd1.il.comcast.net>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
 <1323445326-24637-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 20:40:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ6Io-0000wd-U9
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 20:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634Ab1LITkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 14:40:08 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56764 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625Ab1LITkH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 14:40:07 -0500
Received: by yenm11 with SMTP id m11so2365650yen.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 11:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LOzLfg56ilEUdZVLGKi96vWOiNBskpafEugpHAocK/M=;
        b=kt2vw6caHmu3PKzOk4AjGTEevaB1ph+0YowPoZOzlhss+1mCWmzgrbowyImjlTarDS
         C6H4lLFCkNqFkL7z8aoGzFFeW9mfqI0ufmOi7cMoW2id2tO0SSnePKwpcGx27ZARHCDC
         XOM5RTj+8TJDk26qTNNtrMu7D4Fv5KMGv7ihQ=
Received: by 10.236.161.133 with SMTP id w5mr14266437yhk.63.1323459606935;
        Fri, 09 Dec 2011 11:40:06 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 39sm26554855anu.6.2011.12.09.11.40.05
        (version=SSLv3 cipher=OTHER);
        Fri, 09 Dec 2011 11:40:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323445326-24637-4-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186671>

Ramkumar Ramachandra wrote:

> +++ b/builtin/revert.c
> @@ -727,7 +727,11 @@ static struct commit *parse_insn_line(char *bol, char *eol, struct replay_opts *
>  	} else
>  		return NULL;
>  
> +	/* Eat up extra spaces/ tabs before object name */
> +	while (*bol == ' ' || *bol == '\t')
> +		bol += 1;
> -	end_of_object_name = bol + strcspn(bol, " \n");

Why not use strspn?  What happens if I use a tab immediately
after the pick/revert keyword?
