From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Git server eats all memory
Date: Mon, 9 Aug 2010 19:57:00 +1000
Message-ID: <AANLkTinT-taMqB87moLZ_CLio2USnxsriq6U0EJvSGte@mail.gmail.com>
References: <wesfwyupgrg.fsf@kanis.fr>
	<AANLkTimwy6GumHYSTo2je_hOUO80KEpx4_8z3iOoZyc0@mail.gmail.com>
	<87ocdhlgbl.fsf@kanis.fr>
	<AANLkTikt7LuhxHhOqPm2P-2hzXP54YThX5FRxF4yCFZu@mail.gmail.com>
	<AANLkTi=tf51FWkZZFw9cF=pcCyadgp7a9EXK=KQ6GSQS@mail.gmail.com>
	<87hbj74pve.fsf@kanis.fr>
	<AANLkTi=yeTh2tKn9t_=iZbdB5VLrfCPZ2_fBpYdf9wta@mail.gmail.com>
	<wesbp9cnnag.fsf@kanis.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Ivan Kanis <expire-by-2010-08-14@kanis.fr>
X-From: git-owner@vger.kernel.org Mon Aug 09 11:57:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiP6c-0007v4-U9
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 11:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756042Ab0HIJ5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 05:57:13 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40475 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755931Ab0HIJ5M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 05:57:12 -0400
Received: by wwj40 with SMTP id 40so11350422wwj.1
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 02:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=t5SlJ0k9rsvYXk1x5mgp/i5d8HKFy2atog/DI/805vk=;
        b=PXRz/GN1+q72HFTEQ39X3l1zf/VxL6mH3W9yGpYKIddAtMsEu7U7CBBuxayf8w8r6C
         8Aa8IqIlHxbn6cyUZ7zlJg6LfEUHtDXsVycDHWS3WrsgtXaHn02V0F5Ple24uDvxW8Pu
         xJP2GigzMV9ykAjs8oseskEd3EOBtYUqTngmk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ddtANX6iKeDe2VE2BwFU9p/YSJeoyfp39koVWA4RHp7QxWRySCtyLZwZl7ZvDZwH8t
         L08G9xScBmU6F9x9NBERUJAfvcW1FlPcVMP9PooZFAGh7UDEmZRbTCF+m3g2pPoKnW8e
         9UQ97P1Oe86DO9OgCH/Pigz70hoyGaDFstUkc=
Received: by 10.216.164.21 with SMTP id b21mr2400920wel.28.1281347820946; Mon,
 09 Aug 2010 02:57:00 -0700 (PDT)
Received: by 10.216.173.133 with HTTP; Mon, 9 Aug 2010 02:57:00 -0700 (PDT)
In-Reply-To: <wesbp9cnnag.fsf@kanis.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152959>

On Mon, Aug 9, 2010 at 7:33 PM, Ivan Kanis
<expire-by-2010-08-14@kanis.fr> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>
>> Can you send me massif report of git pack-objects? It'd be interesting
>> to see how memory is allocated.
>
> Hi Nguyen,
>
> I have attached the massif report.

Thanks. It does not look like it used a lot of memory (~50MB) (viewed
with ms_print). Git allocates 32 bytes per tree and 48 per commit plus
all tree contents, and all that will stay in memory until the end.

This command on git already gives me ~40MB peak. Are you sure you ran
it on your big repo?

echo|valgrind --tool=massif ./git pack-objects --all --stdout > /dev/null
-- 
Duy
