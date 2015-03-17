From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/2] cat-file: teach cat-file a '--literally' option
Date: Tue, 17 Mar 2015 02:51:33 -0400
Message-ID: <CAPig+cSJVGy_L6mThFCU1Bw0ZrZEv=pZ8=W8gTZd=A5y2fcR7Q@mail.gmail.com>
References: <5507B7EE.1070403@gmail.com>
	<1426569400-8204-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 07:51:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXlLm-00053m-PO
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 07:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbbCQGve (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 02:51:34 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:34524 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbbCQGve (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 02:51:34 -0400
Received: by ykfc206 with SMTP id c206so296983ykf.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2015 23:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=xyZnUb6jgdg81LrOcDGi0JKFYVkwV1ZsDGat08cWwLE=;
        b=k4zcN7GoOo70bltc47NTv9V81xDqiLdnl1eG75HgNWpnSlTqC41pFGuekUiZZdyvoO
         KFLH34cEhH4rrUJKm7/oZPHnV8IX7NtM6Iezse+B1fs3Tn/i3u5F68IXE9Do36RW+nhw
         P2SxPdqRDOArWtS2NVDryz4rQV/kcRuzXcY/pJVKXJMXQjz4JSqj7Zcni3l3pYSo1AlD
         ToARHw1FvWdJeuvlapD/ogeFGZNlXx1eggy6xqOcK7AlxFiSyNCIC0y0tnv0ScJl93Tu
         oZQ+lAA5yvqADLX+fBU9PpSm6ZgGGst37EoD98ZuKfdsGCGr+gaYjZc3pVwjy0tGf6M0
         vi0Q==
X-Received: by 10.236.41.78 with SMTP id g54mr52282151yhb.112.1426575093412;
 Mon, 16 Mar 2015 23:51:33 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Mon, 16 Mar 2015 23:51:33 -0700 (PDT)
In-Reply-To: <1426569400-8204-1-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: ANUEo_x_axjCkkUynvx5tesXzKs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265612>

On Tue, Mar 17, 2015 at 1:16 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index df99df4..1625246 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -323,8 +338,8 @@ static int batch_objects(struct batch_options *opt)
>  }

I don't presently have time for a proper read-through, however, this
popped out while quickly running my eyes over the changes.

>  static const char * const cat_file_usage[] = {
> -       N_("git cat-file (-t | -s | -e | -p | <type> | --textconv) <object>"),
> -       N_("git cat-file (--batch | --batch-check) < <list-of-objects>"),
> +       N_("git cat-file (-t [--literally]|-s [--literally]|-e|-p|<type>|--textconv) <object>"),
> +       N_("git cat-file (--batch | --batch-check) <list-of-objects>"),

The '<' in the second line before <list-of-objects> is intentional. It
means that <list-of-objects> is provided via stdin. Therefore, it is
incorrect to remove it.

>         NULL
>  };
>
