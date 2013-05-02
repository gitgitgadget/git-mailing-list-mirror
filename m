From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] sha1_name: reorganize get_sha1_basic()
Date: Thu, 2 May 2013 13:02:48 -0500
Message-ID: <CAMP44s1mm-uEnVQSwN5ORy8kqe9q7w_PKGYgOhKHcXbbkAtkUQ@mail.gmail.com>
References: <1367516919-4735-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 02 20:03:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXxqI-0007O9-Jl
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 20:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296Ab3EBSCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 14:02:50 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:41824 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760354Ab3EBSCu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 14:02:50 -0400
Received: by mail-la0-f48.google.com with SMTP id eg20so796040lab.21
        for <git@vger.kernel.org>; Thu, 02 May 2013 11:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=a09u8cGOhsoJA/H3uyVxsVzQDqC4POkl3GGZO0d2eRw=;
        b=rv4xfRC59IYFyLQRhsWX2jZOMbCih/MXg0zpCyx12WyRWMQ/5mBh0TNt6CKOJVowUh
         DsU4BR9wM0fAU3zswHnRsg6bmdYD1sOfLKY6NckpU9a+ScrvLVPz8CsbHSdoQZTZ76jW
         8sMwtP2LQmXVxJ37S3YqdXkF+6s7nY/p+XtGsZPyhgE1JvX1Nw1kOy3/hIeWU0p5UwGR
         vhmLJfsx2O2mWgDN/4BNyF9KykooIONStRznXVl40KZyl9C97WIaNCiOK2nssJzFjcbu
         hQZk0VPeKYZLXth3AsXCbOjiXCqHnmvXg4rklqTFCBC1SLqPOGYb1V0dinR5CaQxXHc+
         aKvg==
X-Received: by 10.152.22.168 with SMTP id e8mr2929703laf.20.1367517768422;
 Thu, 02 May 2013 11:02:48 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 2 May 2013 11:02:48 -0700 (PDT)
In-Reply-To: <1367516919-4735-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223243>

On Thu, May 2, 2013 at 12:48 PM, Felipe Contreras
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

Forgot again: Inspired by a patch from Ramkumar Ramachandra.

-- 
Felipe Contreras
