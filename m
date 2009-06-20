From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] rebase -i: use some kind of config file to save author information
Date: Sat, 20 Jun 2009 02:27:00 -0700 (PDT)
Message-ID: <m3ab43gsrm.fsf@localhost.localdomain>
References: <20090620023413.3995.3630.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Jun 20 11:27:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHwrO-000495-AH
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 11:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbZFTJ1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 05:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751906AbZFTJ1A
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 05:27:00 -0400
Received: from mail-fx0-f214.google.com ([209.85.220.214]:62345 "EHLO
	mail-fx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbZFTJ07 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 05:26:59 -0400
Received: by fxm10 with SMTP id 10so76798fxm.37
        for <git@vger.kernel.org>; Sat, 20 Jun 2009 02:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=ZOVOLfn2CIqNd3QH2UVUHUv4isyQd4SUHicyvMUoztw=;
        b=O3rrjuyzBlyEg8sA+QwbfcmGivfPs94odtb7xjr5ApjHW7fsUn9nav+ddFYV8Bnp1v
         tBm2R6J9XPrjVDWKGq5RCiu+6k94uuOabaoMeBUIEcly17M3dfMHYGv5oTq5K3U7FJqX
         evpBRl+cKhGafnUODymBDUXp9Gm6/2x+62Yns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=bhxGW9DyPb/W/T7zU5ctaiIjzaXws0JsakPdmh2a0+466J8m//NdbgsA5F+aurQv5W
         CJ1GUdMVLnU35+eIHWc6q79TbRBJv/NRj7WXEC9D3Net36Wpq8sjQXczQFqzXaC5/YjS
         OLqFMqciOVLGpRji0pnGa5YTCGxzjAdkLy0ow=
Received: by 10.86.49.13 with SMTP id w13mr4024767fgw.31.1245490021184;
        Sat, 20 Jun 2009 02:27:01 -0700 (PDT)
Received: from localhost.localdomain (abwr61.neoplus.adsl.tpnet.pl [83.8.241.61])
        by mx.google.com with ESMTPS id 4sm1050257fge.13.2009.06.20.02.27.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Jun 2009 02:27:00 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n5K9Qw6c032558;
	Sat, 20 Jun 2009 11:26:58 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n5K9QsHI032555;
	Sat, 20 Jun 2009 11:26:54 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090620023413.3995.3630.chriscool@tuxfamily.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121938>

Christian Couder <chriscool@tuxfamily.org> writes:

> Subject: [PATCH 2/2] rebase -i: use some kind of config file to save author information

Errr... "kind of" config file?  I'd say use config file format for
saving author information.

>
> This is better than saving in a shell script, because it will make
> it much easier to port "rebase -i" to C. This also removes some sed
> regexps and some "eval"s.

Would it?  Well, I guess that at least we will avoid problems with
shell quoting and shell variable expansion rules.

> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  git-rebase--interactive.sh |   78 +++++++++++++++++++++++---------------------
>  1 files changed, 41 insertions(+), 37 deletions(-)
> 
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> +save_author_ident () {
> +	GIT_CONFIG="$SAVE_AUTHOR_INFO" git config rebase.author.name \
> +		"$author_ident_name" &&
> +	GIT_CONFIG="$SAVE_AUTHOR_INFO" git config rebase.author.mail \
> +		"$author_ident_mail" &&
> +	GIT_CONFIG="$SAVE_AUTHOR_INFO" git config rebase.author.date \
> +		"$author_ident_date"
> +}
> +
> +load_author_ident () {
> +	GIT_AUTHOR_NAME=$(GIT_CONFIG="$SAVE_AUTHOR_INFO" \
> +		git config rebase.author.name) &&
> +	GIT_AUTHOR_EMAIL=$(GIT_CONFIG="$SAVE_AUTHOR_INFO" \
> +		git config rebase.author.mail) &&
> +	GIT_AUTHOR_DATE=$(GIT_CONFIG="$SAVE_AUTHOR_INFO" \
> +		git config rebase.author.date)
>  }

Why not use --file=<filename> option of git-config instead?
-- 
Jakub Narebski
Poland
ShadeHawk on #git
