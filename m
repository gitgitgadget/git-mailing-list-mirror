From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pathspec: adjust prefixlen after striping trailing slash
Date: Wed, 22 Apr 2015 20:47:16 -0700
Message-ID: <CAPc5daUA30ZbbJVK9S_FM9Z8qyyEXUez9hGD2JNhTm78QYb5YQ@mail.gmail.com>
References: <55300D2C.9030903@web.de> <1429319946-19890-1-git-send-email-pclouds@gmail.com>
 <5533A567.7070301@web.de> <CACsJy8A7+rQhn5ry6Z86SbeYHoDw=w7tB73Ls2V05E8F-JMnhA@mail.gmail.com>
 <xmqqy4lnmkbv.fsf@gitster.dls.corp.google.com> <CACsJy8B1QWzehAEtjnQeRJ8uehcFFDbdHSViwk_JtrtYehV8ZQ@mail.gmail.com>
 <xmqq8udlgpey.fsf@gitster.dls.corp.google.com> <5537F31D.4090704@web.de>
 <xmqq1tjcdjfa.fsf@gitster.dls.corp.google.com> <5538218B.4010400@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 23 05:47:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl876-0004X5-9L
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 05:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757433AbbDWDri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 23:47:38 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:33868 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753698AbbDWDrh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2015 23:47:37 -0400
Received: by obfe9 with SMTP id e9so4592447obf.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2015 20:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=9rwOjGxAR49dMK+tzxhvbazwhkAjXqS9FkhH9FbH52Y=;
        b=t7kjFrGRqO0TWyChYi/35CBMjzMY9it5sLV60Mp/nyR5ea54HLZSzQZEALJ9yj1Prj
         iydPLSdaDsTqcC88PuGjAUl/W3Qm8GDnyNjsAVit5mi/6NoSPvCBNQUwO4bRH/w8+TEZ
         77tA1D5FQ4eQsqyDQ+IgsTyE74sALi+mdx09imdQ3hGS6yK4gYBVDaT8wruQY+s4c8xo
         +9p7sIk+c5WONYZlews1rTyq/KFDig5iWfh7vC5pvAyY88DBrk9Ks8zr3mc4NN4oeD6o
         9Qp736Y5wwtQ63NPV9Tc3hLUD3o8uUditCWIWSSiefEePzbvOez0BZgVr5rlyUaJg1nx
         4uMA==
X-Received: by 10.182.241.197 with SMTP id wk5mr699907obc.0.1429760856935;
 Wed, 22 Apr 2015 20:47:36 -0700 (PDT)
Received: by 10.202.197.18 with HTTP; Wed, 22 Apr 2015 20:47:16 -0700 (PDT)
In-Reply-To: <5538218B.4010400@web.de>
X-Google-Sender-Auth: g4Vxw9FP3kNgfBy_0Zz1XoeH-vM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267674>

On Wed, Apr 22, 2015 at 3:32 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> ...
>> But it is unclear if we should still do (2) when "subrepo/.git" is
>> no longer there.  That has to be done manually and it may be an
>> indication that is clear enough that the end user wants the
>> directory to be a normal directory without any submodule involved,
>> in which case it may match the expectation of the user better to
>> just nuke the corresponding 160000 entry in the index and replace it
>> with files in there.  I dunno.
>
> The user having removed subrepo/.git is just one reason for that.
> Another is a user adding a file in an unpopulated work tree of a
> not initialized submodule. I doubt that simply nuking the 160000
> entry would be the right thing to do in this case, I expect this
> to be a pilot error we should barf about ;-)

OK, that sounds sensible.
