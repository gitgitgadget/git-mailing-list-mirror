From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] usage: refactor die-recursion checks
Date: Mon, 15 Apr 2013 19:45:03 -0400
Message-ID: <CAPig+cQtXO_jvymrT1Y69W+bhJ908o3HNABj1eVLN5zdJtpT+Q@mail.gmail.com>
References: <20130415230651.GA16670@sigill.intra.peff.net>
	<20130415230802.GA11267@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 16 01:45:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URt5J-0007HA-Ec
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 01:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837Ab3DOXpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 19:45:07 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:62706 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752971Ab3DOXpG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 19:45:06 -0400
Received: by mail-la0-f45.google.com with SMTP id gw10so4890413lab.18
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 16:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=PJgkC1zGjAVrt4VerTzt3bzA+clIMr2tHyqb9yjzswA=;
        b=DH8AeYq0UdiOpFHC5IGKhNhEng2rMx99+UkqRvMS8rTdWrCM09+yrGCDJuAufxCnYI
         Jeqouoq89mTcH2zomfvuoqFNbcIFgRk6f9bXXhofwMnLOr1A3pl51eHIvJnmnR8QBDat
         PdVdbeTaf45uqjoLrvTdzwrflgCF2KTr5Jv+mpmY6Dlvx3rSjkx+kuSXBumZsrPOCLMn
         RbDLSE6Fv9634EeXQmoe3qFE8SvIzg0qBMk2gI1+MIfmym0KLlojZBoAjkD0sKpjX3fF
         E4wJz/as0Z5QUhj22g5vz9/2ct8eM/SasNQNWGtifetFoJgmbby1XHSrwjsA5peENCIT
         Q+5A==
X-Received: by 10.112.145.197 with SMTP id sw5mr167586lbb.91.1366069503818;
 Mon, 15 Apr 2013 16:45:03 -0700 (PDT)
Received: by 10.114.186.233 with HTTP; Mon, 15 Apr 2013 16:45:03 -0700 (PDT)
In-Reply-To: <20130415230802.GA11267@sigill.intra.peff.net>
X-Google-Sender-Auth: P11p6Lil2NQdg-FDqQROdgDMB9k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221332>

On Mon, Apr 15, 2013 at 7:08 PM, Jeff King <peff@peff.net> wrote:
> This patch teaches die() to print the original die message
> to stderr before reporting the recursion. The custom
> die_routine may or may not have put it the message to

s/put it the/emitted/ perhaps?

> stderr, but this is the best we can do (it is what most
> handlers will do anyway, and it is where our recursion error
> will go).
>
> While we're at it, let's mark the "recursion detected"
> message as a "BUG:", since it should never happen in
> practice. And let's factor out the repeated code in die and
> die_errno. This loses the information of which function was
> called to cause the recursion, but it's important; knowing

Was this supposed to be s/important/unimportant/?

> the actual message fed to the function (which we now do) is
> much more useful, as it can generally pin-point the actual
> call-site that caused the recursion.
>
> Signed-off-by: Jeff King <peff@peff.net>
