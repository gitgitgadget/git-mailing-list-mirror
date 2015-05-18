From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] Documentation/log: clarify sha1 non-abbreviation in log --raw
Date: Mon, 18 May 2015 13:52:36 -0700
Message-ID: <xmqq4mn9bobv.fsf@gitster.dls.corp.google.com>
References: <xmqqtwvdhhb2.fsf@gitster.dls.corp.google.com>
	<1431971758-979-1-git-send-email-Matthieu.Moy@imag.fr>
	<1431971758-979-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon May 18 22:52:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuS1k-000766-8r
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 22:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932781AbbERUwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 16:52:39 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37609 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932537AbbERUwi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 16:52:38 -0400
Received: by igbsb11 with SMTP id sb11so58421686igb.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 13:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=agBZF7uN+2uxZWTeCbJRb5K3r59vN6wP4PRCtdYY1ss=;
        b=UpncLS3eMMSP4+UMcuf0UqZ9HnYsx+FYvQd7rhK0zlRRDayEu3zjgn8FYvl6ztUH2A
         pswN0eE9Y57b9JVxBGlLxSz4adRC00quABpBYvwWvAG9MdbLz+CxkDZnGHQrdBuOhu1x
         AVU5Q7HOpbBHMDZN8Cz2NQ9U4H7NHYc6Ghh1vCxPmGdo3NHnPFk6TllHGHF5fz4TSro7
         AtVdOd3U4MOh5jvF7fsAsyZV2GgApEV+zynyPnn1oaHLHm4fg9y2thARhr86OmWSMEsU
         rlyYvLGMw0ScJgHefNhHPbw4GXZPlfBSLIJFSrYxe7+pZz2KyXNftNhN/Tw+NMpxUC4F
         kGkw==
X-Received: by 10.50.13.10 with SMTP id d10mr17133164igc.20.1431982358261;
        Mon, 18 May 2015 13:52:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:799e:649b:b86b:7c03])
        by mx.google.com with ESMTPSA id w4sm6312579igl.22.2015.05.18.13.52.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 May 2015 13:52:37 -0700 (PDT)
In-Reply-To: <1431971758-979-2-git-send-email-Matthieu.Moy@imag.fr> (Matthieu
	Moy's message of "Mon, 18 May 2015 19:55:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269317>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> This patch is new.
>
>  Documentation/pretty-formats.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> index dcf7429..c434ecc 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -79,7 +79,10 @@ stored in the commit object.  Notably, the SHA-1s are
>  displayed in full, regardless of whether --abbrev or
>  --no-abbrev are used, and 'parents' information show the
>  true parent commits, without taking grafts or history
> -simplification into account.
> +simplification into account. Note that this format affects the way
> +commits are displayed, but not the way the diff is shown e.g. with
> +`git log --raw`. To get unabbreviated commits in a raw diff format,
> +use `--no-abbrev`.

s/commits in a raw/object names in a raw/?

I wondered what "this format" was, and had to read the patch with
"show -U60" to realize that this is about "--pretty=<format>".
Perhaps the introductory text of the first paratraph in the section
is not clear enough that not just --pretty=raw but --pretty=anything
is about how the commit object is shown and has nothing to do with
how patches are shown, and that is why this new text is necessary?
It somehow looks out of place to have this description only for
'raw'.  I think it is OK because it is hard to imagine how other
formats would affect patch output ("git log --pretty=<any>" would
not give any patch, "git log --pretty=<any> -p" would always give
textual patch and not diff-tree raw patch), but it is possible to
confuse between '--pretty=raw' and '--raw'.

Thanks.
