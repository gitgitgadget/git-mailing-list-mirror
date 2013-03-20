From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation: merging a tag is a special case
Date: Wed, 20 Mar 2013 11:54:34 -0700
Message-ID: <20130320185434.GP3655@google.com>
References: <1363704914.6289.39.camel@test.quest-ce.net>
 <7vfvzrjrad.fsf@alter.siamese.dyndns.org>
 <1363802033-26868-1-git-send-email-ydroneaud@opteya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 19:55:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIOAF-0001od-Kh
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 19:55:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755643Ab3CTSyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 14:54:40 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33020 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab3CTSyj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 14:54:39 -0400
Received: by mail-pb0-f46.google.com with SMTP id uo15so1583254pbc.33
        for <git@vger.kernel.org>; Wed, 20 Mar 2013 11:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/3H76GSkZ/sNKeFikyQEZrV7MA7sPWybfS23Q/jZhkY=;
        b=WYNwQx8uSYyso1yEBlkWHfVlTN1eYs5WSC8MVFiHelcvWcis25yQspW9TB5YvXjeMd
         S7YGORKEvudd/ChWykwPbY9tDNKy/+fGGfdwzknzIHieZBcS7LNDGJw/n7yR2GKoTfPd
         FkhalYsuGWcDBk6xpVrc7lempFr5B2g4B3Dh3UoCFMTJNcC2dz9JEB1TdjGTropx55vG
         UIoyzffTmMuW6InTYqFzD58VMlgDASLpo6OpvdVFaJh/jSKPbAzX4Wes0xjKwx/DxzDM
         SKMaj7G4wZGVw7RNg6FNvpBxRS/hrlTgcJmD/sVh43ccfHws2UGQHaoPFmhNP7Y3gAd2
         RIxA==
X-Received: by 10.66.228.194 with SMTP id sk2mr11071644pac.51.1363805679401;
        Wed, 20 Mar 2013 11:54:39 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id ab1sm3002439pbd.37.2013.03.20.11.54.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 Mar 2013 11:54:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1363802033-26868-1-git-send-email-ydroneaud@opteya.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218655>

Yann Droneaud wrote:

> When asking Git to merge a tag (such as a signed tag or annotated tag),
> it will always create a merge commit even if fast-forward was possible.
> It's like having --no-ff present on the command line.

Thanks.  This looks good, modulo some nitpicks.

[...]
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -170,6 +170,15 @@ happens:
>  If you tried a merge which resulted in complex conflicts and
>  want to start over, you can recover with `git merge --abort`.
>  
> +MERGING TAG
> +-----------
> +
> +When merging a tag (annotated or signed), Git will create a merge commit

How about something like "When merging an annotated or signed tag" or
"When merging an annotated (and possibly signed) tag"?  The above text
can be misread as meaning "When merging any tag, no matter whether it
is annotated or signed", which is needlessly confusing for people who
don't know about unannotated tags.

[...]
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -26,7 +26,7 @@ set to `no` at the beginning of them.
>  --ff::
>  	When the merge resolves as a fast-forward, only update the branch
>  	pointer, without creating a merge commit.  This is the default
> -	behavior.
> +	behavior (except when merging a tag).

s/a tag/an annotated tag/ here as well.

By the way, what about the possibility of dropping this implicit
--no-ff?  I think Linus could get used to passing --no-ff explicitly
when responding to pull requests.  I could go either way on it.

It is certainly useful to document the current state before
considering changing it, so with the tweaks mentioned above,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
