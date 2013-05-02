From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] sha1_name: reorganize get_sha1_basic()
Date: Thu, 2 May 2013 17:19:44 +0700
Message-ID: <CACsJy8CWGJZByedxhzuU8OkPPBc0XmfZqE_e_ehmt55t-tHmsQ@mail.gmail.com>
References: <1367455791-30091-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 12:20:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXqd9-0008Ld-34
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 12:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756379Ab3EBKUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 06:20:17 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:53810 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427Ab3EBKUP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 06:20:15 -0400
Received: by mail-oa0-f43.google.com with SMTP id n2so353754oag.16
        for <git@vger.kernel.org>; Thu, 02 May 2013 03:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Z8b0TSNa4sqT7NjGf70X87YzQKunCSurTt9E5hK2yk8=;
        b=ac8NXm54yxP5t8PjZPWCe4zAR1vQNoJaGTQ+tgtiGwFdt/bd33RzjmJzRUwjI2FcWW
         1nHNqnUcUFRrp/GDwnWH+dgnyp3jF3y2NIuD+HQs/KH3PBsHwOALjSe1980vhy9XGmDs
         n+plgFJTG6mOhZVw2e2wICr4i4n12/ILxnb2nbh2u2LZb7pzYej3jqba7YM8LvZmPPMz
         HTuP/Jyp80qxFe045H2nK08+fxMV4qI1ER+nRuuByCmRdITo4lFeTUyCnrHmbXkOr8Js
         tfhFNTWKKdyYc/l2S7bFdGwaOSp+HCc6vjiL2ai+9nedxgp12kf/Y6nLQoW5uGKebE5h
         ULQA==
X-Received: by 10.60.50.70 with SMTP id a6mr1634867oeo.43.1367490015081; Thu,
 02 May 2013 03:20:15 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Thu, 2 May 2013 03:19:44 -0700 (PDT)
In-Reply-To: <1367455791-30091-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223190>

On Thu, May 2, 2013 at 7:49 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Through the years the functionality to handle @{-N} and @{u} has moved
> around the code, and as a result, code that once made sense, doesn't any
> more.
>
> There is no need to call this function recursively with the branch of
> @{-N} substituted because dwim_{ref,log} already replaces it.
>
> However, there's one corner-case where @{-N} resolves to a detached
> HEAD, in which case we wouldn't get any ref back.
>
> So we parse the nth-prior manually, and deal with it depending on
> weather it's a SHA-1, or a ref.

If you are brave, reorganize the whole extended sha-1 parsing code. I
think the right-to-left parsing is confusing, not to mention it has to
treat ":path" differently. But may be that's too big work for little
gain.
--
Duy
