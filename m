From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 06/12] connect: Fix custom ports with plink
 (Putty's ssh)
Date: Wed, 2 Jul 2008 21:04:20 +0200
Message-ID: <200807022104.20146.johannes.sixt@telecom.at>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-5-git-send-email-prohaska@zib.de> <1214987532-23640-6-git-send-email-prohaska@zib.de>
Reply-To: johannes.sixt@telecom.at
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, "Edward Z. Yang" <edwardzyang@thewritingpot.com>
To: prohaska@zib.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Wed Jul 02 21:05:55 2008
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from yw-out-2122.google.com ([74.125.46.25])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE7dv-0005z1-6G
	for gcvm-msysgit@m.gmane.org; Wed, 02 Jul 2008 21:05:52 +0200
Received: by yw-out-2122.google.com with SMTP id 8so239367yws.63
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Jul 2008 12:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received-spf:authentication-results:received
         :received:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:reply-to:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere;
        bh=MN3x5+viFELOhXjyrf/az5jdPgRQ86YuvH7AFtQgZA4=;
        b=WlsRhdYZmLikjMNg6dtRxh+w0to7+jnS9edLHV6h+pcXT4hiSp8Sbp7BTfW3UaPRzd
         yfCWnuwZWHB5LFTYeW9A91+bdul/oxW9AvaYHFNQKPyKC9y+JvOD6WuSXNlDNXsRQ601
         TgriLdylfdyh2AmKWxtsj6EHQQBx877HtHRqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results:from
         :to:subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id:reply-to:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere;
        b=Q0Wkgr9CVRCkAZI5MDMn3QDZVslDkg078zrjKENenVurl04sFPRezkozJ9XPcrXq5m
         H+VuD/ZoAN2yWpWiCxGmPfyylO5n+GQiB08SvM72le24VutjsX3INynvtffIUlsk2aGO
         THBWQLLSC79CgFuclJAbQPI3YoT2XTl7MVhPg=
Received: by 10.115.18.18 with SMTP id v18mr582704wai.26.1215025462946;
        Wed, 02 Jul 2008 12:04:22 -0700 (PDT)
Received: by 10.106.193.17 with SMTP id q17gr2580prf.0;
	Wed, 02 Jul 2008 12:04:22 -0700 (PDT)
X-Sender: johannes.sixt@telecom.at
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.114.193.1 with SMTP id q1mr4842166waf.12.1215025462560; Wed, 02 Jul 2008 12:04:22 -0700 (PDT)
Received: from smtp5.srv.eunet.at (smtp5.srv.eunet.at [193.154.160.227]) by mx.google.com with ESMTP id 7si8607370yxg.1.2008.07.02.12.04.21; Wed, 02 Jul 2008 12:04:22 -0700 (PDT)
Received-SPF: neutral (google.com: 193.154.160.227 is neither permitted nor denied by best guess record for domain of johannes.sixt@telecom.at) client-ip=193.154.160.227;
Authentication-Results: mx.google.com; spf=neutral (google.com: 193.154.160.227 is neither permitted nor denied by best guess record for domain of johannes.sixt@telecom.at) smtp.mail=johannes.sixt@telecom.at
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19]) by smtp5.srv.eunet.at (Postfix) with ESMTP id 7DD3413A37E; Wed,  2 Jul 2008 21:04:20 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1]) by dx.sixt.local (Postfix) with ESMTP id 41EDD1D155; Wed,  2 Jul 2008 21:04:20 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1214987532-23640-6-git-send-email-prohaska@zib.de>
Content-Disposition: inline
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit-owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit-help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit-unsubscribe@googlegroups.com>
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87181>


On Mittwoch, 2. Juli 2008, Steffen Prohaska wrote:
> From: Edward Z. Yang <edwardzyang@thewritingpot.com>
>
> PuTTY requires -P while OpenSSH requires -p; if plink is detected
> as GIT_SSH, use the alternate flag.
>
> Signed-off-by: Edward Z. Yang <edwardzyang@thewritingpot.com>
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> ---
>  connect.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/connect.c b/connect.c
> index 574f42f..0d007f3 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -599,11 +599,13 @@ struct child_process *git_connect(int fd[2], const
> char *url_orig, conn->argv = arg = xcalloc(6, sizeof(*arg));
>  	if (protocol == PROTO_SSH) {
>  		const char *ssh = getenv("GIT_SSH");
> +		int putty = ssh && strstr(ssh, "plink");
>  		if (!ssh) ssh = "ssh";
>
>  		*arg++ = ssh;
>  		if (port) {
> -			*arg++ = "-p";
> +			/* P is for PuTTY, p is for OpenSSH */
> +			*arg++ = putty ? "-P" : "-p";
>  			*arg++ = port;
>  		}
>  		*arg++ = host;

What about installing a wrapper script, plinkssh, that does this:

#!/bin/bash

if test "$1" = -p; then
	port="-P $2"
	shift; shift
fi

exec plink $port "$@"

and require plink users to set GIT_SSH=plinkssh?

-- Hannes
