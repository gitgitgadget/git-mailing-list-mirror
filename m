From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH bg/format-patch-p-noop] log-tree: always add --- marker
 when options are patch and a stat
Date: Tue, 03 Nov 2009 23:35:33 -0800
Message-ID: <4AF12EC5.4030407@gmail.com>
References: <1257283456-7007-1-git-send-email-bebarino@gmail.com> <7vy6mmltz9.fsf@alter.siamese.dyndns.org> <20091104063612.GA24263@coredump.intra.peff.net> <20091104071053.GB24263@coredump.intra.peff.net> <20091104071940.GA15011@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?ISO-8859-1?Q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 08:35:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5aP8-0002cN-FT
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 08:35:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbZKDHfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 02:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbZKDHfb
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 02:35:31 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:54705 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbZKDHfb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 02:35:31 -0500
Received: by yxe17 with SMTP id 17so6144588yxe.33
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 23:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=O4crlE50Cq9KOL4iEW9+DWcWK7d6odCwKQV6HLZt8JY=;
        b=av+2P8fErfrdHe7cU2gPn9/wMOXTYBThc4ZC8mw4AyNYjOXY4puPUgpvzZ5dov8Td1
         KvWmR41x13AnU37q1zteywgWbX35SD9harRiJSPmh7SDB1n749xgkpmwxr3ikIXFBnzi
         XBgIei0ralX/3FMsK/qa4TpV7LG/5InXxQJg0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=nrr/vre54180++Yv6r0Sg1kZW0Foe99SXzwhfnH5BLiE1kR1k7sVIsRgk33zrIEibN
         CXnvAXPTytTB7EMrevNMGVfoa6UdfLYqi8XgZIa4HNiPDnJ0qgTNTMwT3nO9RD+RBz/m
         dI9r/RJaC3kDRVzrv6Qch4cIX7tyPN5Opzsc4=
Received: by 10.150.44.28 with SMTP id r28mr2134642ybr.36.1257320136341;
        Tue, 03 Nov 2009 23:35:36 -0800 (PST)
Received: from ?192.168.0.5? (cpe-76-174-15-88.socal.res.rr.com [76.174.15.88])
        by mx.google.com with ESMTPS id 14sm418151gxk.14.2009.11.03.23.35.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Nov 2009 23:35:35 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20091026)
In-Reply-To: <20091104071940.GA15011@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132056>

Jeff King wrote:
>
> This patch unbreaks what 68daa64 did (while still preserving
> what 68daa64 was trying to do), reinstating "-p" to suppress
> the default behavior. We do this by parsing "-p" ourselves
> in format-patch, and noting whether it was used explicitly.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>   

This looks good to me; covering 2 and 3 of Junio's TODO list.

> @@ -940,6 +941,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		{ OPTION_CALLBACK, 0, "thread", &thread, "style",
>  			    "enable message threading, styles: shallow, deep",
>  			    PARSE_OPT_OPTARG, thread_callback },
> +		OPT_BOOLEAN('p', NULL, &use_patch_format,
> +			"show patch format instead of default (patch + stat)"),
>  		OPT_END()
>  	};

I don't imagine we want this option in the messaging group though. Can 
you move it up?
