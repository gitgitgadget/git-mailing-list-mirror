From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diffcore.h: be explicit about the signedness of is_binary
Date: Mon, 24 Feb 2014 09:55:48 -0800
Message-ID: <xmqqmwhg9yzf.fsf@gitster.dls.corp.google.com>
References: <m2ob1xba94.fsf@richlowe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Richard Lowe <richlowe@richlowe.net>
X-From: git-owner@vger.kernel.org Mon Feb 24 18:56:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHzl1-00046z-C1
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 18:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbaBXRzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 12:55:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47351 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752873AbaBXRzu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 12:55:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D83B6BC44;
	Mon, 24 Feb 2014 12:55:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eM4dL9kMdcKNEEnX0M9VJNHoJYc=; b=SAlvkB
	bGQ352Q3U5j8n+BD/7oSCvM03kE58g09m/SG4PS1NelcRBCxa/jWWethZngIxJ+G
	IIvwoxNw7cehyQ7/mI+Yxfgs2ImswhxMb1B86FIw6T1eE2ibKcI2pQhChKanfp+b
	sivASIg9N6PdrzLClZVrkcRsf5ViMue0agpW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iUHGHI1WuUPgpSRBKPvL4ObfvVTPs1B2
	wh0lN265zVuWddI9PbrO56ga0yFaLgHU8VHwbxEXjopXX8XUst73UFEdF5inrcdt
	PyDWIQeyveUc6vZJKkkkKwthU+5EX6yXQ3q6w9UEjaWUFDX+0lhhhadVDMENI2p0
	MwVvHXcEQkA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 198086BC43;
	Mon, 24 Feb 2014 12:55:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B8AC6BC42;
	Mon, 24 Feb 2014 12:55:49 -0500 (EST)
In-Reply-To: <m2ob1xba94.fsf@richlowe.net> (Richard Lowe's message of "Sun, 23
	Feb 2014 19:54:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E4F22090-9D7C-11E3-9B16-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242623>

Richard Lowe <richlowe@richlowe.net> writes:

> Bitfields need to specify their signedness explicitly or the compiler is
> free to default as it sees fit.  With compilers that default 'unsigned'
> (SUNWspro 12 seems to do this) the tri-state nature of is_binary
> vanishes and all files are treated as binary.
>
> Signed-off-by: Richard Lowe <richlowe@richlowe.net>
> ---

Looks good; thanks.

>  diffcore.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/diffcore.h b/diffcore.h
> index 79de8cf..7c6f391 100644
> --- a/diffcore.h
> +++ b/diffcore.h
> @@ -46,7 +46,7 @@ struct diff_filespec {
>  	unsigned is_stdin : 1;
>  	unsigned has_more_entries : 1; /* only appear in combined diff */
>  	/* data should be considered "binary"; -1 means "don't know yet" */
> -	int is_binary : 2;
> +	signed int is_binary : 2;
>  	struct userdiff_driver *driver;
>  };
