Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972C1EB64DD
	for <git@archiver.kernel.org>; Thu, 27 Jul 2023 23:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjG0XO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jul 2023 19:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjG0XO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2023 19:14:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914CD2701
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 16:14:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c647150c254so2505493276.1
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 16:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690499695; x=1691104495;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A+fFwn3ZiHWc5y359JiJ2GJtyzexwq5BaSRXYy6PqOk=;
        b=J8U8UbweCtCQpwy+tGcSu8FP/E8XQa3Y9nUNocBMo7LUPC1N3DfXAV8Upl3GCfcjTl
         rJyAXju4VQBBmfVabvQ6cG4qoMk2fuyf2BD3xGH9uDRtkVTUIO4W/OHHZ9XXjovCYJul
         Tf0z4/aalLqyLx9+AKoR2SA3i8nV82bApkJPafvfwnlUX44KBxxiE4bpleEJVtDo8dbx
         ekfvtIkGZzqw6S8KZLcBymWmOPjL7Nhgw/FJ3ZQEgH5U0H/ovm8bZzH7unOFpAYvt3wK
         1jOfvhFAdQGBKqwllBNhdWtXmCffLF/K1ojmiT3LKYWea/86KgQfQcIZciQNO7y7jGJQ
         9B4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690499695; x=1691104495;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+fFwn3ZiHWc5y359JiJ2GJtyzexwq5BaSRXYy6PqOk=;
        b=GVM1NRkH/Ds8OLeRPKoQc9xaU5CAJ4DmWbXY92zGWvy7JI8pJyOE6UyDLer4bCNCBK
         2UsnNFgiTVHkSjh+0FlrbKMgMWfvXHaDDvsdu4qdxTZ2f4UdK8UknvlOkta++lCoDLbQ
         F3GDfsvaW+mabOn0mGqeOfaz0FtauP04dn4/LZYCuGkRL28PxzINm1qOxBXeF8v/8NJ1
         pcIhxboyjkaH08HyIk5Jrzckvve+3ucFQFMOTKsjkJo+zp4K8pmNQ1MD1h7SJKScfWM1
         YwEeuea4eZE7tbe/e5OUzOc/q9j2ZhehhGhnXzrROgo7xvWS/RaPQDZ38jC7HaZOeErp
         c+gQ==
X-Gm-Message-State: ABy/qLYfAg1AVcHKmRP6tQ50djyZCNXAf90JcjEm8xikT4BplQYp0Pkw
        LdUQP76oPMx/bacQ1LNIgGRYN1YvJlc=
X-Google-Smtp-Source: APBJJlHe9yk7VGdz79K8MG5t04k3VeANtQyzV+lSGMVXavTTXE1PR+jamYXaDGZM2/78o9vegnpCi7tcll8=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6902:11cb:b0:d16:7ccc:b406 with SMTP id
 n11-20020a05690211cb00b00d167cccb406mr332ybu.5.1690499694881; Thu, 27 Jul
 2023 16:14:54 -0700 (PDT)
Date:   Thu, 27 Jul 2023 16:14:52 -0700
In-Reply-To: <xmqq8rbbbzp2.fsf_-_@gitster.g>
Mime-Version: 1.0
References: <xmqq3583uyk0.fsf@gitster.g> <20230122071156.367jwwt3d5txvkl4@tb-raspi4>
 <xmqqcz76tv6d.fsf@gitster.g> <xmqqzga9opdu.fsf@gitster.g> <20230123175804.2bkcr7yawyz5fhkb@tb-raspi4>
 <xmqq8rbbbzp2.fsf_-_@gitster.g>
Message-ID: <owlycz0deykz.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v3] MyFirstContribution: refrain from self-iterating too much
From:   Linus Arver <linusa@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     "Torsten =?utf-8?Q?B=C3=B6gershausen?=" <tboegi@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was in the process of writing a review but my comments were getting a
bit long. So to save you the trouble of applying the suggested changes,
I have a scissors patch version at the bottom with the changes applied
(you may simply want to read that first).

