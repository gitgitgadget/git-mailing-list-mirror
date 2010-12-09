From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] config: add core.sharedconfig
Date: Thu, 9 Dec 2010 12:19:24 -0600
Message-ID: <20101209181924.GD5974@burratino>
References: <1291907388-9068-1-git-send-email-pclouds@gmail.com>
 <1291907388-9068-4-git-send-email-pclouds@gmail.com>
 <7vwrnig6gr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 19:19:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQl5m-0001yd-B5
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 19:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756754Ab0LISTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 13:19:42 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44104 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756063Ab0LISTl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 13:19:41 -0500
Received: by wyb28 with SMTP id 28so2556131wyb.19
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 10:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=W7uOL6+eILHMMOwgwpVf8oulC13QazkzMuxiSBSfCt4=;
        b=oCIhHYWXEBqR+6WluTjFemGMjZWEPgkhmr9OciG9k55J7Tcm0I9Vr/L58EZJIWZc2Y
         BlhCdM75tp0pBjjFEK6Xa7hJRAKBkdzl2DFWT0o336JZI7NSdB3h9zY2J9qkHVNuVZ8Q
         BROmcx6VlYCcZvOuQP+z6JQ2ddRsrcFrC/xvY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cSzRDrqy56ahf4PFrZo/injunCk2rT2GWayabJyb0clsmJW3+87QOw3mMOvNnzqGrs
         uqpJXrZ1SL4pvpZjk6+ZMSf5VQYSP4V10i+V1Ay9NYCWOdZYsE/AN18bGf4y9agIqi26
         zaceVm3rqQ+ly9Wa9gkv6sdFZc9xazBiy3Oeg=
Received: by 10.227.10.198 with SMTP id q6mr10960687wbq.21.1291918779622;
        Thu, 09 Dec 2010 10:19:39 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.sbcglobal.net [69.209.58.175])
        by mx.google.com with ESMTPS id p4sm1027801wer.29.2010.12.09.10.19.38
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 10:19:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vwrnig6gr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163303>

Junio C Hamano wrote:

> I originally liked what the first two tried to do, but think about the use
> case.  How would this whole thing work?
> 
>  - The user clones from the project to get a repository with a working
>    tree;
> 
>  - The user somehow learns that s/he can run one command to get
>    project-wide preference of the project:
> 
>      $ git config core.sharedconfig refs/remotes/origin/config:git.config
> 
>  - Everything hopefully should work the way project wishes in that blob,
>    unless the end user later overrides them by adding different settings
>    to .git/config.
> 
> How is that different from:
> 
>  - The user clones from the project to get a repository with a working
>    tree;
> 
>  - The user somehow learns that s/he can run one command to get
>    project-wide preference of the project:
> 
>      $ ./setup-project-preference.sh
> 
>    Typically, such a ./setup-project-preference.sh script would only
>    consist of a series of "git config $foo $bar", so any user who can say
>    "git config core.sharedconfig $foo" should be able to use it as well.

Wouldn't this ./setup-project-preference.sh have to set up a post-fetch hook
to update the configuration when the project's preferences change?
