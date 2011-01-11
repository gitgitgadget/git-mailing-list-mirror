From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] svndump.c: Fix a printf format compiler warning
Date: Tue, 11 Jan 2011 12:39:27 -0600
Message-ID: <20110111183927.GF15133@burratino>
References: <4D2C9EB1.2050100@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Jan 11 19:39:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcj8E-0001lW-4q
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 19:39:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566Ab1AKSjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 13:39:42 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46652 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756253Ab1AKSjk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 13:39:40 -0500
Received: by vws16 with SMTP id 16so8635251vws.19
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 10:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=oCOWab0k7hjV3PfLbLG7gSLcdjQslBRa0StnrE/IqTI=;
        b=XCXGjqNckzaRm6AaAR3gQvieTOwbdl3FloasvI28PqdJkHVmL2AMeUVJCFTT0ypTis
         hhoR2s0EW80okDU3AE4RLDeaM8FEkMnoLF8//BEYTU7oN/DvigetA3MjdSOwOsVBlu85
         mmzs8GD+RgflYOCa7SkZMydwI8ZRG6aK+R1E4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JjHfYOKcJStKKUIw2c5yUMt/HxpBnI7mwVOt94C1wdXm14tB9nzv3Ad+pMiXC3dA5R
         8m9ckLFKX+wv64lYBQzJJTWFRj2ck+vkuNOhq0lD3unUvBVW+myd6XxDF1VB8YYC+ADo
         B7za/lRuglJLlv54a/PfMY+6ihl3w/7SM3wWA=
Received: by 10.220.191.131 with SMTP id dm3mr1911176vcb.30.1294771179557;
        Tue, 11 Jan 2011 10:39:39 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id r7sm11709179vbx.19.2011.01.11.10.39.36
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 11 Jan 2011 10:39:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D2C9EB1.2050100@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164970>

Ramsay Jones wrote:

> --- a/vcs-svn/svndump.c
> +++ b/vcs-svn/svndump.c
> @@ -211,7 +211,7 @@ void svndump_read(const char *url)
>  		if (key == keys.svn_fs_dump_format_version) {
>  			dump_ctx.version = atoi(val);
>  			if (dump_ctx.version > 2)
> -				die("expected svn dump format version <= 2, found %d",
> +				die("expected svn dump format version <= 2, found %"PRIu32,
>  				    dump_ctx.version);

Acked-by: Jonathan Nieder <jrnieder@gmail.com>

I think we should just use "int", but that is a wider sweeping change
for another time.  Thanks.

Does gcc or sparse provide a warning that could have caught this
mistake?
