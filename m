From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] quote: let caller reset buffer for quote_path_relative()
Date: Thu, 11 Oct 2012 20:04:05 +0700
Message-ID: <CACsJy8CTGpDW46-37oX14+JxLxWmoz2f4mawr4QPkqCSunF7dQ@mail.gmail.com>
References: <7vk3uzfp3p.fsf@alter.siamese.dyndns.org> <1349868894-3579-1-git-send-email-pclouds@gmail.com>
 <1349868894-3579-2-git-send-email-pclouds@gmail.com> <7vd30qav4m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 15:05:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMIRb-000541-4b
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 15:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756325Ab2JKNEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 09:04:37 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:39930 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652Ab2JKNEg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 09:04:36 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so2868604iea.19
        for <git@vger.kernel.org>; Thu, 11 Oct 2012 06:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=O38Hnb3nZu9jUCpyO8R2SOuYaiEsgUbhW7eFNugYZ58=;
        b=z3XaovNfBmqjtV2U/JY3I8BdrbRK3iKUs/5pObolOFju257FNMqOFDIY+MK4qcKMPq
         A7fMRYKQihjYk8hiYibx/sNhlTAkqzcP52M70ybFywFSi5EwE7w1v8ONhEbUXDaL283W
         LJxF+kKxuDaN0a8P2QCJEvFOo2CjYpzZjC056f6//wler/IX7Ia4+VjxgWpZIKXK8v/7
         77rqsBdRSItFVkwo6DKVZzYDzBaRctp+qBKey7cFol1M0c4zEBhMOygKVw3miWZyPio0
         VBGCtCoSEgETHVpkdSNCDZNz4f4ft8hyeEPRdiJJNt6LYduP9qof6XpHXxY1IBM7eEdd
         W/uQ==
Received: by 10.50.15.193 with SMTP id z1mr692549igc.47.1349960676009; Thu, 11
 Oct 2012 06:04:36 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Thu, 11 Oct 2012 06:04:05 -0700 (PDT)
In-Reply-To: <7vd30qav4m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207476>

On Thu, Oct 11, 2012 at 4:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> This sounds a lot stronger than "let" to me.  All existing callers
> that assumed that buf to be emptied by the function now has to clear
> it.  "quote: stop resetting output buffer of quote_path_relative()"
> may better describe what this really does.
>
> How should this interact with the logic in the called function that
> used to say "if we ended up returning an empty string because the
> path is the same as the base, we should give ./ back", and what
> should the return value of this function be?
> ...
> So what does it mean to have an existing string in the output buffer
> when calling the function?  Is it supposed to be a path to a
> directory, or just a general uninterpreted string (e.g. a message)?

I prefer the KISS principle in this case: do not interpret existing string.
-- 
Duy
