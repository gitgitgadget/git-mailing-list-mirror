From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/5] worktree.c: add find_worktree_by_path()
Date: Mon, 30 May 2016 16:56:28 +0700
Message-ID: <CACsJy8D1WsrA9723FR_m8jR3W4RaiUtu7KHK-37-qLcj9+NfhQ@mail.gmail.com>
References: <20160510141416.GA22672@lanh> <20160522104341.656-1-pclouds@gmail.com>
 <20160522104341.656-2-pclouds@gmail.com> <CAPig+cRnt4ELACEitEkiZxbVT9Uk8hzdj0Ts7cwZwh2qPoa1cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon May 30 11:57:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7JwU-0003dH-TT
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 11:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754403AbcE3J47 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2016 05:56:59 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:36830 "EHLO
	mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbcE3J46 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2016 05:56:58 -0400
Received: by mail-it0-f43.google.com with SMTP id e62so34149298ita.1
        for <git@vger.kernel.org>; Mon, 30 May 2016 02:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y/aRmfP/ei/4OP2P/g87pAXxbnYV32bq7Cm5KgTs5qs=;
        b=llzkdaKKuJqOQI2uIrON0jlDVMb3Yqj9YixwlB1B8tIUbfBTsR3M00a6gP3qHq/fQh
         v2p+pUz5gjoYPHxKETMiT86jp1JoqvLNRdjFtpixM9OVgDBLb1ELtaMPCvNz1/HTltqu
         FEwoBXhrAWDWaO0zbrJJOQTj+5NxIGqA/bYG11vY/Aii/692hzBO146auuih3ijtsw7E
         wZuLgrpViYCr6RZDK8ZCPJvQEUBtXJcMZL6YuakXebtuHi1UoCDNMJ+iwl4WNmloQoEC
         sKF/m7bzkiBv+bZYwglOaK9JELRh7aCxKkYPzsPjlTMrtagV3pKD7b7/gsGX2oVo5JFo
         qDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y/aRmfP/ei/4OP2P/g87pAXxbnYV32bq7Cm5KgTs5qs=;
        b=IFZeBzCN+bdKTYb4XsY3gCcdRqY4ShrllHHnjAB9xRMOYo9ZJzLt3ObkM6YkflHPZG
         PXWFGs7IKDHzCLJ8ZWDzFO1YTXJBP5CCUoE53qLlScibdacuxGzUHBoFDtzg9AF3pbl+
         /L4UWSpj22WQFw60u2+Qk6Yw3yt59/TOD0gPcA/Np0G1d1/z5ehOkZsEhnbuf3eY5TEC
         G/Jz2k4iVuurpwBq2pudCVhalaq2MDXKerqOtV6Qhhk2c6WjjXDKxmkM6ooTlKS/ojeC
         F6PiLceAd7n8TlP39QVepusFT/fc5/SR1x8cQ+zGW2/U0t6qkmcI5E3c10OjooJ5xiVd
         grvQ==
X-Gm-Message-State: ALyK8tJKcxrpJloI1blPL20nXTLsjG8kmeULFIiHqEFT/BVqU2vQjVNcwCu797bz8Wlk0FXZoVj4tl9Kr3LaJw==
X-Received: by 10.36.211.4 with SMTP id n4mr7330296itg.57.1464602217448; Mon,
 30 May 2016 02:56:57 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Mon, 30 May 2016 02:56:28 -0700 (PDT)
In-Reply-To: <CAPig+cRnt4ELACEitEkiZxbVT9Uk8hzdj0Ts7cwZwh2qPoa1cA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295874>

On Mon, May 23, 2016 at 11:11 AM, Eric Sunshine <sunshine@sunshineco.co=
m> wrote:
> On Sun, May 22, 2016 at 6:43 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>> So far we haven't needed to identify an existing worktree from comma=
nd
>> line. Future commands such as lock or move will need it. There are o=
f
>> course other options for identifying a worktree, for example by bran=
ch
>> or even by internal id. They may be added later if proved useful.
>
> Beyond the above methods for specifying a worktree, [1] adds
> $(basename $path) as a possibility if not ambiguous. Excerpt:
>
>     For git-worktree commands such as "lock", "mv", "remove", it
>     likely will be nice to allow people to specify the linked
>     worktree not only by path, but also by tag, and possibly even by
>     $(basename $path) if not ambiguous.

Thanks. This changes things. Turns out my "find_by_path" API  cannot
be easily extended to support identifying worktrees some other way. I
will need to pass the command line argument as-is, so that this
"find_worktree" (by any means) has enough info to decide (especially
about ambiguation).
--=20
Duy
