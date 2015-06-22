From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 19/19] delete_ref(): use the usual convention for old_sha1
Date: Mon, 22 Jun 2015 14:10:08 -0700
Message-ID: <xmqqpp4nfo0f.fsf@gitster.dls.corp.google.com>
References: <cover.1434980615.git.mhagger@alum.mit.edu>
	<29ca4c18c045147c5260eb699dad31d0e4036e8b.1434980615.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 22 23:10:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z78yu-0001yn-7t
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 23:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbbFVVKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 17:10:12 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:32943 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbbFVVKK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 17:10:10 -0400
Received: by ieqy10 with SMTP id y10so35601122ieq.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 14:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=SHUHVcXrfOGBNqoCCAndGwR4sP3q2ehavbG9J+jRnC0=;
        b=K3KLtLseCkTIzNQJam8OP9Suo8w9S6bu2L4gZ9YXYNw4VCoXAd4JEJ8FDo6l6aztnz
         9JXbfD+JdhMprTi4+XIml6gWTk/e9TEDfVq5sJzWKVWBaFOSanLSk4+Sy0TFx0ZZ/2Ea
         p44BMbM1q7n1eb6t1vphATiUm96C6/mS+DRAfuSkZDm6Kw2/Sh+1xsxo4KKbU5Li6B4C
         BjSPGnIyLXrWeKuxi1Ds9sRzMevASuSEhil3Db9rKwEngg+xssA3sE9fkGRqyMH+Gc9W
         lcr5T1ju7q4IiU68u79WAj7uUX2ntNmF/gBKgLeV5OOUJii/W1i6c4IbsUOwtTfBvsRl
         gXlQ==
X-Received: by 10.43.84.73 with SMTP id aj9mr28352920icc.69.1435007410132;
        Mon, 22 Jun 2015 14:10:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0be:ae3d:b206:8e25])
        by mx.google.com with ESMTPSA id x4sm13560996iod.26.2015.06.22.14.10.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Jun 2015 14:10:09 -0700 (PDT)
In-Reply-To: <29ca4c18c045147c5260eb699dad31d0e4036e8b.1434980615.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 22 Jun 2015 16:03:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272418>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The ref_transaction_update() family of functions use the following
> convention for their old_sha1 parameters:
>
> * old_sha1 == NULL: Don't check the old value at all.
> * is_null_sha1(old_sha1): Ensure that the reference didn't exist
>   before the transaction.
> * otherwise: Ensure that the reference had the specified value before
>   the transaction.
>
> delete_ref() had a different convention, namely treating
> is_null_sha1(old_sha1) as "don't care". Change it to adhere to the
> standard convention to reduce the scope for confusion.
>
> Please note that it is now a bug to pass old_sha1=NULL_SHA1 to
> delete_ref() (because it doesn't make sense to delete a reference that
> you already know doesn't exist). This is consistent with the behavior
> of ref_transaction_delete().

Nice.

Everything I read in this round of changes makes sense (except for
the ones I had minor comments on, which were separately sent).

Thanks.
