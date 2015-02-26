From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Any chance for a Git v2.1.5 release?
Date: Thu, 26 Feb 2015 15:51:57 -0800
Message-ID: <xmqqpp8wjko2.fsf@gitster.dls.corp.google.com>
References: <C5211E53-8905-41C9-9D28-26D7BB51E76A@gmail.com>
	<xmqqk2z7qe8s.fsf@gitster.dls.corp.google.com>
	<2D3EB6D1-3029-4F60-AF29-E044E92DB036@gmail.com>
	<xmqq4mqapo9r.fsf@gitster.dls.corp.google.com>
	<DCB8EEAA-F6C3-4321-833E-39B80673C7E9@gmail.com>
	<xmqqvbiol7fg.fsf@gitster.dls.corp.google.com>
	<35E11B78-6FF8-41DE-BBF5-8978DA2F87A6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 00:52:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR8Du-0002bz-2Q
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 00:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735AbbBZXwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 18:52:00 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54861 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752483AbbBZXv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 18:51:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BF263BB93;
	Thu, 26 Feb 2015 18:51:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cLKjdPeIqhXYNM2OkfnoHfyOELY=; b=V5Tscr
	7JsAlhZwZjfTVVpRbxNo6ba+YkVe8CUCm7fRCvot0m5Cwp0TB1BbhZ3H9ATkA4ti
	1niLH3ufmKksNMB2U6+srNbcKZ8fKk6774MHnCPxg8vKNscjO49u9ZPc72/68Qp2
	jG3n3eJqGUuHpN2JX7Fp7oh5e/bp3dw1D3ctw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PFnn+Sm8DHpf9/QgKxo6zH1Sa11gkdx0
	dNjKfGLoAfCddkyc4vxkH5MyOxwQy3o8qBJ2JFIT1nvSFU5XMPLABmTsdevQ3cHp
	R5ztMW2zJqWQ9PVUSpku1WnDDjPkxHG6KcZ33ZBB75/6h5K1q7+nzNnFrtzgIoQc
	92BEYaxsouw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 031953BB92;
	Thu, 26 Feb 2015 18:51:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7CF413BB8F;
	Thu, 26 Feb 2015 18:51:58 -0500 (EST)
In-Reply-To: <35E11B78-6FF8-41DE-BBF5-8978DA2F87A6@gmail.com> (Kyle J. McKay's
	message of "Thu, 26 Feb 2015 15:38:51 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 738C92F2-BE12-11E4-9D1F-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264482>

"Kyle J. McKay" <mackyle@gmail.com> writes:

>> After finishing 2.3.0 release, at some point while 'master' is still
>> at 2.3.0, something like this would happen:
>>
>>    $ git branch -m maint maint-2.2
>>    $ git branch maint master
>
> So the reason I don't notice force-updates to maint when this happens
> is because of the "Sync with maint" commits that make sure the new
> maint contains the old one.

I could also do

    git branch maint-2.2 maint
    git push . master:maint ;# not +master:maint

to make sure that I won't rewind 'maint', but this works because
'master' is designed to be always a super-set of 'maint'.

> If I were to keep a maint-lts branch somewhere I would need to cherry- 
> pick topics with desired fixes that fall into that situation.  That's
> what I expected but when you mentioned down merging the fixes I wanted
> to make sure I wasn't overlooking something.

Yup.  I _can_ become sloppy especially late in the release cycle and
end up doing something silly like this:

    - Fork km/svn-fix from somewhere it _could_ be merged to 'maint'
      (e.g. "the last big release", e.g. v2.3.0).

    - Merge km/svn-fix to 'master' early in a cycle;

    - A mistake is found in the topic late in the cycle; as the next
      release will happen soon _anyway_, and I do not happen to
      consider km/svn-fix is so important a fix to be merged to
      'maint', I apply a fix-up patch directly on top of 'master';

    - A release candidate is tagged from 'master'.

Then even though you can easily grab a broken-out tree at
github.com:gitster/git, km/svn-fix topic alone cannot be merged to
'maint' as it would lack the late fix.  I've been trying to be
careful but I cannot promise to be perfect X-<.
