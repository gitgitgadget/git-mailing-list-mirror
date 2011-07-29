From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 16/18] revert: Remove sequencer state when no commits are
 pending
Date: Fri, 29 Jul 2011 21:16:55 +0200
Message-ID: <20110729191654.GA2368@elie.dc0b.debconf.org>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-17-git-send-email-artagnon@gmail.com>
 <20110727051755.GK18470@elie>
 <CALkWK0noPtLgr_t=DC_XFdLrWUNCLhUd00Mw1HbmWRJjeT4jew@mail.gmail.com>
 <20110727141006.GA24785@elie>
 <CALkWK0k8Lra7LkGJXoXScnGUjrag-xgNptaB_JCiAsgemTq0eQ@mail.gmail.com>
 <20110727154830.GA29924@elie>
 <CALkWK0mUGiCRQoW6UM+mF5tsn4DxRuaiXn0TS2CcEsR0OeusKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 29 21:17:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmsYZ-0002NB-AU
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 21:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193Ab1G2TRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 15:17:06 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37545 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab1G2TRE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 15:17:04 -0400
Received: by fxh19 with SMTP id 19so2546199fxh.19
        for <git@vger.kernel.org>; Fri, 29 Jul 2011 12:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1Cwy6MvvJGmRrDkLpzWHUKUqB2LkfKiJX9sJfbTmlMs=;
        b=L7jMmMA0Q+pptzh4O7U8pAq7ScjamMkNYF9rkmNpEc0GzyuTCfUNa8ExDAELI3wEVs
         K6yLwn7Ck10cSkkAtwKy2W47V8lY4Rp3Dti4gLRqnJPLNu6m6ZlEQg78Q1wFf1XwKXWI
         fYssbVNWlMZJ41RDCUtifR9a9fFWU0L4gwxcM=
Received: by 10.223.72.80 with SMTP id l16mr2278693faj.33.1311967023172;
        Fri, 29 Jul 2011 12:17:03 -0700 (PDT)
Received: from elie.dc0b.debconf.org ([78.28.140.4])
        by mx.google.com with ESMTPS id 28sm1261401fax.27.2011.07.29.12.16.59
        (version=SSLv3 cipher=OTHER);
        Fri, 29 Jul 2011 12:17:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0mUGiCRQoW6UM+mF5tsn4DxRuaiXn0TS2CcEsR0OeusKg@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178160>

Ramkumar Ramachandra wrote:
> Jonathan Nieder writes:

>> If "tight coupling" means "builtin/commit.c calls a function declared
>> in sequencer.h", then yes, I think it should be fine.
>
> My bad. I'll first have to figure out a way to expose the todo parsing
> functions (and dependent functions) without touching much else.

That's the wrong way to go.  One right way would be to expose a single
function, representing "here is what to do after successfully making a
commit".  Think of it as an invisible built-in post-commit hook
(see githooks(5)).
