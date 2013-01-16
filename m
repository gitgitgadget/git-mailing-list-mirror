From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Possible bug in `remote set-url --add --push`
Date: Wed, 16 Jan 2013 12:01:25 -0800
Message-ID: <7vr4lkx5gq.fsf@alter.siamese.dyndns.org>
References: <CAN8TAOsnX1Mr72LPa47KKXDeUZPgSHTJ6u4YpPFPrtsK7VdN+A@mail.gmail.com>
 <7vliby98r7.fsf@alter.siamese.dyndns.org> <4836187.09xoy3kJnj@blacky>
 <CAN8TAOv0Cm8CgiJSweFtRzOqO78OtNKa4G+x7z6M5Bt+odUmiQ@mail.gmail.com>
 <50F40316.7010308@drmicha.warpmail.net>
 <7v1udnbmyz.fsf@alter.siamese.dyndns.org>
 <1D472234-A0A5-4F02-878D-D05DEE995FCD@gmail.com>
 <7vpq1755jb.fsf@alter.siamese.dyndns.org>
 <7vip6z54rh.fsf@alter.siamese.dyndns.org>
 <50F524F8.5090803@drmicha.warpmail.net>
 <7v4nii5tp2.fsf@alter.siamese.dyndns.org>
 <50F668FB.5000805@drmicha.warpmail.net>
 <7v622xyvnd.fsf@alter.siamese.dyndns.org> <m2ip6x0vtk.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jardel Weyrich <jweyrich@gmail.com>,
	Sascha Cunz <sascha-ml@babbelbox.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 21:01:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvZBF-0005qX-MX
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 21:01:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755655Ab3APUB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 15:01:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60508 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754951Ab3APUB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 15:01:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC662A953;
	Wed, 16 Jan 2013 15:01:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pU/MFxImGteDtTYvB3dxwFUBZpc=; b=BqyCYn
	pXSNh6u5SMJ1BI/xDaaA6Y4qlUf6rHvjme6ktZAOWob7aclOHKMuSU8011dIPkoA
	GbWb0v4yzVwHkc/0SERLdZiTHs3yh49Kh8sK18R9ZaQDyNBObhtfcbab28JhOdQD
	ogy452qCXWhpLgW23PtDT/O/sElQD6V2gqk7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G24X2R6P+uEZgslHQC7eCq6PItiuXtZz
	swhgqTcNtOM3tGyjn3zN6II/z6lActMn0Mcj16AI3RdYYN2tc0gfpWa6h9Wyc1Cm
	sVRVl+rcUPwx1eUqzHzy68W5hBmsCa99RE3DdyrhtVtFpSGnQ5Qm2QpuBRE/LR0J
	c0GjsA+c79c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF18FA952;
	Wed, 16 Jan 2013 15:01:27 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FBD4A94E; Wed, 16 Jan 2013
 15:01:27 -0500 (EST)
In-Reply-To: <m2ip6x0vtk.fsf@igel.home> (Andreas Schwab's message of "Wed, 16
 Jan 2013 20:30:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82F3E5FC-6017-11E2-808F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213806>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> I actually think my earlier "it shouldn't be the same (push)" is not
>> needed and probably is actively wrong.  Just like you can tell
>> between
>>
>>     (only one .url)                     (both .url and .pushurl)
>>
>>     origin there (fetch/push)           origin there (fetch)
>>                                         origin there (push)
>
> What should happen when you have a .pushinsteadof configured that
> modifies .url for pushing?

I think push should work like this:

 * the user gives us a nickname;

 * we look at remote.$nickname.pushurl (and if there isn't,
   remote.$nickname.url) to decide the logical URLs to push to;

 * for each logical URL we decided to push, we look at
   url.*.pushInsteadOf to see if there is one that match the $URL
   (and if there isn't url.*.insteadOf), and map the logical URL to
   the final destination.

So that we can instruct "push" to push, when pushing into a
repository that logically resides at git://git.k.org/pub/,
to instead push into the repository via git-over-ssh, e.g.

    [remote "korg"]
	url = git://git.k.org/pub/scm/git/git.git/

    [url "git.k.org:/pub/"]
        pushInsteadOf = git://git.k.org/pub/

without affecting the fetching side.

As I said in a separate message, the above "fetch/push" vs "fetch"
and "push" distinction is not descriptive enough to express the post
rewriting that is done with insteadOf; it only helps debugging
misconfiguration between .url vs .pushurl, which may be better than
the status quo but is not ideal.
