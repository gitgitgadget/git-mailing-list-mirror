From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git status: small difference between stating whole repository and
 small subdirectory
Date: Fri, 10 Feb 2012 21:37:21 +0700
Message-ID: <CACsJy8C05wvQRRQJLxrxYKHjXsgh6RugFexkPUKYGxbQkqiXJA@mail.gmail.com>
References: <CAA01Csr8FbvQ8uFvxX8_6i-hysin6JuaifVVC-yoLyoT0N5F4Q@mail.gmail.com>
 <CACsJy8DnqYZ5CdZqbebWS4NS85mfwumyao0abeqDxMXrHhDELA@mail.gmail.com> <CAA01Csq+zVhRTjGqy1DJGK7o5wByd9ADsSim214T7Vkxmk+ykQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 15:38:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvrbq-0005dQ-OZ
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 15:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758158Ab2BJOhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 09:37:53 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:35176 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755193Ab2BJOhw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 09:37:52 -0500
Received: by wics10 with SMTP id s10so2055582wic.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 06:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QK4y1n9EG3maiE+GHzZ/nwb8Dm9QR7dBFwbpB85cSeo=;
        b=YqCuOHQkwDDY1BgrFf/flW+Hhj5yhBCLAbiqJ9nk31nwCEu8dsGGvsQQKkYz6t9f7A
         CUorbCU8ZHuryl0o+oGk6F0ceideCSjEdOH4X+kW1iK9fq8TSS68KstAo/8PGXfvd+A9
         4/rRCK5LYQAK4dRQsRP5T/lBYM5xzMBGp6218=
Received: by 10.180.87.8 with SMTP id t8mr3577020wiz.15.1328884671251; Fri, 10
 Feb 2012 06:37:51 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Fri, 10 Feb 2012 06:37:21 -0800 (PST)
In-Reply-To: <CAA01Csq+zVhRTjGqy1DJGK7o5wByd9ADsSim214T7Vkxmk+ykQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190411>

On Fri, Feb 10, 2012 at 8:46 PM, Piotr Krukowiecki
<piotr.krukowiecki@gmail.com> wrote:
> On Fri, Feb 10, 2012 at 1:33 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> On Fri, Feb 10, 2012 at 4:42 PM, Piotr Krukowiecki
>> <piotr.krukowiecki@gmail.com> wrote:
>>> Hi,
>>>
>>> I compared stating whole tree vs one small subdirectory, and I
>>> expected that for the subdirectory status will be very very fast.
>>> After all, it has only few files to stat. But it's not fast. Why?
>>
>> Because stat'ing is not the only thing git-status does? In order to
>> find out staged changes, unstaged changes and untracked files, it has
>> to do the equivalence of "git diff --cached", "git diff" and "git
>> ls-files -o". I think copy detection is also enabled, which uses more
>> cycles.
>
> I believe copy detection is not done, neither for tracked nor untracked files.
> Rename detection is done for tracked files. In this case it should not
> matter, as there were no changes to the files.
>
> My point is, that for such small number of small files (55 files and
> 223KB), which had no changes at all, the status took a lot of time (17
> seconds) and doing status on whole repository which has more than
> 2000x files and 10000x data took only 2x more time.
>
> I don't think that the algorithm scales so well, so my guess is that
> 'status' is so inefficient for subdirectories (i.e. the "git status --
> dir" filter does not filter as much as it could).

I think the cost is in $GIT_DIR, not the working directory.
-- 
Duy
