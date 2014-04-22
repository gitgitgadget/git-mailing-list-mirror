From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Tue, 22 Apr 2014 01:45:22 -0500
Message-ID: <5356100296994_268bd0b30839@nysa.notmuch>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
 <53558AD0.3010602@gmail.com>
 <53558a663ea74_604be1f30c2c@nysa.notmuch>
 <53558F6F.7080306@gmail.com>
 <53558f285f379_640076f2f094@nysa.notmuch>
 <CADcHDF+XcWEkvyP3tL4ibicnaMVJpixUZu1Ces0BXWkzPGsodw@mail.gmail.com>
 <53559a8333aaa_6c39e772f07f@nysa.notmuch>
 <535606A3.8040704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Ilya Bobyr <ilya.bobyr@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 08:55:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcUcR-0001Kj-9V
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 08:55:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266AbaDVGzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 02:55:47 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:61324 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbaDVGzp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 02:55:45 -0400
Received: by mail-oa0-f54.google.com with SMTP id i7so2520752oag.13
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 23:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=qOw3x4/PAdHgI0VtRLkzXaXoiBuFAlHTX70+PCZwqXo=;
        b=kzepApTvZDDiIHRw0kT5+JcDfE+lZxHR3/tB8WObBF87NyjXygi8uSb+yeTHdiIDr+
         MO36BUwN5TUd7bFddzAGP07auHr9DEJWVgR4xEXU6ILx328gXrrPyp/DmYMFSyQRw7ov
         5ubUz+J1WPvrZqqfbLV01YD3ul8zIkjk0R8xGKm6HohbIx3huIyl8n57ZI13GUoWJG7E
         +E8Lmf3wDbMBxPihbFfhLo+bNdaIlBau1a32w3XJ0wufZCibdRfeCt7vKclIYfJIz7lm
         xjXyE56UxdBVvXJVw3WorAkiCN19u9wdWNghx2vY+Ujs4vpwFE7X7lLt89ly3nkxeESs
         +2Tg==
X-Received: by 10.60.162.7 with SMTP id xw7mr35723074oeb.13.1398149745293;
        Mon, 21 Apr 2014 23:55:45 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id wy2sm75066807obc.21.2014.04.21.23.55.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 23:55:44 -0700 (PDT)
In-Reply-To: <535606A3.8040704@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246702>

Ilya Bobyr wrote:
> On 4/21/2014 3:24 PM, Felipe Contreras wrote:
> > Ilya Bobyr wrote:
> >> On Mon, Apr 21, 2014 at 2:35 PM, Felipe Contreras <
> >> felipe.contreras@gmail.com> wrote:
> >>> Ilya Bobyr wrote:
> >>>> test_expect_success 'setup' "
> >>>>       mkdir -p .git/hooks &&
> >>>>       cat > .git/hooks/update-branch <<-\\EOF &&
> >>>>       #!/bin/sh
> >>>>       echo \$@ > .git/update-branch.args
> >>>>       EOF
> >>>>       chmod +x .git/hooks/update-branch &&
> >>>>       echo one > content &&
> >>>>       git add content &&
> >>>>       git commit -a -m one
> >>>> "
> >>> That is not maintainable at all.
> >> Maybe you could explain how is this less maintainable, compared to a separate
> >> function?
> > Do I really have to explain that manually escaping a shell script is not
> > maintainable?
> 
> This is rude.

So? I really don't see the need to explain that such a monstrosity would be
unmaintainable, that's a given.

> Here is how you can do it without escaping:
> 
> test_expect_success 'setup' '
> 	mkdir -p .git/hooks &&
> 	cat > .git/hooks/update-branch <<-\EOF &&
> 	#!/bin/sh
> 	echo $@ > .git/update-branch.args
> 	EOF
> 	chmod +x .git/hooks/update-branch &&
> 	echo one > content &&
> 	git add content &&
> 	git commit -a -m one
> '
> 
> It is not different from most of the tests, I think.

This is what I originally asked for.

> >> This is how it is suggested by t/README and how it is done in the other
> >> test suites.
> >> I can not see how your case is different, but I might be missing something.
> > Let's take a cursoy look at `git grep -l "'EOF'" t`.
> >
> > [...]
> 
> So the point is that some existing tests violate best practices?

I don't know what you mean by "best practices", but these are Git's best practices.

> I do not think this is a good justification to do the same for new tests.

It is not a justification to reject a patch either, specially if no better
alternative has been put forward.

Fortunately a better alternative has been put forward, so this is moot.
 
-- 
Felipe Contreras
