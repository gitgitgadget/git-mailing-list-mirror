From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] attr: fix off-by-one directory component length calculation
Date: Wed, 16 Jan 2013 10:12:16 +0700
Message-ID: <CACsJy8C2uEgwozpWBfowYJea3XRB72rhzjsSFuG9Ud0afuQy6w@mail.gmail.com>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com>
 <201301152014.28433.avila.jn@gmail.com> <7vwqve2qk3.fsf@alter.siamese.dyndns.org>
 <CACsJy8Bn4GKJzi4n5cMPp+26dovT795nUqcXGNLgapf+r_PFCw@mail.gmail.com>
 <20130116020901.GA1041@duynguyen-vnpc.dek-tpc.internal> <7vbocp26xa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <avila.jn@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 04:13:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvJR6-0005PG-9e
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 04:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757792Ab3APDMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 22:12:47 -0500
Received: from mail-ob0-f181.google.com ([209.85.214.181]:47155 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756776Ab3APDMr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 22:12:47 -0500
Received: by mail-ob0-f181.google.com with SMTP id oi10so906719obb.26
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 19:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Oa23hNTw0wSMtemNL5gX94hTwMMTUj0MZ5UTGoe5R80=;
        b=BzVau3T+OKBol1lxRfs/ONMvTx/G4EirYFaSI6siMVGytC4ADcMrcHYHbhud1Bir8w
         gzKjzEpQ3xi9y/DRJdDLHQsGr0gk/bjdXL6ipZM+8M+QLKljwFzeY9eJRmXVfoAqOQyo
         Zx8oFJQf9b3jIvx+pE6QBe2aeOwXZsaZ6kGmtr6SErspI68fMdtzvJxQJZbiBYMs4DTf
         +H+q1Bxq9jmGjc0G0jQlF2jNc9d0vGn+gpJvliHNya51KnqW9K/oM+nYDnUC/JNVGMPw
         raFv7uAditKF3mxDX9Jx5zdx4UWAKoy2oT2xOxLULB6OZQJdztXNc+W8Ac8aFMLPP1ky
         Ciaw==
Received: by 10.182.0.19 with SMTP id 19mr60848162oba.15.1358305966673; Tue,
 15 Jan 2013 19:12:46 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Tue, 15 Jan 2013 19:12:16 -0800 (PST)
In-Reply-To: <7vbocp26xa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213719>

On Wed, Jan 16, 2013 at 9:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Wed, Jan 16, 2013 at 08:08:03AM +0700, Duy Nguyen wrote:
>>> Actually I'd like to remove that function.
>>
>> This is what I had in mind:
>
> I think the replacement logic to find the basename is moderately
> inferiour to the original.  For one thing (this may be somewhat
> subjective), it is less readable now.

Yeah, maybe it's micro optimization.

> Also the original only
> scanned the string from the beginning once (instead of letting
> strlen() to scan once and go back).

But we do need to strlen() anyway in collect_all_attrs(). So we scan
the string 3 times (strlen + 2 * find_basename) in the original. Now
we do it twice
-- 
Duy
