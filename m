From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 2/2] version-gen: avoid messing the version
Date: Sat, 14 Sep 2013 00:59:31 -0500
Message-ID: <CAMP44s3o=DCu6X-+36B07gPbSZv-soYja8GjdCZkRAaK0o9UPw@mail.gmail.com>
References: <1379035046-6688-1-git-send-email-felipe.contreras@gmail.com>
	<1379035046-6688-3-git-send-email-felipe.contreras@gmail.com>
	<xmqqbo3wk2ok.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 14 07:59:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKitO-00089o-6v
	for gcvg-git-2@plane.gmane.org; Sat, 14 Sep 2013 07:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752616Ab3INF7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Sep 2013 01:59:33 -0400
Received: from mail-we0-f175.google.com ([74.125.82.175]:65370 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481Ab3INF7c (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Sep 2013 01:59:32 -0400
Received: by mail-we0-f175.google.com with SMTP id q59so1933078wes.34
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 22:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=prf0ouIUnZ8F3ngoUpsNCDX7v015ZVKV7ysvQhQ84fE=;
        b=XXroIEbBkBlSkesZDFzIZFeQborHlMIH8+6G7Q6ALbLZllZLXEEHIoi4qW0zCvki4B
         YgqH1lIBwTjEGguNRrNK4DsuSmBJ8oWo/A4cIRsYo0z7jgsjM5zdyzgvwSVtQTjBW3OG
         K+Bq336R5DhKX85JgUdcneqf+X0NoFuKe17vdw+wjkH/+CDE+d3Z7RgXkxrwTxPSQjE2
         vhqgTv4l5d9USMhoe1nCaSSKGCKVTe5Nl+YU5HWSXZAP6ZhlCBPFhGFFy5aQCOvB1FoG
         Dwahpuu+QShpZCTjFOVk/xtRErK4LANSqUGhOvTVBtyf05fhCDKESirWnIWnVgDpHTCQ
         P8fA==
X-Received: by 10.180.83.228 with SMTP id t4mr5357075wiy.12.1379138371629;
 Fri, 13 Sep 2013 22:59:31 -0700 (PDT)
Received: by 10.194.39.234 with HTTP; Fri, 13 Sep 2013 22:59:31 -0700 (PDT)
In-Reply-To: <xmqqbo3wk2ok.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234790>

On Fri, Sep 13, 2013 at 1:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> If the version is 'v1.8.4-rc1' that is the version, and there's no need
>> to change it to anything else, like 'v1.8.4.rc1'.
>>
>> If RedHat, or somebody else, needs a specific version, they can use the
>> 'version' file, like everybody else.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>
> I already explained to you why this is a bad change.

No, you did not.

All you did is throw a non sequitur argument which I already exposed as such.

> When we say "we try to avoid regressions", we really mean it.

Maybe by "regressions" you mean progress.

> Before coming up with a change to pay Paul by robbing Peter, we must
> make an honest effort to see if there is a way to pay Paul without
> robbing anybody.

There is, because Peter, the RedHat maintainer, can do exactly the
same that Alice does; use the 'version' file.

In fact, Peter, cannot possibly use Git's version because of this:

% rpmdev-vercmp git-1.8.4 git-1.8.4.rc1
git-1.8.4 < git-1.8.4.rc1
% rpmdev-vercmp git-1.8.4 git-1.8.4-rc1
git-1.8.4 < git-1.8.4-rc1
% rpmdev-vercmp git-1.8.4 git-1.8.4~rc1
git-1.8.4 > git-1.8.4~rc1

Fedora's guideline[1] is to use a format like git-1.8.4-1.rc1, then
the final release would be git-1.8.4-2, in other words, the '.rc1' is
mostly informative, but that has nothing to do with Git's internal
version (git-1.8.4.rc1).

openSUSE's guideline[1] prefers to use git-1.8.4~rc1.

Either way, none of them could possibly use git-1.8.4.rc1, because
that's greater than git-1.8.4.

> This change forces existing users who depend on how dashes are
> mangled into dots to change their tooling.

No, it does not.

You just say that, and you assume because you said it, it must be
true; it's not.

First of all, nor RedHat, nor any other RPM-based distribution needs
this any more, because as a simple search demonstrates, they don't use
release candidates any more.

http://www.rpmfind.net/linux/rpm2html/search.php?query=git&submit=Search+...

Essentially, Peter is a figment of your imagination.

The closest thing to Peter 1) doesn't use release candidates, and 2)
if he did, he wouldn't use a version like git-1.8.4.rc1.

> We do occasionally make deliberate regressions that force existing
> users to change the way they work, but only when there is no other
> way, and when the benefit of the change far outweighs the cost of
> such an adjustment, and with careful planning to ease the pain of
> transition.  The updates to "git add" and "git push" planned for 2.0
> fall into that category.
>
> There has to be a benefit that far outweighs the inconvenience this
> patch imposes on existing users, but I do not see there is any.  "If
> somebody needs a specific version, they can use the 'version' file"
> does not justify it at all; it equally applies to those who want to
> use a version name with a dash.
>
> Besides, the patch does not even do what it claims to do; if the
> version is "v1.8.4-rc1", what you get out of the updated code is
> "1.8.4-rc1", still losing the leading "v".

Wrong.

% git tag -m '' v1.8.5-rc1
% ./GIT-VERSION-GEN
GIT_VERSION = 1.8.5-rc1-dirty

[1] https://fedoraproject.org/wiki/Packaging:NamingGuidelines#NonNumericRelease
[2] http://en.opensuse.org/openSUSE:Package_naming_guidelines

-- 
Felipe Contreras
