From: "Simon Sasburg" <simon.sasburg@gmail.com>
Subject: Re: [PATCH] Implement sending mails over TLS in git-send-email.
Date: Wed, 31 Oct 2007 23:04:59 +0100
Message-ID: <981e6de60710311504v666943beve3b87c6a713fb18c@mail.gmail.com>
References: <1193845859-1788-1-git-send-email-Simon.Sasburg@gmail.com>
	 <2faad3050710311445l51d1152cs6761803e2f3a77d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Baz <brian.ewins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 23:06:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InLhk-00005X-IO
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 23:06:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761301AbXJaWFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 18:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761278AbXJaWFL
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 18:05:11 -0400
Received: from nz-out-0506.google.com ([64.233.162.225]:26576 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761554AbXJaWFJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 18:05:09 -0400
Received: by nz-out-0506.google.com with SMTP id s18so241595nze
        for <git@vger.kernel.org>; Wed, 31 Oct 2007 15:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=3xpK7LXZKspK7VonGZ+MuABqVRgACUMZNOMEPbkueCs=;
        b=P+N5sYL15Hpa+wHdVzoHJO122ik+J5Z4gups3T0JzjF1A/a09vStM/3m8DJaSeEJTx4EBCtffk1G9s50R2FeGBK+WVl9US6suf5d+v8QAQcL/19NCgP+da6Juk33SdKAaxz48igXQdd2La7Cg7N7DmX1m9I0pbQLONJx2mUnh9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=t/+F6dztCp3GhA+qpzwgkQY4FS+8lL1LdmzapEtnPIs3DhXwZ2SJT94v+RNLopMTs0nFTqHu0T8ZctA3mn7y5gU5uJ9XS+MDPwkXMYWV3ecTBbR1q4CZ2Y8WEtcy+ELZG03Ah4VfFHZM9zFpr/wVdlKZcwsx3dDTUi37h6bw/48=
Received: by 10.115.88.1 with SMTP id q1mr3715684wal.1193868299759;
        Wed, 31 Oct 2007 15:04:59 -0700 (PDT)
Received: by 10.114.124.16 with HTTP; Wed, 31 Oct 2007 15:04:59 -0700 (PDT)
In-Reply-To: <2faad3050710311445l51d1152cs6761803e2f3a77d3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62887>

> Secondly, Net::SMTP::SSL has no problem connecting to gmail - it does
> everything Net::SMTP::TLS does and more; you can use all of the
> options of IO::Socket::SSL with it. A common problem seems to be not
> having Authen::SASL installed (this is required to authenticate with
> gmail) - the one thing Net::SMTP::TLS *does* do is auth without using
> that module.

Ah, yes, i got the Authen::SASL errors at first, but even after
resolving all missing module dependencies,
the --smpt-ssl still did not work for me, so i started looking at
other solutions and found Net::SMTP::TLS.

> In other words, this patch should be entirely unnecessary if you have
> Authen::SASL installed - could you try this? (I've checked for myself,
> git-send-email sends me mail fine via gmail without this patch)

Well, it fails here, maybe maybe you can show me exactly what you did
(configuration/parameters etc)?

This is what i do now:
> git-send-email testfile.patch -to simon.sasburg@gmail.com --chain-reply-to --smtp-server smtp.gmail.com --smtp-user simon.sasburg --smtp-pass secret --smtp-ssl --smtp-server-port 587
and it fails, while the same line using --smtp-tls instead of
--smtp-ssl with my patch applied works.

What am i missing?
