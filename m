From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: race condition when pushing
Date: Thu, 5 Nov 2015 18:00:33 -0500
Message-ID: <CAPig+cSGSe=7PY7HVuAdy=4chbkkACiEBZzvDA4AktMKFiRfPw@mail.gmail.com>
References: <SNT153-DS223275FC4D60A266EE7E28F6290@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git bug report <git@vger.kernel.org>
To: Lyle Ziegelmiller <lyle_z@hotmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 00:00:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuTWJ-0007Cz-2e
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 00:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756658AbbKEXAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 18:00:34 -0500
Received: from mail-yk0-f174.google.com ([209.85.160.174]:34936 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752962AbbKEXAd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 18:00:33 -0500
Received: by ykek133 with SMTP id k133so159796283yke.2
        for <git@vger.kernel.org>; Thu, 05 Nov 2015 15:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=If2gUm9lW1yxcRMBcl6JoI6GBQC7Kq53jo9iB6UtC1E=;
        b=q+9eg1PCJ9s/uqoxNrh8iKSx4oGXtKqCOwQCxuLwTyWMtRmSz3HkLotOjJloWghcgb
         9rmD1am9D2ly6LcRzD9thcu74INGLXNX0j0xJ8LVgKknpvB+XKgZTVJJBwgHCp6PrF1v
         NTEl+KTcF5FMqS72iLnyw2gOcJEjZoh/szfbKqXqtrkAGCdKcit7amaB6v1TYxqqVTfJ
         dnIRMyka6Nvh/V5sPpegv/VcFpzzIUnCku4cVXF0fS/V4WPQIy+CwJwrCrdpryAhJgPF
         TtFZB0xDnF7DrEDo2kTa0hWFg7zr7+yRf6+Fsi6LzFZygMmNkTE+kYKXk1ZRxeXJqe03
         82Xw==
X-Received: by 10.31.56.75 with SMTP id f72mr9564891vka.115.1446764433312;
 Thu, 05 Nov 2015 15:00:33 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Thu, 5 Nov 2015 15:00:33 -0800 (PST)
In-Reply-To: <SNT153-DS223275FC4D60A266EE7E28F6290@phx.gbl>
X-Google-Sender-Auth: wQbhYaILn70pNkRDppMo8nWr4ck
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280944>

On Thu, Nov 5, 2015 at 11:11 AM, Lyle Ziegelmiller <lyle_z@hotmail.com> wrote:
> git push --set-upstream  has some sort of race condition. Some times when I
> execute it, it works. Other times, it does not. Below is from my command
> window. I've executed the exact same command (using bash history
> re-execution, so I know I didn't make a typo), repeatedly. Notice the last
> execution results in an error. I am the only person on my machine. This is
> non-deterministic behavior.
>
> lylez@LJZ-DELLPC ~/gittest/local
> $ git push --set-upstream origin localbranch1
> Branch localbranch1 set up to track remote branch localbranch1 from origin.
> Everything up-to-date
>
> lylez@LJZ-DELLPC ~/gittest/local
> $ git push --set-upstream origin localbranch1
> Branch localbranch1 set up to track remote branch localbranch1 from origin.
> Everything up-to-date
>
> lylez@LJZ-DELLPC ~/gittest/local
> $ git push --set-upstream origin localbranch1
> error: could not commit config file .git/config
> Branch localbranch1 set up to track remote branch localbranch1 from origin.
> Everything up-to-date
>
> I'm using Git in a Cygwin window on a 32-bit Windows 10 machine.

If I recall correctly, the typical culprit is a Windows virus scanner
(or even an indexer) locking the file, so git is unable to manipulate
it.
