From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH v7 6/9] gitweb/lib - Simple output capture by
 redirecting STDOUT to file
Date: Fri, 24 Dec 2010 03:49:34 -0600
Message-ID: <20101224094934.GA952@burratino>
References: <20101222234843.7998.87068.stgit@localhost.localdomain>
 <20101222235705.7998.76695.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "J.H." <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 24 10:49:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PW4Ha-0003s5-7J
	for gcvg-git-2@lo.gmane.org; Fri, 24 Dec 2010 10:49:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901Ab0LXJtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Dec 2010 04:49:49 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:48949 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab0LXJts (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Dec 2010 04:49:48 -0500
Received: by ywl5 with SMTP id 5so2946053ywl.19
        for <git@vger.kernel.org>; Fri, 24 Dec 2010 01:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=KlmBwMRSRXW6j/8SRV2FjNWsw6jyKr3uEV/2B7EAw/U=;
        b=CWctMrQ0a2/vo6WwOUfph+FyVALSZxg1I+jkIm0iMTVPGptbT33f1wR3/V4jKkMTGj
         yrReBZctrEsCGGJTa8ZTQC7rWMSGln2/zMRFblxK1iNdUJhr56IydEG7QXG/wcxgfoBG
         QBfQO9piAok7gYe+AUJEB+8OvNJ1MqmgPrF/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pjOBYM4lbYYsuDbAC/GMTW2cDFRwPjjwYZXb9zB0jLHT0btxUWorlUnGcJ2KgPdVNJ
         viyd+vvTfK1n4QrG0+xRn7z+1QCekw21DulPOvz3Qwfbz2ifFb95TK8hjG/fBuXPqXmi
         lEmVAvWaMZmoF6A+aQHtW8nD7SI70abO4LZ14=
Received: by 10.150.190.2 with SMTP id n2mr13653677ybf.268.1293184187169;
        Fri, 24 Dec 2010 01:49:47 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id o10sm1519031yha.44.2010.12.24.01.49.44
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Dec 2010 01:49:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101222235705.7998.76695.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164152>

Jakub Narebski wrote:

> This patch was based on "gitweb: add output buffering and associated
> functions" patch by John 'Warthog9' Hawley (J.H.) in "Gitweb caching v7"
> series, and on code of Capture::Tiny by David Golden (Apache License 2.0).

Micronit: if the license of Capture::Tiny were relevant then we would be
in trouble, I think.  (Apache-2.0 and GPLv2 aren't compatible licenses.)
Luckily

[...]
> +# taken from Capture::Tiny by David Golden, Apache License 2.0
> +# with debugging stripped out
> +sub _relayer {
> +	my ($fh, $layers) = @_;
> +
> +	my %seen = ( unix => 1, perlio => 1); # filter these out
> +	my @unique = grep { !$seen{$_}++ } @$layers;
> +
> +	binmode($fh, join(":", ":raw", @unique));
> +}

looks trivial enough.  Maybe either avoiding mention of the license or
clarifying that that is not intended to be the sole license for the
stripped-down code would help?
