From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/5] safe_create_leading_directories(): reduce scope of
 local variable
Date: Thu, 26 Dec 2013 13:55:59 -0800
Message-ID: <20131226215559.GX20443@google.com>
References: <1387696451-32224-1-git-send-email-mhagger@alum.mit.edu>
 <1387696451-32224-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Dec 26 22:56:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwIuY-00034y-96
	for gcvg-git-2@plane.gmane.org; Thu, 26 Dec 2013 22:56:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503Ab3LZV4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Dec 2013 16:56:05 -0500
Received: from mail-gg0-f170.google.com ([209.85.161.170]:35638 "EHLO
	mail-gg0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532Ab3LZV4D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Dec 2013 16:56:03 -0500
Received: by mail-gg0-f170.google.com with SMTP id 24so1819717gge.1
        for <git@vger.kernel.org>; Thu, 26 Dec 2013 13:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WkiaC77qSYw3ZW5F1/YuFpmgoPE8tZC/V85iQm7v34k=;
        b=NYwohoJl9siHmk7GGF1IUDuxLf2kOOJySbsarj/PcvqW6nTzBEsnYoSi+h4zZPI7Fh
         e5eQPLsOrvUBRyBpJuaGIA0gPL2h1alWU1Uc/w6CVRes270lj3B8z2jESJOsDvvPsuT6
         YkNildmzhldH6mmRaWdYCO2vywai7ZJjbKHmaZpwmJSgJW800o9fPCPxRzprOaXPi68Y
         YvsOLxeuGNF6/KHy6HYMJH4iSzjZkBW1hVZdWNvqA/HNG9VFZTuMAowQb3ppUj9YM4PS
         eRhEXa3WITypyTJ1J3LCCrzntrv1qtbkVIv6EikT1RYCgiXzUXfbemHJyxb7qHjfGaO5
         W4XQ==
X-Received: by 10.236.24.196 with SMTP id x44mr6509977yhx.92.1388094962693;
        Thu, 26 Dec 2013 13:56:02 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id f78sm43467168yhp.12.2013.12.26.13.56.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 26 Dec 2013 13:56:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387696451-32224-3-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239715>

Michael Haggerty wrote:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  sha1_file.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sha1_file.c b/sha1_file.c
> index c9245a6..cc9957e 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -108,9 +108,10 @@ int mkdir_in_gitdir(const char *path)
>  int safe_create_leading_directories(char *path)
>  {
>  	char *pos = path + offset_1st_component(path);
> -	struct stat st;
>  
>  	while (pos) {
> +		struct stat st;

Is this to make it easier to reason about whether 'st' has been
properly initialized at any given moment, or is there a more subtle
reason?

Curious,
Jonathan
