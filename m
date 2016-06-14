From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] fetch: document that pruning happens before fetching
Date: Tue, 14 Jun 2016 17:36:35 +0700
Message-ID: <CACsJy8Bbd0=vnbaj4-2m7WKfvWG6PfyXLg1h+970HPsak1hnMQ@mail.gmail.com>
References: <20160613235850.GA8009@sigill.intra.peff.net> <CACsJy8Ds_DnBLJ0jx7Pp9EH1coG-xAtri4w4hh__=nigCmBbdA@mail.gmail.com>
 <20160614102210.GA14357@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Tom Miller <jackerran@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 14 12:37:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bClia-0004N1-OV
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 12:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbcFNKhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 06:37:07 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:38628 "EHLO
	mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbcFNKhF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 06:37:05 -0400
Received: by mail-it0-f42.google.com with SMTP id h190so63382473ith.1
        for <git@vger.kernel.org>; Tue, 14 Jun 2016 03:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KbMFWa6a6mq9GFcgERkwrCQJNWLWXiEkgmB8ZN49LNU=;
        b=MVhtlngBJsP1jVFdfqdwgtohKCLoEiOIvoeoo1JN44/ckWanKpfjtrFB/7SeO9Lj4b
         pGQCWud1JFM/gfXYEcI/jmcMq1zy5CUQ+nmi3kKxSyrK1lEqoStOkM1xL7vVynzawMkK
         l1GGh3htrq+nKKmUTfGX2FI3LC9CxT44Bwl2hZoJ6MNE1GQ2YMhkaanNENXB50grc2HD
         zVMHEBFJchSyuTxRpJv39bCVc4T4/2Awb6RwtQJMGjMIKb5tILxTJaeiD5YjJeayj4uB
         DSJA17aXLI8l2OYhYI5Q2GhroQcJtz9Fy26G5T2jUJqRv4onf9DO5HGoU+XI6WgbmqeO
         Z3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KbMFWa6a6mq9GFcgERkwrCQJNWLWXiEkgmB8ZN49LNU=;
        b=bqV5sgJTBKCLnZqpcczgUhCFrXcaVdGCXag8vD5hT4EvTdgXeRAU0834U2hBvq9mwl
         FAzTt3dy4FLMQIY/soz8tWhCRWF5BdxGxmaaxn74RbsjYI5jhX7q+eHpYw7h49BEIFIe
         ePZR0YJq4a+wxbcYD8pAAbi/RaPW6VCWWaUUAJ3wmAqG1nGBu/52ktNQnkeOCN5SIe4L
         f3tFFgTfWGQum+/j1aXs7rCaJAyzcysE7ijSdMN1MIfZJq7t3LKnhCoOKklEtIH7I31T
         i9AfuRFgEO295dgZDmBn6q5pLR9mha337+vivOVr7S5a2PHRH6ZDWywALGb8ayojbnv+
         hUcw==
X-Gm-Message-State: ALyK8tIFVJrjusXjeQX1ZQBRJaWryfuDqMWc9vrlGHFsfyvy2VLsiTEq7y2il9iYx3ns6yhkqpsca34JFgoaUg==
X-Received: by 10.36.82.8 with SMTP id d8mr26016440itb.57.1465900624655; Tue,
 14 Jun 2016 03:37:04 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Tue, 14 Jun 2016 03:36:35 -0700 (PDT)
In-Reply-To: <20160614102210.GA14357@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297281>

On Tue, Jun 14, 2016 at 5:22 PM, Jeff King <peff@peff.net> wrote:
> I think the documentation should be updated either way. This is not
> about the ordering in the status table, but rather about the order of
> the real operations. The user may care about that ordering if they want
> to know what races are possible

Good point.

> or what would happen if the packfile
> fetch failed (we'd already have deleted the old refs, but wouldn't fetch
> the new ones).

Off topic, but this sounds like a bug to me. We could have kept ref
update more consistent (maybe at some point we could even do atomic
transaction update for all refs if there's a need for it).
-- 
Duy
