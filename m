From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] pathspec: allow escaped query values
Date: Thu, 2 Jun 2016 11:58:22 -0700
Message-ID: <CAPc5daWQYRbV_Oc-xCKE2R_O=aMBm_g_CLB=RPUam7EtbGPTgQ@mail.gmail.com>
References: <20160601235233.21040-1-sbeller@google.com> <574F800D.6070107@ramsayjones.plus.com>
 <xmqqy46ouorn.fsf@gitster.mtv.corp.google.com> <57505105.2000801@ramsayjones.plus.com>
 <xmqqoa7jvag0.fsf@gitster.mtv.corp.google.com> <57507DFD.6010800@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 20:58:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8XpQ-0006xr-77
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 20:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933129AbcFBS6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 14:58:43 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:32770 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932214AbcFBS6n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 14:58:43 -0400
Received: by mail-yw0-f176.google.com with SMTP id h19so59173831ywc.0
        for <git@vger.kernel.org>; Thu, 02 Jun 2016 11:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pEEThyJGjHkz+B7bxdIz6VirUfPDse5FOjhKl3ViGq0=;
        b=buJSruFM7kFbnO4bc7k2hlXNyfTMWXCChgJvuPxNpzk92obUHutUKTUVctw3HNd/5Y
         vnlsjxf7uiLzhXyatPlvPg+zxsXDavT5x0oO5Ew+ZFH472kwpxYiGDJ7n6EqrpFU+DxA
         gK61nQd5Un2geVc4e7tJHjpOXNCc2swDUsBVkAElU7HyzxSzFVYkRNIVcmoh7vB1ZuSQ
         tvGQB1Y6uGb2tuDNd2kKA8OUT/Km7ikkydaWY+yTF7tZtkEpRg2qjebtYAF/xzbTF0X9
         RCR+N7rZIEo9cX6KmDXxmbuWSmaIzPYQ49iJ6Px99X3dYwxIO9S188/EHy6vkNj//RmE
         jvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=pEEThyJGjHkz+B7bxdIz6VirUfPDse5FOjhKl3ViGq0=;
        b=JUHvFd4ws2dHRZ1h799+6u/L6lqk9rsCBK9AzZSJphZWJgGQrb2cxHXzTUb3dx8OXF
         X2IE3wIPuMcuq/56TZuVbOc5RtC9wLaGiJYWIaqO1QBkScxLyhSilsIBL9Cgek1OYxFT
         vcPTvU3AAgAjqXvc7gqNDtfpvZ7pf1Q/ZkHPfMzovAytv8oEWVlBucBIV2K2boNdt6is
         ySl5kvSgiz9R+g1rp6WMPSmSFLubvhKxTMJKJdBZKP3MDBaPonriooROsDCVuD8ktmhU
         ELKrsxsaAw4XId1ujylX4w4HW5qN2gQYk29n5USKhpN8xSTXEj3WWS9N4GOVFrvoUspx
         bhuQ==
X-Gm-Message-State: ALyK8tIeEpqoeuYyWqc7CfKC7NU99KTfYNjkoOPjkHUhC4x846R6JgjkhdDdwKd/93OGG7kpAXIhb7XGy5apnw==
X-Received: by 10.37.59.132 with SMTP id i126mr6533626yba.151.1464893922112;
 Thu, 02 Jun 2016 11:58:42 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Thu, 2 Jun 2016 11:58:22 -0700 (PDT)
In-Reply-To: <57507DFD.6010800@ramsayjones.plus.com>
X-Google-Sender-Auth: GmJLH37729-MSwYV2MS3ZclYRy8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296223>

On Thu, Jun 2, 2016 at 11:42 AM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>>
>> That would be workable, I would think.  Before attr:VAR=VAL
>> extention, supported pathspec <magic> were only single lowercase-ascii
>> alphabet tokens, so nobody would have used " as a part of magic.  So
>> quting with double-quote pair would work.
>
> I was thinking about both ' and ", so that you could do:

Yes, I understood your suggestion as such. Quoting like shells would work
without breaking backward compatibility for the same reason quoting with
double-quote and backslash only without supporting single-quotes would
work.
