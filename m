From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 07/10] gitweb: remotes view for a single remote
Date: Mon, 25 Oct 2010 17:12:28 +0200
Message-ID: <201010251712.30362.jnareb@gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com> <1287917136-26103-8-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 25 17:12:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAOjB-0003YR-0F
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 17:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775Ab0JYPMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 11:12:39 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:44589 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649Ab0JYPMi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 11:12:38 -0400
Received: by fxm16 with SMTP id 16so3020920fxm.19
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=qSeU09o3Bhr4G5dnCK+xrTqbrGjo96xWDrrzwOFA134=;
        b=jC9NjBBOigvzTPxLy/LDlBCq8Q1tlWK632ZYyE7lPVCtQfvbppYsdcUbcgJJjuzc+A
         4EgC5OFHSxJSZac5QSI+WtKUjBLeJurRvms3ZgLcZS23/Pw37sddMzjz+sb3aC+dO6CB
         Gi2HAskGgDFwOLuQT6+enNckXwOBK+L8hX7x8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=RqOutt9iwSyPa63Cte53aEZ3WKZrEJn5h3lUAWDsHaPCTg/GC4/rQ3CPTIUKAQtVnO
         0vcVko9u/JM179F6AAapnh14Z0k87vb9vVV/zE/BBC1PuufItrCCO2f+7TqfOIJgdHaN
         s3MiGD/wUhp5CBkB5acmjk202mA1xeWd37wRM=
Received: by 10.204.50.194 with SMTP id a2mr4404139bkg.183.1288019556680;
        Mon, 25 Oct 2010 08:12:36 -0700 (PDT)
Received: from [192.168.1.13] (abwi90.neoplus.adsl.tpnet.pl [83.8.232.90])
        by mx.google.com with ESMTPS id u4sm4921976bkz.5.2010.10.25.08.12.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Oct 2010 08:12:35 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1287917136-26103-8-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159958>

On Sun, 24 Oct 2010, Giuseppe Bilotta wrote:

> When 'remotes' view is passed the 'hash' parameter, interpret it as the
> name of a remote and limit the view the the heads of that remote.

I don't quite like (ab)using 'hash' parameter like that, but because
it allows us to use e.g. 'project.git/remotes/origin' path_info
without writing special code for that, I am all right with this hack.

> 
> In single-remote view we let the user switch easily to the default
> remotes view by specifying an -action_extra for the page header and by
> enabling the 'remotes' link in the reference navigation submenu.

Nice!

> +	if (defined $remote) {
> +		# only display the heads in a given remote

It also strips uninteresting '<remote>/' prefix, isn't it?
It would be nice, though not necessary, to have this in comment.

> +		@remotelist = map {
> +			my $ref = $_ ;
> +			$ref->{'name'} =~ s!^$remote/!!;
> +			$ref
> +		} git_get_heads_list(undef, "remotes/$remote");
> +	} else {

-- 
Jakub Narebski
Poland
