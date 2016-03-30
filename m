From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 0/4] Some cleanups
Date: Wed, 30 Mar 2016 10:32:40 -0700
Message-ID: <CAGZ79kYwpj+NSn4yZK0tqASQ7CghAMgE6L9thVhTwuBNmFY6PA@mail.gmail.com>
References: <1459357518-14913-1-git-send-email-sbeller@google.com>
	<20160330172538.GC19675@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 30 19:32:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alJz5-0004Cx-BD
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 19:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367AbcC3Rcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 13:32:43 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:34675 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755277AbcC3Rcm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 13:32:42 -0400
Received: by mail-io0-f172.google.com with SMTP id e3so82768093ioa.1
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 10:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=hsiSHY0FWdo6dHRn+xIw7uRUIR3va8x2X4i+jYJfiR0=;
        b=VPThQOfColXCKl1u1uJLNvS/lWmZ8gkVCWyvnUuAgBAW+jXX4vsrwJqQs3WuUPTtpn
         lC0j/x09r+UDMEqW7ih1n0Gr1R0GVnjpf4sSxp7UWl67Pi4HBThFwpWH0IABd7uhnE3j
         ICBNK1X1PKR5tlSvwKeCzMRmPCn3sgTznJNlu8d769R8qR1UlnUucyQVBK+/4MHt70tB
         0xUhr3NQiMqR9LNj4EOStB2ASbI+gEoqrVL9MFg2juXLyZ2gUgdOyOu/hl+CTIpPNNlI
         PZdiz8WjcCySjKCU4mit2xyKmsOwKr+u5fCq8Uc59SEpy6qUgqHjzuMC4iV+PtglFU0Q
         tSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=hsiSHY0FWdo6dHRn+xIw7uRUIR3va8x2X4i+jYJfiR0=;
        b=fDZhd8AxAQQy9Rp9ojGLK10EdEkIeLM5V5OjquDcOtkb6YyTkuQE9uCaRX6Y4EaSxj
         UkKK4bhhDkk8mdBF1aiqXq99ZDwXIR0xMxZxELMdWS2h60vWYOIERl3F3nYp+b8YTaQm
         iqoVITilMCSaAVVK5mYegCP3lmsRRww1dGvASSiYWoZLo5Wk36CNdkFlT9Spo+FAUD9F
         76XAZ1XGQRYJ4JaAklbiK41z9QHGYHdUVMe1ruYrd76N8n2Wozphzxg3dfAJRjJCY/DP
         4uX3nzJ3ed10CahZgqMQr5J8sH6jgYaoSw+C+V48nX3Uybh+Xn7dJOWp15OuP0ZIl6PB
         kFkQ==
X-Gm-Message-State: AD7BkJKYJpjQk2LmSGj1wd5qoOdhiF1C3SKhdvebB97zPOUugYg8cQCmYL5ehKQpzx56bQywqTSdkZJImvkvnQ4M
X-Received: by 10.107.161.68 with SMTP id k65mr12750294ioe.110.1459359161030;
 Wed, 30 Mar 2016 10:32:41 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Wed, 30 Mar 2016 10:32:40 -0700 (PDT)
In-Reply-To: <20160330172538.GC19675@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290327>

On Wed, Mar 30, 2016 at 10:25 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Mar 30, 2016 at 10:05:14AM -0700, Stefan Beller wrote:
>
>> v2:
>> Thanks Eric, Jeff, Junio for discussion, I picked up all hints and here
>> is a v2.
>>
>> * drop the overallocation patches (1&2)
>> * use git_config_get_string instead of its _const equivalent, such that
>>   we don't need a cast when freeing in git_config_get_notes_strategy
>> * Use strbuf_list_free instead of cooking our own.
>> * have a dedicated error exit path in bundle.c, create_bundle
>
> I'm OK with all of these as-is, though I did mention a nit in the third
> one. I also like Junio's rewrite instead of using strbuf_list_free.

I'm fine using the rewritten version instead of using strbuf_list_free. :)
On the third one, there is one case, where we have

  if (..)
    return error(_(text));

and that is an exit(128); eventually.

I thought it is worth preserving the difference (as it is a faithful
bug fix not a
change to make it better or more uniform).

Thanks,
Stefan



>
> -Peff
