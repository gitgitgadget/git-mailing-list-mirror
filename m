From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH,RFC] Implement 'git rm --if-missing'
Date: Wed, 16 Jul 2008 14:17:33 -0400
Message-ID: <32541b130807161117h54e97825o9119655f73138341@mail.gmail.com>
References: <1216231250-21141-1-git-send-email-ciaran.mccreesh@googlemail.com>
	 <20080716180617.GO32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Ciaran McCreesh" <ciaran.mccreesh@googlemail.com>,
	git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Jul 16 20:18:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJBaR-0003S7-Bc
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 20:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758184AbYGPSRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 14:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757791AbYGPSRi
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 14:17:38 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:46993 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757500AbYGPSRh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 14:17:37 -0400
Received: by wx-out-0506.google.com with SMTP id h29so3450850wxd.4
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 11:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fKzzWpIjNQCedf1adN4UUevewFTpC39kmJHtGIH0b1g=;
        b=Z7vRyIgwgIxjWf6qLcBrgDdLTDrqINpCa+KN2lsBUToTWDv8jHpyAdrPAS8zsuGe/1
         KqOoK1QsCZPkrYrft1cXn9cZ5IZpyKA4DhOVujaX2pXfdrSaDzrFdsG4TnBRgIFWEN1k
         OWxmAiqxjjmhhiJ7sxVasvU1t+LPq1rR9Yy4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rSKdKbOY5Hp9ERUzO1EClvyhbbzYSKQRZqW+dEf/QQ0JJRSu0Q3cafBd48PoJyxg12
         3832YdgdLE7YUJ0Jwdee/w5KGanamQQPj8UTb3ACZPvpsMBHZKQ4qzKxEgQ7GLp4AE7V
         9EyubJqK1XXaLqBw4U+SquIAL+4jXawkU6CmY=
Received: by 10.100.7.1 with SMTP id 1mr1711649ang.99.1216232256124;
        Wed, 16 Jul 2008 11:17:36 -0700 (PDT)
Received: by 10.100.8.19 with HTTP; Wed, 16 Jul 2008 11:17:33 -0700 (PDT)
In-Reply-To: <20080716180617.GO32184@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88706>

On 7/16/08, Petr Baudis <pasky@suse.cz> wrote:
>  On Wed, Jul 16, 2008 at 07:00:50PM +0100, Ciaran McCreesh wrote:
>  > git rm --if-missing will only remove files if they've already been removed from
>  > disk.
>  >
>  > Signed-off-by: Ciaran McCreesh <ciaran.mccreesh@googlemail.com>
>
>   what is the usage scenario? The porcelain options space is a precious
>  resource, so please explain why do you need this and who is going to use
>  it (especially with such a long name).

I see the idea here: right now you can do:

         touch a b c
         git add .

And have it auto-add all the new files, so "git commit" will work.
But there is no equivalent for rm, because for obvious reasons,

        rm b c
        git rm .

Doesn't do the same thing.  And "git add ." doesn't auto-recognize
deletions, which probably also makes sense.

"git commit -a", on the other hand, will automatically commit all
deletions for you.  But you don't always want to commit *all* your
changes just because you want to commit all your deletions.

That said, --if-missing is a bit unwieldy.  I don't have a better
suggestion though.

Have fun,

Avery
