From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: [PATCH] TIG: Fix to reinstate proper operation with no arguments
Date: Fri, 19 Jul 2013 07:55:04 -0400
Message-ID: <CAM9Z-n=_vV2+TOXqj_p+wbuFVX8DEU8p_NtytqGepziLdJeong@mail.gmail.com>
References: <1374123113-3889-1-git-send-email-n1xim.email@gmail.com>
	<51E7EDE3.4080205@gmail.com>
	<CAFuPQ1K=hWUSCEhaGsuW8PeoGQcj6AoPo61zUTDbjLE802h+7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Jul 19 13:55:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V09HG-0000gr-0W
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 13:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760237Ab3GSLzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 07:55:07 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:45374 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760225Ab3GSLzG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 07:55:06 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so8949675iea.25
        for <git@vger.kernel.org>; Fri, 19 Jul 2013 04:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hMHNbvAe1FEuMmZLddyiqvEb0J61QKhY9HXbeB9zvt8=;
        b=vF3vpglnTb3jBYje6J5vIOjyz4o0o01vaVT5Z1z99hxv43nuYyEI2/yLgPzvHJ9ovy
         EptZXLAMqECYZTx5oO+fElvExpytlbkcs0ziAUSWsj8qtk0zoHYgHISe/FTd+Yy3fqZx
         LA1y4Rz5/MFGYmDdA3cWn1gANokQ5tzjihr+GwwIPCWOShFVHpIZ/QXKfbmEW6RlbO11
         qs0b2r0eNNUHJd0NTBft0yTIYFqHJFuyuXsBA6bt2U0SWIAH1I3EtwEw8PcFff8O/j1Y
         IkR8rERTkdlP220Zo+a00IBZThhSaqVl755lR+XkmYj3WSWnKvLQU+FSZ1CPOuAW0Y90
         ehNg==
X-Received: by 10.42.62.4 with SMTP id w4mr9905288ich.27.1374234904959; Fri,
 19 Jul 2013 04:55:04 -0700 (PDT)
Received: by 10.43.1.68 with HTTP; Fri, 19 Jul 2013 04:55:04 -0700 (PDT)
In-Reply-To: <CAFuPQ1K=hWUSCEhaGsuW8PeoGQcj6AoPo61zUTDbjLE802h+7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230794>

On Fri, Jul 19, 2013 at 12:07 AM, Jonas Fonseca <fonseca@diku.dk> wrote:
> On Thu, Jul 18, 2013 at 9:30 AM, Drew Northup <n1xim.email@gmail.com> wrote:
>>
>> Somehow this patch breaks the main view to not open the correct commit in diff view when <enter> is pressed. Back to the debugger...
>
> Does this (possibly white-space damaged) patch work for you?

I did look back at that sort of fix, but I kept getting compiler
warnings about a pointer conversion. Yes, it does work (I was actually
initializing the whole buffer to NULL), but I'd prefer doing so
without the implicit int* conversion warnings.

> diff --git a/tig.c b/tig.c
> index ba9ba98..74a2928 100644
> --- a/tig.c
> +++ b/tig.c
> @@ -3104,7 +3104,7 @@ format_expand_arg(struct format_context *format,
> const char *name)
>  static bool
>  format_append_arg(struct format_context *format, const char
> ***dst_argv, const char *arg)
>  {
> - format->bufpos = 0;
> + format->buf[0] = format->bufpos = 0;
>
>   while (arg) {
>   char *next = strstr(arg, "%(");

--
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
