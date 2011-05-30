From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 3/3] verify_path: consider dos drive prefix
Date: Mon, 30 May 2011 13:17:56 +0200
Message-ID: <BANLkTi=o6p=E4bM+CG77yKrFFvQ8sBS07g@mail.gmail.com>
References: <1306512040-1468-1-git-send-email-kusmabite@gmail.com>
 <1306512040-1468-4-git-send-email-kusmabite@gmail.com> <4DDFF473.7030104@kdbg.org>
 <BANLkTikdeq7cuhi0uo7Q6wqDJK3nxjmP-g@mail.gmail.com> <C8718F35FD1A4C3C84A4D353D27621E0@martinic.local>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	gitster@pobox.com, johannes.schindelin@gmx.de
To: Theo Niessink <theo@taletn.com>
X-From: git-owner@vger.kernel.org Mon May 30 13:18:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR0Uc-0007kv-Q0
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 13:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753699Ab1E3LSh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 07:18:37 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56292 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634Ab1E3LSh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 07:18:37 -0400
Received: by pwi15 with SMTP id 15so1603568pwi.19
        for <git@vger.kernel.org>; Mon, 30 May 2011 04:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=6DwlHOM5X3D/yXVcGrGt6DjTtgODDczKWilY1gq1Bxk=;
        b=JCM19OjymaDQamjqQ56xLJhfyofldxFlHUnywGEBbvKJGVXYq/z+/QPREp9O3HBdq3
         f0CBuPkUFy+exq+ZNRk33Vm/ipxSOx3+wd2Fc+GUCkHEJNe2NdJ7bcN6wrxmuYc5/BgA
         N6qKm1cqG365qo1HPIhvXW4Tkk2jvrQosO7K0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=IAcCdROAF8QNhRxKLYkvOisD/2ZT6IopVqDyswZ0fbl7Dt32CYvZ6F5LDlDXf05tIw
         wSJvCWqQsKS3nf64wa6ARJpZ6vCU+ozUM6XrgWWHpekYgmXd0Wta8wUJoIrkXpgqwJn1
         AHFnu71GYaTL6UUpEFTzjdYdoXRvszIPHNz6Q=
Received: by 10.68.71.135 with SMTP id v7mr2097395pbu.232.1306754316334; Mon,
 30 May 2011 04:18:36 -0700 (PDT)
Received: by 10.68.47.131 with HTTP; Mon, 30 May 2011 04:17:56 -0700 (PDT)
In-Reply-To: <C8718F35FD1A4C3C84A4D353D27621E0@martinic.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174739>

On Mon, May 30, 2011 at 12:58 PM, Theo Niessink <theo@taletn.com> wrote:
> Erik Faye-Lund wrote:
>> But I think I might have been a bit too care-less; I didn't fix the
>> switch-case to check for multiple backslashes on Windows. It's not
>> immediately obvious if this is needed or not, but I don't think it can
>> cause harm; we should never have created an index like that anyway.
>>
>> So something like this on top, perhaps?
>
> Nitpick: If you already know that c != '\0' and !is_dir_sep(c), then why do
> continue? It will check for '\0' and is_dir_sep(c) again, but you already
> know that both ifs will be false. So you could just as easy jump straight to
> c = *path++, which IMHO also makes the code easier to follow:

Very good point, thanks for noticing. I just rewrote the logic from
switch/case to if/else, but with the rewrite these redundant compares
became more obvious. I think your version is better, indeed.
