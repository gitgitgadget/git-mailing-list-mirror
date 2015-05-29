From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: suggest sequencer commands for revert
Date: Fri, 29 May 2015 12:50:53 -0700
Message-ID: <xmqq1thzcgde.fsf@gitster.dls.corp.google.com>
References: <1432547975.4644.5.camel@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Thomas Braun <thomas.braun@virtuell-zuhause.de>
To: John Keeping <john@keeping.me.uk>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 21:51:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyQJ2-0005Kb-9Z
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 21:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756747AbbE2Tu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 15:50:56 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:32909 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756539AbbE2Tuz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 15:50:55 -0400
Received: by iebgx4 with SMTP id gx4so70828174ieb.0
        for <git@vger.kernel.org>; Fri, 29 May 2015 12:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=jB8zLWR3Q/6xlhhGzFJjDVlH9TSzRcJk7zBNsxXHyQY=;
        b=0+GUvA2BmOJkiS/pI20M5NP1JdpxO4IFLEFzqNRFE9WZtMDo8mOmB4Fk7BOswK7U0/
         u4woaD62DXtvS7KGjM/TIIGJ3io2h4IeXRyuJPOZ6uTtbFzbMfx9mewwq3B5F9mOrBwc
         Bh/pN/IO+vZiDhZrcOzFFeL5mUWnldNwzL3vvrKfd2hQL+x/nLPxTb+Qb+TxZG/XDzvC
         yxCXpr1c0enRbAGEBxYx6WmrByqJjPGgO9SzhL4WqQd0ZQNGIcyIElYakqqJIE1hmkqw
         9ZPAbBFN+Xn21lyMiNKMMqrYWBFTZXGzy1ey8B6RWWMeMnW3Tppx+64Au9+Zm6oh7Dce
         Jm7w==
X-Received: by 10.42.154.65 with SMTP id p1mr3172901icw.26.1432929054517;
        Fri, 29 May 2015 12:50:54 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d9c8:419b:acd5:cf1d])
        by mx.google.com with ESMTPSA id r34sm4861024ioi.34.2015.05.29.12.50.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 29 May 2015 12:50:53 -0700 (PDT)
In-Reply-To: <1432547975.4644.5.camel@virtuell-zuhause.de> (Thomas Braun's
	message of "Mon, 25 May 2015 11:59:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270269>

Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:

> Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> ---
>
> Hi,
>
> I added the sequencer commands for git revert. These are handy in case a git
> revert needs manual intervention.

This looks OK from a cursory read to me; asking opinions from those
who have touched the file in the recent past (Ram also happens to be
one of the people who were heavily involved in sequencer work).

Thanks.

>
> Thanks,
> Thomas
>
>  contrib/completion/git-completion.bash | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index bfc74e9..3c00acd 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2282,6 +2282,11 @@ _git_reset ()
>  
>  _git_revert ()
>  {
> +	local dir="$(__gitdir)"
> +	if [ -f "$dir"/REVERT_HEAD ]; then
> +		__gitcomp "--continue --quit --abort"
> +		return
> +	fi
>  	case "$cur" in
>  	--*)
>  		__gitcomp "--edit --mainline --no-edit --no-commit --signoff"
