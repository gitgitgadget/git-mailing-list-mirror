From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC] get_sha1: prefer 40-hex ref name over 40-hex SHA-1
Date: Thu, 2 May 2013 17:09:29 +0700
Message-ID: <CACsJy8AOEEAJ6jtcaAWmrfCbejq8SLcEsUNSsrOEJ6he+5CByA@mail.gmail.com>
References: <1367377282-9862-1-git-send-email-pclouds@gmail.com> <20130501184327.GM24467@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 12:10:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXqSk-0007ub-Q9
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 12:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824Ab3EBKKA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 May 2013 06:10:00 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:53221 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751986Ab3EBKKA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 May 2013 06:10:00 -0400
Received: by mail-oa0-f41.google.com with SMTP id k14so350127oag.14
        for <git@vger.kernel.org>; Thu, 02 May 2013 03:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=PUNnTEL1nemkhCKqczrwmBla1hjEdI/7u39hRASy4OI=;
        b=JOk/adMqCvso9jBxZNONzr7wOFJ2FEQ0N9RdaNkx89z+iqz4OlcQ41GfW3yISyu9kz
         MMlVpkR7Kzfb6GBpBJVLOZ5xvOuTDJteqLQgqEFypJleyFSwnjKg5Gh26UZJ6bKWt0ud
         vPC1I3oXcl+MqwrhqQExIchIrKnFTEsvYxH+g1C+wgnJWhFpFY7BIOLQl9cPZA6zIcQQ
         /bqt2rITcbvCAU9qrEIeOWaoQ4vIraSi+NOt2lXSakP/lbRCXXakzJ8/vkRrhjedUtyH
         ltTP0X3Il5TPEbWIyaEv2XNR7OheFDC4c3ozbIudQw9gP4+bz60TuYwGjKhcwhSL46ad
         LsBQ==
X-Received: by 10.182.224.162 with SMTP id rd2mr1574752obc.95.1367489399513;
 Thu, 02 May 2013 03:09:59 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Thu, 2 May 2013 03:09:29 -0700 (PDT)
In-Reply-To: <20130501184327.GM24467@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223188>

On Thu, May 2, 2013 at 1:43 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>>                                              "git rev-parse 1234" wi=
ll
>> resolve refs/heads/1234 if exists even if there is an unambiguous
>> SHA-1 starting with 1234. However if it's full SHA-1, the SHA-1 take=
s
>> precedence and refs with the same name are ignored.
>
> That's an important feature for safety.  When a script has created an
> object or learned about it some other way, as long as it doesn't
> abbreviate its name it can be sure that git commands will not
> misunderstand it.

Then what about abbrev sha-1? You pick up an abbrev sha-1 from "git
log --oneline", do "git show <abbrev>". If you happen to have
refs/heads/<abbrev> then what you see is not what you intend to see.
Warn about ambiguity and move on? Banning all sha1-alike refs seems
unreasonable (or not? I don't know).

> So I think this is a bad change.  Maybe check-ref-format should
> reject 40-hexdigit refnames?

I tried that first. The test suite screamed. Will do that again and
figure out soon.
--
Duy
