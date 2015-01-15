From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] commit: reword --author error message
Date: Thu, 15 Jan 2015 15:25:24 +0100
Message-ID: <54B7CDD4.2010306@drmicha.warpmail.net>
References: <54B7CCCD.1070708@drmicha.warpmail.net> <84cf10a22858275d6e213311c93df7f6a5408f60.1421331608.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Gunnar Wagner <gunnar.wagner@irisgermanica.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 15:25:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBlMc-0003Ek-2F
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 15:25:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721AbbAOOZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 09:25:27 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34326 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754654AbbAOOZ0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2015 09:25:26 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 0DBF221109
	for <git@vger.kernel.org>; Thu, 15 Jan 2015 09:25:26 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 15 Jan 2015 09:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=7w+F/o5OvIycF1xpccHKjT
	7TTA8=; b=Tc7/cb1+fpB2yjfkbgTI1nh+xKlX+fgP1EpqXVKd5f0EENQ9BFrSjv
	OuzfX28Mlg82sT80QIKbNwao0ctnekClLdQIQ0UM2QnxupRxnHRGUv+2oq8CVcsW
	+J/EImDZu+GduUaMxlfGkIKBbLej5gVNBJXDE+ZzqgsnYBgwl48a0=
X-Sasl-enc: A8iOJ98ahDBstwB90+2ZNvn3rFK5ayETS93TzU1e6HDr 1421331925
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 62AEB680142;
	Thu, 15 Jan 2015 09:25:25 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <84cf10a22858275d6e213311c93df7f6a5408f60.1421331608.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262481>

Michael J Gruber schrieb am 15.01.2015 um 15:23:
> If an --author argument is specified but does not contain a '>' then git tries
> to find the argument within the exiting authors; and gives the error
> message "No existing author found with '%s'" if there is no match.

Oh well, I'm bracing already for the comments on that entertaining
typo... Can I buy an 's', please?

> This is confusing for users who try to specify a valid complete author
> name.
> 
> Rename the error message to make it clearer that the failure has two
> reasons in this case:
> "Bad --author parameter '%s': neither completely wellformed nor part of
> an existing one"
> 
> (This codepath is touched only when we know already that the argument
> cannot be a completely wellformed author ident.)
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  builtin/commit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 7d90c35..851e2c5 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1056,7 +1056,7 @@ static const char *find_author_by_nickname(const char *name)
>  		clear_mailmap(&mailmap);
>  		return strbuf_detach(&buf, NULL);
>  	}
> -	die(_("No existing author found with '%s'"), name);
> +	die(_("Bad --author parameter '%s': neither completely wellformed nor part of an existing one"), name);
>  }
>  
>  
> 
