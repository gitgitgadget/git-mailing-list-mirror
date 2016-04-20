From: Stefan Beller <sbeller@google.com>
Subject: Re: bug: git submodule add fails when .git is a symlink
Date: Wed, 20 Apr 2016 09:41:52 -0700
Message-ID: <CAGZ79kbpyu34kz7gRgro-HZqNvpmRoCsyQatZRbxP19bk1gkfg@mail.gmail.com>
References: <20160301204218.GA4083@kitenet.net>
	<CAGZ79kY6Lf6u0=s8J_cqRNFsry4nu2SdL0GZ2gkFsu6gBrB65Q@mail.gmail.com>
	<xmqq8u217tqa.fsf@gitster.mtv.corp.google.com>
	<20160301231720.GB3731@kitenet.net>
	<20160302084904.GA30295@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Joey Hess <id@joeyh.name>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 18:42:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asvCV-0000zF-5w
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 18:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbcDTQl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 12:41:58 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:37571 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbcDTQl5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 12:41:57 -0400
Received: by mail-ig0-f182.google.com with SMTP id g8so54646536igr.0
        for <git@vger.kernel.org>; Wed, 20 Apr 2016 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=kQNvzhhHbJUqhmglUNgybzrx1jw20aZxefxfTYikquU=;
        b=MbQTWqBoKTRqZjVBRLp7UmQOK0gAm5D9fgzfM/Equm18dkJELd0XZjkN+cr4PREjJY
         yE+/lCHjZAuHHtvL86i8zVisBWm5dJ4A8TRXbrGdq/RFqCLOjbSrlyqC2iR5P8XSJfAj
         QhdfeNwppgmZe4lMBAApQTadnPmkKwkAyT0niqEvWEVuJKqElPeTyNvLVD02cYcYHTBD
         m4GrqmK65hY8eIxr+HUE7M9fHEp8j+kNkuTHh7UZfFffoG8Wf20spYPxtPrvJWKaDrxG
         MSXqOvvBFFAmJHYi8gZbM1/txUIzLAtKQE4Bbrzu8jeL/59sRKCto8gNki+K2uV4EO5z
         zmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=kQNvzhhHbJUqhmglUNgybzrx1jw20aZxefxfTYikquU=;
        b=BmeLQw8lp4cfc850hrgYeHNzTKY2TRNnLfyfL6qlnBWQcXUhGmuiyYuAtCt4YSX112
         CFZyvIpFwbZFmSQ1gCk+MBBcuq4HV5TEosUcdkafZ+xhQxfrmtHRvugOmxnHY301QR9a
         RG1iqSWQ8LVJ1/6+K+G3YhmuZWqBTDyYgUDiUgdx/H8MQ6RkvW7qBe2XjiuKRa0VfwpY
         7DWffx0ioHwmnD1lCX0Blc8cJavRWcerZKPcd+KTa7vwSt+p9DVGarGnSrryGrxrOPiA
         95WKCRE5mlMOr+QeqD0wWwP+INmWspojCgF1Ki5Wr91s9Qy4UfZGXoxofpPZisz4aF7D
         eXzw==
X-Gm-Message-State: AOPr4FXwgziry1amE7waBs/18cfLoK+XMLhnxhB4YS+BGAsK7DtX3TrA8nniMu2QCS5Heclu+V4T+QyJUX4xOYJG
X-Received: by 10.50.57.50 with SMTP id f18mr4780826igq.93.1461170512127; Wed,
 20 Apr 2016 09:41:52 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 20 Apr 2016 09:41:52 -0700 (PDT)
In-Reply-To: <20160302084904.GA30295@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292044>

On Wed, Mar 2, 2016 at 12:49 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 01, 2016 at 07:17:20PM -0400, Joey Hess wrote:
>
>> Junio C Hamano wrote:
>> > A more pertinent question may be which version of Git did the above
>> > ever work, I guess.  We fairly liberally chdir around and I do not
>> > think we deliberately avoid assuming that "cd .git && cd .." might
>> > not come back to the original directory, for example, so I wouldn't
>> > be surprised if it never worked.
>>
>> IIRC git used symlinks for .git in submodules before version 1.7.8, so I
>> guess that older versions supported that pretty well.
>>
>> This one case is the only time I've seen a symlink for .git present a
>> problem so far.
>
> Fortunately you provided a simple reproduction case, so it is easy to
> bisect. It did work in v1.7.8, and broke in d75219b (submodules: always
> use a relative path from gitdir to work tree, 2012-03-04). Not
> surprising, I guess. It presumably worked before only because we were
> using absolute paths.

So I was looking into this bug again, as it was linked from another bug report.

fatal: Could not chdir to '../../../sub': No such file or directory

sounds like a path issue with the prefix thing.

Using the " echo "gitdir: ../gitdir/.git" > .git" workaround does still work,
I'll see if there is another way to fix it with actual links.


>
> -Peff
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
