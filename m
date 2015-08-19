From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH v2 8/9] Support signing pushes iff the server supports it
Date: Wed, 19 Aug 2015 16:00:30 -0400
Message-ID: <CAD0k6qT8azfV296wx-Q1AAjbT1fcVjZBQCuK515DYv_ZfefzdQ@mail.gmail.com>
References: <1439998007-28719-1-git-send-email-dborowitz@google.com>
 <1439998007-28719-9-git-send-email-dborowitz@google.com> <xmqqpp2j82z7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 22:00:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS9Xb-0008Ma-MB
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 22:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbbHSUAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 16:00:51 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:34564 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbbHSUAu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 16:00:50 -0400
Received: by iodb91 with SMTP id b91so22108137iod.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 13:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dbLXbf2A1d7ihrQidgFiOkYl1OnEd2i+gzkoDjKcr4w=;
        b=bIV6ixPyX6R41oow4D3fTvHjUD+z7Q9afLKkO8LqGMrkGvzDeI7lB0R/qqXQv6Yo98
         jCD18AxNpFJRfJlqWAbffTJLMHW8E85H3uKotqgsR05939loqEfQ/yLwcSnofF7YOGw+
         24fSalhWifWOm4LOw/e2AngjGc2jM0seiMEODPXWrgf5LKibZGpRS7m8fkn0WYBjc7YE
         /4TX8wq2x/e2r9750hySwiAfFH5kIJxDUC5biYvbL6Z+ZE/Cunjri5wClZlFye/9EF/m
         zzTX3Ep3A9aQsaP/ni2C00qjLawhPvoowVrsrnMf27CW3gZ576oyZzNl+M4TNj/cIhDf
         HxgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=dbLXbf2A1d7ihrQidgFiOkYl1OnEd2i+gzkoDjKcr4w=;
        b=FJzWfADSPKtsaQ+EwbL3iwpSFnZ96F+O0uxdTm8cyGnfaiM6rU6uuZI7Yl1BO1CroC
         bCWDJRP7mbtRrvxzNk0xcUXFbS3o69vuFcWzIYv+D3Sl7Hobn8ysHqlbtSlqyL59SrKe
         0Shid5d9sve4IZgNNvppzpqTEhuD7HEH5z97dKesq7v8xoZk2UDOvErKC4bVo2DWVhpt
         NlvhODsaqToVOqNnxrQAQjYx2hiie7dfaui5WDuhWm6QJY8v1KWu2M6ypzA7PU60XGrh
         2p+yfTbYpawEYSsgfjkQVf2wTAi9ZPsQi/qchfW7TgHmcjTcqP/Sp0gs5aT/fZO1JOtT
         1Jww==
X-Gm-Message-State: ALoCoQlcCPxZP5YEPBurA2MTRBYz0vSQ+J73ozz+ErxB2ek2PyUZDpzXsq1EGAS1Le6rB5IT2X7V
X-Received: by 10.107.136.66 with SMTP id k63mr13846946iod.194.1440014450158;
 Wed, 19 Aug 2015 13:00:50 -0700 (PDT)
Received: by 10.107.4.201 with HTTP; Wed, 19 Aug 2015 13:00:30 -0700 (PDT)
In-Reply-To: <xmqqpp2j82z7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276222>

On Wed, Aug 19, 2015 at 3:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dave Borowitz <dborowitz@google.com> writes:
>
>> Add a new flag --signed-if-possible to push and send-pack that sends a
>> push certificate if and only if the server advertised a push cert
>> nonce. If not, at least warn the user that their push may not be as
>> secure as they thought.
>>
>> Signed-off-by: Dave Borowitz <dborowitz@google.com>
>> ---
>
> Obviously, the above description needs updating.  Here is what I've
> queued tentatively.

Sound good.

> Thanks.
>
> commit 32d273dfabb0a70b2839971f5afff7fa86a8f4c2
> Author: Dave Borowitz <dborowitz@google.com>
> Date:   Wed Aug 19 11:26:46 2015 -0400
>
>     push: support signing pushes iff the server supports it
>
>     Add a new flag --sign=true (or --sign=false), which means the same
>     thing as the original --signed (or --no-signed).  Give it a third
>     value --sign=if-asked to tell push and send-pack to send a push
>     certificate if and only if the server advertised a push cert nonce.
>
>     If not, warn the user that their push may not be as secure as they
>     thought.
>
>     Signed-off-by: Dave Borowitz <dborowitz@google.com>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
