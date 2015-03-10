From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] protocol upload-pack-v2
Date: Tue, 10 Mar 2015 08:38:39 +0700
Message-ID: <CACsJy8AuCAfHMbnV3N4ZyZCCqF6WAs_k2dS_Y1ZccWAzWm0yVA@mail.gmail.com>
References: <20150302092136.GA30278@lanh> <1425685087-21633-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 02:39:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV98l-00061t-3p
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 02:39:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbbCJBjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 21:39:14 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:42221 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515AbbCJBjK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 21:39:10 -0400
Received: by igkb16 with SMTP id b16so26761466igk.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 18:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CRemyI3UifU8VHd0bb7+yl7ezsxpkDHaBziDZbyPp4k=;
        b=jwElQmhERkcvaMZMwAMKpOz45gU/HGfCkujCAJckmNsjfxHwum5/PjAVsjdHpAk9h9
         iqDhXxAHQoi/eXzb4M0/qvv7oGTzh1r72gMG6xeWsvS0van6UWNxJMmBy0yBmr/lI8QB
         dAMMnQy3wJtwsQ6NGogWbayVVAH1KaKAV89Y00jy71oHuPwMLmTMiN2NTkD06qib/E9D
         uvO260oJqQa0mdoeC3L5KoE+hL6BRi9qkTnlxfoQyDERhUUwP/+cm9nR4C/o/QfTyn6a
         BudW/4HbJNhTnQIT6OScJsnJyeD7mN8v4qumhQ08kgnl/AIpS+n8F52wnayM7uUhef/H
         vHvw==
X-Received: by 10.42.103.199 with SMTP id n7mr30644853ico.56.1425951549527;
 Mon, 09 Mar 2015 18:39:09 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Mon, 9 Mar 2015 18:38:39 -0700 (PDT)
In-Reply-To: <1425685087-21633-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265204>

A minor point on capability negotiation. I remember why I passed
capabilities via command line instead of this proposal. With this
proposal, daemon.c does not recognize "i18n" capability and cannot
switch to the correct language before it reports an error.

But perhaps I approached it the wrong way. Instead of letting the
daemon produce non-English language directly, if could sort of
standardize the messages and send an error code back in "ERR" line,
together with an English message (current pack-protocol.txt says "ERR"
followed by explanation-text). The client can use this error code to
print non-English messages if it wants to. Perhaps we can reuse http
(or ftp) return codes or some other protocol then customize to fit
Git's needs.
-- 
Duy
