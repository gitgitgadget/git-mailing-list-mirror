From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [BUG] Possible bug in `remote set-url --add --push`
Date: Wed, 16 Jan 2013 17:24:29 +0100
Message-ID: <50F6D43D.2000509@drmicha.warpmail.net>
References: <CAN8TAOsnX1Mr72LPa47KKXDeUZPgSHTJ6u4YpPFPrtsK7VdN+A@mail.gmail.com> <7vliby98r7.fsf@alter.siamese.dyndns.org> <4836187.09xoy3kJnj@blacky> <CAN8TAOv0Cm8CgiJSweFtRzOqO78OtNKa4G+x7z6M5Bt+odUmiQ@mail.gmail.com> <50F40316.7010308@drmicha.warpmail.net> <7v1udnbmyz.fsf@alter.siamese.dyndns.org> <1D472234-A0A5-4F02-878D-D05DEE995FCD@gmail.com> <7vpq1755jb.fsf@alter.siamese.dyndns.org> <7vip6z54rh.fsf@alter.siamese.dyndns.org> <50F524F8.5090803@drmicha.warpmail.net> <7v4nii5tp2.fsf@alter.siamese.dyndns.org> <CABURp0rR_wB6vcjrZajQU_=AVVvBq-aTGpggh5XxdCMYis3-ag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jardel Weyrich <jweyrich@gmail.com>,
	Sascha Cunz <sascha-ml@babbelbox.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 17:25:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvVnP-0003E6-2i
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 17:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758666Ab3APQYd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 11:24:33 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36302 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756390Ab3APQY3 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2013 11:24:29 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id AB8FE20E75;
	Wed, 16 Jan 2013 11:24:28 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 16 Jan 2013 11:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=3aNMUtwUhZMKMUp/UBWhh8
	k3Y2g=; b=AXjPCmDBDSIuVIK/PlkxBXAkiC3I0kqmcmAsI+VgoJVDFHUQu7L1eE
	NZQ9FMsEwH/A/2YBo1xcg5sQD6MSR/+ulaR/g18NVLWNAxLIoXeMyP3urYjWDtAB
	N9opOsguUhMHWZxM27X/dmmgLGfy4txaxfGMsTm/ndHJywNlFdQS8=
X-Sasl-enc: BVVUIwyhtWtE0xfzrMXhIAi5CqBJ6robfsgJO4aOIidm 1358353468
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id A519A4827D6;
	Wed, 16 Jan 2013 11:24:27 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <CABURp0rR_wB6vcjrZajQU_=AVVvBq-aTGpggh5XxdCMYis3-ag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213764>

Phil Hord venit, vidit, dixit 16.01.2013 17:15:
> On Tue, Jan 15, 2013 at 10:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>
>>> That being said, I don't mind changing the behaviour of set-url.
>>
>> I do not think we want to change the behaviour of set-url.
> 
> I agree with Michael that changing the set-url behavior would be
> appropriate here.  If I say "--add" this pushUrl, don't I mean to
> create an additional url which is pushed to?

I said I wouldn't mind, I didn't vote for it.

> I agree that it makes the config situation messy; this is currently a
> "clean" sequence, in that it leaves the config unchanged after both
> steps are completed:
> 
>   git remote set-url --add --push origin /tmp/foo
>   git remote set-url --delete --push origin /tmp/foo
> 
> If the behavior is changed like Michael suggested, it would not leave
> the config clean (unless heroic steps were taken to keep track).  But
> I'm not sure that's such a bad thing.  In simple command sequences,
> the results would be clean and the only behavior change is that the
> initial "--add" really acts like "add" and not "replace".  But more
> complex sequences could be devised which were affected by this change.
> 
> I'm curious, Junio.  Do you think the set-url behavior is correct
> as-is, or that changing it will cause breakage for some workflows, or
> that it complicates the operation too much for people who are already
> used to the config layout?

For "set url --add --push" on top of a push url only being defaulted
from a fetch url, both behaviours (replace or add, i.e. current or new)
make sense to me. So the questions are:

- Is it worth and possible changing?
- How to best describe it in "remote -v" and "remote show" output?

My patch answered to "no" to the first question and answers the second
one in cases where (push)insteadof is not used to transform one fetch
config into two different urls for fetch and push. I think :)

Michael
