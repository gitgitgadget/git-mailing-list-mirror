From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/12] prune_remote(): use delete_refs()
Date: Mon, 15 Jun 2015 12:45:30 -0700
Message-ID: <CAPc5daXJ-FJ_1=EJ8+5t+-fY-w1cQraKYUrvqTu_rXptx24frw@mail.gmail.com>
References: <cover.1434206062.git.mhagger@alum.mit.edu> <aab9d191609b34fbfee0b68883a5b14fba2421ad.1434206062.git.mhagger@alum.mit.edu>
 <xmqq381sakgf.fsf@gitster.dls.corp.google.com> <20150615183906.GA10080@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 15 21:46:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4aKX-00086E-M7
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 21:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbbFOTpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 15:45:52 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34037 "EHLO
	mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754107AbbFOTpv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 15:45:51 -0400
Received: by oigx81 with SMTP id x81so7371119oig.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 12:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=cxaqRYvsKfO8sO1w8q2P6PUt4U6A3lpV4pZ5JXOGLVY=;
        b=ak3pzyZOT5aJxdQmyaygG/064Yj0QvoPi2djPU37thxt7e/nK8w5lSE1RHtJNCGE/R
         Ndu6Ukr0pFnNnw65OiLW8qTaQP2QAsw53+NkuTDuZ8EPa8yXCtCuoT2YZz1aQBrUIwK6
         Q+3pr90aVs4tN8udEqI/8kL8uVlpqkFGSVZ/KswToWA55ns/UkLc6tj70nkfycn/McNN
         QbdZ2+uxCgZXzMpxNsCFBqcdohU6PljrlMTFgnlCZXlJSYnaUVa2WP6LkYpfgY70X6gK
         48tKS1C8eZutQwkmFJT4GF5E7JG8lAy/psnRGzf8xyRl26tdpZQx92EWOrvTlnx9vfO5
         YLNg==
X-Received: by 10.202.98.193 with SMTP id w184mr24031954oib.96.1434397551214;
 Mon, 15 Jun 2015 12:45:51 -0700 (PDT)
Received: by 10.202.202.131 with HTTP; Mon, 15 Jun 2015 12:45:30 -0700 (PDT)
In-Reply-To: <20150615183906.GA10080@peff.net>
X-Google-Sender-Auth: qzuSoY-s-9h2xlLTEw-I8RcMw7A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271717>

On Mon, Jun 15, 2015 at 11:39 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 15, 2015 at 11:35:28AM -0700, Junio C Hamano wrote:
>
>> But the log message puzzles me.  Didn't refs that cannot be deleted
>> cause the original to fail?  After repacking without these refs, it
>> called delete-ref, and a failure to delete or commit the deletion
>> would have hit the error() down there, no?
>
> I think this discussion:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/271017/focus=271164
>
> from v1 is relevant.

Ah, OK, that makes sense; the log message may want to explain that though.
