From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-hg: unquote C-style paths when exporting
Date: Tue, 22 Oct 2013 19:45:22 -0500
Message-ID: <CAMP44s37-R0u4oLnuRfdghx-Tk3X9eer0MVTcAGmPZ3Bu32dug@mail.gmail.com>
References: <1382115821-12586-1-git-send-email-apelisse@gmail.com>
	<xmqq4n89t8yw.fsf@gitster.dls.corp.google.com>
	<CALWbr2zsOYNN45d+qHDQ88eLj82iV4QxJ_9ro+RGk7upBJVATA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 02:45:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYmZl-0002UF-3D
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 02:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751Ab3JWApZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 20:45:25 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:36494 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199Ab3JWApY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 20:45:24 -0400
Received: by mail-la0-f48.google.com with SMTP id ev20so69708lab.21
        for <git@vger.kernel.org>; Tue, 22 Oct 2013 17:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2RkMyMsKW6aytZIG22ycIx/RIGkENmo057e+dDDFQOU=;
        b=KFXnNSXLLrdmlgxd+s5xvmNc0JCr6I1MWOc7Hoss8QzLD04gTFJ178ctDPuvBTfuKS
         go5lNEx3oOIVSt5MqZYwPsSywuMtSEgIKbLydhEkyVM1iN1rkOIjrIfz1+tdb/FCn2sQ
         98du1QbzlbB1orgDRJrlpDedG9eEHEMFaWU8qULhbXrrOernyEIzd5jVhE5XUaQPSMrU
         uUGSq0sixO27iQu0ZP1kvNHbgeYeubnTwTN26A+MdZ+58QEgBL5pS2pfI/1lGqK30n5Z
         u81xni9pMrPluDsr6cSef/9FoW96+cVb7Hs/4Uxj/zY8gframQASFvHCjc9FlIqrMc/2
         lvjA==
X-Received: by 10.152.23.5 with SMTP id i5mr19440086laf.8.1382489123132; Tue,
 22 Oct 2013 17:45:23 -0700 (PDT)
Received: by 10.114.201.69 with HTTP; Tue, 22 Oct 2013 17:45:22 -0700 (PDT)
In-Reply-To: <CALWbr2zsOYNN45d+qHDQ88eLj82iV4QxJ_9ro+RGk7upBJVATA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236495>

On Tue, Oct 22, 2013 at 3:49 PM, Antoine Pelisse <apelisse@gmail.com> wrote:

> It is true that I have expected "valid output" from git-fast-export.
> And I don't have in mind any easy solution to detect that the output
> is broken, yet still accepted as a valid string by python. We could
> obviously write a unquote_c_style() equivalent in python if needed.

Something like this?

def c_style_unescape(string):
    if string[0] == string[-1] == '"':
        return string.decode('string-escape')[1:-1]
    return string

It's in git-remote-bzr.py.

-- 
Felipe Contreras
