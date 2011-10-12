From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make is_gitfile a non-static generic function
Date: Wed, 12 Oct 2011 11:08:17 -0700
Message-ID: <7vmxd69j72.fsf@alter.siamese.dyndns.org>
References: <4E94C70E.3080003@cisco.com> <4E94C8AB.3040807@cisco.com>
 <7vipnvccso.fsf@alter.siamese.dyndns.org>
 <CABURp0p4_oVMmkFDPue4kvhO_bEr_dBh-XFGArdSJFMz-Eboeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <hordp@cisco.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 20:08:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE3E9-0006ex-Of
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 20:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858Ab1JLSIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 14:08:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51776 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753792Ab1JLSIU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 14:08:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3F765AB8;
	Wed, 12 Oct 2011 14:08:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/bNtNu9gmGP5P4piN3goYpcz6mE=; b=Wopy3u
	bG/Sr6q83iuE8EnylJquV0QxunsS/TceHD4QX6uxSHBCfDXmYYeilYMnHAEn4BaC
	ythVzArAD8vaiDXIhxpSlC4vicDGTLQDxDY3W+/ISgV/NrhNNvWlO+bg5TN6FIDr
	6CzIYl6d/ENboId7B76utLvQJjwndLYvUkL1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BWg+UM8Ytc4qJ0WR5kf5dK6hXzyHnMxc
	NsyOLa2JuSn5cYnSODMFxc7OVhTEWQ8A+Rm/JdCZkwWbBn/iAFxD1iZvDbSaT2pW
	kkGYZHI+OPGDhVbsURfbjLXxWXPx3Bwj/dpqFCANvH2FipYEpW/u5JnJONoNiPu2
	jcDl+FYz2M4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCB6D5AB5;
	Wed, 12 Oct 2011 14:08:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A3F85AB3; Wed, 12 Oct 2011
 14:08:18 -0400 (EDT)
In-Reply-To: <CABURp0p4_oVMmkFDPue4kvhO_bEr_dBh-XFGArdSJFMz-Eboeg@mail.gmail.com> (Phil
 Hord's message of "Wed, 12 Oct 2011 14:01:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 29A69B88-F4FD-11E0-BCC8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183384>

Phil Hord <phil.hord@gmail.com> writes:

> On Tue, Oct 11, 2011 at 7:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> After looking at this patch and the way the other caller in transport.c
>> uses it, I am more and more convinced that "is_gitfile()" is a stupid and
>> horrible mistake.
>
> I think I misunderstood your objection before.  Now I think I
> understand.  Tell me if I am right.
>
>
> I think you mean that instead of this:
>         } else if (is_local(url) && is_file(url) && !is_gitfile(url)) {
>
> you would like to see this:
>         } else if (is_local(url) && is_file(url) && is_bundle(url)) {
>
> Or maybe even this:
>         } else if (is_bundle(url)) {

Exactly.
