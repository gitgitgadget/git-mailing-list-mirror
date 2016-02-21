From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] t9200: avoid grep on non-ASCII data
Date: Sun, 21 Feb 2016 16:15:31 -0500
Message-ID: <CAPig+cQkcUPD5+0rUPkKCcJSzRC0NkuRYKHmW54eZ041PqaqmQ@mail.gmail.com>
References: <20160219193310.GA1299@sigill.intra.peff.net>
	<cover.1456075680.git.john@keeping.me.uk>
	<42c95c23bffcbb526aaae302f80667867d164876.1456075680.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Feb 21 22:15:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXbLt-0007yl-6m
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 22:15:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752112AbcBUVPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 16:15:33 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33482 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbcBUVPc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 16:15:32 -0500
Received: by mail-vk0-f41.google.com with SMTP id k196so115244790vka.0
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 13:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=o4FiDLnuv4E9OQ4zldHyCC8Uf1fpYAVqvoPAjKPBFIA=;
        b=EwsRE8zeChdBNvDqNvUpkjWI1FEXhQqkuaA5wEeigcspBqeYfd173ooUMsr0wYV1Ly
         DYLGF1b7YnFzrlmgY6njHLiM5fdgkEDWR9YjR6wmICGgYb8lA4mkQxVZcNBSyokAF1kA
         P6wQ7cEPI/4yIl97sutdUfNmY9kdJlruYeM5GmSt+m4g58kLGSXk8wNXXzjGFtsCtk1w
         Re/kkKodx4NLaRcKW35qeNuJ0d79gjwFDG8O0kQbr4v2hRFGjzu/tpa2xuz3M5b/69gN
         /tIPT1ZMdrrm5XH0K+s2Wfltjh49r6St/KMxYp0AofoN6C8USlWMESs98vgvaV9yEsss
         naWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=o4FiDLnuv4E9OQ4zldHyCC8Uf1fpYAVqvoPAjKPBFIA=;
        b=ktpYe59QACdLIIghii/D0SEZPxkMdZa3HNImrdeYtJNu9sdHK8LtF9cwGlkA3EZjAo
         7rankb8SKTxp7p+lbCpAv6YAPi9FtFKQQNaETErppGXMTDKm/5+0knG9FRdAd+bsXvu9
         MCmOSXWDuhuKFdOuuViB7O4bpOthfPJ108u9h2BxO7wqxJ3dLzpi/xo/FmppaSC+IBgW
         XeyE5HYV+bJLgTVTky/VhF1PTjoxej+YUgaIeJ3V9i2nUz2rEhgwaMH/IbNy1LWGSue/
         GCYYIgu4zbZYR/xbWwDCtm52vLRouYabDmmgGukUdTxr6UYyTzSwtJQph0lTKz0z2AnP
         UuKA==
X-Gm-Message-State: AG10YORHasYt6AcMEwmPUImyz2NtxbzJs7aj7lCdZ5Q26wrMak6JSebgESvK2MdGNhw0k/0TwNrjbNehw2TNZw==
X-Received: by 10.31.182.143 with SMTP id g137mr20118867vkf.45.1456089331970;
 Sun, 21 Feb 2016 13:15:31 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 21 Feb 2016 13:15:31 -0800 (PST)
In-Reply-To: <42c95c23bffcbb526aaae302f80667867d164876.1456075680.git.john@keeping.me.uk>
X-Google-Sender-Auth: E3y0G85LSD0GWINoUF_7e_soYM4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286831>

On Sun, Feb 21, 2016 at 12:32 PM, John Keeping <john@keeping.me.uk> wrote:
> GNU grep 2.23 detects the input used in this test as binary data so it
> does not work for extracting lines from a file.  We could add the "-a"
> option to force grep to treat the input as text, but not all
> implementations support that.  Instead, use sed to extract the desired
> lines since it will always treat its input as text.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
> diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
> @@ -35,7 +35,7 @@ exit 1
>  check_entries () {
>         # $1 == directory, $2 == expected
> -       grep '^/' "$1/CVS/Entries" | sort | cut -d/ -f2,3,5 >actual
> +       sed -ne '\!^/!p' "$1/CVS/Entries" | sort | cut -d/ -f2,3,5 >actual

This works with BSD sed, but double negatives are confusing. Have you
considered this instead?

    sed -ne '/^\//p' ...

>         if test -z "$2"
>         then
>                 >expected
