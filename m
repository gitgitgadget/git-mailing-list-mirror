From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] sha1_name: reorganize get_sha1_basic()
Date: Wed, 1 May 2013 19:53:41 -0500
Message-ID: <CAMP44s2_riedK8gsHELRgQXd+7XWaTC6ErhPqX3xqWQoc5pJKQ@mail.gmail.com>
References: <1367455791-30091-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 02 02:53:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXhmN-0004JH-8Z
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 02:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758746Ab3EBAxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 20:53:44 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:53077 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753830Ab3EBAxn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 20:53:43 -0400
Received: by mail-wi0-f180.google.com with SMTP id h11so60688wiv.1
        for <git@vger.kernel.org>; Wed, 01 May 2013 17:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=GF9MzluE3d8gZK8D47e0l8ZFsOl2c5Y4xrKamJQBIuA=;
        b=H5+oJoQnYc2t58fQvh3DHthJJ5WON7niyYDS4n7mzAQ1uyxqzhNrwa5xwfAo/8To1g
         F7lXbgKIvr7YylpSZhSRZQxJsqHwvVJyZ9kQnF0bnNUuoo0FwzfnH3UxQ1HKds7Vm6YL
         LrQYlO5C8wZRcC+jC3ePN5zL4KPSLDRWFUzfTXk2SkkdBR7U6tdkphUdYSa+SYIN4UNf
         wCiiplE7mOD993XeYH/FW0g02D6dHRu/kMc0/2kkU7le+vutE6DS3Jh4FcU1faq+mhZ6
         YOuKj+sBfrKtu0Tu75Uo8ZKs+rg79wawTpoa0mxdix6l0/zA/wMEccs7Y0eBl2i63sHx
         BlDA==
X-Received: by 10.180.95.106 with SMTP id dj10mr4253889wib.1.1367456021928;
 Wed, 01 May 2013 17:53:41 -0700 (PDT)
Received: by 10.194.240.135 with HTTP; Wed, 1 May 2013 17:53:41 -0700 (PDT)
In-Reply-To: <1367455791-30091-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223171>

On Wed, May 1, 2013 at 7:49 PM, Felipe Contreras
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

Forgot to mention; inspired by a patch from Ramkumar Ramachandra.

-- 
Felipe Contreras
