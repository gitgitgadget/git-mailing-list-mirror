From: Niek van der Kooy <niekvanderkooy@gmail.com>
Subject: Re: Issue when changing staged files in a pre-commit hook
Date: Tue, 19 Jan 2016 12:53:55 +0100
Message-ID: <CAPYEnzFLD8z3KXA7yWxaQss22VhcuL2Oc-=D_Qxs-s0q+pQ-mg@mail.gmail.com>
References: <CAPYEnzGfnRbajDQAwBTNE5XSaB0WbHKbf1heRV0bUgbq5w_A5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 19 12:54:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLUrd-0004kF-Gh
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 12:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464AbcASLyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 06:54:18 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36001 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbcASLyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 06:54:16 -0500
Received: by mail-lf0-f43.google.com with SMTP id h129so142346486lfh.3
        for <git@vger.kernel.org>; Tue, 19 Jan 2016 03:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=kpqV3aOJbKRElv7D9862WD8mDELDupcVhi0dBxW7nXw=;
        b=kmorQMTgjHrc5HagrkqukB/vxnDr4ucCUycoWzYXfv7urfH4ac+N0vnqDlssXEXW8f
         psA/2lXenQOXraqlf2QRFKjuZff5Znt8NhDp12BMiI+ewZR/hFpDa1111tjCFvk+BzK5
         oBwAzlksQUmfLsN/hAaNjoemIeEQ+Lp8FCIxbV+l7zdNeLaIWMM+Nc4kcaP1w3ltsa4U
         vYX0nWlaF3jRSaU6vIXrJ4+rIjKDVJZk037Lms/VN5WHwLkLhzhNaXxUkKjyHkFDogsj
         e3L8AQyv//5ptvPJ6zO35vrPlP7Z9n9AuCyNq06mtsR+O/E4e6LC7PvBX5iVxPXGSOG6
         vH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type;
        bh=kpqV3aOJbKRElv7D9862WD8mDELDupcVhi0dBxW7nXw=;
        b=muhUsViPZ8Iwm9JrLD4sWzhkMfzBsQeGFXK6XWEK0I3PG40VJg9W11hlxpaerrt228
         m7Xh1JrEOHY7jd+pd04CrS9ksxyVdiP7YdBcHTUdRSu76IWCXSH+O3rOhMJlbIhD4u6e
         5Yrye6aS9B9na4hJ4YbDMQuhaGTjreZZ5z9RpdJKRqSq5t83MXl7v4nEZjRPfhWbGC3b
         bX5qw7fAq7X5OTSHMrREdtrpGtAxe1vrJf1hwEwubXuJU+Va/Wp7ItL+Wf4TYZHd0MuE
         ZAYZKYme4aIzmIQzdMurdL4nj0buixLZtJyMSrxIccMo8Lz7TAQsxbM4tTpfp0E/QT4b
         YK8w==
X-Gm-Message-State: ALoCoQkXvSnNd42q7ydeHvJv6awulFkBtU577pebIquhqRo0uyTRF25nxTo/JpPFa3fJy4P8aTDxjyacRcVEqnqchP7inx3Meg==
X-Received: by 10.25.18.89 with SMTP id h86mr8524404lfi.165.1453204454789;
 Tue, 19 Jan 2016 03:54:14 -0800 (PST)
Received: by 10.25.198.3 with HTTP; Tue, 19 Jan 2016 03:53:55 -0800 (PST)
In-Reply-To: <CAPYEnzGfnRbajDQAwBTNE5XSaB0WbHKbf1heRV0bUgbq5w_A5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284356>

A few weeks ago I sent below email, and was wondering if anyone can
either confirm this as a bug or tell me the correct way to approach
the problem.

Regards,
Niek van der Kooy

On 28 December 2015 at 13:17, Niek van der Kooy
<niekvanderkooy@gmail.com> wrote:
> I am having an issue where the default commit message is not changed
> when adding staged files in a pre-commit hook.
> Please see http://stackoverflow.com/questions/34492779/git-update-git-status-part-of-commit-message-after-pre-commit-hook
> for details.
>
> Is there a workaround / proper way to achieve what I am trying to do,
> or is this a bug?
>
> Regards,
> Niek van der Kooy
