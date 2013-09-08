From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Sat, 7 Sep 2013 21:34:51 -0500
Message-ID: <CAMP44s1Rb2WKGD-QfNh055099R+9FHv9W8TA8Gfjp=qZh_7p7Q@mail.gmail.com>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
	<xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<xmqqa9jso69u.fsf@gitster.dls.corp.google.com>
	<7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley>
	<xmqqr4d4jird.fsf@gitster.dls.corp.google.com>
	<20130905080606.GE2582@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Sep 08 04:35:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIUq7-0005va-Oh
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 04:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518Ab3IHCey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Sep 2013 22:34:54 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:56606 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431Ab3IHCex (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Sep 2013 22:34:53 -0400
Received: by mail-lb0-f180.google.com with SMTP id q8so3954359lbi.39
        for <git@vger.kernel.org>; Sat, 07 Sep 2013 19:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5dDBP/LVBQLtl4m2bKFccN7apR7JPASVTItA28zkazg=;
        b=KVCU5iEfYTgoXKiPpz0td5jsb58Bs7t+SNhJJPceBaNbsMwsy6GwJ2bb9wjJw97FqM
         /DSiFsFYsz0SdnNvY+DgzQ5UXdIez4IYHCA6BqjVQ4+ryXBBfzYZDPThBifZYhEMmWcA
         dNG/V9ErZkiwIDBDwZNhrYUTZ1FqWniL+gmbIl8QLPLYzJqMIfuXgkr2IEzA/lbpMHHX
         V+gR0Go5Xx6mq95C2JIEBGWUJHfDcw7Pv4HlRtrkbjEB15k8qK/dRB609V0nkKKsMJQS
         avt49vLkYUuYVIfGbYD40IT3XWiiDUvHSTvbydVqdJFI9wHne5b0+LKeNVOKZSoHUA3T
         Z/9Q==
X-Received: by 10.152.120.37 with SMTP id kz5mr9542981lab.21.1378607691849;
 Sat, 07 Sep 2013 19:34:51 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 7 Sep 2013 19:34:51 -0700 (PDT)
In-Reply-To: <20130905080606.GE2582@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234162>

On Thu, Sep 5, 2013 at 3:06 AM, John Keeping <john@keeping.me.uk> wrote:
> On Wed, Sep 04, 2013 at 03:59:18PM -0700, Junio C Hamano wrote:
>> Are there cases where you do not want to either rebase nor merge?
>> If so what do you want to do after "git pull" fetches from the other
>> side?  Nothing?
>
> One other thing that I can see being useful occasionally is:
>
>     git rebase @{u}@{1} --onto @{u}
>
> which allows local commits to be replayed onto a rewritten upstream
> branch.
>
> Although I agree with your side note below that people doing this may be
> better off fetching and then updating their local branch, particularly
> if @{1} is not the correct reflog entry for the upstream when they
> created the branch.

That's why after recognizing the fact the you can't find the branch
point of a branch in Git, I decided to write patches to support the
@{tail} shorthand, which is basically the point where the branch was
created, or rebased to:

https://github.com/felipec/git/commits/fc/base

And if 'git rebase' was fixed to ignore the commits already in the
rebased onto branch, almost always what you would want to do is 'git
rebase @{tail} --onto @{upstream}'.

-- 
Felipe Contreras
