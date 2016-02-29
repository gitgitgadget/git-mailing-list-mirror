From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 0/7] replacing strbuf_getline_lf() by strbuf_getline()
Date: Mon, 29 Feb 2016 13:26:48 -0500
Message-ID: <CAPig+cT4+bKS53E6bmLNn=xWkXK2Tx8N9bDEqGCNwNy-qjMOUg@mail.gmail.com>
References: <56D28092.9090209@moritzneeb.de>
	<56D401C2.8020100@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Moritz Neeb <lists@moritzneeb.de>
X-From: git-owner@vger.kernel.org Mon Feb 29 19:26:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaSWz-0004IR-QH
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 19:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbcB2S0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 13:26:49 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33751 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbcB2S0t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 13:26:49 -0500
Received: by mail-vk0-f68.google.com with SMTP id c3so9958729vkb.0
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 10:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=yCodZc+9PD9IOKX+/jmuHEnKEkxLdYYY9+INqmyBV+o=;
        b=MVJyq914opYkGdLZf5gfRQkxgLaBcCXsiZ8jYpFc8h2aOr+PhqSNh54UjEsEfw86gl
         guTQlJY0je/gIA+0GXxXAw8Fa4A0obD40rmjo0wv7a7hJzcf0u0vdTH3WNQkcGu+17sQ
         Gp8B6tdDkJze4dhXpiv4CYaeDTJmH/Uhf3AIvVIEzJIlHSmwdxK/J8pRxR6OtNTg9dxW
         ISaMolEfI/fTEy1/JcBaq9syy2xpYc2lmr+cRRMrUdP//1DbIbCnM75jiKEcq+S4/UO2
         4xz0z4o8AjXGE4njJ+l7/job0R7VCirLDm3uJp5ogJnQyHDB3QVgdFd3vL/tp3vGG5VG
         fEtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=yCodZc+9PD9IOKX+/jmuHEnKEkxLdYYY9+INqmyBV+o=;
        b=O/9CJvW3d2DD/8bcEeEJ5pElTcOuYUrvhvW3el9DZzIyTORyyDTLnRqsKLbRM39ojf
         lGjM43sJrpH9D2RrXMvwwjvoONgelfT7XNN80aSDG7ioqN4YZn7/fKX9wPoCX9LwpqGE
         6nTLnxsPpzSGOX0ydZwiAW5ewpZtHBex3iaPQqhKCr40d+JEuuLpARw7YyciTt1o2K/5
         XlG7LcT+mFhfliRiHHe/KVKjFWssXDMwaWW0tP6d3+9r/E8efAbn0VO9DEBt7md2G2MX
         9pguft3zwkHLfJ5ua2qsLU9jhuCWmRT7pYhjclPHi27JNuj4kCAYtPbC5/ekfMJb6qJK
         P62Q==
X-Gm-Message-State: AD7BkJJIDGqNLepFmg9WJ7Zr49qwaZX1Ki4F4iEFuBfMSaAPF01B7wrIe+a8NZ1M/JmdE7f6r0zNoWNzPGP63g==
X-Received: by 10.31.8.142 with SMTP id 136mr12770560vki.14.1456770408100;
 Mon, 29 Feb 2016 10:26:48 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 29 Feb 2016 10:26:48 -0800 (PST)
In-Reply-To: <56D401C2.8020100@moritzneeb.de>
X-Google-Sender-Auth: NnuRqo3XM0KMRpl84S9JForvobk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287858>

On Mon, Feb 29, 2016 at 3:30 AM, Moritz Neeb <lists@moritzneeb.de> wrote:
> Although I was not sure [4], I decided to roll out v4, in the hope that the next
> reviewers will profit by the more polished commit messages and order.
>
> Changes since v3 [3] (the changes to single patches are indicated below):
>
>  * Commit messages refined
>  * Order of patch 4 and 5 in v2 was switched.

Thanks. With the exception of my commentary on patch 4/7, I think v4
addresses all my v3 review comments.
