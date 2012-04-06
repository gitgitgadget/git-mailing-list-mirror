From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RESEND] send-email: add 'specify-author' option
Date: Fri, 06 Apr 2012 15:30:32 -0700
Message-ID: <7vobr4ze5z.fsf@alter.siamese.dyndns.org>
References: <1333714876-21895-1-git-send-email-felipe.contreras@gmail.com>
 <7vobr4236g.fsf@alter.siamese.dyndns.org>
 <CAMP44s1b=HfhPNkmiEjPnQpupd0FPBNgVyp5Sw=zFVTdqmJXEg@mail.gmail.com>
 <7vbon41ugg.fsf@alter.siamese.dyndns.org>
 <CAMP44s1m2exUVRTzcBJrY8hnWxF+uEt58AQOP5vKiA3tfeRXRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Pierre Habouzit <madcoder@debian.org>,
	Pascal Obry <pascal@obry.net>,
	Jay Soffian <jaysoffian@gmail.com>,
	David Brown <git@davidb.org>, Matthew Wilcox <matthew@wil.cx>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 07 00:30:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGHg0-0006OQ-J5
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 00:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758231Ab2DFWag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Apr 2012 18:30:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52815 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753887Ab2DFWaf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2012 18:30:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 460D37100;
	Fri,  6 Apr 2012 18:30:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w1TxkGY6+H7Uj8opCYmXPSIy2pQ=; b=iSnnBX
	GKqQNtpLgIzsg773cmgG9C3Le751UMwBT0g0udZP0W3AL+o0Aoq+bSrnffefgqBv
	eurhgtbY8V0OtnVYyIYeqTLu47tF83QMnpwubuzAK8xcYgvBmY4pzhD9WQYUP1Pr
	Zyul0EgyDzs74/jCwpDp5cs84MUebx4JXlPzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OjlIXM61dxoSagJN+1/YwzGktUWUFwEc
	bANGczDgCtQD7IVIEHQd5rf+QUzhq0KDdRl1cu7yWAxRw9cB+zOshORwOuBbocOs
	3JxQeaY7rkFxXVM+reu/JHBKkcyc1kc0DBGvz2X5tsPA1VRWozYwPZ1T5V0eGVJD
	8V5yxBuD5CQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C89770FF;
	Fri,  6 Apr 2012 18:30:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8778070FE; Fri,  6 Apr 2012
 18:30:33 -0400 (EDT)
In-Reply-To: <CAMP44s1m2exUVRTzcBJrY8hnWxF+uEt58AQOP5vKiA3tfeRXRQ@mail.gmail.com> (Felipe
 Contreras's message of "Sat, 7 Apr 2012 00:48:26 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1FB184FA-8038-11E1-8218-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194919>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> The "Subject:" is very often used in the wild, when responding to an
>> existing discussion thread with a patch, without changing the topic of the
>> thread (I would say it is used more than "From: " override).
>
> Hmm, but that is different, isn't it?
>
> AFAIK people use this format:
>
> ---
> $headers
>
> Message
>
> Patch (format-patch output: headers, commit message, diff)
> ---
>
> In this case 'git am' would ignore the patch headers. The only way
> 'git am' would override $headers, is if the first part of the body has
> new headers:
>
> ---
> $headers
>
> $patch_headers
>
> $patch_commit_message
>
> $patch_diff
> ---
>
> IOW; if there's no message at the beginning of the body.

Your notation is a bit unclear to me, but I take that $headers mean the
e-mail headers, and $patch_headers mean what we often call "in-body"
headers; in other words, your patch is "duplicate my authorship in
$patch_headers because my MSA/MTA mangles my name in $headers."  Am I
following you well so far?

What I meant to say was that perhaps the approach can help the same class
of issues where other fields in $headers can be corrupted and the user
wants duplicate in "in-body", assuming that it is less likely to be eaten,
and non-ASCII subject was one example that immediately came to my mind.

So in that sense, it is not much a different issue.

> I can't foresee that, but I guess we can do it anyway. So which would
> be the fields to repeat? From, Date, and Subject?

I would say From and Subject are equally worth considering.
