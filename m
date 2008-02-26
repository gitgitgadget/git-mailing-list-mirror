From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH v2] pull: document usage via OPTIONS_SPEC
Date: Tue, 26 Feb 2008 16:37:41 -0500
Message-ID: <76718490802261337i16e5f27bg11cf452fdc0542ca@mail.gmail.com>
References: <7vk5kw5v79.fsf@gitster.siamese.dyndns.org>
	 <1204058554-74593-1-git-send-email-jaysoffian@gmail.com>
	 <7v4pbv4dkw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 22:38:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU7VG-0007iS-4v
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 22:38:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764978AbYBZVho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 16:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764761AbYBZVho
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 16:37:44 -0500
Received: from wa-out-1112.google.com ([209.85.146.181]:52393 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764398AbYBZVhm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 16:37:42 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2763528wah.23
        for <git@vger.kernel.org>; Tue, 26 Feb 2008 13:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=hxaiRQiL57aDUEc7Lmtb4bGejxL+k4+89wb+p+YeTQM=;
        b=TUerYCrvZB8kogaN8j5odT3QkjJTQooRp+4JhnbXSi+q1p2l/AzmxYa2gupvtmKV1pxNFfFZ5Y9qK8dxkHJsUQJqeH5JVaLKC+BFYvvED20he22xLgLahwmq02ejDg6U+AES7RuP1M44OvjXr9vHymWFmJ+2ccUNVed48xZT18E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kzY/kFikiaiSKOb4XTNhPKJpiKYTvaxpRhLXBtToBQao0iHezmHBdSYMXMCBHrCLhwnW2P0tp+irw1ZZ4zoUQRSBmdbbFYz3B8K2VEtn/IXZX+8BhfviRmrqtVx6dWUAWgmaZvH76rAZ/KPlxuG7LTEYZMugbXXxymncXLwp+gw=
Received: by 10.115.60.1 with SMTP id n1mr6217089wak.37.1204061861901;
        Tue, 26 Feb 2008 13:37:41 -0800 (PST)
Received: by 10.114.13.5 with HTTP; Tue, 26 Feb 2008 13:37:41 -0800 (PST)
In-Reply-To: <7v4pbv4dkw.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75178>

On Tue, Feb 26, 2008 at 4:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>  >  * There is one semantic change. You can't use "-s=<strategy>" anymore. That's not
>  >    really proper usage of a short option (it's either "-s<strategy>" or
>  >    "-s <strategy>"). Is it okay to not accept the "-s=<strategy>" form?
>
>  Well, with my maintainer hat on, I must resist _any_ change ;-).
>  Personally I would not mind this.  It is a borderline between
>  regression and making the option parameters more consistent.

My reasoning was that were the script converted to a built-in, the -s= behavior
would not likely be maintained (or even noticed...). And that form certainly
isn't documented. I think it was an accident that it ever worked.

>  If a contributor feels wasting his time, what should reviewers
>  feel reviewing such patches ;-)?

I get the smiley, but let me rephrase: is there a long term goal to replace all
shell scripts with builtins?

And to answer your rhetorical question, reviewers should feel appreciated,
because they are.

>  While it is technically correct that you _can_ feed any option
>  meant for git-fetch to this command, some options do not make
>  any sense in the context of git-pull, and we should not
>  advertise them, or better yet, actively reject them if you can.

Well then we have a documentation issue then, because it was from the git pull
docs that I wrote the option spec. So I suppose this patch should include a
documentation cleanup at the same time.

>  Because the loop breaks here, the option description above
>  should mention that options meant for fetch should come after
>  all the options you want to give to git-pull itself.  For
>  example, I do not think "git pull -q -s stupid $there $that" is
>  meant to work.
>
>  A better long-term alternative would be to lift that restriction.

Sigh, nothing is ever as simple as it seems. And here I was just trying to
improve the usage statement. :-(

>  I do not recall offhand but does the parse-options reorder the
>  options in any way?  If that is the case, it makes the above not
>  a long-term thing but a must-be-done in a patch that starts to
>  use parse-options.

I don't think it does.

Back to the drawing board...

j.
