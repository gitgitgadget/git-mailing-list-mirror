From: =?UTF-8?Q?Felipe_Gon=C3=A7alves_Assis?= <felipeg.assis@gmail.com>
Subject: Re: Custom merge driver with no rename detection
Date: Mon, 15 Feb 2016 08:42:34 -0200
Message-ID: <CALMa68p9jdO63k2NLTUJXyms=Fc+woXx00UXCxzJ5_zV8jO8Rw@mail.gmail.com>
References: <CALMa68ovz=VZYkCcUDvEn1d7=xJDx__71caqsPXUFASZ1phfdw@mail.gmail.com>
	<alpine.DEB.2.20.1602150858340.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 15 11:42:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVGcC-000261-7V
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 11:42:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbcBOKmf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 05:42:35 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37795 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbcBOKme convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2016 05:42:34 -0500
Received: by mail-ig0-f181.google.com with SMTP id 5so53006379igt.0
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 02:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3bpNClCo7TTdWRbbCvoK4IwOHHtf1l4RYVmdT6IFg/g=;
        b=qBPQDjnCNcigICpMhe69QedpO9TZBcca1vcP9vDC12NiEfwDJrV31w7P7zFwjih1pN
         Kyv4rrTw8atHYcAYffyyAA/sU3oUTyTmZ7hcbVJmMtypHjFQP6ZkfmKJMVEkYzN9nZzc
         Pm8K9AlWHYWnTiMg0w69AgNmJNCXb24Dpl5galfa0NBsJZdN1mcIEY2GVCtugzEQcman
         b5w/LT8CSa8My9CndEywGBsiBq31DZ4SEbErvlpGrnDYwrh5lHKSztyuN4WBVabVe9MW
         XP39iiOYwCXih0CDcMslAZkzGPoVFHfYcTXTj8bO8o4Z8YNCAkEvjZrItaN0b66Wj5Rd
         9Psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3bpNClCo7TTdWRbbCvoK4IwOHHtf1l4RYVmdT6IFg/g=;
        b=ahpy/DssRoV/3KKw5Y6qYVmR3pgIoVTzU7N8lHRiSs/fZ0+PCNlqH45i7aI2jyP42V
         fJDarDmzbbwqnlwszrrgg7uYtBpQqGVaQH5TKxleuw1uD/XwqF2RxAb8lJwHd0UT4iDD
         JRkTaIzitLbPW7gCc7aOkoTWdIPHm9gtxU34v87bVKGMBmqIM0jUIMWwRsPZ7cVW3jKf
         ZHeyZ10wTrEKE9IE3adCm0mPOIfFrFdB5EJCsLHYWVd9MRRs6+q4xeHgPstMRa05RB66
         LY8mxtVj+GbatImKwlUDraoAvV8W8Ca5FnQR+YUlGBASHdqP3K8FSG2CvQB1x8t0GxcZ
         VTrw==
X-Gm-Message-State: AG10YORXJZvpn57Cw5mjMyGCEduhOro8/uKVUeujSHNdQrqCG0eqxhC1lZyzoc4RnW9fMpl6a20SViTa1iyDaA==
X-Received: by 10.50.43.199 with SMTP id y7mr12063767igl.47.1455532954111;
 Mon, 15 Feb 2016 02:42:34 -0800 (PST)
Received: by 10.107.3.94 with HTTP; Mon, 15 Feb 2016 02:42:34 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1602150858340.2964@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286201>

On 15 February 2016 at 06:06, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Felipe,
>
> On Sun, 14 Feb 2016, Felipe Gon=C3=A7alves Assis wrote:
>
>> Attached is a quick and dirty patch that emulates the effect by
>> allowing greater than 100% rename thresholds to mean "no-renames".
>
> It is really hard to comment on attached patches.
>
> First comment: the commit message is awfully empty, and lacks a sign-=
off.
>

Thanks. I am sorry for not submitting the patch separately in an
email, but, it was really not meant for serious review, just for
emulating the desired effect with minimal effort.

However, if you do find this approach acceptable/desirable
(rename-threshold > 100%), I can work on the issues pointed out and
propose a proper patch.

Regards,
=46elipe
