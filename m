From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] tests: factor HOME=$(pwd) in test-lib.sh
Date: Mon, 30 Aug 2010 10:22:50 +0000
Message-ID: <AANLkTi=81oEPHko45Mo2d1qn+qWy-TVLvrFcXaVKd8Lu@mail.gmail.com>
References: <7vzkw4edc5.fsf@alter.siamese.dyndns.org>
	<1283161842-22689-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Aug 30 12:23:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq1W2-0008Gy-Dh
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 12:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289Ab0H3KWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 06:22:51 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37164 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889Ab0H3KWu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 06:22:50 -0400
Received: by iwn5 with SMTP id 5so4804020iwn.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 03:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=0f0UAQ6Y6RUjjkw3afV95WonJ8CGLdxfuAyOT4DwTwo=;
        b=Wftv2VlF14qD7/gXJTXSA+fu2bHhaULl+I+YwlrPmTWc1DCQBSvcPZRjMtA5RodzVu
         CEjar2+cvJN1GW/Li+DKZ0I/QXlR0RtfSV9CgaAXwiBzo4r4AxFR00kjME2LEwMygrTi
         3N84AbmbOCQPSn08QNULVnzwaJ2c2khlld/Vo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=fUG5VqxVR1HdTJqn+KZ3fn1pdFgkC+cOl1HCJ3vYMczAHCbmfG7jHkJc+TVccRvWbn
         A+Z9ikgNV5OEFMvsLIaB64hEvXMysaGp8UGbmzJ1yZY9HBl0rBzz5oCIs9FUyTmk07C3
         cKjdyJ+GGAlYO6TT64YEhSIpy4TlEtUyUNtDM=
Received: by 10.231.155.206 with SMTP id t14mr5220917ibw.34.1283163770070;
 Mon, 30 Aug 2010 03:22:50 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Mon, 30 Aug 2010 03:22:50 -0700 (PDT)
In-Reply-To: <1283161842-22689-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154782>

On Mon, Aug 30, 2010 at 09:50, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> The same pattern is used in many tests, and makes it easy for new ones to
> rely on $HOME being a trashable, clean, directory.

Looks good, but why not:

> +HOME=$(pwd)
> +export HOME

This instead:

HOME=$TRASH_DIRECTORY
export HOME

Looks like it might be more correct given this (always an absolute
path), but I haven't tested:

case "$test" in
/*) TRASH_DIRECTORY="$test" ;;
 *) TRASH_DIRECTORY="$TEST_DIRECTORY/$test" ;;
esac
