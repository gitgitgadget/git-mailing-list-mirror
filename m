From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/3] name-rev: fix assumption about --name-only usage
Date: Mon, 8 Jul 2013 18:48:33 +0530
Message-ID: <CALkWK0=j_ZwiiQ+-PFxptH7mLvkRDyHXhyiTuoCT5gNXrJUFgg@mail.gmail.com>
References: <1373200996-9753-1-git-send-email-artagnon@gmail.com>
 <1373200996-9753-2-git-send-email-artagnon@gmail.com> <7v61wm44k0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 08 15:19:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwBLh-00079E-4D
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 15:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936Ab3GHNTP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 09:19:15 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34271 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab3GHNTO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 09:19:14 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so9795566ief.40
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 06:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zhhmcukZCGdV+i4FkIQwQZGfaQvfu1cqpubkIi7CYaA=;
        b=CsV7PsHpqJ1new2hYxI2AobCZHhZLKiLxMvU2Z1qCXVEuJi4CnXP/DwK43realUsAI
         O5kVMLlcUx8ej8VkRDlHrt08ge48dX2diHGnxIEPBynNLW++li8OqY78Gq8hBLbnCZ20
         CD93FFsAs67JBHdfPBBcHhnhQa6Yv9n978pD/uTPTQiaeSbcuuxlnemHnAJqrpZwODbx
         nOroeqBwP52YTwbhi0cbpQYH+DJmHES9bCPKcNm3rzBD1EWWBabvWeRzFqWEjKwr+jWU
         kARnbMxkI3S+72ZngXhman2XUfpt5s/Bk0u/IrUoAye4nFZjmmqw2omOs5qngGBhd3Q3
         VPkg==
X-Received: by 10.50.66.130 with SMTP id f2mr32094606igt.55.1373289553833;
 Mon, 08 Jul 2013 06:19:13 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Mon, 8 Jul 2013 06:18:33 -0700 (PDT)
In-Reply-To: <7v61wm44k0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229850>

Junio C Hamano wrote:
>> would get name-rev to print output in the same format as describe,
>>
>>   $ git describe --contains --all v1.8.3~1
>>   tags/v1.8.3~1
>>
>> would not strip the leading "tags/".
>
> If you _know_ v1.8.3 does not appear outside "tags/", this does look
> inconsistent, but I do not think the code checks it.  Ahd if the
> code does not, I am not sure not stripping "tags/" is necessarily a
> bad thing, because "--all" allows names to come outside "tags/"
> hierarchy.

Yeah, you asked for it using --all.

> Also how should this interact with v1.8.3-1-g98c5c4a that changed
> the rule somewhat so that the common prefix is stripped when we know
> the result is not ambiguous?

Completely independent of everything else.  The condition is "if
name-only && prefix == refs/tags", strip that prefix.
