From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/6] Recognize magic pathspec as filenames
Date: Thu, 13 Oct 2011 15:23:39 +1100
Message-ID: <CACsJy8CY=myfLpAbEA0=LCm+tCgS7jzEAxH3rnwQt4-RXyjW9w@mail.gmail.com>
References: <1318373083-13840-1-git-send-email-pclouds@gmail.com>
 <1318373083-13840-2-git-send-email-pclouds@gmail.com> <7v4nze7x61.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 06:24:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RECq9-0006Ph-TR
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 06:24:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035Ab1JMEYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 00:24:12 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:54720 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab1JMEYL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 00:24:11 -0400
Received: by bkbzt4 with SMTP id zt4so900364bkb.19
        for <git@vger.kernel.org>; Wed, 12 Oct 2011 21:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=q2eC9kQN31zkCRjF+WtWW+e4GZ+TO3tdNc1KqEDOihw=;
        b=wKZA8atVWX124ybwcYSTy5B+sbRfSn3u/TqwWtr9BzIUZszzyS9OUbPUIsZC4Khkaj
         DDj+J4qz3tjmGAWJhDDnR+DRQvwfHD+gmQ6kDZiJv/EEIEeMpVlOVFpboAkCP0EjWUEQ
         47fpUQu0QyXxpT8ygatEpr0VJWlupJBy21cJ4=
Received: by 10.204.140.206 with SMTP id j14mr1151113bku.55.1318479850103;
 Wed, 12 Oct 2011 21:24:10 -0700 (PDT)
Received: by 10.204.120.75 with HTTP; Wed, 12 Oct 2011 21:23:39 -0700 (PDT)
In-Reply-To: <7v4nze7x61.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183437>

2011/10/13 Junio C Hamano <gitster@pobox.com>:
> "git log :/foo" is ambiguous no matter how you slice it, if you are going
> to look at only the first character in the string. It could be asking to
> show only commits that touch the path in the top-level directory "foo" and
> its subdirectories, or it could be asking to start traversal at a commit
> with "foo" in the log message.

Yeah, I forgot the ":/" ref syntax. But because it's ambiguous anyway,
should we disallow "git log :/foo"? Either "git log :/foo --" or "git
log -- :/foo" is OK.

> Longhand magic pathspecs e.g. ":(icase)foo" might have better chance, but
> not by a wide margin. It can be a rev that names the blob object in the
> index registered for the literal path "'(icase)foo", or it could be an
> element in the pathspec to match [Ff][Oo][[Oo].

It's unfortunate that ":" has so many meanings attached to it. I hope
that our ambiguation detection code can be smart, based on context, to
avoid unnecessary "--". For example, "git log :(icase)foo" can only
mean pathspec magic (I hope..)
-- 
Duy
