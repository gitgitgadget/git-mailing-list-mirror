From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/10] Better "Changed but not updated" message in
 git-status
Date: Thu, 28 Oct 2010 13:35:13 -0500
Message-ID: <20101028183513.GC14212@burratino>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
 <1288290117-6734-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Thore Husfeldt <thore.husfeldt@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Oct 28 20:35:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBXJt-0003UM-RI
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 20:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761389Ab0J1SfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 14:35:22 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60849 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761238Ab0J1SfU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 14:35:20 -0400
Received: by wwe15 with SMTP id 15so2345026wwe.1
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 11:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=/L3AgxGu2KeOcfYXqTHc+25IpE3JlTyoIXPgA6LcQrU=;
        b=Ly7Tjj70oL4ug0ch0JvrQtQqf9prH9qFVO17bmWljLxHiHkTHzZohbrgZzGgC5KOnX
         sXCSxjbFeWWtV4dYoMThVNx4x7z3bWWm9oCKbfftmeIdiarq6YMFieD66NIY7bwGkdD4
         kwm/AFzRKEY2vwiXOmhqn9f8ICstCsn0Nfw+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=K5Ju+/Zz5KfjRRgwQiBJN8FbnLfl1TmANbm3MAedGzD5Y3N7ubCo1HIN1xju0VQDi/
         bK5OCn9qKSNNH6TXTRzWyCi/6fqyVLU+qO2/gf3GLRZEH9OQi7cjSCHQcH55xpik8ahl
         2MJPVRb+pw7xu+98T8+peS8CYZGFXOwiPu5F4=
Received: by 10.227.135.144 with SMTP id n16mr11405383wbt.17.1288290919183;
        Thu, 28 Oct 2010 11:35:19 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id ga16sm1205307wbb.1.2010.10.28.11.35.16
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 11:35:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1288290117-6734-2-git-send-email-Matthieu.Moy@imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160205>

Matthieu Moy wrote:

> +++ b/wt-status.c
> @@ -88,7 +88,7 @@ static void wt_status_print_dirty_header(struct wt_status *s,
>  {
>  	const char *c = color(WT_STATUS_HEADER, s);
>  
> -	color_fprintf_ln(s->fp, c, "# Changed but not updated:");
> +	color_fprintf_ln(s->fp, c, "# Changes not staged for commit:");
>  	if (!advice_status_hints)
>  		return;

Result looks like:

 # Changes to be committed:
 #   (use "git reset HEAD <file>..." to unstage)
 #
 #       new file:   foo.c
 #
 # Changes not staged for commit:
 #   (use "git add <file>..." to update what will be committed)
 #   (use "git checkout -- <file>..." to discard changes in working directory)
 #
 #       modified:   foo.c
 #
 # Untracked files:
 #   (use "git add <file>..." to include in what will be committed)
 #
 #       bar.c

which is both clearer and more consistent.  So for what it's worth,
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
