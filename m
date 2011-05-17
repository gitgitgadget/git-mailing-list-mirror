From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 08/11] streaming_write_entry(): support files with holes
Date: Tue, 17 May 2011 08:18:25 +0700
Message-ID: <BANLkTimF4zpNewcwsw=3pkt467p6Psq2Dw@mail.gmail.com>
References: <1305505831-31587-1-git-send-email-gitster@pobox.com>
 <1305505831-31587-9-git-send-email-gitster@pobox.com> <BANLkTi=VKb44yYuXdKLxrvFCVkfsDZSb4Q@mail.gmail.com>
 <7v62pan207.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 03:19:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM8w9-00006I-PM
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 03:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887Ab1EQBS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 21:18:57 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64380 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab1EQBS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 21:18:56 -0400
Received: by bwz15 with SMTP id 15so101801bwz.19
        for <git@vger.kernel.org>; Mon, 16 May 2011 18:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=DYtHI4u+aQcsiKHQ2b1XMn8N+S1OaoJOCM6OLHcEKZ4=;
        b=I66ota/lM0jDc3X6FX2Zd7flvhhW0S8nwKIgBLjZ0avCBdHCjgczC2V33HIsYpqddi
         GoWX+0E3CvCCdYB7+b3I5y0bIXlPL4oOmW2Snm/8Ugc8okBndpmeS2utunPW70137kUs
         vaqaM/TxfoY0qsszXZrgXSGAlLHZf6+iUyT00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=XwpwfXjZSrhWiDofd28LwlKMjubaHGzrGPfQoftZ4OIx3cQTQL8tkCyxXK3UhilLHs
         Xly6rq2nqVvd30Bvvd03WpDCMnneUl+7WypqL0K6OdszzZm9hm2zALor5eJJT284oma4
         3SQX1+8JfDJ0WaCjiCDUfXS99Y78LhKCIQWAs=
Received: by 10.204.171.65 with SMTP id g1mr61617bkz.45.1305595135191; Mon, 16
 May 2011 18:18:55 -0700 (PDT)
Received: by 10.204.46.71 with HTTP; Mon, 16 May 2011 18:18:25 -0700 (PDT)
In-Reply-To: <7v62pan207.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173779>

On Mon, May 16, 2011 at 9:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Mon, May 16, 2011 at 7:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> One typical use of a large binary file is to hold a sparse on-disk hash
>>> table with a lot of holes. Help preserving the holes with lseek().
>>
>> Should that be done only with big enough holes? Random zeros may
>> increase the number of syscalls unnecessarily.
>
> I think that is a valid concern, but doesn't the code do that already?

Ahh I see you only increase kept when the the whole buf is zero. I was
looking for an explicit threshold, but it's implicitly the buffer
size. Sorry for the noise.
-- 
Duy
