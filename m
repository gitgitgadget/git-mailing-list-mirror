From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] repack: Add --version parameter
Date: Thu, 26 Sep 2013 05:17:42 -0500
Message-ID: <CAMP44s0E7=fupwfe=rm9yETmzdjFyH8vuyWY=Ce4wKg=g4-iJg@mail.gmail.com>
References: <1380162409-18224-10-git-send-email-pclouds@gmail.com>
	<1380184349-26380-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>,
	git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Sep 26 12:17:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VP8do-0001a8-3W
	for gcvg-git-2@plane.gmane.org; Thu, 26 Sep 2013 12:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756357Ab3IZKRo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Sep 2013 06:17:44 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:34806 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755578Ab3IZKRn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Sep 2013 06:17:43 -0400
Received: by mail-la0-f46.google.com with SMTP id eh20so743375lab.33
        for <git@vger.kernel.org>; Thu, 26 Sep 2013 03:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CWDLgtXsWcEU4a1DNFTJp9RoJQHmygoUlzW9rf6jLMM=;
        b=IM6ur1CEtRAQZarjRQL7fPBF0DLuTih683LTSzID5qSUqGlJv7//MskBI74pINL73K
         haiDTwNrzYtjmaQUDvfhMpxgniY2jeUe8HykMYeX80bs9NgmqYgLNFm+iR2bqAwNIAQ1
         KRy/OZhnXc7JXtlPbfVn9mP+k3/jI5Vxl8tm726QCWw8GfQ2W3xqZD4rRtDaLI6IS5CO
         7jsR6W1Qi5Q3v992bp/ZrJZrfLiY1iKBvq6Nw76nUBWGIWrp8kdF+RJwuYvx+br0dvKP
         sQl5otN0JNe/nZjsvekTpxIlFjigBy1dEXyPLhPPtp3Z9xwRzOaYSisDj+MUOhpdOvkK
         jEjQ==
X-Received: by 10.152.30.6 with SMTP id o6mr56151lah.33.1380190662434; Thu, 26
 Sep 2013 03:17:42 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Thu, 26 Sep 2013 03:17:42 -0700 (PDT)
In-Reply-To: <1380184349-26380-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235413>

On Thu, Sep 26, 2013 at 3:32 AM, Stefan Beller
<stefanbeller@googlemail.com> wrote:
> This is just a direct translation of
> http://article.gmane.org/gmane.comp.version-control.git/235396
> So I don't consider this is ready for inclusion.
>
> Some notes:
> We need to have more error checking, repack shall be 0, 2 or 4 but nothing
> else. If 0 is given, no argument is passed to pack-objects, in case of
> 2 or 4 --version=<n> is passed.
>
> Do we really want to call it "--version"? This parameter sounds so much
> like questioning for the program version, similar to
>         git --version
>         1.8.4
> So I'd rather use "--repack-version".
> ---
>  builtin/repack.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 3e56614..fd05e9a 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -9,6 +9,7 @@
>  #include "argv-array.h"
>
>  static int delta_base_offset = 1;
> +static int pack_version;
>  static char *packdir, *packtmp;
>
>  static const char *const git_repack_usage[] = {
> @@ -22,6 +23,9 @@ static int repack_config(const char *var, const char *value, void *cb)
>                 delta_base_offset = git_config_bool(var, value);
>                 return 0;
>         }
> +       if (!strcmp(var, "core.preferredPackVersion")) {
> +               pack_version = git_config_int(var, value);
> +       }

The style is without braces if the block is a single line.

-- 
Felipe Contreras
