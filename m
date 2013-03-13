From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] tag: --force is quiet about new tags
Date: Wed, 13 Mar 2013 00:21:00 -0400
Message-ID: <CABURp0oT8ZN5fKtKh67Gm1P5rf_a3diqcYbw8mUga-gv5MPu6Q@mail.gmail.com>
References: <1363130021-28624-1-git-send-email-hordp@cisco.com> <7vy5ds3re0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Phil Hord <hordp@cisco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 05:21:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFdCL-0005hT-N1
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 05:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109Ab3CMEVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 00:21:22 -0400
Received: from mail-ve0-f182.google.com ([209.85.128.182]:38567 "EHLO
	mail-ve0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914Ab3CMEVV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 00:21:21 -0400
Received: by mail-ve0-f182.google.com with SMTP id ox1so428537veb.13
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 21:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Ym/iASHQl7NZnqxHRntc+JbmPZy+4gxx7Xd+7LX0rFI=;
        b=qGwzmXjSXJ7KB6uXicL/1vFx3TtSwOs/lfSz++aI/WnElTrUbFhFcWjUneXyLS68ox
         KR/z4o/z3G5T7+QmYGryDBkt9L0WqBw0QP2TBUDjW35ros7weaJCOr1924wocQqwftAp
         a9dKq7nfuLsTP4dI50oQebi4V2MGnYun9bjXvtTctcktXpXAsBuJc13Rl597125ZRMT7
         0qxDbcFLzTM4G2yq24LUvxCIlhXW1KYj3aGqGBkD/niUpA8iMz0TeTFxdoTRFplxcnjX
         +ddBhkUQMmYeLSjmpiCQ3mPwBJG8FCpp+5CCA5aH+xRAK6P5dUPTbSR2zN1HDS6TTYvb
         tEUA==
X-Received: by 10.52.92.199 with SMTP id co7mr6555242vdb.82.1363148480594;
 Tue, 12 Mar 2013 21:21:20 -0700 (PDT)
Received: by 10.58.201.103 with HTTP; Tue, 12 Mar 2013 21:21:00 -0700 (PDT)
In-Reply-To: <7vy5ds3re0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218032>

On Tue, Mar 12, 2013 at 11:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Phil Hord <hordp@cisco.com> writes:
>
>> git tag --force is used to replace an existing tag with
>> a new reference.  Git helpfully tells the user the old
>> ref when this happens.  But if the tag name is new and does
>> not exist, git tells the user the old ref anyway (000000).
>>
>> Teach git to ignore --force if the tag is new.  Add a test
>> for this and also to ensure --force can replace tags at all.
>>
>> Signed-off-by: Phil Hord <hordp@cisco.com>
>> ---
>
> I think we would still want to allow the operation to go through,
> even when the --force option is given, to create a new tag.  I agree
> that the message should not say "Updated".  So teaching Git not to
> issue the "Updated" message makes perfect sense.  It is somewhat
> misleading to say we are teaching Git to ignore the option, though.
>
> Thanks.

My phrasing was too ambiguous.  What you described is exactly what the
patch does.  --force is superfluous when the tag does not already
exist.  It is only checked in two places, and one of those is to
decide whether to print the "Updated" message.  How's this?

   Teach 'git tag --force' to suppress the update message if
   the tag is new.  Add a test for this and also to ensure
   --force can replace tags at all.

Phil
