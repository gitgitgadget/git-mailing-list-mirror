From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH] pull: Allow pull to preserve merges when rebasing.
Date: Mon, 12 Aug 2013 12:04:50 -0500
Organization: Exigence
Message-ID: <20130812120450.47f785b2@sh9>
References: <1376256387-30974-1-git-send-email-stephen@exigencecorp.com>
	<CAPrKj1b=QTdqVH+JtukJrfEc=EqxWOEYE4YG7oSY7413uqdKfg@mail.gmail.com>
	<20130811180915.390d660a@sh9>
	<CAPrKj1aMURcVoaiJ+WS64ekafUZgSagKrYSknTUk3+TL6tCETQ@mail.gmail.com>
	<7vr4dz1n6c.fsf@alter.siamese.dyndns.org>
	<7viozbz950.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Andres Perera <andres.p@zoho.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 19:05:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8vYA-00057a-Sf
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 19:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757239Ab3HLREz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 13:04:55 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:62048 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756898Ab3HLREy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 13:04:54 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so9371802obb.29
        for <git@vger.kernel.org>; Mon, 12 Aug 2013 10:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exigencecorp.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-type:content-transfer-encoding;
        bh=xoYhxUzGFk07/HN8uGB0oGiJKOPxOIv4E+xmZfaThIQ=;
        b=WvUnABb5jV5yZje6wSjJgw427rsRG8crlLJu5NEmPmcSzZh1J3vGE3pe0By4NXF6fQ
         hg3SSbFOk35GPADG80Ve++2UHY1NUP+mWD2CqOQBbpAqBa9iCiK3fussjMPOKUs2XitC
         4gtJCR1TypHJK7+Z0pbPe5G+cGFm8/O2JF+OA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-type
         :content-transfer-encoding;
        bh=xoYhxUzGFk07/HN8uGB0oGiJKOPxOIv4E+xmZfaThIQ=;
        b=eSKs6Tf/MNuyWtBq/ktzKt8FuPPhRu79e8BRfltg9jwnoKJMKCVn+aNhUiF4XRbRmE
         JwVV7sFYiROzo9YJig91wBKEAPoF1G8fG/NA2c1OZ7xVHvQngRS8tABxHdV3dsWVx2at
         bZ6Ncv75SsUlQts5P3NJOfsOWZa5OOeqZun6Le7sdTq+xx7iiZqyq4f2GwQnsx8yYv9q
         os9tg0P/5Yx238RkZEhw+AQQMXTwwEpjaGBMOs/RcHYInZjHY2b1N/1lUa1p3U+9DdzB
         j9dN3DdBDYwL6wg7eU6ibi848XTInK3OGrqTK0esuOP0EypozmB6+gbpcQUkUaPVDdoc
         PE1w==
X-Gm-Message-State: ALoCoQkFLjG9inD81XQzgqhwEkpVTSzi9NFtiHEeBYtt+xtR9DxXXbgao4tuTKB2KYPuGae8xguQ
X-Received: by 10.60.155.200 with SMTP id vy8mr44219oeb.72.1376327093005;
        Mon, 12 Aug 2013 10:04:53 -0700 (PDT)
Received: from sh9 (wsip-70-184-197-10.om.om.cox.net. [70.184.197.10])
        by mx.google.com with ESMTPSA id z2sm34284964obi.3.2013.08.12.10.04.51
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Mon, 12 Aug 2013 10:04:52 -0700 (PDT)
In-Reply-To: <7viozbz950.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.9.1 (GTK+ 2.24.17; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232198>


> How should this interact with 949e0d8e (pull: require choice between
> rebase/merge on non-fast-forward pull, 2013-06-27)

I believe there should not be any conflicts in functionality, other
than just tweaking the docs to mention --rebase=preserve as an option.

Personally, I would assert that, for people using a rebase workflow with
"git pull", --prebase=preserve should be the default behavior, otherwise
they'll be surprised when their feature branches get flattened.

Unfortunately, we can't change the behavior of the naked "--rebase"
flag to really mean "--rebase=preserve", but I think that would be
ideal. I think it's what people mean they do "git pull". If you want a
more raw rebase, they would likely (I think/assume) be running "git
rebase" directly.

Nonetheless, thanks for pointing out 949e0d8e, I did not know about it.

Perhaps after that commit graduates to master, I can base this commit
on it, and tweak the new docs to suggest --rebase=preserve as the
least-surprising behavior.

(Since I'm offering opinions, I think --rebase=preserve would be a great
default for "git pull" in 2.0, but please ignore this statement if
you've already hashed out the future/2.0 behavior of git pull.)

- Stephen