Junio C Hamano <gitster@pobox.com> writes:

> +After you sent out your first patch, you may find mistakes in it, or

s/you sent/sending

Also, add "perhaps realize" after "or".

> +a different and better way to achieve the goal of the patch.  But
> +please resist the temptation to send a new version immediately.
> +
> + - If the mistakes you found are minor, send a reply to your patch as
> +   if you were a reviewer and mention that you will fix them in an

s/a/the

> +   updated version.
> +
> + - On the other hand, if you think you want to change the course so
> +   drastically that reviews on the initial patch would become
> +   useless, send a reply to your patch to say so immediately to
> +   avoid wasting others' time (e.g. "I am working on a better
> +   approach, so please ignore this patch, and wait for the updated
> +   version.")

How about this wording?

     - On the other hand, if you think you want to change the course so
       drastically that reviews on the initial patch would be a waste of
       time (for everyone involved), retract the patch immediately with
       a reply like "I am working on a much better approach, so please
       ignore this patch and wait for the updated version."
 
> +Then give reviewers enough time to process your initial patch before
> +sending an updated version (unless you retracted the initial patch,
> +that is).

I think this paragraph should be moved inside the first one above. So it
could read something like this:

    Please give reviewers enough time to process your initial patch before
    sending an updated version. That is, resist the temptation to send a new
    version immediately (because it may be the case that others may have
    already started reviewing your initial version).

    While waiting for review comments, you may find mistakes in your initial
    patch, or perhaps realize a different and better way to achieve the goal
    of the patch. In this case you may communicate your findings to other
    reviewers as follows:

> +Now, the above is a good practice if you sent your initial patch
> +prematurely without polish.  But a better approach of course is to
> +avoid sending your patch prematurely in the first place.

OK.

> +Keep in mind that people in the development community do not have to
> +see your patch immediately after you wrote it.

How about just

     Please be considerate of the time needed by reviewers to examine
     each new version of your patch.

?

> Instead of seeing

s/Instead of/Rather than

> +the initial version right now, that will be followed by several

s/, that will be / (

> +updated "oops, I like this version better than the previous one"

s/updated//

> +versions over 2 days, reviewers would more appreciate if a single

s/versions over 2 days,/patches over 2 days),

s/more appreciate/strongly prefer

> +polished version came 2 days late and that version with fewer

s/2 days late/instead,

> +mistakes were the only one they need to review.

s/need/would need/
> +
>  [[reviewing]]
>  === Responding to Reviews
>  
> -- 
> 2.41.0-376-gcba07a324d

Below is my scissor patch version.

--8<---------------cut here---------------start------------->8---
Please give reviewers enough time to process your initial patch before
sending an updated version. That is, resist the temptation to send a new
version immediately (because it may be the case that others may have
already started reviewing your initial version).

While waiting for review comments, you may find mistakes in your initial
patch, or perhaps realize a different and better way to achieve the goal
of the patch. In this case you may communicate your findings to other
reviewers as follows:

 - If the mistakes you found are minor, send a reply to your patch as if
   you were the reviewer and mention that you will fix them in an
   updated version.

 - On the other hand, if you think you want to change the course so
   drastically that reviews on the initial patch would be a waste of
   time (for everyone involved), retract the patch immediately with
   a reply like "I am working on a much better approach, so please
   ignore this patch and wait for the updated version."

Now, the above is a good practice if you sent your initial patch
prematurely without polish.  But a better approach of course is to avoid
sending your patch prematurely in the first place.

Please be considerate of the time needed by reviewers to examine each
new version of your patch. Rather than seeing the initial version right
now (followed by several "oops, I like this version better than the
previous one" patches over 2 days), reviewers would strongly prefer if a
single polished version came instead, and that version with fewer
mistakes were the only one they would need to review.
--8<---------------cut here---------------end--------------->8---
 
