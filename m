From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] svnrdump_sim: start the script with /usr/bin/env python
Date: Wed, 28 Nov 2012 20:19:32 +0100
Message-ID: <CAMP44s3YfLrL+74j5DOVVATK8GWEo1qHnmJDW5dLWJRxK_CVLQ@mail.gmail.com>
References: <20121128025734.21231.47468.chriscool@tuxfamily.org>
	<7vy5hmgovt.fsf@alter.siamese.dyndns.org>
	<CAMP44s17Gycr2tWOLYAxMG7-CGP3SpFf7XTWf94qGg3WfVpT-A@mail.gmail.com>
	<CAP8UFD08LhywQ9KaNoeG1nORZwtK8MNWqwjfRJPyT2vLkNgs9A@mail.gmail.com>
	<7vmwy1hdgx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 20:19:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdnAm-0002j5-Ua
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 20:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755645Ab2K1TTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 14:19:36 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:43290 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755254Ab2K1TTg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 14:19:36 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so8403964vbb.19
        for <git@vger.kernel.org>; Wed, 28 Nov 2012 11:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BkyjZZd36YfnXuwDNBxD9Eh/SM+A7OCheSTyu0mMIjc=;
        b=Fnntk7+OhNDUaNlf79x54JlMOdFHogSOO1AeBaoqJUgOrV3RMjSwL1IriXkjd8RVL7
         KcEcIMh09f4ADOpUk7oNWb08roW8nVEXMYRbqLlLSH8ThXaWyFz3tHpB0NfRB8zfMGEc
         w8mL3nOZpwz3U9TWQCi69XBWQAnY/v81zeZrizexOEfsupyHUKCMmW/AckmBCdeBes7/
         /vB+bmbHsH6osqPQmQJRFfp7GJrAOFY/7ShqnoHbSPaWsPZBGeuH17uuVw9NS1wkEOHz
         wWvf8yj5u1D0Hm2oTOs9t/Vvwlg8yFQAxIFPMshFS4xiH5SDLFqilUOEr1ZsLtG1w7m7
         2/hQ==
Received: by 10.220.220.5 with SMTP id hw5mr28722113vcb.53.1354130373100; Wed,
 28 Nov 2012 11:19:33 -0800 (PST)
Received: by 10.58.34.51 with HTTP; Wed, 28 Nov 2012 11:19:32 -0800 (PST)
In-Reply-To: <7vmwy1hdgx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210761>

On Wed, Nov 28, 2012 at 5:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> On Wed, Nov 28, 2012 at 9:03 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:

>>> That works if somebody managed to export PYTHON_PATH, which very very
>>> often is not the case for me.
>>
>> Yeah, and even if PYTHON_PATH is used, in t9020-remote-svn.sh,
>> svnrdump.py is used as is.
>
> You need a fix for that; didn't I already say "you need a bit more
> than that"?

I disagree. Most of the contrib scripts are expected to be used as
they are. There's no step in the Makefile that will convert them, and
it's up to each distribution to decide what to do with them. This is
what Arch Linux does:

  # more contrib stuff
  cp -a ./contrib/* $pkgdir/usr/share/git/
  # scripts are for python 2.x
  sed -i 's|#![ ]*/usr/bin/env python|#!/usr/bin/env python2|' \
    $(find "$pkgdir" -name '*.py') \
    "$pkgdir"/usr/lib/git-core/git-p4 \
    "$pkgdir"/usr/share/git/gitview/gitview

At some point we might decide to change this, but at the moment
contrib scripts are pretty much stand-alone.

Cheers.

-- 
Felipe Contreras
