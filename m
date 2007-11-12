From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] status&commit: Teach them to show submodule commit summary
Date: Mon, 12 Nov 2007 23:17:48 +0800
Message-ID: <46dff0320711120717gf8a67cdn2b6bdaa9cfa29218@mail.gmail.com>
References: <47382506.1090106@viscovery.net>
	 <1194877277-31777-1-git-send-email-pkufranky@gmail.com>
	 <20071112144605.GA16791@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Ralf Wildenhues" <Ralf.Wildenhues@gmx.de>,
	"Ping Yin" <pkufranky@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 16:18:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irb37-0000au-Ix
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 16:18:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbXKLPRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 10:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751687AbXKLPRu
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 10:17:50 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:65386 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbXKLPRt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 10:17:49 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1194818rvb
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 07:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=r+ZD/q/rUyhZr82bYTCh5zYYtJJOuSn1DjIy9xA6jWw=;
        b=H4BUQ7oAwqsilELIAamnGnmPucZhccDy8Vad18TMppDX7ZxHyumAcezT18Oy2jGq1t2L74OVm5R7XA8mG4DdMcP2H2i1sBwZmUVX2aPjXxzjrHZDJs4bMOlAD/yPOLNA4o+HN+Tlg1sJG94siQ4x5iW4aWf9krGXAOtS8yMbHUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gC8yzfKdrl2H2Mn6UTABDoE8FM5eS5CFWcYeQa2MAg9JqzopRVul09dybQ7uT+K9dGC5VTdr2zwjno5JTAv9fuQ4hLl1jYcCZ5+TNAjb6UCUXl8/mWv35X7n3x4WT7IslRBlDRa5l9tgIpXS2ytjTAcgZTCoXUwIlJrwsSbWgwM=
Received: by 10.140.148.3 with SMTP id v3mr218460rvd.1194880668902;
        Mon, 12 Nov 2007 07:17:48 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Mon, 12 Nov 2007 07:17:48 -0800 (PST)
In-Reply-To: <20071112144605.GA16791@ins.uni-bonn.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64634>

On Nov 12, 2007 10:46 PM, Ralf Wildenhues <Ralf.Wildenhues@gmx.de> wrote:
> Hello,
>
> A couple of portability nits:
>
> * Ping Yin wrote on Mon, Nov 12, 2007 at 03:21:17PM CET:
> [...]
> > +
> > +     # TODO: quote module names containing space or tab
> > +     test -n "$modules" && echo -e "# Submodules modifiled: "$modules"\n#"
>
> Typo: s/modifiled/modified/
Oops
>
> Then, "echo -e" is not portable (and not used elsewhere in git), but you
> can just use this instead:
>   test ... && { echo "# ..."; echo "#"; }
See
>
> Also, it so happens you leave $modules outside quotes which will drop
> multiple adjacent white spaces.  Did you mean to use
>   echo "# Submodules modified: \"$modules\""
I leave $modules outside quotes to let "\n" change to <space> by auto
word splitting.
It actually eats white spaces in the module names. So any suggestion
to handle this case?
To handles module names with spaces, is it ok to display as follows?

Submodules modified: sm1 "sm name with space"

Any good way to only add quoting for names with spaces?

> You can instead just use a literal newline:
>   IFS='
>   '
> (minus the indentation).  And add a literal carriage return if need be
> (is that really needed on Mac OS?), though you may want to enclose that
> in another pair of quotes to avoid it being "optimized" away by some
> editor.
I just guess '\r' is need for Mac OS because i havn't Mac OS environment.
BTW, how to add a literal carriage return?
>
> Cheers,
> Ralf
>



-- 
Ping Yin
