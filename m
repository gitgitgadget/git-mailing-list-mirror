From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] Makefile: add commented out 's for Emacs here, too
Date: Thu, 19 Dec 2013 15:52:21 -0800
Message-ID: <20131219235221.GG20443@google.com>
References: <1243289231-32500-1-git-send-email-naesten@gmail.com>
 <200905301505.38016.markus.heidelberg@web.de>
 <7vr5y6z9xp.fsf@alter.siamese.dyndns.org>
 <200905310001.44532.markus.heidelberg@web.de>
 <CAJYzjmcbQVgRk9pjyWSqaDPz6=kFQ9spE14Bq5aG4dnuo-t=oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: markus.heidelberg@web.de, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Samuel Bronson <naesten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 20 00:53:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtnPc-0002Gk-FT
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 00:53:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756917Ab3LSXxs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 18:53:48 -0500
Received: from mail-gg0-f178.google.com ([209.85.161.178]:45486 "EHLO
	mail-gg0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756807Ab3LSXw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 18:52:28 -0500
Received: by mail-gg0-f178.google.com with SMTP id n5so443014ggj.9
        for <git@vger.kernel.org>; Thu, 19 Dec 2013 15:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=pBmsEwqOtC4eZvtj7R12+X+PGUPZnGfJAkrQOmbM+/E=;
        b=DPRGcR1aDZez7rWEDjKt4sg51weNUcshrjM94Qr22ZsthMqmK7Qh3oGvvW8ARJXv6B
         boyARVNWDrpNbJxx+exIGLGvtZ/bjsEYn+1U9Z8XU9wJixLw2PLPJGYh8E8/y0T3eV1z
         0NwuVdrvPxJcIyIA9M4cUSOoGzxU0r/NHo06A4nqBCLqrrPF5Sa5O/DWKw7RtqvpWkCH
         lPw4E5FgcleA3kszPDCD8Rx4myzyC88muYCNGD3MvHEx9SYKQsGOwC1DIij5nkg723ae
         nw0u51c+uS6cKRHhRDfefRxmzrUcVzl8opnPYFO5kWSv45hj7A8jjI6lsqnoe/Yow82d
         1CAQ==
X-Received: by 10.236.122.165 with SMTP id t25mr3566451yhh.46.1387497145391;
        Thu, 19 Dec 2013 15:52:25 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id g25sm8462027yhg.6.2013.12.19.15.52.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 19 Dec 2013 15:52:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAJYzjmcbQVgRk9pjyWSqaDPz6=kFQ9spE14Bq5aG4dnuo-t=oA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239559>

Hi,

Samuel Bronson wrote:
> Markus Heidelberg wrote:

>> In the buildroot project (it consists of Makefiles) there a lots of
>> those workarounds. There was a patch on the list to replace all
>> $(strip $(subst ",,$(FOO))) with $(call strip_dquotes, $(FOO)), but
>> $(call) is not allowed in git for compatibility reasons.
>
> Hmm.  What compatibility reasons, and are they still applicable?

Good question.

  $ git log -1 -S'$(call ' -- Makefile 
  commit 39c015c556f285106931e0500f301de462b0e46e
  Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
  Date:   Sat Feb 18 12:40:22 2006 +0100

      Fixes for ancient versions of GNU make

      Some versions of GNU make do not understand $(call), and have problems to
      interpret rules like this:

      some_target: CFLAGS += -Dsome=defs

      [jc: simplified substitution a bit. ]

      Signed-off-by: Johannes E. Schindelin <Johannes.Schindelin@gmx.de>
      Signed-off-by: Junio C Hamano <junkio@cox.net>

A quick gmane search finds [1], which suggests the "make" where this
problem came up was on IRIX.  I don't have a strong opinion either way
about whether such ancient 'make' is worth supporting (as a practical
matter, it's hard to keep testing and make sure such support still
works).

Would $(call) simplify the makefile much?

Thanks,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/16344
http://thread.gmane.org/gmane.comp.version-control.git/16345/focus=16375
http://thread.gmane.org/gmane.comp.version-control.git/48968/focus=49117
