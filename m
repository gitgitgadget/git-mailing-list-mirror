From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] sha1: use char type for temporary work buffer
Date: Wed, 12 Sep 2012 11:42:36 -0700
Message-ID: <7v8vcfccbn.fsf@alter.siamese.dyndns.org>
References: <cover.1347442430.git.ydroneaud@opteya.com>
 <a8c30a998cad6a7b38bd983e7689a628567a8176.1347442430.git.ydroneaud@opteya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 20:42:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBrtf-0002Al-3Z
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 20:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755985Ab2ILSmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 14:42:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61853 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755322Ab2ILSmi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 14:42:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 380CF9CE4;
	Wed, 12 Sep 2012 14:42:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u6Cre+UkVf0oVUVfDmyKemlbCck=; b=BlvEKj
	5gfP0odiH/kqMevlyU7GE1erOoPfXoxLollzOShQzOcx2BEVpxJHWFR+vMCEBhXz
	eFWm1DIsIObetNCHHujXLa/WPOjk00bD67lGc19o6yyFKvgmiITCCTWeSsXe9rAk
	6L/oU61OHQ2wGBbR0Cj8nsIBtclAKwyOLLXQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UbYtioCQVmDWdOmf2HDS4Nicm558rpaj
	8O+DDl9Es31yElz22JuCnAQVyT+ATGDOTpw9qkob4/kRiVC3VAxlIQasUZSLCC8D
	I9AuZdvNaaeqCIFHtcAXgiqD1C4Zokmu9z/uCTDsqDnO+frN6CYkrzNnsFqlWhfQ
	GBnfHlf9MTg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 269B59CE3;
	Wed, 12 Sep 2012 14:42:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 835579CE1; Wed, 12 Sep 2012
 14:42:37 -0400 (EDT)
In-Reply-To: <a8c30a998cad6a7b38bd983e7689a628567a8176.1347442430.git.ydroneaud@opteya.com> (Yann Droneaud's message of "Wed, 12 Sep 2012 12:30:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9FCE63F8-FD09-11E1-AC9A-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205324>

Yann Droneaud <ydroneaud@opteya.com> writes:

> The SHA context is holding a temporary buffer for partial block.
>
> This block must 64 bytes long. It is currently described as
> an array of 16 integers.
>
> Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
> ---

As we do not work with 16-bit integers anyway, 16 integers occupy 64
bytes anyway.

What problem does this series fix?

>  block-sha1/sha1.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
> index b864df6..d29ff6a 100644
> --- a/block-sha1/sha1.h
> +++ b/block-sha1/sha1.h
> @@ -9,7 +9,7 @@
>  typedef struct {
>  	unsigned long long size;
>  	unsigned int H[5];
> -	unsigned int W[16];
> +	unsigned char W[64];
>  } blk_SHA_CTX;
>  
>  void blk_SHA1_Init(blk_SHA_CTX *ctx);
