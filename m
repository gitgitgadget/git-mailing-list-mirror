From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2] refs.c: enable large transactions
Date: Tue, 21 Apr 2015 12:56:34 -0700
Message-ID: <CAGZ79kYyvRb=T5JFp7-DL1HiAm2rUTDuGi-0UZG-F5iGHBOorA@mail.gmail.com>
References: <xmqqpp6xgy50.fsf@gitster.dls.corp.google.com>
	<1429643171-27530-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 21 21:57:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkeHw-00040R-UD
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 21:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933250AbbDUT4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 15:56:44 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:34822 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933239AbbDUT4f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 15:56:35 -0400
Received: by iejt8 with SMTP id t8so22255462iej.2
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 12:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VSiNyx3YEFdh52RsPRqaQPN0fORpzyLFwj4/ofFSd9c=;
        b=g13FfXRqVBfr5riLfipilx4dUaQK2IvH0oE4FUczn8TEJBC7pgtK+4Yd4UB+UK16hQ
         +IThmur/hqP7brCDrYJo8dnrCK7B7eJkt/19u6yt76iGYYp3GrP49RuO3IT6vc1XImgD
         AhjVQwN1RO12BazhYp93WSuByn+PMFgriNpMC8kIG3vg61FSda1t50jsvDyFafpB9OW3
         TMg8PdCnaRnWTYoe+TRgrDG8syDxL8NY01EvodAB9EvwW6tN1eFNG7DsLBLr/HCFlPO0
         NMZY+vuYaWCL1j3Jk5P8KQvWQd4NoeX/hX83jiL9ilNgoTWuUF02TlN1e3Y5Q4/e/SZP
         4WeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=VSiNyx3YEFdh52RsPRqaQPN0fORpzyLFwj4/ofFSd9c=;
        b=al/FHgSXd8IqD3mOf7E5dF6zZjptQaxq/eNkQ8ROgphVvLIFWGPI71LmYnl56THjKe
         b8RHAv4fYxjz7QVgbd0zfFbeJzZEht1xW+R7/cK6xrKEu6J6tMZKLW51Tf1GUVRBZxTa
         5BoIFRCOJv9WtW6t8OlgMdMsAZpHMmpvrrRK0t/xB4XPMpx9k6T2ywrm15Z98+E56TCh
         llrxlvUUNyzcYXCjxNicC9MTKhfx/t+CFJjtParnEf57qjiPezHTnWtBcICkcl4Kl5Va
         beh74nnSWH0D/kvUvEq2RAYl5+/C3gbvqx7ixJhdap+UyJEl6bVirSWmmcoTwnlTmA47
         RUhg==
X-Gm-Message-State: ALoCoQmfMkYLi/RQKipjhM29qiMuG+LInPpIe5p8KWnfZz6n+wvZhjaQmTgbS6tAMqUBcT196xaa
X-Received: by 10.107.170.135 with SMTP id g7mr31941388ioj.2.1429646195023;
 Tue, 21 Apr 2015 12:56:35 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Tue, 21 Apr 2015 12:56:34 -0700 (PDT)
In-Reply-To: <1429643171-27530-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267551>

>
> * Removed unneeded braces in the condition to check if we want to close
>   the lock file.
> * made the counter for the remaining fds an unsigned int. That is what
>   get_max_fd_limit() returns, so there are no concerns for an overflow.
>   Also it cannot go below 0 any more.
> * moved the initialisation of the remaining_fds a bit down and added a comment

* Once again this replaces the last patch on top of
origin/sb/remove-fd-from-ref-lock
