From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv5 3/3] gitweb: gravatar url cache
Date: Thu, 25 Jun 2009 00:46:22 +0200
Message-ID: <cb7bb73a0906241546x6b6164e7w4e6c6601d1119032@mail.gmail.com>
References: <1245878183-2967-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245878183-2967-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245878183-2967-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245878183-2967-4-git-send-email-giuseppe.bilotta@gmail.com>
	 <7v63elqoig.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 00:46:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJbEe-0007Ww-DV
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 00:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbZFXWqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 18:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752864AbZFXWqV
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 18:46:21 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:45001 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbZFXWqV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 18:46:21 -0400
Received: by bwz9 with SMTP id 9so1063267bwz.37
        for <git@vger.kernel.org>; Wed, 24 Jun 2009 15:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ANW8csV9qx86p9+RS9hGBtAAnpmqrb0S97dnKl99pzE=;
        b=H3b6PknCJKCXgdvpJ9My+Pq/cr4b9SuvAbbib/stiecIUPemR0IBbbNy0sSqxSbQQl
         cmqhrE221+cyvVNVhl9BTPzOllcLamrxY3kxggW9cSfPoKs3oiLNbTEcsqlITxfEQEEH
         DRu1nI+nq9Y/cdhzmK4ySBFhpsbQiGBvp2hEk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hCAPGgbfDUd5fZdnDPrHGO6Rg5+iO5FYgiZopHi0xlZpo2p//DGhFJDxKSiCCzLml4
         lEKpbt7yXEiv0fxUtnullfPJ3hLFXiA9AyxzPi+l46+qLNKfGkpvp5eT8B5SQwMOWVUm
         yhDVDkPHpmuOumiGrv1Mg/uUjh27w6JrH4TSE=
Received: by 10.204.103.209 with SMTP id l17mr1759659bko.152.1245883582808; 
	Wed, 24 Jun 2009 15:46:22 -0700 (PDT)
In-Reply-To: <7v63elqoig.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122166>

On Thu, Jun 25, 2009 at 12:02 AM, Junio C Hamano<gitster@pobox.com> wrote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> Views which contain many occurrences of the same email address (e.g.
>> shortlog view) benefit from not having to recalculate the MD5 of the
>> email address every time.
>> ---
>
> Sign-off?

Duh.

> I think the cache is placed at the wrong level (it doesn't have to be a
> GRavatar_url_cache, but can be a general avatar_url_cache).

I'm not sure about it. The URL depends on email and size (can you use
arrays as hash keys in Perl?) , and the email part might be the same
but the size part might differ across separate calls (in theory; in
practice avatars in a view are presently all the same size; but for
example if we were to autodetect email addresses in commit messages,
we might have both single- and double- sided avatars in the same
page). By hashing on email+size only we would lose the benefit of
cache when using the same avatar at separate sizes.

-- 
Giuseppe "Oblomov" Bilotta
