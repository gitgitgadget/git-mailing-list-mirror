From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: [PATCH] bash-completion: fix getting strategy list
Date: Thu, 21 Aug 2008 04:14:09 +0200
Message-ID: <237967ef0808201914k2cf8ad09s7b7d56dd8ea35d62@mail.gmail.com>
References: <fcaeb9bf0808190527q60869fd0uccbfd165431a752d@mail.gmail.com>
	 <20080819132803.GA26201@laptop> <48AADDBB.1080203@viscovery.net>
	 <fcaeb9bf0808200958u65ad8fa3oa118b88e16c9c50c@mail.gmail.com>
	 <7vfxozpeyh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 04:15:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVzhq-0002Od-TU
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 04:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbYHUCON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 22:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752715AbYHUCON
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 22:14:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:54679 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752701AbYHUCOL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 22:14:11 -0400
Received: by nf-out-0910.google.com with SMTP id d3so361815nfc.21
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 19:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=G0QwzexZIqfmNYTCxnd3lcjHC2jYXvMddljySA1epiQ=;
        b=K4vpU7iPaaxYTDVBh2BHtgG+ErRCmZgvlJXcPxSGR+/mamVH5Uy031ppv0Hd3h1Hdr
         yfC8zVREXhZZtFAk3F43g3/IfZIejXIxAq3nzm+10OQhkZ1qgnwrNFBWt8JuQ3vmBq3T
         EqbCHnACDRqMVhHTfd1Zo1JflwwxOSB4rkb20=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Qb1eCRkuACA04kGxDD2LnCywH7UuKnfMlOFsvYHbwc7/g+oXeDjtLd7eeNzic1zW4s
         0pR0yMavO7OrYQ6JDOIHKrWws448ELRD1HRcmsHfaS48ECMsDPhBARFxweVpCnNn+god
         JvKwwvwYTCe1aprDx74soX6wSqiUqKsF9aYXg=
Received: by 10.210.142.6 with SMTP id p6mr1073627ebd.102.1219284849655;
        Wed, 20 Aug 2008 19:14:09 -0700 (PDT)
Received: by 10.210.19.20 with HTTP; Wed, 20 Aug 2008 19:14:09 -0700 (PDT)
In-Reply-To: <7vfxozpeyh.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93088>

2008/8/20 Junio C Hamano <gitster@pobox.com>:
> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
>
>> On 8/19/08, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> Nguyen Thai Ngoc Duy schrieb:
>>>
>>> > +--show-strategies::
>>>  > +     Show all available strategies. For internal use only.
>>>  > +
>>>
>>>
>>> IMO, you don't need to declare this option as internal; offering it for
>>>  the public is fine...
>>
>> On second thought, I don't think the patch's worth it.
>
> How about doing this instead?
>
> -- >8 --
> completion: find out supported merge strategies correctly
>
> "git-merge" is a binary executable these days, and looking for assignment
> to $all_strategies variable does not work well.
>
> When asked for an unknown strategy, pre-1.6.0 and post-1.6.0 "git merge"
> commands respectively say:
>
>    $ $HOME/git-snap-v1.5.6.5/bin/git merge -s help
>    available strategies are: recur recursive octopus resolve stupid ours subtree
>    $ $HOME/git-snap-v1.6.0/bin/git merge -s help
>    Could not find merge strategy 'help'.
>    Available strategies are: recursive octopus resolve ours subtree.
>
> both on its standard error stream.  We can use this to learn what
> strategies are supported.
>
> The sed script is written in such a way that it catches both old and new
> message styles ("Available" vs "available", and the full stop at the end).
> It also allows future versions of "git merge" to line-wrap the list of
> strategies, and add extra comments, like this:
>
>    $ $HOME/git-snap-v1.6.1/bin/git merge -s help
>    Could not find merge strategy 'help'.
>    Available strategies are: blame recursive octopus resolve ours
>    subtree.
>    Also you have custom strategies: theirs
>
>    Make sure you spell strategy names correctly.
>
> ---
> diff --git c/contrib/completion/git-completion.bash w/contrib/completion/git-completion.bash
> index 158b912..a310040 100755
> --- c/contrib/completion/git-completion.bash
> +++ w/contrib/completion/git-completion.bash
> @@ -271,15 +271,17 @@ __git_merge_strategies ()
>                echo "$__git_merge_strategylist"
>                return
>        fi
> -       sed -n "/^all_strategies='/{
> -               s/^all_strategies='//
> -               s/'//
> +       git merge -s help 2>&1 |
> +       sed -n -e '/[Aa]vailable strategies are: /,/^$/{
> +               s/\.$//
> +               s/.*://
> +               s/^[    ]*//
> +               s/[     ]*$//
>                p
> -               q
> -               }" "$(git --exec-path)/git-merge"
> +       }'
>  }
>  __git_merge_strategylist=
> -__git_merge_strategylist="$(__git_merge_strategies 2>/dev/null)"
> +__git_merge_strategylist=$(__git_merge_strategies 2>/dev/null)
>
>  __git_complete_file ()
>  {

I don't know if i somehow have some weird patch merged in, i tried to check
and didn't find anything, at least. But when i run git merge -s help i get:

Could not find merge strategy 'help'.

available strategies in '/usr/libexec/git-core'
-----------------------------------------------
  file      octopus   ours      recursive resolve   subtree

which i suspect does not work with your regex.

-- 
Mikael Magnusson
