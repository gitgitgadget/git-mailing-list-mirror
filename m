From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 2/3] index-helper: convert strncpy to memcpy
Date: Mon, 11 Apr 2016 18:30:54 -0400
Organization: Twitter
Message-ID: <1460413854.5540.24.camel@twopensource.com>
References: <570ADB68.8000705@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 00:31:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apkMJ-0007dI-Ti
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 00:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755063AbcDKWa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 18:30:58 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:35320 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221AbcDKWa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 18:30:57 -0400
Received: by mail-qg0-f46.google.com with SMTP id f105so467510qge.2
        for <git@vger.kernel.org>; Mon, 11 Apr 2016 15:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=DoeJM8o7vW145cy2Fd34dpfE94OnixsxWUDXTTudp7Y=;
        b=dbUToInuBnSCOlqTX/WcpJLSh4eVOnhGVvPdsmoxBa0CAYOyPXZllTC1yUJOrYEtLP
         dDvvYRt491SzfwMEoEv4gSoA9QOjKuxw6+dVCE5joMA4tuucZeZVnrczJAv4fHTbGn5b
         Y0/ihOXXcaNFqgYd+5QAgRciOTjnd9S7kiX5ORsEZ85/U84P7GquFRhBn/EBBxNRQr4T
         zHHAs52dv4AOymC4BDYX/ZrFlJtisUjEfNG2fDJALqAyqcdHnD+0AwhqjOQGl21KdP+Y
         YuL1Bi6GAbltIOOs2ciHSJKQLZzhH8MYZDzif5Jf5KV4U9am/5ClwYHD0lfFTzA4NZti
         YRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=DoeJM8o7vW145cy2Fd34dpfE94OnixsxWUDXTTudp7Y=;
        b=HA6eM06G869xeXPXvQ8IvOhT6qy4b0yMjbY0OsqY/MjR9CJPrhyxPQdBz/rtlAZjVJ
         +x4xH1zm/10X1A9bKj6mFnciZe2hDtnWOkjFVLzAZUfofR0fcxKyvSyJwe2yL38ue+dj
         xBZHxywrjRVk+V828ge8IIx1kv2G8A/HgWJuzdvS0YuzvGFMtkOnzgWkMvBn1HbpOtui
         wpko1rD5uzYNSo7J16h5uJtnUXliqSWjqSyy5yGeNsFfcB1YsMaH24W+ufZvZ6EGlcQA
         diywBHVikAGVvhhT3bW9maeYWRBxcVYRFkSWvXHAPOH5wVxiFvmJHhjiYo1ZwjO3ym5o
         33Jw==
X-Gm-Message-State: AD7BkJI+IhNkCaso9Q+IvpRm1lVMLExbV1XbLBDKU2dZ1K1By9TZPR4yJxoiRHHhXww/2w==
X-Received: by 10.140.101.80 with SMTP id t74mr32069762qge.65.1460413856424;
        Mon, 11 Apr 2016 15:30:56 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id c18sm12117672qgd.49.2016.04.11.15.30.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Apr 2016 15:30:55 -0700 (PDT)
In-Reply-To: <570ADB68.8000705@ramsayjones.plus.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291237>

On Mon, 2016-04-11 at 00:02 +0100, Ramsay Jones wrote:
> see commit eddda371 ("convert strncpy to memcpy", 24-09-2015).
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  index-helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/index-helper.c b/index-helper.c
> index 4a8e2ae..00f286a 100644
> --- a/index-helper.c
> +++ b/index-helper.c
> @@ -317,7 +317,7 @@ static int setup_socket(const char *socket_path)
>  		return -1;
>  
>  	address.sun_family = AF_UNIX;
> -	strncpy(address.sun_path, socket_path,
> sizeof(address.sun_path));
> +	memcpy(address.sun_path, socket_path, len+1); /* include
> '\0' */
>  
>  	if (bind(fd, (struct sockaddr *) &address, sizeof(address)))
>  		die_errno(_("failed to bind to socket %s"),
> socket_path);

Thanks. 

I'm actually going to drop this patch because I'm switching to the unix
-socket.c helpers, so the affected code no longer exists.  But I
appreciate the thought anyway.
