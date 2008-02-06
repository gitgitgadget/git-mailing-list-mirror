From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH WIP] git-stash: add new 'drop' subcommand
Date: Wed, 06 Feb 2008 18:11:38 +0100
Message-ID: <47A9EA4A.60101@gnu.org>
References: <alpine.LSU.1.00.0802051401000.8543@racer.site> <47A9DE06.9050307@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wincent Colaiuta <win@wincent.com>,
	Tim Stoakes <tim@stoakes.net>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Feb 06 18:12:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMnop-0007Ii-Ru
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 18:12:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249AbYBFRLq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 12:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754269AbYBFRLq
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 12:11:46 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:54472 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013AbYBFRLp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 12:11:45 -0500
Received: by fg-out-1718.google.com with SMTP id e21so2426938fga.17
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 09:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=ZorbNg7bZ4nOH4S2sbT3Cn084lVKheaKlu0Wso86U0E=;
        b=mGbhhwCL+YLgX2jnf+LMCEFm8CEOfEucKJF18VaopVAOlvYQpEe4wZRQiL+eIK2iR5yuAxN4sDZRNOsN7hj1RB1KDYzxeN90nNyJwn3kly38hGiF7EMZOA/hacaPN81azGGOwY8qyJiVCS0iidbiWnb7IHAgM8FRcwkACMOmAvM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=RQdSc7Injc2bp6igbCV3yCdDR/MTX62WXUL31x/YJn3uVf0duWo7H+vm4F43ZQ4OOrEOaK1gVWXmv7mya+OSUojcDYgMtm1nJZA3dYdJj3m0NmnVwJ+LiUSqwgQkbo30hErf5otJJ9xRnp6qDw+W4eP1NNXeEGMzuwfdmgFBzOo=
Received: by 10.86.89.4 with SMTP id m4mr9321288fgb.45.1202317903838;
        Wed, 06 Feb 2008 09:11:43 -0800 (PST)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id l19sm14406089fgb.0.2008.02.06.09.11.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Feb 2008 09:11:42 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Macintosh/20071031)
In-Reply-To: <47A9DE06.9050307@nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72819>


> Also missing is the ability to drop multiple stash entries at
> one time. I think reflog delete will have to be modified to
> accommodate this. What happens is that the deletions are performed
> in a loop, and each deletion shifts the reflog entries so that they
> don't necessarily point to the same thing.

You just have to sort them backwards, either here or in git reflog.

> +drop)
> +	shift
> +	drop_stash "$@"

drop_stash $(echo "$@" | tr ' ' '\n' | sort -runt\{ -k2)

Paolo
