From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 5/5] ls-remote: add support for showing symrefs
Date: Mon, 18 Jan 2016 23:09:58 +0100
Message-ID: <20160118220958.GJ7100@hank>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
 <1453136238-19448-1-git-send-email-t.gummerer@gmail.com>
 <1453136238-19448-6-git-send-email-t.gummerer@gmail.com>
 <20160118195159.GD1009@sigill.intra.peff.net>
 <20160118195346.GA9337@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bturner@atlassian.com, gitster@pobox.com,
	pedrorijo91@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 18 23:09:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLHzT-0002MF-VM
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 23:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756620AbcARWJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 17:09:33 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35516 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754871AbcARWJb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 17:09:31 -0500
Received: by mail-wm0-f67.google.com with SMTP id 123so12012472wmz.2
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 14:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Ad/MfEl5VvOjV2N3YWhF4VcAYlvTnBWrIAA93cWQg5I=;
        b=GBPZf/U4mz51LOiei3AkRpIYrU8I0FT4/UH2fzSq0aCWO3fxfJ0+JWi0jYSwNkWj6A
         njGvPiM+wZgunH6+Kemx030meWb1bpJUqDZm1nNU0mppCks7P1HIIYzM01kXBKC2Uppg
         srJWXhpYq9B/DBD1ArewfWK8QE7XAFvv82YfvcukkAHgQ25spkIvSyL0VTfH9Ls4G7Nq
         8+mEsvHXYT3zfWmMjMeD6QFE18n5osqbwqHG4Q9D3ecmWUPSgk5PBz8IEeH730j9mMjy
         xqsVUIdIeakynEbYZRg1+oTqfa+CxBJJZZJdqFTKCL+eE8jXTPynU+VG6zso1czdGACv
         NhgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Ad/MfEl5VvOjV2N3YWhF4VcAYlvTnBWrIAA93cWQg5I=;
        b=KQ0ujeWO1DoHjVIyfmFQQfKG17ZbIgTI7l26HJKAJ1L+JRxWjXrunT4wc/ulg2tliN
         lOHHrbooWQzCiKd6eg1CoKN59W7r9q0+H+13mBKzKYv7BlF5zzEgyqcfefKiWcdTlZoP
         RttwYA4U107iJN35w9Q5Y/nlwdM9UG3BkGYAvMKeHmcxnrZxvwIcvgqUX0SWw8LBTNnT
         nRT/vMBZYQ3Cr8jS4P22vQlnBc2QW66P9yD1fJgaTLz7KEzNxcNcfwn50V1ZA16z2ttC
         dUeCGTfP4LAV0ZL8HdNT9R2DiKEJ3YzYjhyqcKLbv/5mwXirHR7+c9H44GTD1pgXkbte
         zBBg==
X-Gm-Message-State: AG10YORqdxjNikl6k5XKECdFaQS/MUcumD/wjVI5AN3tgKpmiIRUkPSkwpTWYdenoa0v7g==
X-Received: by 10.28.229.20 with SMTP id c20mr14618006wmh.79.1453154970643;
        Mon, 18 Jan 2016 14:09:30 -0800 (PST)
Received: from localhost (host113-108-dynamic.249-95-r.retail.telecomitalia.it. [95.249.108.113])
        by smtp.gmail.com with ESMTPSA id w8sm25632181wjx.21.2016.01.18.14.09.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 14:09:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160118195346.GA9337@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284331>

On 01/18, Jeff King wrote:
> On Mon, Jan 18, 2016 at 02:51:59PM -0500, Jeff King wrote:
>
> > It would be nice to also test that
> > "git ls-remote --symrefs --heads" shows "refs/heads/foo" as a symref.
> > But that cannot work with the current code, because upload-pack only
> > tells us about the symref HEAD, and not any others.
>
> Actually, I wonder if it is worth making a note of that in the new
> "--symref" documentation, so people do not report it is a bug that
> "ls-remote" does not show it. :)

I agree, I'll add that.  Thanks.

> -Peff

--
Thomas
