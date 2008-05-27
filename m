From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: setup_git_directory_gently contract question?
Date: Tue, 27 May 2008 22:32:41 +0700
Message-ID: <fcaeb9bf0805270832lc779a37gd9e58d0790981788@mail.gmail.com>
References: <8e04b5820805270710v3a06e5c2if2dcf3b94ef40c1f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ciprian Dorin Craciun" <ciprian.craciun@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 17:33:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K11B9-0004yX-LS
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 17:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756594AbYE0Pco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 11:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756487AbYE0Pco
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 11:32:44 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:23331 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756083AbYE0Pcn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 11:32:43 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1547689fgg.17
        for <git@vger.kernel.org>; Tue, 27 May 2008 08:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=M5YhOA7twWEBCY0kRynwIHmBfI/bhMAfE8xDP1rXIWI=;
        b=dfOGBlgoEqmwtnVIzrj1bXwL/XqDpi/XGJ2Q6FSC9HLA7tFGVsT4FlHbNued+hpzrNInJDICiLZziSZJq6lqbmTNNlzPDChVS+7yH3rFsPsVoYbMJk5zLipkWeAsTx21QX9q3rK+Q2/RmR6jeta4kNG9UjjDYh0LFsTsoWB++0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=peO1spCinplNw+xttF4KBIKEYHuYpF0BxbH5fX3kosLR8wZWvhfdjgBqObiOOksE+0NcIQmDNgg7giyD8gqMcxP7UWQP6MlDgcOYvcIdpfDPm4Y7Qp40LtgilllUDd6LXogXxRgLjMgKKB2RKaAJ0gzVuLCA7DiSTo7Xt5m+mqA=
Received: by 10.86.77.5 with SMTP id z5mr7518695fga.42.1211902361857;
        Tue, 27 May 2008 08:32:41 -0700 (PDT)
Received: by 10.86.62.13 with HTTP; Tue, 27 May 2008 08:32:41 -0700 (PDT)
In-Reply-To: <8e04b5820805270710v3a06e5c2if2dcf3b94ef40c1f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83026>

On Tue, May 27, 2008 at 9:10 PM, Ciprian Dorin Craciun
<ciprian.craciun@gmail.com> wrote:
>    Is the function setup_git_directory_gently supposed to change the
> current working directory, or should it keep the initial one?

It will change if it finds a worktree.

>    What is the meaning of nongit_ok?

Setting it to a non null pointer prevents git from die() when no git
repository can be found.

>    Because if I use nongit_ok != NULL, but *nongit_ok == 1, this
> function changes the current working directory to the top of the
> worktree directory.

It returns a directory prefix so that you can still know the original
current working directory. You can do as following to have current
directory "unchanged"

prefix = setup_git_directory_gently(&nongit_ok);
if (prefix) chdir(prefix)

>    Thanks,
>    Ciprian Craciun.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Duy
