From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 2/2] interpret-trailers: add option for in-place editing
Date: Mon, 18 Jan 2016 16:11:11 -0500
Message-ID: <CAPig+cRRdca7PfkqppY2X7KSFpHX0yH19fxRL+w_=u9vg7NV9A@mail.gmail.com>
References: <1452790676-11937-1-git-send-email-tklauser@distanz.ch>
	<1452790676-11937-3-git-send-email-tklauser@distanz.ch>
	<xmqqio2vki0i.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tobias Klauser <tklauser@distanz.ch>,
	Christian Couder <chriscool@tuxfamily.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 18 22:11:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLH5T-0004Ze-QV
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 22:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbcARVLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 16:11:13 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33368 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756311AbcARVLM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 16:11:12 -0500
Received: by mail-vk0-f66.google.com with SMTP id n1so11990373vkb.0
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 13:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=oRbWBGTjYTrPClVMWh+tsyaQQ/1hBMkJGTIl3nfEE+o=;
        b=VA9atnVlF5FuW2b0dN/RRAmGnvXauhHXi1KxvzxkZyQtG44PX0Vomr2DuodGEdxine
         6KJVUM4s2gtXAfrxBQP74nV4vS3bi30VU0p5Jzj6tRp0JcqpyeIPSZ55DDQO3h7JeT6D
         UlPwVbZQkneCrM/1emYzg5zzcwhvxYOzAPJd0syh5jh6Jmvu3dAVxgGgmAXIXVyUpO6t
         f1EQ3kvdAvCE4MWqqPrJkcE0ycRQwkdDihdcpoxtsl6shaKZzgHwwYpzKE1cpAjaJFh+
         OsE03G3hOimGZSYWwLnE0waQaqCmMSave4i3WVD2xIJefZnVJBqtlvBlZze8JEpWARlf
         J1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=oRbWBGTjYTrPClVMWh+tsyaQQ/1hBMkJGTIl3nfEE+o=;
        b=bRkMSYlrIk6psrs+p1W/GzmwytMIrwrkn26RL7iGGJtgtbdDrCachZBlSeCbDSFjWW
         J0/sv2dCB3m9c+2VFym3ZFhw9L58wghX9g14XG1klJzPN9AH1c4QTRVanaNmAsYMkSYO
         fBuss8peaCnToC1OCmcadnAX+gpA7PlyJpI1Cw9VhVgG+TLNs0Xgy7JQ84E77RMARnEh
         SZdo219bYiFiNmzd1ngEGPl9WOqj1V9oBCk0APl/WEszhYqmVYlHcG/EDxbo2/S5YmRY
         Oo659eyRYv7tIxPLbkvxxufQJdcPfEuFkEuUzj3Fd8IeKbSURhIJGh+14FltncPjThVa
         +jTQ==
X-Gm-Message-State: ALoCoQnxBVjP2qaKfCuaVjRmS3gSNTmJBjIBhjniEwuPQQRc8BiPA5L1HYu6+Y6zJmddoV6eBr/+Y8JmHYonVM2uOXXcFXgnYA==
X-Received: by 10.31.56.18 with SMTP id f18mr15666713vka.19.1453151471350;
 Mon, 18 Jan 2016 13:11:11 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 18 Jan 2016 13:11:11 -0800 (PST)
In-Reply-To: <xmqqio2vki0i.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: zbmSGeZUgN2TfgGpkrdpEiKxt1E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284322>

On Thu, Jan 14, 2016 at 3:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Tobias Klauser <tklauser@distanz.ch> writes:
>> diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
>> @@ -326,6 +326,46 @@ test_expect_success 'with complex patch, args and --trim-empty' '
>> +test_expect_success POSIXPERM,SANITY "in-place editing doesn't clobber original file on error" '

I think POSIXPERM is all you need for this case; SANITY doesn't buy
you anything, if I understand correctly.

>> +     cat basic_message >message &&
>> +     chmod -r message &&
>> +     test_must_fail git interpret-trailers --trailer "Reviewed-by: Alice" --in-place message &&
>> +     chmod +r message &&
>> +     test_cmp message basic_message
>> +'
>
> If for some reason interpret-trailers fails to fail, this would
> leave an unreadable 'message' in the trash directory.  Maybe no
> other tests that come after this one want to be able to read the
> contents of the file right now, but this is an accident waiting to
> happen:
>
>         cat basic_message >message &&
> +       test_when_finished "chmod +r message" &&
>         chmod -r message &&
>         test_must_fail ... &&
>         chmod +r message &&

Don't forget to remove this (now unnecessary) "chmod +r" once you've
added the 'test_when_finished "chmod +r"'.

>         test_cmp ...
