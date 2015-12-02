From: Stefan Beller <sbeller@google.com>
Subject: Re: Bug: Incorrect stripping of the [PATCH] prefix in git-am
Date: Tue, 1 Dec 2015 17:10:12 -0800
Message-ID: <CAGZ79kZ8WLzwvsSPCgt4ncfqib479mXuDWQ5cLj0QjmZmR439g@mail.gmail.com>
References: <5655D3DA.1050403@informatik.uni-hamburg.de>
	<5655D755.8060503@atlas-elektronik.com>
	<5655DAE7.2000008@informatik.uni-hamburg.de>
	<20151202005826.GE28197@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: huebbe <nathanael.huebbe@informatik.uni-hamburg.de>,
	stefan.naewe@atlas-elektronik.com,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 02 02:10:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3vw4-0006C4-Fy
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 02:10:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbbLBBKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 20:10:14 -0500
Received: from mail-yk0-f174.google.com ([209.85.160.174]:33146 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbbLBBKN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 20:10:13 -0500
Received: by ykdv3 with SMTP id v3so29709640ykd.0
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 17:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=60/kkm+EaouvZT7Xsv4SZ41VPq/NTLdS/4VIfmMMR58=;
        b=D5k+KO3EQkLi4PtBDbsGifwChoypmw+kZptPD5q+8eL5qgqEdbmWD5gKwGick9xL3h
         7KlwK4OM8ed/JtpOI42uzkyuk7Fx8mMxuB+/DVWSsmNuCN5SvdFozCsXcHv8gg57mVdW
         mc6iYlgTUyHnfPvebh6Y8pjvtyxDEFDb+0HFldxEIh/Rru1pjX51LEmpj94+W5vCLPwq
         CtQ+lBGmJo3L0R0dcm3g5erz2ZsC+Z5szAgxpeRC/HEE2K3mO7q/TspeNW5NjthO4H+O
         ST3ERfl+K65wdKQGKjNPFZ6ddOrlq51ddP2Jk7nVcNsZdEjncXHhTkESwqA7LcTIeNv3
         0BAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=60/kkm+EaouvZT7Xsv4SZ41VPq/NTLdS/4VIfmMMR58=;
        b=jkKrBIcbWVyqUHC9N5HfUUiB5k/9TAV5n/8VBqLEQ/2xjVHkEJozIgwPlw4zRIxoQK
         ItgYlqIvlPVjw92Lllg6DR+X6+Jli5pyJdCtMCizO2mszmKtCNRUxbgfkNvV9Yxasw24
         D/UZuowmnFR3YxwvawnIkEEtIinu6wnjo+T9M1hN7amTw10GDgq6wuK2LDkfnPg9UxNS
         1AJ+7TN98+SWm/UkOXo1Jt2urKhDGEyf9kMS+Wz9f8xj0UqIZdB2kQ5g05qIDZ1k7OTp
         AcYOluTGfkEwthOuHQYBOOesrVfSlCAm3ArxruSplR6b86PxbF9inQWZzpmBQZ4kKGfK
         EjkA==
X-Gm-Message-State: ALoCoQk7wM0a5lgLVvj2zxkzZH5LvjmIrTESx7Ingna2vPYkoTwmsnOhLD+q3j8VtpCYmOBfZ/19
X-Received: by 10.13.214.19 with SMTP id y19mr273228ywd.63.1449018612401; Tue,
 01 Dec 2015 17:10:12 -0800 (PST)
Received: by 10.37.215.16 with HTTP; Tue, 1 Dec 2015 17:10:12 -0800 (PST)
In-Reply-To: <20151202005826.GE28197@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281873>

On Tue, Dec 1, 2015 at 4:58 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 25, 2015 at 04:59:35PM +0100, huebbe wrote:
>
>> Yes, it looks like the `--keep-non-patch` option works around this.
>>
>> However, shouldn't that be the default behaviour?
>> I mean, what is the point in stripping stuff that is not proven to be inserted by `git` itself?
>> That's not what I expect a tool to do which I trust.
>
> The "[]" convention is a microformat used by Linux kernel folks. So it's
> not "whoops, we are stripping stuff not added by git". It is respecting
> a microformat used by the tool's authors.
>
> That being said, if we were choosing a default from scratch today, it
> might go the other way. But we aren't, and we have to deal with the
> burden of breaking existing scripts by flipping it.

Do we as the Git community have a place where we take notes for version 3?

This sounds perfectly fine (to me at least) to change the default with a major
version number as the changelog for major version numbers may even be read
by kernel devs maintaining such scripts ;)

Or could we even patch that today to have `--keep-non-patch` be default
later on by checking for our version number ourselves and deciding upon that
for the default?

>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
