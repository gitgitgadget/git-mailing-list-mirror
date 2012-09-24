From: Johan Herland <johan@herland.net>
Subject: Re: [BUG?] Path limiting in "git log" when run from another subdir
Date: Mon, 24 Sep 2012 15:16:46 +0200
Message-ID: <CALKQrgfb8qbeKmCzri27iA1qk9H8R4FgyA-YsUQf_JQRWvGK4g@mail.gmail.com>
References: <CALKQrged+ptCQYm-=JKRborrAeKmaNFG=rDS8BQK5CNhwqjnkQ@mail.gmail.com>
	<CACsJy8CECnFbkD6QFWiDMxz6J4mOngrmHPwjuXvsFBUXhNc1_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 15:17:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TG8X2-0000es-8i
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 15:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786Ab2IXNQy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 09:16:54 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:57523 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569Ab2IXNQx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 09:16:53 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1TG8Wn-000OwD-I1
	for git@vger.kernel.org; Mon, 24 Sep 2012 15:16:49 +0200
Received: by oago6 with SMTP id o6so5353323oag.19
        for <git@vger.kernel.org>; Mon, 24 Sep 2012 06:16:46 -0700 (PDT)
Received: by 10.60.29.226 with SMTP id n2mr9552594oeh.138.1348492606103; Mon,
 24 Sep 2012 06:16:46 -0700 (PDT)
Received: by 10.76.128.204 with HTTP; Mon, 24 Sep 2012 06:16:46 -0700 (PDT)
In-Reply-To: <CACsJy8CECnFbkD6QFWiDMxz6J4mOngrmHPwjuXvsFBUXhNc1_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206266>

On Mon, Sep 24, 2012 at 2:22 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Mon, Sep 24, 2012 at 6:59 PM, Johan Herland <johan@herland.net> wrote:
>> The following works in the git.git repo:
>>
>> $ cd t
>> $ git log -- /Documentation
>> [...]
>>
>
> What version? Mine (recent master) does not work
>
> ~/w/git/t $ ../git log -- /Documentation
> fatal: '/Documentation' is outside repository

We initially found it on 1.7.9.5, and conrfirmed it on various 1.7.10
versions. A bisect reveals that this behavior changed in
v1.7.11.5-35-gf4c21e8 (Michael Haggerty: real_path(): properly handle
nonexistent top-level paths).

Does this mean that "git log -- /Documentation" never should have
worked in the first place (and was "fixed" by this commit), or that it
should work (but was broken by this commit)?

In any case, what is the _preferred_ way to path-limit "git log" to
Documentation/RelNotes, when my cwd is t/?


Thanks for your help,

...Johan

>> but the following does not:
>>
>> $ cd t
>> $ git log -- /Documentation/RelNotes
>> fatal: Could not switch to '/Documentation': No such file or directory
>>
>>
>> Is this the intended behavior?
> --
> Duy



-- 
Johan Herland, <johan@herland.net>
www.herland.net
