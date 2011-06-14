From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: allow space as delimiter in mime.types
Date: Tue, 14 Jun 2011 07:59:10 -0700 (PDT)
Message-ID: <m3ips8v4s2.fsf@localhost.localdomain>
References: <1308060595-28294-1-git-send-email-ludwig.nussel@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ludwig Nussel <ludwig.nussel@suse.de>
X-From: git-owner@vger.kernel.org Tue Jun 14 16:59:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWV5J-0005sv-T7
	for gcvg-git-2@lo.gmane.org; Tue, 14 Jun 2011 16:59:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764Ab1FNO7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2011 10:59:13 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48739 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149Ab1FNO7M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2011 10:59:12 -0400
Received: by wya21 with SMTP id 21so3956376wya.19
        for <git@vger.kernel.org>; Tue, 14 Jun 2011 07:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=0ntVc+0S7nHkCcn4p+A2tOJ/ZINeh/ZhrnC3ZQNAERg=;
        b=PoVjeErJS7pxnYMP6NY2HTd9DUdrISTGnWzF4gBzI05xXFAHuDJbcA7qg1MLEh3poN
         Rm6JUD+LtUNfw1rkKYdd8inOZN3hXUn0+IAAgPD8/sCN9WE+xchCxpWgBSG/TbJGMS3n
         ged6K38NlHgzZH4EC1s4ziLK6JFapzpGFpluU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=h8bxFyLdaIhH3klEkba4elTpUVHg9heG/VBBzJIv+iSVS6h2Fhtjtw5GeJBWeyJyCK
         bbpAR00pUvzrHynAhpwk4ob/JhyB/G7D88gviMDFGoeuNerfeRg40VwtHbQ/ayGGgreu
         D08l2XFFOzRfOboiBUTdkvgRp2qNoBKhex0MQ=
Received: by 10.216.69.196 with SMTP id n46mr6250401wed.86.1308063551045;
        Tue, 14 Jun 2011 07:59:11 -0700 (PDT)
Received: from localhost.localdomain (abwt98.neoplus.adsl.tpnet.pl [83.8.243.98])
        by mx.google.com with ESMTPS id z66sm3537564weq.24.2011.06.14.07.59.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Jun 2011 07:59:10 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p5EEwbHa018161;
	Tue, 14 Jun 2011 16:58:48 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p5EEwLQA018157;
	Tue, 14 Jun 2011 16:58:21 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1308060595-28294-1-git-send-email-ludwig.nussel@suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175778>

Ludwig Nussel <ludwig.nussel@suse.de> writes:

> Subject: [PATCH] gitweb: allow space as delimiter in mime.types

A very minor nitpick: perhaps "work with" rather than "allow" would be
better?

> in openSUSE /etc/mime.types has only spaces. I don't know if there's
> a canonical reference that says that only tabs are allowed. Mutt at
> least also accepts spaces. So make gitweb more liberal too.

Ack.

It is obviously correct, as names of MUME types cannot contain spaces,
it makes gitweb work with openSUSE /etc/mime.types, and it makes code
simpler.

> ---

Signoff (i.e. Signed-off-by)?

>  gitweb/gitweb.perl |    9 +++------
>  1 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 1b83a8d..d81d87b 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3560,12 +3560,9 @@ sub mimetype_guess_file {
>  	open(my $mh, '<', $mimemap) or return undef;
>  	while (<$mh>) {
>  		next if m/^#/; # skip comments
> -		my ($mimetype, $exts) = split(/\t+/);
> -		if (defined $exts) {
> -			my @exts = split(/\s+/, $exts);
> -			foreach my $ext (@exts) {
> -				$mimemap{$ext} = $mimetype;
> -			}
> +		my ($mimetype, @exts) = split(/\s+/);
> +		foreach my $ext (@exts) {
> +			$mimemap{$ext} = $mimetype;
>  		}
>  	}
>  	close($mh);
> -- 
> 1.7.3.4
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
