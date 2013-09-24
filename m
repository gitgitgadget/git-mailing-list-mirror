From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] doc: don't claim that cherry-pick calls patch-id
Date: Tue, 24 Sep 2013 15:14:09 -0700
Message-ID: <20130924221409.GT9464@google.com>
References: <1380060333-2226-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Sep 25 00:14:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOas6-0002ts-Jf
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 00:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754306Ab3IXWOO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 18:14:14 -0400
Received: from mail-pb0-f47.google.com ([209.85.160.47]:63044 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062Ab3IXWON (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 18:14:13 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so5111716pbb.20
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 15:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lZGWV8rg9FB+TGPKvg+lGqsRYgioj/x00IrTKBmXLM4=;
        b=Qz6ZUh3boUG8EEQhDVBfZxYI9zPbpZVRKohqdVHGBMnW8KTeCHPu6DMqT3KBnEg/l9
         ziTmJbVovbmITw+8C4hg5GaXIpfcJmqmweE+RCow/ySQ80R+GWO2kpICBiJwn7svUyKo
         blHRRuQonFqeIwRE8FJ+2bXH20sgGsYNGH7b7LOrSGdMM70eJXk+4/bRVU/uWa5McQYm
         sZjFZntw34OETD63rSl71+4jVFAvj9gwZ/FliTO/ZQJpBFKbm9vuj+Xeiqng3vGe3cXx
         qrrynMEhYiyBT1jAPMHypN3NPieCVeFgX+eo0F4mxIGhtmbx4OCCrWEuBI2nQu71zDiS
         eVXQ==
X-Received: by 10.68.139.168 with SMTP id qz8mr12696642pbb.1.1380060853163;
        Tue, 24 Sep 2013 15:14:13 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ed3sm19198849pbc.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 24 Sep 2013 15:14:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1380060333-2226-1-git-send-email-mst@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235322>

Michael S. Tsirkin wrote:

> Subject: [PATCH] doc: don't claim that cherry-pick calls patch-id

s/cherry-pick/cherry/

> The id is already different for binary files.
> Let's document that they are similar, not identical.

Thanks.

[...]
> --- a/Documentation/git-cherry.txt
> +++ b/Documentation/git-cherry.txt
> @@ -13,12 +13,13 @@ SYNOPSIS
>  DESCRIPTION
>  -----------
>  The changeset (or "diff") of each commit between the fork-point and <head>
> -is compared against each commit between the fork-point and <upstream>.
> +is compared against diff of each commit between the fork-point and <upstream>.

I think the old version of this sentence is clearer.

> -The commits are compared with their 'patch id', obtained from
> -the 'git patch-id' program.
> +The diffs are compared with their diff id (sha1) calculated after removing
> +any whitespace and line numbers (similar but not necessarily identical
> +to 'patch id', obtained from the 'git patch-id' program).

The hash used internally is just an implementation detail, so maybe this
sentence could just be dropped?

>  Every commit that doesn't exist in the <upstream> branch
> -has its id (sha1) reported, prefixed by a symbol.  The ones that have
> +has its diff id (sha1) reported, prefixed by a symbol.  The ones that have

Confusingly, here 'id' means 'commit name'.  For example:

 $ git log --oneline -1 sb/repack-in-c
 0b63c6a repack: improve warnings about failure of renaming and removing files
 $ git cherry sb/repack-in-c^ sb/repack-in-c
 + 0b63c6a5b78f3fdd8c4e4fed4e535e7f4eed4257

Hope that helps,
Jonathan
