From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 14/25] setup.c: convert is_git_directory() to use strbuf
Date: Thu, 20 Feb 2014 20:04:31 +0700
Message-ID: <CACsJy8Ab0OVQw4ATgv6E7rv-B3OwbhyrJBbXiXjYiUvtMknMrg@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1392730814-19656-15-git-send-email-pclouds@gmail.com> <xmqqppmi97s3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 20 14:05:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGTJO-0003KZ-R8
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 14:05:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522AbaBTNFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Feb 2014 08:05:04 -0500
Received: from mail-qa0-f44.google.com ([209.85.216.44]:63762 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019AbaBTNFD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Feb 2014 08:05:03 -0500
Received: by mail-qa0-f44.google.com with SMTP id w5so2937317qac.31
        for <git@vger.kernel.org>; Thu, 20 Feb 2014 05:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=uOjq3TeYXgOIcnJJJveHPXXu37Zu7+HGD9rf7d1PnTw=;
        b=bIHhumqZTZ3MjCKlW7rCU6Yw8hFgnmlYwQdhNJJaIrAjYoTGJPTnRMO2BHenCu6mHp
         GVvh2wGuUY901DpGmAPh4Bb0l9L04dehjgJAuMZEPFWJqNFJpppzlsKKvBuXgi1P5zob
         ZpxdgNCH+acJeuqzSUj800PbobNIZldSTG00cqEAVpfGG8Rp4rzpFgHipubdoNUZh/nL
         3gBIQ3CxKb44DnCL/8yo9mBZq/Iwb2JRD+y4ABL6wfyNsZ2t6rIeM6u7qOqhrq6Mfm91
         BDKhwWJFwizMMGm9gYvRweUIWB9wJX6GMLet0Oqm0Vr7b8c67NzY1oNK6kOWcpOAVR+d
         xvfg==
X-Received: by 10.224.167.84 with SMTP id p20mr1344716qay.24.1392901501323;
 Thu, 20 Feb 2014 05:05:01 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Thu, 20 Feb 2014 05:04:31 -0800 (PST)
In-Reply-To: <xmqqppmi97s3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242430>

On Thu, Feb 20, 2014 at 3:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> +     strbuf_setlen(sb, len);
>> +     strbuf_add(sb, s, strlen(s));
>
> I am not sure addstr_at() gives us a good abstraction, or at least
> the name conveys what it does well not to confuse readers.
>
> At first after only seeing its name, I would have expected that it
> would splice the given string into an existing strbuf at the
> location, not chopping the existing strbuf at the location and
> appending.

I think I invented a few new strbuf_* in this series and this is one
of them. We have about ~14 other places in current code that do
similar pattern: set length back, then add something on top. Not sure
if it's worth a convenient wrapper. I don't know, maybe it's not worth
reducing one line and causing more confusion.

>
>> +}
>>  static inline void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2) {
>>       strbuf_grow(sb, sb2->len);
>>       strbuf_add(sb, sb2->buf, sb2->len);



-- 
Duy
