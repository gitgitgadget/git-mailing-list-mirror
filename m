From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/log: clarify what --raw means
Date: Fri, 15 May 2015 10:38:41 -0700
Message-ID: <xmqqtwvdhhb2.fsf@gitster.dls.corp.google.com>
References: <297757279.1883703.1431704571028.JavaMail.zimbra@imag.fr>
	<1431704674-18595-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, eda@waniasset.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri May 15 19:38:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtJZR-0007FV-3C
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 19:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbbEORio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 13:38:44 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38745 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397AbbEORin (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 13:38:43 -0400
Received: by igcau1 with SMTP id au1so35262146igc.1
        for <git@vger.kernel.org>; Fri, 15 May 2015 10:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=FsL5rwXNVAy2GXEn5r8oYDcQ1wj5WMs2glKcPEXn3xc=;
        b=HCpLzhSGloEZOqI34vta22i4Vc5OZx9fyUPfj4ABEfxmZghJhTx/F6cRHfthX1Lbh+
         pTs+lIM9gv4x53+RBVJzKPdUT6uHNQza30vGzy+aJ/lvdpmcauVXKcP2KKvzvPFAqm29
         U/hGroyF51hw0YMZ0LDKcTfOEtq7O43fp+zELJbAqLqv1HNiwyWS+uqOoJYCg8CxvdaC
         3uTOyyDZWryugwc2SPUfXpfYTbT1q9hnv8IEC+wsey3THjpf/CTvdf99r0+EFfPtWF9l
         MzwNlZtgBKUjWxswnZeL2ivFwULcO8rii6ZEAckbjK42Pz0Fs6Xv2+JMRwnHMKcF9lkN
         fSSA==
X-Received: by 10.50.30.197 with SMTP id u5mr44795109igh.9.1431711523036;
        Fri, 15 May 2015 10:38:43 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1148:d596:44de:a92d])
        by mx.google.com with ESMTPSA id m36sm1567518iod.3.2015.05.15.10.38.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 15 May 2015 10:38:42 -0700 (PDT)
In-Reply-To: <1431704674-18595-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Fri, 15 May 2015 17:44:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269159>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> There are several "raw formats", and describing --raw as "Generate the
> raw format" in the documentation for git-log seems to imply that it
> generates the raw *log* format.
>
> Clarify the wording by saying "raw diff format" explicitely, and make a
> special-case for "git log": "git log --raw" does not just change the
> format, it shows something which is not shown by default.

Being a pedant, I find "generate the raw diff format" somewhat a
strange wording.  Aren't we generating a diff in the raw format (as
opposed to in other format like the textual patch format),
generating a diff using the raw format, etc.?

In any case, this is an improvement.  Thanks.  Will queue.

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  Documentation/diff-options.txt | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index ccd4998..163163b 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -41,8 +41,17 @@ endif::git-format-patch[]
>  
>  ifndef::git-format-patch[]
>  --raw::
> -	Generate the raw format.
> +ifndef::git-log[]
> +	Generate the raw diff format.
>  	{git-diff-core? This is the default.}
> +endif::git-log[]
> +ifdef::git-log[]
> +	For each commit, show a summary of changes using the raw diff
> +	format. See the "RAW OUTPUT FORMAT" section of
> +	linkgit:git-diff[1]. This is different from showing the log
> +	itself in raw format, which you can achieve with
> +	`--format=raw`.
> +endif::git-log[]
>  endif::git-format-patch[]
>  
>  ifndef::git-format-patch[]
