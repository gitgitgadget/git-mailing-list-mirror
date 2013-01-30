From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/6] introduce a commit metapack
Date: Wed, 30 Jan 2013 21:16:29 +0700
Message-ID: <CACsJy8Bqg6knVtddwaGSqtiXzVDgbO1JjbFOPMbF_RqrxM2rFQ@mail.gmail.com>
References: <20130129091434.GA6975@sigill.intra.peff.net> <20130129091610.GD9999@sigill.intra.peff.net>
 <20130130135607.GA23154@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 30 15:17:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0YTb-00030C-M4
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 15:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880Ab3A3ORB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 09:17:01 -0500
Received: from mail-oa0-f53.google.com ([209.85.219.53]:39750 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754828Ab3A3ORA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 09:17:00 -0500
Received: by mail-oa0-f53.google.com with SMTP id m1so791747oag.40
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 06:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=lgVycKducQy+TUHcxXFi+EF6JQgu557Cf3IuQMwan+4=;
        b=IrCPXZlT50UNBxpw/qi5E2te4094xi0xY1uGmR6Hk5z+G0f1Yx0033TWSX/8lwSxc/
         xTyz3hTaCw96WwapFKKhOlF6TEs2vzf3AdYq99wHcRrvZfPMJJ0ifGw7Q8fPXpkViAUp
         kO+lrKLs7AZ8F8A4p/2Wj96CfuK3Zq+az3T8EMr1FVvxfZZ6WgqZLjWZDmpWGl3nJkrC
         zgkGo/hRjAPVS058vvnBP1kLaJ/W/YLrYZaTVOynLtnTQBFWs6Gb3AsGqBsXiu+8x3fD
         AGLcs7/e7YxMnEgFmh/aUwnh+WNskBLxRJX4ARxmIEaeGiAmCXRvIBDJ8HBFs/IRqjS+
         yXAQ==
X-Received: by 10.182.18.133 with SMTP id w5mr3760457obd.64.1359555420083;
 Wed, 30 Jan 2013 06:17:00 -0800 (PST)
Received: by 10.182.118.229 with HTTP; Wed, 30 Jan 2013 06:16:29 -0800 (PST)
In-Reply-To: <20130130135607.GA23154@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215021>

On Wed, Jan 30, 2013 at 8:56 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> However, performance seems to suffer too. Maybe I do more lookups than
> necessary, I don't know.

Yes, I should have stored the position in the sha-1 <-> offset map
instead of the position of the object in .pack file. Even so,
performance does not improve.

> I should probably measure the cost of revindex separately.

And the cost of create_pack_revindex() is 0.6 sec :-(

Perhaps we could store abbrev sha-1 instead of full sha-1. Nice
space/time trade-off.
-- 
Duy
