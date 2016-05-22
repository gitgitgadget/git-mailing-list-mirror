From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 1/9] connect: document why we sometimes call get_port
 after get_host_and_port
Date: Sat, 21 May 2016 22:40:21 -0400
Message-ID: <CAPig+cQPpX7w7gJc_F_Jz=1PpiK_Q+tSSBrCwmhW84QuwX20kw@mail.gmail.com>
References: <20160521231732.4888-1-mh@glandium.org>
	<20160521231732.4888-2-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun May 22 04:40:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4JJd-0004am-Qw
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 04:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbcEVCkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2016 22:40:22 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:32849 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbcEVCkW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2016 22:40:22 -0400
Received: by mail-io0-f176.google.com with SMTP id t40so81622658ioi.0
        for <git@vger.kernel.org>; Sat, 21 May 2016 19:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=koK5dNIhWZ/H7TkZsRCM+zfDU7cBkFJMVhISaBD29d4=;
        b=fskP3dyPRFkYUrY5C6B3NzoPep0GNejD2TEwR3eBw+PKo7sOkkKiFb+eK7sQM3mnXh
         2CJK/iRG38WcUYnsDgCa6/EDuPG7g3QYAOAm7HxbKWZ8gWcmOJuxEct1MRIeXVpAk0ml
         tVOA0hRj7bEbuSUZ7vL1l5uy/K8lw7mf4t/a74N1C5YNZLc0No9wZUVj6dI+5tUJ8TBN
         nk/ajIsIi1Ir+zZ9EZkgodEIxImLjN8qAKsYZ8/wNhIaxtFat9Qwtd/aqK6z8DJC50+/
         fDf+TRjdFl51mcG149c7cBRNN0KeiiHBGQqPml+lMC3VnmHY6tAEHCne/Uz8GGZZap+I
         HDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=koK5dNIhWZ/H7TkZsRCM+zfDU7cBkFJMVhISaBD29d4=;
        b=VVRTl6e3cDVHm/7JZ4CZZ96Qapuohd4h+Ln0lxM89T08pDIuk8PwL/j9cS/1+P0fxK
         02iHW+I5Q4HIT9xS0lmd8VmjAOp/u7qf0sex+2r7+g/kZ2WStlV6MRPsnW0993Hc7y4L
         QABOiPDc8BJeLB7CAW/oMoFjiTMfCqnDuGEbEZREAZGUd0CSPTCuQIlCHF8cTNpJPl45
         bBoQaoYLuFb48pvBHW5s/bRQzRGQ2VDrCaFRPEpKgkj1B0lY6VqBjsbxksdbh4LLawlB
         OlBSlvicvVTfAHo3OqDP0oJPDspnSs+Ai+XuDJRCYUEUIrwJKspg8WQBHvq09aZZHJ7h
         n4wA==
X-Gm-Message-State: AOPr4FUOWzeqeTUX+nTMfAvKnQQU5t5vPNq4fh8Mrr71mJWM6umYYGqt5+PFcJY/9/mzmSBigIzIUaP7DI7bZA==
X-Received: by 10.107.47.37 with SMTP id j37mr7670481ioo.168.1463884821229;
 Sat, 21 May 2016 19:40:21 -0700 (PDT)
Received: by 10.79.139.135 with HTTP; Sat, 21 May 2016 19:40:21 -0700 (PDT)
In-Reply-To: <20160521231732.4888-2-mh@glandium.org>
X-Google-Sender-Auth: aIEmOKDJM5mXWGHl1JhnVLBCt84
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295256>

On Sat, May 21, 2016 at 7:17 PM, Mike Hommey <mh@glandium.org> wrote:
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
> diff --git a/connect.c b/connect.c
> @@ -742,6 +742,12 @@ struct child_process *git_connect(int fd[2], const char *url,
>                         transport_check_allowed("ssh");
>                         get_host_and_port(&ssh_host, &port);
>
> +                       /* get_host_and_port may not return a port even when
> +                        * there is one: In the [host:port]:path case,
> +                        * get_host_and_port is called with "[host:port]" and
> +                        * returns "host:port" and NULL.
> +                        * In that specific case, we still need to split the
> +                        * port. */

Style:

    /*
     * This is a multi-
     * line comment.
     */

>                         if (!port)
>                                 port = get_port(ssh_host);
