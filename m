From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-push sent too many objects
Date: Wed, 18 Apr 2012 00:59:14 -0700
Message-ID: <CAJo=hJuGHymJtZL14mAq0gBZE+za5URoon=rMzPA=tTQC14ftQ@mail.gmail.com>
References: <30586.1334681607@plover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mark Jason Dominus <mjd@plover.com>
X-From: git-owner@vger.kernel.org Wed Apr 18 09:59:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKPnf-0000Bd-VT
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 09:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518Ab2DRH7g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Apr 2012 03:59:36 -0400
Received: from mail-pz0-f52.google.com ([209.85.210.52]:50404 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252Ab2DRH7f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Apr 2012 03:59:35 -0400
Received: by dake40 with SMTP id e40so9506824dak.11
        for <git@vger.kernel.org>; Wed, 18 Apr 2012 00:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=iVCaIXpjkSuv4ZfvkX1Asvc57v12rrOMXEoQxMnokLw=;
        b=SUt6awg80xZA8st6Gw0smIAhqgbEop31Pu66DbLLJ4wtCAsJiRRTE6sohvFqOyEUdY
         8sf/EyuUaF5iyv7L/4h34cXcJsYMNC5LfkouwJx+WYvV1SZ3/+iC1LGeEYmujPJid9WS
         xVVQLcs4zeKwRuvXL1WzA6sZs5fC0QSLt9w+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=iVCaIXpjkSuv4ZfvkX1Asvc57v12rrOMXEoQxMnokLw=;
        b=GxnQC5/ovsyjeaEHCDLDykBwIpXBGf2ygfJf98jkVcLcK/yakk4HlEbQpLOSU+XKjR
         3oMW6RZzb3/f1kSVFpJtZdaIe56IVuqP/K8/Nqe0a1S5pM74tr5+HhiVXooqBnr0babF
         m53D6X1rFocHJkS9lPaZcEdXHrHQ8YXaZWhgIDXpvRr+LpLeoQSLUYpMoC+DqOQGoNyq
         JpQdW8l+iy1m24/Ry9ozBJF4nM/2wqq0M0TftYLZJIsS5OYMU2NEdZ6unKr14QGUyDw6
         5wVMkwkTd+EgJo8sgORFKZeWkgZt6mdJUunN4+Yw4iIyfod5mbg1KdLo/onmVP19j/Ir
         mZTQ==
Received: by 10.68.131.69 with SMTP id ok5mr4588077pbb.2.1334735974889; Wed,
 18 Apr 2012 00:59:34 -0700 (PDT)
Received: by 10.68.55.68 with HTTP; Wed, 18 Apr 2012 00:59:14 -0700 (PDT)
In-Reply-To: <30586.1334681607@plover.com>
X-Gm-Message-State: ALoCoQnaVCzG0ldv8iZGm0er9csqVXEXlhs7cz2i0G4L2XQsXIJbCOYE51so6m0HOBDWG+tzEvNw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195844>

On Tue, Apr 17, 2012 at 09:53, Mark Jason Dominus <mjd@plover.com> wrot=
e:
>
> I had a master ref, pointing to commit 231e284, which I branched to
> make a "coupon" ref. =A0My remote, "origin" had a copy of commit
> 231e284.
>
> I modified one file and committed it on "coupon", yielding commit
> 03b6489. Then I pushed coupon to origin. =A0I expected that git-push
> would send about five objects, but instead it reported sending 1,315.
>
> Command output is pasted at http://nopaste.info/a866bb00e0.html .
> You can verify that:
>
> 1. I pushed only coupon, not any other ref.
> 2. origin already had a copy of coupon's predecessor commit, 231e284.
> 3. 03b6489 was identical to 231e284 except for changes in one file.
> 4. I was not doing anything obviously strange.
>
> What happened here? =A0Why did git-push send 1,315 objects instead of=
 5?

Is it possible someone else modified the repository at the same time?

We see this happen when the remote no longer has a branch pointing
exactly at commit 231e284, because another user (or you in another
shell?) had pushed a new commit to that branch before you pushed this
new coupon branch. In these sorts of cases your Git client can't
accurately determine what the server has and does not have, so it errs
on the conservative side and sends a lot more than it probably needed
to.
