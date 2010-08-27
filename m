From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] for-each-ref: fix objectname:short bug
Date: Fri, 27 Aug 2010 09:08:02 +0200
Message-ID: <4C776452.8020200@drmicha.warpmail.net>
References: <AANLkTikhcAC6Nf=jWQN40ascodaCte6v6e1JPfv-=To-@mail.gmail.com> <1282858469-22116-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>,
	Jeff King <peff@peff.net>, Junio C Hamano <junio@kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 27 09:08:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oot2n-0007Pz-N1
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 09:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268Ab0H0HIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Aug 2010 03:08:04 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59948 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752092Ab0H0HID (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Aug 2010 03:08:03 -0400
Received: from compute3.internal (compute3.internal [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id DE367425;
	Fri, 27 Aug 2010 03:08:01 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 27 Aug 2010 03:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=fCYRolSHrPzuQJX/ouwPJ+SuzTw=; b=g9lAU/9lfFU2A+Hk66gegvAyaYDAdQgSBw1WG4HG5ZBaznUy3W6HSlCp5gjkwKN9Xz6HJnGycHWrDIQUofI0HnjEKW127J0W0FM1skLYZrTelLLQ7zmXwPyk3ZbFlaaVrQIuMxROMQ5CqlwR8XVa1d8afOzaNNdjatvoVSirhcY=
X-Sasl-enc: VzlpxsEEI1u4laHmI37KWrSwzbMHA7nVutuHxpZehrTb 1282892881
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 114B25E235F;
	Fri, 27 Aug 2010 03:08:00 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8) Gecko/20100806 Fedora/3.1.2-1.fc13 Lightning/1.0b2pre Thunderbird/3.1.2
In-Reply-To: <1282858469-22116-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154585>

Jay Soffian venit, vidit, dixit 26.08.2010 23:34:
> When objectname:short was introduced, it forgot to copy the result of
> find_unique_abbrev. Because the result of find_unique_abbrev is a
> pointer to static buffer, this resulted in the same value being
> substituted in for each ref.
> 
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---
>  builtin/for-each-ref.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index a2b28c6..89e75c6 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -228,7 +228,8 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
>  			v->s = s;
>  		}
>  		else if (!strcmp(name, "objectname:short")) {
> -			v->s = find_unique_abbrev(obj->sha1, DEFAULT_ABBREV);
> +			v->s = xstrdup(find_unique_abbrev(obj->sha1,
> +							  DEFAULT_ABBREV));
>  		}
>  	}
>  }

3 words:

embarrassing - sorry - thanks!

Michael
