From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 0/8] Sequencer Foundations
Date: Fri, 13 May 2011 11:11:34 +0200
Message-ID: <BANLkTi=8BrFXfoDwL_fXG2bXarP7d0xioA@mail.gmail.com>
References: <1305100822-20470-1-git-send-email-artagnon@gmail.com>
	<20110511131356.GI2676@elie>
	<BANLkTi=zXWojMOfe9sECUu-X9euCjr4i3w@mail.gmail.com>
	<20110512084136.GD28872@elie>
	<20110512114415.GA14724@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 11:11:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKoPN-0005J0-FJ
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 11:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932886Ab1EMJLg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 May 2011 05:11:36 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52875 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932478Ab1EMJLf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2011 05:11:35 -0400
Received: by yxs7 with SMTP id 7so814804yxs.19
        for <git@vger.kernel.org>; Fri, 13 May 2011 02:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/aUdzu0swCxSh7jFTrqIwZRUi75e8N1uhqlgjrxI6YE=;
        b=mVPr7C1vG96CAxgDHjBdMqcYRFRfw4f0/yG909SFcryNPhFyZcWsUL05Z2PSX+WhFw
         u4t2bpQic/NY5mvUT96Vze3qhQyD6b/E80wZuwCOApUE36/OlvUPAdlzktW7SplO21ij
         mphZLIUnx5aFPL3p53Tcsd3EeD8Ie84/v2uvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZFIYFcnobDnx8iIwvn4h54kBW5IsnykrN+xbmTrAhHEpNxorp9AqYv7r0SysH8EGpj
         4Y1rZjrJ/l1YXfXT6/sTdS4pf8VoL5imfOB/f28UMcQ/qV/EIKXvWKOMbcaWyv+xwmVI
         kKWyxP0/ol2xoyObK4BsO+OwdP6hbd8SO7V1Y=
Received: by 10.236.105.140 with SMTP id k12mr1067280yhg.169.1305277894539;
 Fri, 13 May 2011 02:11:34 -0700 (PDT)
Received: by 10.147.167.5 with HTTP; Fri, 13 May 2011 02:11:34 -0700 (PDT)
In-Reply-To: <20110512114415.GA14724@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173513>

Hi,

On Thu, May 12, 2011 at 1:44 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Jonathan Nieder wrote:
>> Christian Couder wrote:
>
>>> I think that the risk at this point might be to overengineer things
>>> and to lose time, and then we will perhaps find out that we need to=
 do
>>> some refactoring of the merge_recursive API anyway.
>>
>> I agree with the general principle... let's see if I understand the
>> details of what you are saying.
>
> It occurs to me now that you were probably talking about the
> suggestion of using the lockfile API (i.e., the write temporary/renam=
e
> trick). =A0In that case, I agree --- no need to overengineer it and
> concurrency problems can be fixed later. =A0Sorry for an overcomplica=
ted
> explanation.

Yeah, it was mostly the lockfile API.

About writing files before each cherry-pick, I am not against it, if
it is really needed to be safe. I even suggested it in my patch series
back in November
(http://article.gmane.org/gmane.comp.version-control.git/162183).
But it will make cherry-pick less efficient, so it is a kind of
performance regression that we can perhaps avoid by changing some
die() into error().

So what i suggest and in fact started is to just try that. We may find
that we could indeed do it quite safely or we may find that it's too
much work to be safe enough. When I tried it, it seemed to me that it
was not a lot of work, and not very complex, though it added many
commits to the patch series. But perhaps I overlooked some problems. I
will have another look soon.

Thanks,
Christian.
