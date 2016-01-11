From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 3/3] builtin/grep: allow implicit --no-index
Date: Mon, 11 Jan 2016 12:10:15 +0100
Message-ID: <20160111111015.GA10612@hank>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
 <1452435597-12099-4-git-send-email-t.gummerer@gmail.com>
 <CACsJy8Bs3z0Gk3CjhyZGfOLA7R3pZQz7K5gk4BTytvYkZeyBtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 12:09:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIaMH-0007Bg-Ao
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 12:09:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759364AbcAKLJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 06:09:53 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35938 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759098AbcAKLJw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 06:09:52 -0500
Received: by mail-wm0-f68.google.com with SMTP id l65so25733601wmf.3
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 03:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ty3I84j+mtX1tgtwochWbPOylfGwBxmQuih2ESDmsMs=;
        b=gMy3cjpwDYVL5898aqAZxjXT4EcyW9ee4I2aWHDxY8f1LnylFuUnoUlBhjCg5b+4SG
         GMm7rmeGeeRmHjmLHAFhmxLlq3UouYDuHCti9HS+cH/kYqXskug/6GFeAuM+ByjQXmVN
         kZx9iNYeFXOLrZcxPN7DOJ41MaieUvChpWzYhdVoXAwvcCLvm8wumfAKUoPkWSve3Qgo
         5U45LEPyLxapO4zmh8fkcs29YsehrrAvCI55UjqhudwCebS+VYOjYYF0/+0ZpkrF7R5E
         m8D8tcLLGzGuCnY1uYiRLhr127Nju2RZjG4hifvPzrWVCbtBCi4YCnGFdVbCP6SyBTJ9
         mB7g==
X-Received: by 10.28.141.10 with SMTP id p10mr12534975wmd.83.1452510591321;
        Mon, 11 Jan 2016 03:09:51 -0800 (PST)
Received: from localhost (host143-106-dynamic.248-95-r.retail.telecomitalia.it. [95.248.106.143])
        by smtp.gmail.com with ESMTPSA id bg10sm118934014wjb.46.2016.01.11.03.09.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2016 03:09:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACsJy8Bs3z0Gk3CjhyZGfOLA7R3pZQz7K5gk4BTytvYkZeyBtQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283644>

On 01/11, Duy Nguyen wrote:
> On Sun, Jan 10, 2016 at 9:19 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > Currently when git grep is used outside of a git repository without the
> > --no-index option git simply dies.  For convenience, implicitly make git
> > grep behave like git grep --no-index when it is called outside of a git
> > repository.
>
> Should we have a line about this behavior in git-grep.txt, maybe the
> description section?

Yes good point, the behavior change should definitely be documented.

> I wonder if anybody wants the old behavior (e.g.
> non-zero exit code when running outside a repo). If there is such a
> case (*), we may need an option to revert it back (--no-no-index seems
> ridiculous, maybe --use-index). The safest way though, is introduce a
> new option like --use-index=<always|optional|never> then you can make
> an grep alias with --use-index=optional.

You're right.  I couldn't think of a reason why someone would rely on
the old behavior, but maybe I missed something.  I like the idea of
introducing the --use-index=... option.

How should we handle priority between --no-index and --use-index,
should we just give --no-index priority if it is set and ignore the
new --use-index option, or is there some other way?

> (*) I've been hitting really weird real-world use cases so I'm a bit paranoid..
> --
> Duy
