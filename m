From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 42/43] refs: add LMDB refs backend
Date: Fri, 02 Oct 2015 14:35:26 -0700
Message-ID: <xmqq1tdd3qe9.fsf@gitster.mtv.corp.google.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
	<1443477738-32023-43-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 23:35:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi7zI-0004SW-FY
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 23:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbbJBVf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 17:35:28 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33096 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbbJBVf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 17:35:27 -0400
Received: by pacex6 with SMTP id ex6so116845332pac.0
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 14:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=P791ue1cTnRTGvF26xD8UELb6ZehuEq8aSJs+XjVJ9w=;
        b=ZPubrYAvvduTHPjm/vJ8NXNh97SFYmnrkhkW1ki1BnKI7QUqMN1yzUP8oP+dD6UeLt
         zrtb2UadGE2uBgjmfDdpmYbZ0DWMFBvGAu5UCxrxv3lVM+pRBWkiBh1a1oHKgBjIxMcf
         EXiaVUuhnJxqI6SiIZ/hS85arfqiIur+VZcF6aUCsjzSEdwylja+yY7Wi21n9D5SiaQg
         Geu6SjmyYhuLi5cHHqAFwBKmLDT46I4aFOrkfV8Jsd28XKMyN4fFZGe3WX4xWqWXx/Wg
         SJaeE1YqNi9ZUvIcILxYyu6Hb5y7ueD/c4AtKM0kI8YC3OaawPSRKqNdHUh8NBnSySLo
         vp+g==
X-Received: by 10.66.221.104 with SMTP id qd8mr23144476pac.155.1443821727325;
        Fri, 02 Oct 2015 14:35:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:5831:5c0e:ce5f:86ea])
        by smtp.gmail.com with ESMTPSA id jw6sm13639384pbb.86.2015.10.02.14.35.26
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 02 Oct 2015 14:35:26 -0700 (PDT)
In-Reply-To: <1443477738-32023-43-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Mon, 28 Sep 2015 18:02:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278951>

David Turner <dturner@twopensource.com> writes:

> diff --git a/refs-be-lmdb.c b/refs-be-lmdb.c
> new file mode 100644
> index 0000000..99cbd29
> --- /dev/null
> +++ b/refs-be-lmdb.c
> @@ -0,0 +1,2003 @@
> +/*
> + ...
> + */
> +#include <lmdb.h>
> +#include <sys/uio.h>
> +#include "cache.h"

"git-compat-util.h" (or "cache.h", because it is well known and
includes "git-compat-util.h" as the first thing before doing
anything else) must be the first file included in any of our C
files, unless it is a platform specific compat/ object.
