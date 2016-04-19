From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 0/6] Move PGP verification out of verify-tag
Date: Tue, 19 Apr 2016 15:10:00 -0400
Message-ID: <CAPig+cRz4stVQWFD-NroVHft2xFvyZJi1ePX9T4zZ3k3=X6ZrA@mail.gmail.com>
References: <1461088041-19264-1-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Tue Apr 19 21:10:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asb2M-000395-Vq
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 21:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933622AbcDSTKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 15:10:03 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34785 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933248AbcDSTKB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 15:10:01 -0400
Received: by mail-io0-f196.google.com with SMTP id z133so3965779iod.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 12:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=RZX1WB7U2Y7i2sw/6o5quwPlWBGGQDF/KDGWIrUAGTw=;
        b=TXtlUDo1sKGt47bmibn33qh7w4JgZouNjJFekPTLKmu3SnE7re/Z9YRJwyOdh5t4nY
         WIXqJBThtiMfxz4GNItaZxncs8IfXZ3YVYkay4PbDuHwyDV4oZwZJTB/iAc5gYnNga3g
         tMMwqzvXlJlleQGlVNP+gtz3pBjdDF9fRR4lCjoDsfxaBS6BxKPyYkraeomKNgmeQTtP
         FG/xO12BLBF+dNtP5zHA/sYRF96ku/1jAMTBBkCJyaeaPDVZt/NSqMfICvbMzFkL/q5G
         Qn4wOqj5NAhApMtsy8fCN0N7OEDeMTagtknNjyrSWm2pOqLaq0cI9t5HU5KULMGnIxif
         NH0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=RZX1WB7U2Y7i2sw/6o5quwPlWBGGQDF/KDGWIrUAGTw=;
        b=WpApzXYGIxSp4jC6FL5FUt+7lmlWvihWEAB5+YvPjW/7qP8HuRFIt6EU+Mj7ZLmP+P
         O1MSLYZ19/jznDQvu7Xen8hI4P9T8+9BQUCw0fJdUBa53PqccvMKO8zNMphvSNfC4VrN
         VPfewVwsKz/z5xjeNp3qgWmXM0xpCF4UN1uqt53MNL7ax3d/gQMoN3SufxNV01Q+Inn2
         BWje1sAxqYElblHntONHsMADUtlAA2xO+vHLWB/Sbxl3OVr6hRPBqfSGX3a+Oze7tgfj
         uvovLIJXhwpYcItYp0hYgkFtFk5D6/MDWLbX27gxVGyb0B6QXhIWX/3AKQqZDJj4Hzih
         VS5Q==
X-Gm-Message-State: AOPr4FVG/tr3SpO2Q9fa+7f8pQcr2hkJXB2EP5C6XYblaMybPE3LzPlPyhVAB3rWUb5hBw1n6vR5RFgF5ZUuEQ==
X-Received: by 10.107.9.102 with SMTP id j99mr1596677ioi.104.1461093000501;
 Tue, 19 Apr 2016 12:10:00 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Tue, 19 Apr 2016 12:10:00 -0700 (PDT)
In-Reply-To: <1461088041-19264-1-git-send-email-santiago@nyu.edu>
X-Google-Sender-Auth: ZuKfwbm2HEQ2XQApwRTz9Yx21fQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291909>

On Tue, Apr 19, 2016 at 1:47 PM,  <santiago@nyu.edu> wrote:
> This is a follow up of [1], [2], [3], [4], [5], [6]. patches 1/6, 2/6, are the
> same as the corresponding commits in pu.
>
> v7:
> Mostly style/clarity changes mostly. Thanks Peff, Eric and Junio for the
> feedback! In summary:
>
>  * Eric pointed out issues with 3/6's commit message. It doesn't match the one
>    in pu though. I also took the opportunity to update payload_size to a size_t
>    as Peff suggested.
>  * 4/6 I updated report_name to name_to_report, I updated the commit message
>    and addressed some nits in the code, one of the fixes removed all three nits
>    that Eric pointed out. I updated 5/6 to match these changes
>  * I gave the commit message on 6/6 another go.

Thanks, this re-roll looks good. My reviews mention a couple nits, but
I hope they are not worth a re-roll (perhaps Junio can address them
when/if he picks up the series).

As before, the entire series is:

    Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
