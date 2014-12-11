From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] added git-config support for diff.relative setting
Date: Thu, 11 Dec 2014 20:37:16 +0700
Message-ID: <CACsJy8CBRzbVrKnKPACuqxLw2N3PiK2O2nE4-C_3jfEp6-2p=g@mail.gmail.com>
References: <548947A0.7000608@shysecurity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Kelson <kelson@shysecurity.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 14:37:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xz3wG-000607-QV
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 14:37:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932802AbaLKNht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 08:37:49 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:55916 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932159AbaLKNhs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 08:37:48 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so4762986iec.22
        for <git@vger.kernel.org>; Thu, 11 Dec 2014 05:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8YGZE/uA3tlO2bnxuwfCghiJ3RPAJHBHJcw0zL8qIpU=;
        b=q9dR8OtfNcB7YhabzJ69flpVSo55gqxUkuDJ9JJ6wJvKcwdLLbmYtIp+l4AXnEPEvg
         5/lc/ATpB1xJPhsd5KULsmdcQEkEjEyT/CMVnWPwtaLyt/Njtk7i9OmVR20aZY/hsf56
         /rXvqH20OhgcCWDowoxyIOvQQGUjgtpOqYFE0E6buZTeg19Ea7n9EngKWYVw6+yub3mi
         iCfpqUTRxNJiYFSp7gpZetcNmdnv2s7PcVmrW6sI8cZG53kjbIw82AubG6PZAkS0gOsf
         iRkbQrEqQ/C+h4cwTjI9AUW3nARcgoace1q0LZEXJbtQgJDY2F9OViTmWKyDnl3H9Zom
         WdtQ==
X-Received: by 10.50.171.194 with SMTP id aw2mr13631693igc.25.1418305066232;
 Thu, 11 Dec 2014 05:37:46 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Thu, 11 Dec 2014 05:37:16 -0800 (PST)
In-Reply-To: <548947A0.7000608@shysecurity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261277>

On Thu, Dec 11, 2014 at 2:28 PM, Kelson <kelson@shysecurity.com> wrote:
> @@ -270,6 +270,14 @@ int git_diff_basic_config(const char *var, const char
> *value, void *cb)
>                 return 0;
>         }
>
> +       if (!strcmp(var, "diff.relative")) {
> +               if (git_config_bool(var, value))
> +                       DIFF_OPT_SET(&default_diff_options, RELATIVE_NAME);
> +               else
> +                       DIFF_OPT_CLR(&default_diff_options, RELATIVE_NAME);
> +               return 0;
> +       }
> +
>         if (starts_with(var, "submodule."))
>                 return parse_submodule_config_option(var, value);
>

This affects more than just git-diff. git_diff_ui_config() may be a
better place.
-- 
Duy
