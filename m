From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] introduce git root
Date: Mon, 1 Dec 2014 05:17:22 +0100
Message-ID: <CAP8UFD2jES1i+6zOt1gXqTWFy1UHu2GBwAisQktd_Ymbj9Db2g@mail.gmail.com>
References: <1417291211-32268-1-git-send-email-arjun024@gmail.com>
	<2AC7B765F56B4AA8A0DB76E8C670A889@PhilipOakley>
	<CAJFMrCEciWXhBb36MVeFPi7Y7D=9zQ2xGPpiyUz9y4_hOh_taw@mail.gmail.com>
	<vpqoaro99xd.fsf@anie.imag.fr>
	<xmqqd284rryz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Arjun Sreedharan <arjun024@gmail.com>,
	Philip Oakley <philipoakley@iee.org>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 05:17:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvIQR-0001m0-Na
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 05:17:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566AbaLAERX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2014 23:17:23 -0500
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34565 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752421AbaLAERX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 23:17:23 -0500
Received: by mail-ie0-f175.google.com with SMTP id x19so3509740ier.6
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 20:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5Emq7x+ZlpiqBP6FYJkHAXqmDzvIPh+GIVAbP91B2+c=;
        b=osxRM5edm7ZXLixEg+VkrgRpWGDtDwR4YlUDQqEEvARnp0h+FBsYShztgLujbXa0L1
         5ZtfzRXLpJMeIIuUNPwx4bPCrXoUUf013UWXEczX9sy4AtbAPi6qATDlqk20k8prv8fc
         G+cboHZN9pfRhM0LomzXsljNR0xIJUb5XWs4I0UlX9C2O4MkynIrIiYxATCtQw2H68Id
         v/4BZhxPM89yoGi5DfhdQ+3+GzkAi+eFirUhyTgdTYTXxmpW/VnbFCqCzNADEqwxWCYc
         vdo79CIRQZW37DEWeqdlGAXuLmJoLJeix34mj7hsXsHMc/flTzFS9AuXxLAsr7N9YKUC
         tZgg==
X-Received: by 10.42.155.197 with SMTP id v5mr44344183icw.52.1417407442682;
 Sun, 30 Nov 2014 20:17:22 -0800 (PST)
Received: by 10.50.30.40 with HTTP; Sun, 30 Nov 2014 20:17:22 -0800 (PST)
In-Reply-To: <xmqqd284rryz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260468>

On Mon, Dec 1, 2014 at 4:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> If I were redoing this today, I would probably nominate the "git"
> potty as such a "kitchen synk" command.  We have "--man-path" that
> shows the location of the manual pages, "--exec-path[=path]" that
> either shows or allows us to override the path to the subcommands,
> and "--show-prefix", "--show-toplevel", and friends may feel quite
> at home there.

I wonder if we could reuse "git config" which is already a "kitchen
synk" command to get/set a lot of parameters.
Maybe we could dedicate a "git" or "virtual" or "proc" or "sys" (like
/proc or /sys  in Linux) namespace for these special config parameters
that would not necessarily reflect something in the config file.

"git config git.man-path" would be the same as "git --man-path".
"git config git.root" would be the same as "git rev-parse --show-toplevel".
"git config git.exec-path mypath" would allow us to override the path
to the subcommands, probably by saving something in the config file.

If we wanted for example to try just once a special exec-path we could use:

git -c git.exec-path=/path/to/git-foo foo

Best,
Christian.
