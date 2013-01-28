From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 11/11] Unify appending signoff in format-patch, commit
 and sequencer
Date: Sun, 27 Jan 2013 19:39:21 -0800
Message-ID: <20130128033921.GP8206@elie.Belkin>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
 <1359335515-13818-12-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 04:39:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzfZW-0001Bd-Ff
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 04:39:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435Ab3A1Dj3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 22:39:29 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36995 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753368Ab3A1Dj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 22:39:27 -0500
Received: by mail-pb0-f46.google.com with SMTP id mc17so553052pbc.5
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 19:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=X89hrUYjHUWOMwdArnk0xqtR7gGWc9UqrBeSGZLdi0c=;
        b=SIjlaYTnSC+L9N+UcWrug2YFevC07TTzftGv/XahctUUzFDyUdcwzEl9ZXzAACqiz7
         EeFXcaCK1B40CVCy7fICPAxxFt0blzKrBKoiCAnXpQLBck1iTWMlPETfQcXGYP9LX6l5
         oaz/L3Nt/Svf/IbVX0lG9btbKTrd7rqn/Brrpl/Jcq9/AMIPubQcg43ZpDMOoYiTghB4
         I4UmhhFKcIZI5zk9sbC3X/rhU9IgsTiW7MKKwXSaq1Ii4j5opbwO1Zf+WmLFq8gsQxxl
         y3MQ6SSqLCigZHZwnADHeo/PtdbaZhRnJwpf0vrzveERRDxjIe9Cs0+gqpplGajfoP0e
         LATA==
X-Received: by 10.66.86.71 with SMTP id n7mr32753360paz.77.1359344367445;
        Sun, 27 Jan 2013 19:39:27 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id bv10sm5845916pab.14.2013.01.27.19.39.25
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 19:39:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359335515-13818-12-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214799>

Brandon Casey wrote:

> --- a/log-tree.c
> +++ b/log-tree.c
[...]
> @@ -208,94 +207,6 @@ void show_decorations(struct rev_info *opt, struct commit *commit)
>  	putchar(')');
>  }
>  
> -/*
> - * Search for "^[-A-Za-z]+: [^@]+@" pattern. It usually matches
> - * Signed-off-by: and Acked-by: lines.
> - */

That's stricter than the test from sequencer.c.  Maybe it's worth
stealing to avoid false positives?
