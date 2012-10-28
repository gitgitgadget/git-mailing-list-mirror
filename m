From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH v2] git-submodule add: Add -r/--record option.
Date: Sun, 28 Oct 2012 14:59:33 -0700
Message-ID: <CAJo=hJt_A5FCCcvR=sZ5Ni+-ZGq+MjxqkONbh9k+A46xBH9jzA@mail.gmail.com>
References: <20121023204437.GE28592@odin.tremily.us> <1f6ee2966ffe0f58f4b96ae0efb2ffb13e2fa2d8.1351029479.git.wking@tremily.us>
 <50883E54.4080507@web.de> <20121025005307.GE801@odin.tremily.us> <508D9A12.6010104@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Nahor <nahor.j+gmane@gmail.com>, Phil Hord <phil.hord@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Oct 28 23:00:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSatr-00083c-Kx
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 23:00:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402Ab2J1V7z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Oct 2012 17:59:55 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:60715 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752427Ab2J1V7y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Oct 2012 17:59:54 -0400
Received: by mail-qc0-f174.google.com with SMTP id o22so2297599qcr.19
        for <git@vger.kernel.org>; Sun, 28 Oct 2012 14:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=SvxNvxy7729cwyqDKGRwuQ+duUIiIKpR8CbP1e/RWiI=;
        b=P1f11pZA6ehs6xsYor9iJVRBGhIRaJ1QeOSEP5mVCLuRiWZjygZjW84mHipu8xUU6S
         CWIrLLwUAcZoCPU4As0XcBxywi2bRao1fOVl6m6ww3C90yUnpP7C8wawXJpnle4B3Yex
         vT5tPaqLxwZBoHSzec5Q9si+VxdX2EaYJ6Otw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=SvxNvxy7729cwyqDKGRwuQ+duUIiIKpR8CbP1e/RWiI=;
        b=CsiWbyTd/y9fwgZMO7M7D+KTSuYuJLDh1IgxPQ5BMIGfeyi7mDnFb0vOJhJxzh7roi
         QMSsNFZxqT3zmRrlufgPZ1eDDZ/dlR+rrOJGwIwPti8wFu3ZZtDw2DljpbNAfVlUUQuE
         H8ccGXH1EGz58ubCTZ+Fw7oQHzTyUI8kKAr3ijKe0ATI6YSh/q2ur2Uq6P1lAKxRVtNV
         ELOA4nLTI6z9pAL4OfwagisKw+IK3MtQo0O8smHd1KZ64MJ01iuuWJaFlLy8g5/xDCXC
         yTF7/7baEnSchSHaVA9v1IP8SB6uDti6nV6VIoyXx88kGRzwfZTH932Tb7jLpI9+D7u5
         p+fQ==
Received: by 10.49.127.115 with SMTP id nf19mr20141610qeb.36.1351461593553;
 Sun, 28 Oct 2012 14:59:53 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Sun, 28 Oct 2012 14:59:33 -0700 (PDT)
In-Reply-To: <508D9A12.6010104@web.de>
X-Gm-Message-State: ALoCoQlHB4HQs7plTPI7COtEv9bRxZdCa1CsWIouSIv+GVqI4AuefNhYWcknryns+sBaGdrinDlU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208573>

On Sun, Oct 28, 2012 at 1:48 PM, Jens Lehmann <Jens.Lehmann@web.de> wro=
te:
> Am 23.10.2012 22:55, schrieb W. Trevor King:
>> As Phil pointed out, doing anything with this variable is ambiguous:
>>
>> On Mon, Oct 22, 2012 at 06:03:53PM -0400, Phil Hord wrote:
>>> Some projects now use the 'branch' config value to record the track=
ing
>>> branch for the submodule.  Some ascribe different meaning to the
>>> configuration if the value is given vs. undefined.  For example, se=
e
>>> the Gerrit submodule-subscription mechanism.  This change will caus=
e
>>> those workflows to behave differently than they do now.
>
> I don't have a problem with the amount or complexity of the code bein=
g
> added, But by adding that option we may be giving the impression that=
 it
> is officially sanctioned, or that it will be kept up to date by furth=
er
> submodule commands. I added Shawn to the CC, maybe he can comment on =
how
> the "branch" setting is used in Gerrit and what he thinks about addin=
g
> code to set that with "git submodule add -r <branch> ..." to core git=
=2E

Looks like the Gerrit meaning is basically the same as =C6var's. Gerrit
updates the parent project as if you had done:

  $ git submodule foreach 'git checkout $(git config --file
$toplevel/.gitmodules submodule.$name.branch) && git pull'
  $ git commit -a -m "Updated submodules"
  $ git push

and it does this automatically each time the submodule's branch is
modified by the Gerrit server.

On Tue, Oct 23, 2012 at 2:57 PM, W. Trevor King <wking@tremily.us> wrot=
e:
> I'm not clear on what that means, but they accept special values like
> '.', so their usage is not compatible with =C6var's proposal.

"." is a special value to mean use the parent project's branch name.
So its more like this:

  $ git submodule foreach 'git checkout $(git --git-dir $toplevel/.git
read-ref HEAD | sed s,^refs/heads/,,) && git pull'
  $ git commit -a -m "Updated submodules"
  $ git push

We use "." in Gerrit to make branching an entire forest of projects
easier. Setting up dev-fix-yy in the parent project will automatically
track dev-fix-yy in each submodule.
