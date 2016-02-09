From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv9 1/6] submodule-config: keep update strategy around
Date: Tue, 9 Feb 2016 13:49:37 -0800
Message-ID: <20160209214937.GG28749@google.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
 <1455051274-15256-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 22:49:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTGAQ-0005TR-0U
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 22:49:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933098AbcBIVtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 16:49:46 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36002 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932360AbcBIVto (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 16:49:44 -0500
Received: by mail-pf0-f177.google.com with SMTP id e127so326801pfe.3
        for <git@vger.kernel.org>; Tue, 09 Feb 2016 13:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VQwP3OuIlEs+UV9YplYFYbuOXmW1QsxMqliNNujdilQ=;
        b=F7781dSWR0p/og3H1/pqEmamSDOYYZrARd2GAM33HQj0EdOuwORZEVOd0Z/QaQXzD5
         8i0PWc26DqKVCpGFXhn3fB0+yWHSTdRB3VL9XCAVveCbuOmhTtwR1RFpHdhth4C7REXq
         JyghaxbU2TpGJwoyFxPxxuYNMw5b1GpXY57tVF3flCKMkSFzJjKBavJc7+UwIanN0Ehy
         T+QgRNnKrZLuckKm6eJXnqrHRKzQ5DoVmh4g3VFAnyI1PnS8Ygu+iDe5M5aKnh2la7yR
         IuH6uZZtEYBHguAb28sf/3UkQGvWEXaon2hnVIbzRScD2yk/LbqLJBIOAISX371/0ncn
         mVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=VQwP3OuIlEs+UV9YplYFYbuOXmW1QsxMqliNNujdilQ=;
        b=ecsuUbcL4ASkKC+1/zEIiSd+dhC84MUlOIOI9brz1ui7gyF9E8b0yQKCYnNt82OoUu
         7N4ePC12wMdLh/EBEGU7s8fDrFkyybmfVihp9A6TigPpfrejPQ97ZwtHHmgMz501R83p
         SjG8JMrkChc1FGGck/qYEHTyVCRI7NYrvIGiXmCvgEJO41SDk7jEmUk/m0raU24ekpa7
         iR+0vZQzCERHJHN1gIuKKOEi1+QEIttNyj7g5nqQjIujPNfLoh8P2TfXx29dksBYkKE4
         PV7uk1o3cUPVXU9DhIEfv93I+b2HERkQNcMZkKoqgWaynmtoVZNhZlDdhUCi3/jtzCk+
         lFiQ==
X-Gm-Message-State: AG10YORB7bWFSNffyJaMq4Ojw8NclMZmbINvQQ8VhIJHkOmXr9p+0njzmnv/a7KRk9gTDg==
X-Received: by 10.98.68.193 with SMTP id m62mr53640955pfi.130.1455054583844;
        Tue, 09 Feb 2016 13:49:43 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:609c:fa:6497:fd10])
        by smtp.gmail.com with ESMTPSA id to9sm49948pab.3.2016.02.09.13.49.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 09 Feb 2016 13:49:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1455051274-15256-2-git-send-email-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285872>

Hi,

Stefan Beller wrote:

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule-config.c | 22 ++++++++++++++++++++++
>  submodule-config.h | 11 +++++++++++
>  2 files changed, 33 insertions(+)

Yay, this is much clearer.  Thanks for indulging.

[...]
> +++ b/submodule-config.c
[...]
> @@ -311,6 +313,26 @@ static int parse_config(const char *var, const char *value, void *data)
> +			else if (!skip_prefix(value, "!", &submodule->update_command))
> +				die(_("invalid value for %s"), var);

Should this say
			else if (skip_prefix(value, "!", &submodule->update_command))
				submodule->update = SM_UPDATE_COMMAND;
			else
				die(...);

?

[...]
> --- a/submodule-config.h
> +++ b/submodule-config.h
> @@ -4,6 +4,15 @@
>  #include "hashmap.h"
>  #include "strbuf.h"
>  
> +enum submodule_update_type {
> +	SM_UPDATE_CHECKOUT,
> +	SM_UPDATE_REBASE,
> +	SM_UPDATE_MERGE,
> +	SM_UPDATE_NONE,
> +	SM_UPDATE_COMMAND,
> +	SM_UPDATE_UNSPECIFIED
> +};

If _UNSPECIFIED is equal to 0, that would futureproof this better
against zero-initialized submodule structs without ->update explicitly
set.

After those two changes and the whitespace change Junio suggested,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
