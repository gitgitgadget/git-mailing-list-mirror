From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 3 Oct 2012 16:25:57 +0200
Message-ID: <CAB9Jk9CdYXZzPcM=YiwOUyKNQ=4uKpfs+HY7WpWBmqgQRw4SyA@mail.gmail.com>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<CABURp0pbX4Fk4sNWCicfF7Gm52-KTMBrasdi_XHnjtE2zmSBFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 16:27:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJPtr-0008DO-Ov
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 16:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999Ab2JCOZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 10:25:59 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:35739 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab2JCOZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 10:25:59 -0400
Received: by vbbff1 with SMTP id ff1so7890799vbb.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 07:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yFBqbo4zeW0HkrCIdI2FtjiAI6eTxiMLWjtfVbM+FxQ=;
        b=zYwYxtbaH3TL03BOzLa8N4si/XxcJwZN0K0ahoqNM8pHtJIVpvSfP2pOM1aieU01td
         WJJGm1me2Isr21LoyxijLAYtoucBlSG8KwfJtJwe1+KREHZXTrFJMBW20GEZBbXYvJj3
         MY02KUGdw8B4dMRGi0K5Jix67CEGW/MxKLYKBnhUUNpCSIkzTAwQXUjS3hdcSjhNmVyS
         nXqf01RGSp/p71f9OLQDPqO0AjO3bf/5ltjb8RkqHzq2Rd9KKxoSeImUKhq0+MUqpKwu
         stofuRGP301S1TtRd+UBFeg96j+oZCZp0bHLyAx1ZQXWxL/LFNhKVqSjDQAPFFZ0dPQ6
         904A==
Received: by 10.220.152.11 with SMTP id e11mr1185609vcw.61.1349274358039; Wed,
 03 Oct 2012 07:25:58 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Wed, 3 Oct 2012 07:25:57 -0700 (PDT)
In-Reply-To: <CABURp0pbX4Fk4sNWCicfF7Gm52-KTMBrasdi_XHnjtE2zmSBFg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206900>

Hi Phil,

> Perhaps the confusion arises from the the meaning of "the safety".  In
> this case, the safety mechanism in place is to prevent you from
> creating a child commit which has the same "tree" contents (working
> directory) as the parent commit.  It will not be the same commit
> because it has different parent(s) than its parent commit; but the
> tree (working directory) is the same and git normally prevents you
> from doing this because normally this is an accident, a mistake.
>
> --allow-empty tells git you intend to do this and so it should bypass
> this "no changed files" safety mechanism.  It is not a safety to
> prevent you creating a new commit with the exact same sha1; the safety
> is concerned only with the exact same "working directory" file
> contents.
>
> Can you suggest a rewrite of this description which would make it more clear?

Instead of:

"Usually recording a commit that has the exact same tree as its sole
parent commit is a mistake, and the command prevents you from making
such a commit. This option bypasses the safety, and is primarily for
use by foreign SCM interface scripts."

I would suggest:

"Usually recording a commit that has the exact same tree as its sole
parent commit is not allowed, and the command prevents you from making
such a commit. This option allows to disregard this condition, thereby
making a commit even when the trees are the same. Note that when the
tree, author, parents, message and date (with the precision of one
second) are the same as those of an existing commit object, no new
commit object is created, and the identity of the existing one is
returned."
>
> Phil
