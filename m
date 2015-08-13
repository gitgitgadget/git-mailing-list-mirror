From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 05/13] ref-filter: implement an `align` atom
Date: Thu, 13 Aug 2015 14:26:31 -0400
Message-ID: <CAPig+cRhgfOozy42UiDs24JFQTw5k8CYS0c+3DTOFB+XkPrLRQ@mail.gmail.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
	<1439129506-9989-6-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 20:26:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPxD3-0005BK-Ul
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 20:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271AbbHMS0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 14:26:32 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:34621 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbbHMS0c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 14:26:32 -0400
Received: by ykdt205 with SMTP id t205so48896264ykd.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 11:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=BgEEHJaxHWHW88iLBW6JtZVonf493hhGNfmtub48sQc=;
        b=cIBUM+tfL65z02kcAzn9qVbVEOzx/lI6iUgO2e0WlUd86sRtqeXABw0hWEuvXzhepP
         FAqnncDzIkpUigOC0lwpic6F+HpsJYjvmPWP40tQ+fN8MJ6ANHLHQftqyGhF4ncnSPeB
         uTAytYfR3X1QWx+T39INEaID6d3l7mT2hqiazE3/hcx2Vfoz41znksT1NWXZsBNwx/Rw
         eMFr/mtL9z/pCaDcqOdeBh9bbfniWkACObEutKLVskjmFaIsGqizsJKN73ve7lftzONB
         Q3YUhIHCReyawxS0rntqnu5DZrMS4pRbCDIAnvhsXNii3Qyx7NmC/Zh9l/PkxjqRdDzA
         qXeQ==
X-Received: by 10.170.172.84 with SMTP id o81mr11743629ykd.69.1439490391491;
 Thu, 13 Aug 2015 11:26:31 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Thu, 13 Aug 2015 11:26:31 -0700 (PDT)
In-Reply-To: <1439129506-9989-6-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: zySMNZvVsk9X31sT-IzaohpmrTY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275870>

On Sun, Aug 9, 2015 at 10:11 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Implement an `align` atom which left-, middle-, or right-aligns the
> content between %(align:..) and %(end).
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index e49d578..d949812 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -127,6 +127,15 @@ color::
>         Change output color.  Followed by `:<colorname>`, where names
>         are described in `color.branch.*`.
>
> +align::
> +       Implement an `align` atom which left-, middle-, or
> +       right-aligns the content between %(align:..)  and

This documentation seems to be copied a bit too literally from the
commit message. Saying "Implement an `align` atom" makes sense for the
commit message, but not for the documentation of the 'align' atom.
Instead,

    Left-, middle-, or right-align the content between
    %(align:...) and %(end).

would sound better.

> +       %(end). Followed by `:<position>,<width>`, where the
> +       `<position>` is either left, right or middle and `<width>` is
> +       the total length of the content with alignment. If the
> +       contents length is more than the width then no alignment is
> +       performed. Currently nested alignment is not supported.
