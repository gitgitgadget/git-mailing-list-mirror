From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Mingw: verify both ends of the pipe () call
Date: Fri, 28 Aug 2015 11:14:16 -0700
Message-ID: <xmqqtwrj1ds7.fsf@gitster.mtv.corp.google.com>
References: <0000014f6fdf5839-19f5bc24-80bf-4b9e-a26b-2ef089a28f06-000000@eu-west-1.amazonses.com>
	<0000014f73b0e4ef-12b105a6-5f9c-4131-956f-97a1bd85e072-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, "Jose F. Morales" <jfmcjf@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 28 20:14:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVOAR-0002LH-8y
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 20:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbbH1SOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 14:14:19 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33991 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751693AbbH1SOS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 14:14:18 -0400
Received: by pabzx8 with SMTP id zx8so70126943pab.1
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 11:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=bjTMIFjDoWpkHjBVXBolLFcVjL7iaVJWmQBziYYfATc=;
        b=QULWMHLvNwSKGRy1mHDNf+3QIeZACFPYacVbSsdqp22w+/aHlx/8solNhwaNOkOewG
         5cVP0gwNS8JCk9jRUeIOO7pcA+bqQjP5oA7P6JEoqCEcCWo07G2uvUgMMu2eKqL4Z3CM
         C0c9X9peXjV46Pqt5cJ44VkrEMyHxqEdUIxcos8FZrVV+BuhRwKTX6d5IeEwJCYFbuRO
         A4PbbAMQ49V7Cy3bly6kDHoXgzQgrEl0Cl2znGOunXaxe2cka9pDA6Z6OObjVnH+yBoH
         LzkEs+LGxxADxeWes47gGiDuPRy8bh1fFUyJPPxQsFHoH7Mj5zLMW330n9qomObhenx4
         HnkQ==
X-Received: by 10.66.252.131 with SMTP id zs3mr16973676pac.75.1440785658250;
        Fri, 28 Aug 2015 11:14:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c919:3f20:8560:5a06])
        by smtp.gmail.com with ESMTPSA id fe8sm6472064pab.40.2015.08.28.11.14.17
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 28 Aug 2015 11:14:17 -0700 (PDT)
In-Reply-To: <0000014f73b0e4ef-12b105a6-5f9c-4131-956f-97a1bd85e072-000000@eu-west-1.amazonses.com>
	(Johannes Schindelin's message of "Fri, 28 Aug 2015 09:43:37 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276743>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> From: Jose F. Morales <jfmcjf@gmail.com>
>
> The code to open and test the second end of the pipe clearly imitates
> the code for the first end. A little too closely, though... Let's fix
> the obvious copy-edit bug.
>
> Signed-off-by: Jose F. Morales <jfmcjf@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/mingw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 496e6f8..f74da23 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -681,7 +681,7 @@ int pipe(int filedes[2])
>  		return -1;
>  	}
>  	filedes[1] = _open_osfhandle((int)h[1], O_NOINHERIT);
> -	if (filedes[0] < 0) {
> +	if (filedes[1] < 0) {
>  		close(filedes[0]);
>  		CloseHandle(h[1]);
>  		return -1;
>
> --
> https://github.com/git/git/pull/168

Thanks all.  Will queue directly on 'maint' with reviewed-by's and
acked-by's.
