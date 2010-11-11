From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 2/3] Add the 'fetch.recurseSubmodules' config setting
Date: Wed, 10 Nov 2010 18:02:16 -0600
Message-ID: <20101111000216.GA14189@burratino>
References: <4CDB3063.5010801@web.de>
 <4CDB30D6.5040302@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Kevin Ballard <kevin@sb.org>,
	Jon Seymour <jon.seymour@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Nov 11 01:02:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGKco-0004eK-Hm
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 01:02:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757559Ab0KKACl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 19:02:41 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55684 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757116Ab0KKACl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Nov 2010 19:02:41 -0500
Received: by vws13 with SMTP id 13so108632vws.19
        for <git@vger.kernel.org>; Wed, 10 Nov 2010 16:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Ecz7w1MkaswVw8QisfuUbuHyQxUpfoIa9i1XkLU3fvM=;
        b=fywFlw1gDHsPBc5BZIwXd7lqJj0jMwgFrR+N3WoBkgKhibvKPXIMg6KtMPtdMH/uKq
         3XMBkNxK9o9i2izFLubtUfE4mv/MZldYMXyjayZawtiiBS65+LhpGpiVsXISoVQNO98R
         DEmerhqQBZ/F1CW448/FR3gqlAdT0c8toi8jU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=UYpZ6CQE8BR97Mrh64aXvKDk3W4KrmE+qDh2U6Y7OqE7UfwwhUw/tVTDlb7jqnH6hA
         0wMEnjnVSzTbOTibZ+oYeKfefTvCyCxXAIwBXAkQeIUBudu+1+EV/xq9W+H1JOvdJ7LO
         gBAcDhcs/AVeDFp/xg5NnyeMXk33wLRgsvfg0=
Received: by 10.220.177.9 with SMTP id bg9mr15276vcb.156.1289433760333;
        Wed, 10 Nov 2010 16:02:40 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id s12sm469767vbp.14.2010.11.10.16.02.38
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 10 Nov 2010 16:02:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CDB30D6.5040302@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161197>

Jens Lehmann wrote:

> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -106,4 +106,40 @@ test_expect_success "--dry-run propagates to submodules" '
>  	test_cmp expect.err actual.err
>  '
> 
> +test_expect_success "recurseSubmodules=true propagates into submodules" '
> +	add_upstream_commit &&
> +	(
> +		cd downstream &&
> +		git config fetch.recurseSubmodules true
> +		git fetch >../actual.out 2>../actual.err
> +	) &&
> +	test_cmp expect.out actual.out &&
> +	test_cmp expect.err actual.err
> +'

This configuration item is read from .gitmodules, too, right?  Would
it be easy (or desirable) to make it not read from there?  Either way,
it would be nice to have a test so the behavior doesn't change without
anyone noticing.
