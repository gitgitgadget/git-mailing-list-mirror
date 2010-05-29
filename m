From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/7] Add a memory pool library
Date: Sat, 29 May 2010 04:06:10 -0500
Message-ID: <20100529090609.GA7247@progeny.tock>
References: <1274650832-7411-1-git-send-email-artagnon@gmail.com>
 <1274650832-7411-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 29 11:05:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIHzL-0000yS-Ot
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 11:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357Ab0E2JFq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 May 2010 05:05:46 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:48128 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288Ab0E2JFp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 05:05:45 -0400
Received: by ywh36 with SMTP id 36so1327559ywh.4
        for <git@vger.kernel.org>; Sat, 29 May 2010 02:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Ew7KKKvhqPpCA+UETHSikkutM+OMkVkE0fCqGcQeZW8=;
        b=Ihws835V02gdXO71NfIa0XyHYviBDHQm3K8PaDVyBg4YZdg6A8mecf2DvwYJvH7L6J
         bHbgRrLZ2+zfwYliR1JJInM0D090yyVSA2FdaumBS74cM+/X0rITJSqndCeeKUwUk55z
         So8twifceuWhCSkGpZSsUmGqMPSuebLvjzbH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=j5yyKyvPPzJgxyJ519hcUAFDPeFb67hGQ1pY1Mq8l/7MIunDfE0fNeEsx07p2sLfdJ
         3ZQrlJS0eIEjknKbgomgjy7wFukKBAF83Girn0i2ENhnlyGE4fvLRhhLWJQcXBKpsYdt
         /n2XPMjyqbVpnt2m6yOWUSPhPp3YKmq0e7WK8=
Received: by 10.231.169.131 with SMTP id z3mr1923521iby.48.1275123944868;
        Sat, 29 May 2010 02:05:44 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id r12sm15116439ibi.14.2010.05.29.02.05.43
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 29 May 2010 02:05:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1274650832-7411-5-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147961>

Ramkumar Ramachandra wrote:

> Add a memory pool library implemented using cpp macros.

Hmm, like talloc[1].  How do they compare?

[...]
> + *   pre              : Prefix for generated functions (ex: string_).
> + *   obj_t            : Type for treap data structure (ex: char).
> + *   intial_capacity  : The initial size of the memory pool (ex: 4096).
> + *
> + */
> +#define obj_pool_gen(pre, obj_t, initial_capacity)                         \
> +static struct {                                                            \
> +    uint32_t size;                                                         \
> +    uint32_t capacity;                                                     \
> +    obj_t *base;                                                           \
> +} pre##_pool = { 0, 0, NULL};                                              \
> +static uint32_t pre##_alloc(uint32_t count)                                \
[...]

This makes functions with names like string_alloc(), which would then
be un-greppable.  It might be nice (though certainly not necessary) to
provide an overview in Documentation/technical/ so there is no need to
find the definition of each function.

Jonathan

[1] http://ccan.ozlabs.org/info/talloc.html
