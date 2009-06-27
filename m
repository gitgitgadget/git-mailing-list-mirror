From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 7/8] gitweb: recognize 'trivial' acks
Date: Sat, 27 Jun 2009 02:19:45 +0200
Message-ID: <200906270219.46266.jnareb@gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com> <1245926587-25074-7-git-send-email-giuseppe.bilotta@gmail.com> <1245926587-25074-8-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 02:20:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKLeJ-0008AQ-1N
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 02:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442AbZF0AT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 20:19:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753084AbZF0ATz
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 20:19:55 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:42821 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945AbZF0ATz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 20:19:55 -0400
Received: by fxm18 with SMTP id 18so9322fxm.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 17:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=PkpwPDOrWs5fWp9x0LCSYHcU8ZiDlUCfcNkwd6RCI58=;
        b=dDvNuxDul1jWZiBDfZP2o1kUZ+gZIbFsqoEpc3XyiA4aKQh5uMf3MeiFxz5etQR8Hv
         pvySFlAUR8VMYn11L3/olpkEYmmbq3OeW0qqjlFKw8gWL76ThMHSaRYeYfN/WOK2Axte
         kp8qX3VYBy1G+igOfd6aBk06AnbDOfA5WiAbs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=xwXWXEz+wkIW4qmSkFSaznGE3j42yH+bZzr8+am7KQIG4ggxjWYaOWtyiFjA+Yedgo
         cs1ssrZuGO58oW6R0723ZX7h3wvNQspTYaFoqOPFDSTkkN16juKWXG2fWZ+0mn9Ih5Pn
         drnbNS1/x0h0somIkYWWfhPI1b1avz6PAtBKo=
Received: by 10.86.2.8 with SMTP id 8mr4110295fgb.59.1246061997328;
        Fri, 26 Jun 2009 17:19:57 -0700 (PDT)
Received: from ?192.168.1.13? (abwa104.neoplus.adsl.tpnet.pl [83.8.224.104])
        by mx.google.com with ESMTPS id e11sm1413603fga.11.2009.06.26.17.19.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Jun 2009 17:19:57 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1245926587-25074-8-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122340>

On Thu, 25 Jun 2009, Giuseppe Bilotta wrote:
> Sometimes patches are trivially acked rather than just acked, so
> extend the signoff regexp to include this case.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

This is straghtforward enough.

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 3e6786b..7ca115f 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3403,7 +3403,7 @@ sub git_print_log {
>  	my $signoff = 0;
>  	my $empty = 0;
>  	foreach my $line (@$log) {
> -		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|acked[ \-]by[ :]|cc[ :])/i) {
> +		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|(?:trivially[ \-])?acked[ \-]by[ :]|cc[ :])/i) {
>  			$signoff = 1;
>  			$empty = 0;
>  			if (! $opts{'-remove_signoff'}) {
> -- 
> 1.6.3.rc1.192.gdbfcb
> 
> 

-- 
Jakub Narebski
Poland
