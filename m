From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Mon, 14 Feb 2011 17:19:20 -0600
Message-ID: <20110214231920.GA24814@elie>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
 <20110213193738.GA26868@elie>
 <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
 <AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 00:19:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp7hd-0003qF-Iu
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 00:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147Ab1BNXT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 18:19:29 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:51787 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934Ab1BNXT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 18:19:28 -0500
Received: by qwa26 with SMTP id 26so3526175qwa.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 15:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=bV4D5t3gxjlc4BzfB4FMY0pxC+MoayZw8GaBPwMQLko=;
        b=KokQR7uz1yMnihuw4HoM98Q6XfhBeCKcOkLyu69KeBwIMx2UZEX823UpkcG8poB7KR
         tENodSd8SWo1/S2UU6IQ9knmXAQwsK4J1SOJpC459+DLSByTN2Qsbxn1hP4AwFJHfgJs
         CO7OqDkIGl2JrlcP3CapTSq5QbM8ifcA4/q3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MnLVBoSyrcm5e2riRvv2Kaw7eiiy4rs6Jtg97+F8d24emd03RgpDyJI9f5Nz6tFsL3
         Wc4KBqrGYz2/gTz+SBF5uD1j5imXSOyc9zR4nojsBsG/APXkGI5HEpuBnPVXoG1rYepB
         dA4yYYaBywc7dHsgvZefPXYvGNSuBjc6OI7rg=
Received: by 10.229.86.7 with SMTP id q7mr3372256qcl.262.1297725567232;
        Mon, 14 Feb 2011 15:19:27 -0800 (PST)
Received: from elie (adsl-69-209-51-217.dsl.chcgil.sbcglobal.net [69.209.51.217])
        by mx.google.com with ESMTPS id p13sm2156069qcu.41.2011.02.14.15.19.24
        (version=SSLv3 cipher=OTHER);
        Mon, 14 Feb 2011 15:19:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166793>

Hi again,

Piotr Krukowiecki wrote:

> In other places "index" is called "staging area" and act of updating the index
> is called "staging in the index".
>
> I ask: why do we need the "index" term at all?
>
>    - instead of "index" use "staging" and "staging area"
>    - instead of "listed in index" use "staged" or "tracked"

Unlike "staging area", the word "index" is unfamiliar and opaque.  So
there is a sense that there is something to learn.

When people talk about the staging area I tend to get confused.  I
think there's an idea that because it sounds more concrete, there is
less to explain --- or maybe I am just wired the wrong way.

There is a .git/index file, with a well defined file format.  And
there is an in-core copy of the index, too.  It contains:

 - mode and blob name for paths as requested by the user with
   "git add"

 - competing versions for paths whose proposed content is
   uncertain during a merge

 - stat(2) information to speed up comparison with the worktree

There are some other pieces, too --- "intent-to-add" entries added
with "git add -N", cached tree names for unmodified subtrees to
speed up "git commit", and so on.  But the 3 pieces listed above are
the main thing.

"Staging area" only describes the first.

All that said, I am not against formulations like "content of the next
commit" that might be more concrete from a user's point of view.

[...]
>  --refresh::
>  	Don't add the file(s), but only refresh their stat()
> -	information in the index.
> +	information in the staging area.

git add/update-index --refresh are precisely meant for _not_ changing
the content of the next commit, so this particular change seems
confusing.

Hoping that is clearer.  Thanks for caring.
Jonathan
