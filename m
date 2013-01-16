From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [BUG] Possible bug in `remote set-url --add --push`
Date: Wed, 16 Jan 2013 17:19:23 +0100
Message-ID: <50F6D30B.9030703@drmicha.warpmail.net>
References: <CAN8TAOsnX1Mr72LPa47KKXDeUZPgSHTJ6u4YpPFPrtsK7VdN+A@mail.gmail.com> <7vliby98r7.fsf@alter.siamese.dyndns.org> <4836187.09xoy3kJnj@blacky> <CAN8TAOv0Cm8CgiJSweFtRzOqO78OtNKa4G+x7z6M5Bt+odUmiQ@mail.gmail.com> <50F40316.7010308@drmicha.warpmail.net> <7v1udnbmyz.fsf@alter.siamese.dyndns.org> <1D472234-A0A5-4F02-878D-D05DEE995FCD@gmail.com> <7vpq1755jb.fsf@alter.siamese.dyndns.org> <7vip6z54rh.fsf@alter.siamese.dyndns.org> <50F524F8.5090803@drmicha.warpmail.net> <7v4nii5tp2.fsf@alter.siamese.dyndns.org> <50F668FB.5000805@drmicha.warpmail.net> <7v622xyvnd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jardel Weyrich <jweyrich@gmail.com>,
	Sascha Cunz <sascha-ml@babbelbox.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 17:19:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvViM-0003RO-Pj
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 17:19:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758721Ab3APQT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 11:19:26 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53663 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758746Ab3APQTX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2013 11:19:23 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 30FB620F96;
	Wed, 16 Jan 2013 11:19:22 -0500 (EST)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute6.internal (MEProxy); Wed, 16 Jan 2013 11:19:22 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=iI7+dWd0kQq0Rvm0mg9Lo+
	PqOWI=; b=HUe6/ltK4R3JMMUZInpbPP5hVd3j9XnFROop+YXWH20vq0S1VPSaAJ
	bSKfD7dWzxoBRAx3jmb17Gy6c+EgRDmdNOoYV+jKJEWZi+Qyl10+pfRRkPn2Lcfx
	7ySGls/yMPhoBbGW5BnPwctIg6ufqPr0hsEyy4yJ4pnQXX5BTtjVE=
X-Sasl-enc: YTXVJBauHUdEKoFJ/2h6MV7Tr1zsX/oI0vM+lSwiTHoE 1358353161
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 730018E07FA;
	Wed, 16 Jan 2013 11:19:21 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <7v622xyvnd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213763>

Junio C Hamano venit, vidit, dixit 16.01.2013 16:50:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Junio C Hamano venit, vidit, dixit 15.01.2013 16:53:
>> ...
>>>  * When there are more than one URLs, and there is no pushURL, then
>>>    show the first URL as (fetch/push), and the remainder in a
>>>    notation that says it is used only for push, but it shouldn't be
>>>    the same "(push)"; the user has to be able to distinguish it from
>>>    the pushURLs in a repository that also has URLs.
>>
>> Maybe "(fetch fallback/push)" if we do use it as a fallback? If we don't
>> we probably should?
> 
> I actually think my earlier "it shouldn't be the same (push)" is not
> needed and probably is actively wrong.  Just like you can tell
> between
> 
>     (only one .url)                     (both .url and .pushurl)
> 
>     origin there (fetch/push)           origin there (fetch)
>                                         origin there (push)
> 
> even when the value of the URL/PushURL, i.e. "there", is the same
> between .url and .pushurl, you should be able to tell between
> 
>     (two .url, no .pushurl)             (one .url and one .pushurl)
> 
>     origin there (fetch/push)           origin there (fetch)
>     origin another (push)               origin another (push)
> 
> So let's not make it too complex and forget about the different kind
> of "(push)".
> 
> A case that is a potential misconfiguration would look like:
> 
>     (two .url, one .pushurl)
> 
>     origin there (fetch)
>     origin some  (unused)
>     origin another (push)
> 
> I think.

I'm sorry but E_NOPARSE. I can't grok the above at all. But I'll try
again tomorrow ;)

In any case, the issue with (push)instead of that John mentions bothers
me: there are "two specified URLs" but one URL in config only; my patch
doesn't make that case clearer at all. My early attempts at amending
struct remote produced too many segfaults to continue today...

Michael
