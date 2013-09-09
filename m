From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/5] config: set errno in numeric git_parse_* functions
Date: Sun, 8 Sep 2013 20:36:35 -0400
Message-ID: <CAPig+cSPf0Cvk4Em71NX-ad46Ub7GysdhKUuqtjRU7fFTKOvSw@mail.gmail.com>
References: <20130908082724.GA27184@sigill.intra.peff.net>
	<20130908083642.GC29554@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 02:36:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIpT6-00034W-MX
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 02:36:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413Ab3IIAgh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 20:36:37 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:41314 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab3IIAgg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 20:36:36 -0400
Received: by mail-lb0-f170.google.com with SMTP id w7so4447871lbi.15
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 17:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=wsXoAnmGm1cFT/lRxQtFd5W/wLa3nYRlI1mM/R5BTcM=;
        b=l2/pMVka5FMpTexrAhXgf7JU57dKph87n+e1xq4al39Z9f1afOSCjwh4P4eUBwpIrO
         9rlEBR/Pk5C+JEahdu0tRsZciiNemR7WcRXfg6znqlAI3UcrQ6KEXUrntfi9SC1lttpp
         k6GzC+ZnJY+GQpmWHD4XSKbAgsEBVQkfzAWIju3VyiQMfq6pBtyKfguuqjjfmeb9oJCh
         DcGflrfl/h1tUJdiJgaNNCaAexwmnCYR8akuSARqiRn5rUc6NoSlpJ+3vlXWoKEjXnY2
         e7gKa2NpBX3clBAkXr9hhKPn4C7VW9JyX/NekEPtRXrPmuyWn7zixPE/TjrMdrJaJuvL
         pN5Q==
X-Received: by 10.112.128.166 with SMTP id np6mr14080857lbb.7.1378686995140;
 Sun, 08 Sep 2013 17:36:35 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sun, 8 Sep 2013 17:36:35 -0700 (PDT)
In-Reply-To: <20130908083642.GC29554@sigill.intra.peff.net>
X-Google-Sender-Auth: 6GxapGBllcpoMs9Az9SwsRKIjlI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234291>

On Sun, Sep 8, 2013 at 4:36 AM, Jeff King <peff@peff.net> wrote:
> When we are parsing an integer or unsigned long, we use
> the strto*max functions, which properly set errno to ERANGE
> if we get a large value. However, we also do further range
> checks after applying our multiplication factor, but do not
> set ERANGE. This means that a caller cannot tell if an error
> was caused by ERANGE or if the input was simply not a valid
> number.
>
> This patch teaches git_parse_signed and git_parse_unsigned
> reliably set ERANGE for range errors, and EINVAL for other

Missing "to": s/reliably/to reliably/

Or, if you don't like splitting the infinitive:

s/reliably set ERANGE/to set ERANGE reliably/

> errors.
>
> Signed-off-by: Jeff King <peff@peff.net>
