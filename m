From: pi song <pi.songs@gmail.com>
Subject: Re: [PATCH1/2] Libify blame
Date: Wed, 18 Mar 2009 17:52:38 +1100
Message-ID: <1b29507a0903172352x7864911fm1104e22eddde54f1@mail.gmail.com>
References: <49BE5343.60900@gmail.com>
	 <7vocvzmlqf.fsf@gitster.siamese.dyndns.org>
	 <1b29507a0903172259t348cb4d5n70f5b3003b1eeb00@mail.gmail.com>
	 <7v3adbmjwy.fsf@gitster.siamese.dyndns.org>
Reply-To: pi.songs@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 07:54:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjpfH-0006MQ-7M
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 07:54:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbZCRGwm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 02:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752951AbZCRGwm
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 02:52:42 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:50554 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651AbZCRGwl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 02:52:41 -0400
Received: by yw-out-2324.google.com with SMTP id 3so403098ywj.1
        for <git@vger.kernel.org>; Tue, 17 Mar 2009 23:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=A9JYaa48XGi+GVqnwmnmzGmH8jCuRRpCB6uLIOJ/QM0=;
        b=U+LRngkiqfNOBMibkygcxCNkfivkZ0aJqPmiaZ1SedbovMv5PBoNGELPuK9PfYopei
         PMHfAV4J7dxSoR+NGg2Ef/ox1pb367jJMriocog74V1cD/7LGEL8TjmU23H2ZkR8H/qr
         2O881cGCW10cBdO9tfmnL4qVW4B1xkoU7EnyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:content-type:content-transfer-encoding;
        b=oqhaflA4SJ9C0J306cftkgLcwZyhvB0s/V1u5iWuFyCgP+mA32yyNY6KPKt40QohG8
         kJQldv1fjOR1A6VhHCDdXbTLDjPUsgy3SlpzjhvHsBMzO5D46ETQ4bOGL/pGBGWMqtlT
         45MuZW2fSkGgLypFOhusP79xYiM4eqy45N0Ag=
Received: by 10.142.133.19 with SMTP id g19mr367661wfd.298.1237359158758; Tue, 
	17 Mar 2009 23:52:38 -0700 (PDT)
In-Reply-To: <7v3adbmjwy.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113589>

Wait. If you look at the builtin-blame.c, out of question it is very
messy. Things like print_usage() or -L parameter parsing for example
is not done upfront but hiding somewhere. Some functions are not very
clear if they are frontend or backend. I would say nobody would be
able to split it right in the first place. What you could do is to
split it to something "roughly right" and then work from that.

My latest two patches really do nothing but just splitting files. I
haven't changed any logics or renamed any thing only to make this big
beast more *manageable* rather than tackling the problem directly.
Yes, some bits are  still wrong but I believe 70% of the functions
should already stay in the right place. The following patches will
make the structure more right *gradually*.

Pi Song


On Wed, Mar 18, 2009 at 5:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> pi song <pi.songs@gmail.com> writes:
>
>> Don't you think we should rather split up into smaller files before
>> start reorganizing things?
>
> Yes, but splitting it wrong is, eh, wrong ;-)
>
